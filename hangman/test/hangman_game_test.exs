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

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.init() |> Map.put(:game_state, state)
      assert { ^game, _ } = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    { game, _tally } = Game.init() |> Game.make_move("x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    { game, _tally } = Game.init() |> Game.make_move("x")
    assert game.game_state != :already_used
    { game, _tally } = game |> Game.make_move("x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    { game, _tally } = Game.init("Mohamed") |> Game.make_move("M")
    assert game.game_state  == :good_guess
    assert game.trials_left == 7
  end

  test "a guessed game is a won game" do
    game = Game.init("Lol")
    { game, _tally } = Game.make_move(game, "L")
    assert game.game_state  == :good_guess
    assert game.trials_left == 7
    { game, _tally } = Game.make_move(game, "o")
    assert game.game_state  == :good_guess
    assert game.trials_left == 7
    { game, _tally } = Game.make_move(game, "l")
    assert game.game_state  == :won
    assert game.trials_left == 7
  end
end