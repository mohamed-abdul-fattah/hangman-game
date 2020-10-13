defmodule Hangman.Game do
    defstruct(
        trials_left: 7,
        game_state:  :init,
        letters:     [],
        used:        MapSet.new()
    )

    def init do
        %__MODULE__{ letters: Dictionary.random_word |> String.codepoints }
    end

    def make_move(game = %__MODULE__{ game_state: state }, _guess) when state in [:won, :lost] do
        { game, tally(game) }
    end

    def make_move(game, guess) do
        game = accept_move(game, guess, MapSet.member?(game.used, guess))
        { game, tally(game) }
    end

    def accept_move(game, _guess, _already_used = true) do
        Map.put(game, :game_state, :already_used)
    end

    def accept_move(game, guess, _not_used = false) do
        game
        |> Map.put(:game_state, :guessed)
        |> Map.put(:used, MapSet.put(game.used, guess))
    end

    defp tally(_game), do: 123
end
