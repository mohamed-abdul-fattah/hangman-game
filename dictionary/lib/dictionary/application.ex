defmodule Dictionary.Application do
  def start(_type, _args) do
    Dictionary.WordList.start_link
  end
end
