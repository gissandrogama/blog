defmodule BlogWeb.PageControllerTest do
  @moduledoc """
  test module of page controller
  """
  use BlogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
