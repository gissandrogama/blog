defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Posts.Post

  def index(conn, _params) do
    posts = Post |> Blog.Repo.all()
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
