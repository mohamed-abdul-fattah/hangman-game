defmodule Dictionary.WordList do
    @proc_name __MODULE__

    def random_word() do
        Agent.get(@proc_name, &Enum.random/1)
    end

    def start_link() do
        Agent.start_link(&word_list/0, name: @proc_name)
    end

    defp word_list do
        "../../assets/words.txt"
        |> Path.expand(__DIR__)
        |> File.read!
        |> String.split(~r/\n/)
    end
end
