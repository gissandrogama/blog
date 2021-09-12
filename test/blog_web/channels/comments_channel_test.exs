defmodule BlogWeb.CommentsChannelTest do
  use BlogWeb.ChannelCase

  alias BlogWeb.UserSocket

  @valid_post %{
    title: "Channel in Phoenix Framework",
    description: "Lorem"
  }

  test "connect socket" do
    {:ok, post} = Blog.Posts.create_post(@valid_post)
    {:ok, socket} = connect(UserSocket, %{})
    {:ok, comments, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    assert post.id == socket.assigns.post_id
    assert [] == comments.comments
  end
end
