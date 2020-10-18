defmodule TextClient.Player do
  alias TextClient.State

  def play(%State{ tally: %{ game_state: :won } }),  do: exit_with_msg("You won!")
  def play(%State{ tally: %{ game_state: :lost } }), do: exit_with_msg("Sorry, you lost!")

  def play(game = %State{ tally: %{ game_state: :good_guess } }) do
    continue_with_msg(game, "Good guess!")
  end

  def play(game = %State{ tally: %{ game_state: :bad_guess } }) do
    continue_with_msg(game, "Sorry, try again!")
  end

  def play(game = %State{ tally: %{ game_state: :already_used } }) do
    continue_with_msg(game, "You already used that letter!")
  end

  def play(game), do: continue(game)

  defp continue_with_msg(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp continue(game) do
    game
    |> display
    |> prompt
    |> guess
    |> play
  end

  defp display(game), do: game

  defp prompt(game), do: game

  defp guess(game), do: game

  defp exit_with_msg(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
