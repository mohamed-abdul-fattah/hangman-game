defmodule Dictionary do
  @moduledoc """
  Documentation for `Dictionary`.
  This is an updated module documentation
  """

  def random_word do
    word_list()
    |> Enum.random
  end

  def word_list do
    "assets/words.txt"
    |> File.read!
    |> String.split(~r/\n/)
  end
end
