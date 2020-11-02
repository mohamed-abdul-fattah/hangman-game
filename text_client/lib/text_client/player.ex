defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, State, Summary}

  def play(%State{tally: %{game_state: :won}}), do: exit_with_msg("You won!")

  def play(game = %State{tally: %{game_state: :lost}}) do
    exit_with_msg("Sorry, you lost!\nWord was '#{Enum.join(game.tally.game_service.letters)}'")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_msg(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_msg(game, "Sorry, try again!")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_msg(game, "You already used that letter!")
  end

  def play(game), do: continue(game)

  defp continue_with_msg(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.prompt()
    |> Mover.guess()
    |> play
  end

  defp exit_with_msg(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
