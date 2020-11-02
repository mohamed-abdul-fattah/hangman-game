defmodule TextClient.Mover do
  alias TextClient.State

  def guess(game) do
    gs = game.game_service
    Hangman.guess(game.game_service, game.guess)
    %State{game | tally: Hangman.tally(gs)}
  end
end
