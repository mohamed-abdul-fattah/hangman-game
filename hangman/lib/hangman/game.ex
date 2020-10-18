defmodule Hangman.Game do
    defstruct(
        trials_left: 7,
        game_state:  :init,
        letters:     [],
        used:        MapSet.new()
    )

    def init do
        init(Dictionary.random_word)
    end

    def init(letters) do
        %__MODULE__{ letters: String.codepoints(letters) }
    end

    def make_move(game = %__MODULE__{ game_state: state }, _guess) when state in [:won, :lost] do
        game
    end

    def make_move(game, guess) do
        guess = guess |> String.downcase
        accept_move(game, guess, MapSet.member?(game.used, guess))
    end

    def tally(game) do
        %{
            game_state: game.game_state,
            turns_left: game.trials_left,
            letters:    reveal_letters(game.letters, game.used)
        }
    end

    defp reveal_letters(letters, used) do
        Enum.map(letters, fn x -> used |> MapSet.member?(x) |> reveal_letter(x) end)
    end

    defp reveal_letter(_is_member = true, letter), do: letter
    defp reveal_letter(_is_not_member, _),         do: "_"

    defp accept_move(game, _guess, _already_guessed = true) do
        Map.put(game, :game_state, :already_used)
    end

    defp accept_move(game, guess, _not_guessed = false) do
        game
        |> Map.put(:used, MapSet.put(game.used, guess))
        |> score_guess(Enum.member?(game.letters, guess))
    end

    defp score_guess(game, _good_guess = true) do
        new_state = MapSet.new(game.letters)
                    |> MapSet.subset?(game.used)
                    |> won?
        Map.put(game, :game_state, new_state)
    end

    defp score_guess(game = %{ trials_left: 1 }, _bad_guess = false) do
        %{ game | game_state: :lost, trials_left: 0 }
    end

    defp score_guess(game = %{ trials_left: trials_left }, _bad_guess = false) do
        %{ game | game_state: :bad_guess, trials_left: trials_left - 1 }
    end

    defp won?(true), do: :won
    defp won?(_),    do: :good_guess
end
