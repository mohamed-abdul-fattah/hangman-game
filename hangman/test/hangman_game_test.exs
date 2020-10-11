defmodule HangmanGameTest do
  use ExUnit.Case
  alias Hangman.Game

  test "init returns structure" do
    game = Game.init()

    assert 7 == game.trials_left
    assert :init == game.game_state
  end

  test "init returns a set of letters" do
    game = Game.init()

    assert is_list(game.letters)
    assert length(game.letters) > 0
    assert Enum.all?(game.letters, fn x ->
      <<ascii::utf8>> = x
      ascii in 97..122 # Assert that chars are alpha chars
    end)
  end
end
