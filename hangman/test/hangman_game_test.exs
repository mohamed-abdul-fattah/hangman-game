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
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.init() |> Game.make_move("x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.init() |> Game.make_move("x")
    assert game.game_state != :already_used
    game = game |> Game.make_move("x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.init("Mohamed") |> Game.make_move("M")
    assert game.game_state  == :good_guess
    assert game.trials_left == 7
  end

  test "a guessed game is a won game" do
    game = Game.init("lolly")
    game = Game.make_move(game, "L")
    assert game.game_state  == :good_guess
    assert game.trials_left == 7
    game = Game.make_move(game, "o")
    assert game.game_state  == :good_guess
    assert game.trials_left == 7
    game = Game.make_move(game, "y")
    assert game.game_state  == :won
    assert game.trials_left == 7
  end

  test "a bad guess is recognized" do
    game = Game.init("Lol") |> Game.make_move("x")
    assert game.game_state  == :bad_guess
    assert game.trials_left == 6
  end

  test "a lost game is recognized" do
    game  = Game.init("Lol")
    moves = [
      { :bad_guess, 6 },
      { :bad_guess, 5 },
      { :bad_guess, 4 },
      { :bad_guess, 3 },
      { :bad_guess, 2 },
      { :bad_guess, 1 },
      { :lost, 0 },
    ]
    Enum.reduce(moves, game, fn ({ state, trials_left }, game) ->
      game = Game.make_move(game, Integer.to_string(trials_left))
      assert game.game_state  == state
      assert game.trials_left == trials_left
      game
    end)
  end

  test "tally doesnt reveal letters" do
    assert %{ letters: ["h", "_", "_", "_", "_"] } = Game.init("happy") |> Game.make_move("h") |> Game.tally
  end

  test "Game guessing is case insensitive" do
    assert %{ game_state: :good_guess } = Game.init("happy") |> Game.make_move("H")
  end
end
