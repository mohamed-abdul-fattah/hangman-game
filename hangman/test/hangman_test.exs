defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "Hangman game can start a new game" do
    assert { :ok, pid } = Hangman.new_game
  end

  test "Hangman game can guess a good guess" do
    { :ok, pid } = Hangman.new_game("happy")
    assert %{ game_state: :good_guess, turns_left: 7 } = Hangman.guess(pid, "h")
  end

  test "Hangman game can guess a bad guess" do
    { :ok, pid } = Hangman.new_game("happy")
    assert %{ game_state: :bad_guess, turns_left: 6 } = Hangman.guess(pid, "x")
  end

  test "Hangman game can print game tally" do
    { :ok, pid } = Hangman.new_game("happy")
    Hangman.guess(pid, "h")
    assert %{
      game_state: good_guess,
      letters: ["h", "_", "_", "_", "_"],
      turns_left: 7
    } = Hangman.tally(pid)
  end
end
