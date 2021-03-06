defmodule Blog.PostsTest do
  @moduledoc """
  this module of test the posts context
  """
  use Blog.DataCase

  alias Blog.{Posts, Posts.Post}

  @valid_post %{
    title: "Phoenix framework",
    description: "Lorem"
  }

  @update_post %{
    title: "Update Phoenix framework",
    description: "Update Lorem"
  }

  def post_fixture(_attrs \\ %{}) do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Posts.create_post(user, @valid_post)
    post
  end

  test "list_posts/0 return all posts" do
    post_fixture()
    assert Posts.list_posts() |> Enum.count() == 3
  end

  test "get_post/1 return post" do
    post = post_fixture()
    assert Posts.get_post!(post.id) == post
  end

  test "create_post/1 with valid data" do
    user = Blog.Accounts.get_user!(1)
    assert {:ok, %Post{} = post} = Posts.create_post(user, @valid_post)
    assert post.title == "Phoenix framework"
    assert post.description == "Lorem"
  end

  test "update_post/2 with valid data" do
    post = post_fixture()
    assert {:ok, %Post{} = post} = Posts.update_post(post, @update_post)
    assert post.title == "Update Phoenix framework"
    assert post.description == "Update Lorem"
  end

  test "delete/1" do
    post = post_fixture()
    assert post = Posts.delete(post.id)
    assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
  end
end
