defmodule Hangman.Game do
    defstruct(
        trials_left: 7,
        game_state:  :init,
        letters:     []
    )

    def init do
        %Hangman.Game{ letters: Dictionary.random_word |> String.codepoints }
    end
end
