defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  def index(conn, _params) do
    posts = [%{title: "Phoenix"}, %{title: "LiveView"}, %{title: "Elixir"}]
    render(conn, "index.html", posts: posts)
  end
end
