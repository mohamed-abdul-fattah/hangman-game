defmodule Dictionary do
  @moduledoc """
  Documentation for `Dictionary`.
  Dictionary module is used to generate random words
  """

  @doc """
  `random_word` function returns a random word from a list of
  words in the assets/words.txt file

  ## Examples
      iex(1)> Dictionary.random_word()
      #=> "cancer"
  """
  def random_word do
    word_list()
    |> Enum.random
  end

  defp word_list do
    "assets/words.txt"
    |> Path.expand
    |> File.read!
    |> String.split(~r/\n/)
  end
end
