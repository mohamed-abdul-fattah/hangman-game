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
        { game, tally(game) }
    end

    def make_move(game, guess) do
        game = accept_move(game, guess, MapSet.member?(game.used, guess))
        { game, tally(game) }
    end

    def accept_move(game, _guess, _already_guessed = true) do
        Map.put(game, :game_state, :already_used)
    end

    def accept_move(game, guess, _not_guessed = false) do
        game
        |> Map.put(:used, MapSet.put(game.used, guess))
        |> score_guess(Enum.member?(game.letters, guess))
    end

    def score_guess(game, _good_guess = true) do
        new_state = MapSet.new(game.letters)
                    |> MapSet.subset?(game.used)
                    |> won?
        Map.put(game, :game_state, new_state)
    end

    def score_guess(game, _bad_guess = false) do
        game
    end

    defp won?(true), do: :won
    defp won?(_),    do: :good_guess
    defp tally(_game), do: 123
end
