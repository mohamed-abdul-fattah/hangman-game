defmodule Hangman.Server do
  use GenServer
  alias Hangman.Game

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def start_link(word) do
    GenServer.start_link(__MODULE__, word)
  end

  def init(nil) do
    { :ok, Game.init }
  end

  def init(word) do
    { :ok, Game.init(word) }
  end

  def handle_call({ :guess, guess }, _from, game) do
    game = Game.make_move(game, guess)
    { :reply, Game.tally(game), game }
  end

  def handle_call({ :tally }, _from, game) do
    { :reply, Game.tally(game), game }
  end
end
