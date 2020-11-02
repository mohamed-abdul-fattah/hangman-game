defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  @states %{
    won: {:success, "You won!"},
    lost: {:danger, "You lost!"},
    good_guess: {:success, "Good guess!"},
    bad_guess: {:warning, "Bad guess!"},
    already_used: {:info, "You already guessed that!"}
  }

  def word_so_far(tally = %{letters: _list}) do
    tally.letters |> Enum.join(" ")
  end

  def game_state(state) do
    @states[state]
    |> alert()
  end

  def new_game_btn(conn) do
    button("Create a new game", to: Routes.hangman_path(conn, :store))
  end

  def game_over?(%{game_state: state}) do
    state in [:won, :lost]
  end

  def turn(left, target) when target >= left do
    "opacity: 1"
  end

  def turn(_left, _target) do
    "opacity: 0"
  end

  defp alert(nil), do: ""

  defp alert({class, msg}) do
    """
      <div class="alert alert-#{class}">#{msg}</div>
    """
    |> raw()
  end
end
