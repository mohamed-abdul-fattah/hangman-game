defmodule Hangman do
  alias Hangman.Game

  defdelegate new_game(),        to: Game, as: :init
  defdelegate new_game(word),    to: Game, as: :init
  defdelegate guess(game, word), to: Game, as: :make_move
  defdelegate tally(game),       to: Game
end
