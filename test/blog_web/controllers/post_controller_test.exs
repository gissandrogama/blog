defmodule BlogWeb.PostControllerTest do
  @moduledoc """
  test module of post controller
  """
  use BlogWeb.ConnCase

  @valid_post %{
    title: "Phoenix framework",
    description: "Lorem"
  }

  @update_post %{
    title: "Update Phoenix framework",
    description: "Update Lorem"
  }

  def fixture(:post) do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    post
  end

  test "GET all posts /", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)
    Blog.Posts.create_post(user, @valid_post)

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: user.id)
      |> get(Routes.post_path(conn, :index))

    assert html_response(conn, 200) =~ "Phoenix framework"
  end

  test "GET one post for id", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    conn = get(conn, Routes.post_path(conn, :show, post))
    assert html_response(conn, 200) =~ "Phoenix framework"
  end

  test "enter the post creation form", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.post_path(conn, :new))

    assert html_response(conn, 200) =~ "Criar Post"
  end

  test "enter the post creation form without user", %{conn: conn} do
    conn =
      conn
      |> get(Routes.post_path(conn, :new))

    assert redirected_to(conn) == Routes.page_path(conn, :index)

    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Você precisa está logado!"
  end

  test "enter the post edit form", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.post_path(conn, :edit, post))

    assert html_response(conn, 200) =~ "Editar Post"
  end

  test "enter the post edit form, with outher user", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Blog.Posts.create_post(user, @valid_post)

    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 2)
      |> get(Routes.post_path(conn, :edit, post))

    assert redirected_to(conn) == Routes.page_path(conn, :index)

    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Voce não tem permissão para esta operação"
  end

  test "create post", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: @valid_post)

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "Phoenix framework"
  end

  test "create post with params ivalid", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: %{})

    assert html_response(conn, 200) =~ "campo obrigatório!"
  end

  describe "The tests below depend on a post created" do
    setup [:create_post]

    test "updated post", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: @update_post)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)

      conn = get(conn, Routes.post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Update Phoenix framework"
    end

    test "update post with params ivalid", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: %{title: nil, description: nil})

      assert html_response(conn, 200) =~ "Editar Post"
    end

    test "delete post", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> delete(Routes.post_path(conn, :delete, post))

      assert redirected_to(conn) == Routes.post_path(conn, :index)

      assert_error_sent 404, fn -> get(conn, Routes.post_path(conn, :show, post)) end
    end
  end

  defp create_post(_) do
    %{post: fixture(:post)}
  end
end
