defmodule SubstrateTest.UserListController do
  use Phoenix.Controller
  use SubstrateTest.Registry,
    path: "/users",
    method: :get

  def list_users(conn, _params) do
    conn |> json(%{})
  end
end
