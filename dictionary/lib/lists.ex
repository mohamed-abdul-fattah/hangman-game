defmodule Lists do
    def sum([]), do: 0
    def sum([ h | tail ]), do: h + sum(tail)

    def even_length(list) do
        list
        |> Enum.count
        |> rem(2) == 0
    end
end
