defmodule GallowsWeb.HangmanController do
  use GallowsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def store(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    put_session(conn, :game, game)
    |> render("game.html", tally: tally)
  end

  def guess(conn, params) do
    tally =
      conn
      |> get_session(:game)
      |> Hangman.guess(params["game"]["guess"])

    put_in(conn.params["game"]["guess"], "")
    |> render("game.html", tally: tally)
  end
end
