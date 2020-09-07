defmodule SubstrateTest.BookController do
  use Phoenix.Controller

  use SubstrateTest.Registry,
    path: "/books/:id",
    method: :get
  def get_book(conn, _params) do
    conn |> json(%{})
  end
end
