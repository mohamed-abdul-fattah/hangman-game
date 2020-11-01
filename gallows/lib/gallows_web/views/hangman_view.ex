defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def word_so_far(tally = %{ letters: _list }) do
    tally.letters |> Enum.join(" ")
  end
end
