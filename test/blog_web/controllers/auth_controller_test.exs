defmodule BlogWeb.AuthControllerTest do
  @moduledoc """
  test module of auth controller
  """
  use BlogWeb.ConnCase

  @ueberauth %Ueberauth.Auth{
    credentials: %{
      token: "12345"
    },
    info: %{
      email: "test@test.com",
      first_name: "Gissandro",
      last_name: "Gama",
      image: "imagem12345"
    },
    provider: "google"
  }

  @ueberauth_error %{
    credentials: %{
      token: nil
    },
    info: %{
      email: "test@test.com",
      first_name: "Gissandro",
      last_name: "Gama",
      image: "imagem12345"
    },
    provider: "google"
  }

  test "callback success", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth)
      |> get(Routes.auth_path(conn, :callback, "google"))

    assert redirected_to(conn) == Routes.page_path(conn, :index)

    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Bem vindo!!! #{@ueberauth.info.email}"
  end

  test "callback error", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_error)
      |> get(Routes.auth_path(conn, :callback, "google"))

    assert redirected_to(conn) == Routes.page_path(conn, :index)

    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Atenticação deu errado"
  end

  test "logout success", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 2)
      |> get(Routes.auth_path(conn, :logout))


    assert redirected_to(conn) == Routes.page_path(conn, :index)
  end
end
