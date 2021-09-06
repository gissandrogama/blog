defmodule BlogWeb.CommentsChannel do
  use BlogWeb, :channel

  def join(name, _payload, socket), do: {:ok, %{name: "Deu certo!!!"}, socket}

  def handle_in() do
  end
end
