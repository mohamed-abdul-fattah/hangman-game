defmodule Hangman do
  alias Hangman.Server

  def new_game() do
    {:ok, pid} = Supervisor.start_child(Hangman.Supervisor, [])
    pid
  end

  def new_game(word) do
    Server.start_link(word)
  end

  def guess(game_pid, guess) do
    GenServer.call(game_pid, { :guess, guess })
  end

  def tally(game_pid) do
    GenServer.call(game_pid, { :tally })
  end
end
