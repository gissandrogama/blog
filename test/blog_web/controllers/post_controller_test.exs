defmodule BlogWeb.PostControllerTest do
  @moduledoc """
  test module of post controller
  """
  use BlogWeb.ConnCase

  test "GET all posts /", %{conn: conn} do
    conn = get(conn, "/posts")
    assert html_response(conn, 200) =~ "All posts"
  end

  test "GET show posts /", %{conn: conn} do
    conn = get(conn, "/posts/1")
    assert html_response(conn, 200) =~ "Phoenix framework"
  end
end
