defmodule TextClient.Summary do
  alias TextClient.State

  def display(game = %State{ game_service: gs, tally: tally }) do
    IO.puts [
      "\n",
      "Word fo far:  #{Enum.join(tally.letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Letters used so far: #{Enum.join(gs.used, ", ")}"
    ]
    game
  end
end
