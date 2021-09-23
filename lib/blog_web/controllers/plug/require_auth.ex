defmodule BlogWeb.Plug.RequireAuth do
  @moduledoc """
  This module of plug that verify user authenticate
  """
  use BlogWeb, :controller

  def init(_), do: nil

  def call(conn, _) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "Você precisa está logado!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
