defmodule SubstrateTest.UserController do
  use Phoenix.Controller
  use SubstrateTest.Registry

  @doc SubstrateTest.Registry.handles(path: "/users", method: :get)
  def list_users(conn, _params) do
    conn |> json(%{})
  end

  @doc SubstrateTest.Registry.handles(path: "/users/:id", method: :get)
  def get_user(conn, _params) do
    conn |> json(%{})
  end
end
