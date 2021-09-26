defmodule Blog.Posts do
  @moduledoc """
  this module has functions that interact with the database
  """
  import Ecto.Query, warn: false
  alias Blog.{Posts.Post, Repo}

  def list_posts(user \\ nil) do
    if user do
      query = from p in Post, where: p.user_id == ^user.id
      Repo.all(query)
    else
      Repo.all(Post)
    end
  end

  def get_post!(id), do: Repo.get!(Post, id)
  def get_post_with_comments!(id), do: Repo.get!(Post, id) |> Repo.preload(comments: [:user])

  def create_post(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:posts)
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(post, post_params) do
    post
    |> Post.changeset(post_params)
    |> Repo.update()
  end

  def delete(id) do
    get_post!(id)
    |> Repo.delete!()
  end
end
