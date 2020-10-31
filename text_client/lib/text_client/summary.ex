defmodule TextClient.Summary do
  alias TextClient.State

  def display(game = %State{ tally: tally }) do
    IO.puts [
      "\n",
      "Word fo far:  #{Enum.join(tally.letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Letters used so far: #{Enum.join(tally.game_service.used, ", ")}"
    ]
    game
  end
end
