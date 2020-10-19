defmodule TextClient.Mover do
  alias TextClient.State

  def guess(game) do
    gs = Hangman.guess(game.game_service, game.guess)
    %State{ game | game_service: gs, tally: Hangman.tally(gs) }
  end
end
