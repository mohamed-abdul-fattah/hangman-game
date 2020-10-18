defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "Hangman game can start a new game" do
    assert %{ game_state: :init, trials_left: 7 } = Hangman.new_game
  end

  test "Hangman game can guess a good guess" do
    assert %{ game_state: :good_guess, trials_left: 7 } = Hangman.new_game("happy") |> Hangman.guess("h")
  end

  test "Hangman game can guess a bad guess" do
    assert %{ game_state: :bad_guess, trials_left: 6 } = Hangman.new_game("happy") |> Hangman.guess("x")
  end

  test "Hangman game can print game tally" do
    assert %{
      game_state: good_guess,
      letters: ["h", "_", "_", "_", "_"],
      turns_left: 7
    } = Hangman.new_game("happy") |> Hangman.guess("h") |> Hangman.tally
  end
end
