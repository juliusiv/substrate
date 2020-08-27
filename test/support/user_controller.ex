defmodule SubstrateTest.UserController do
  use Phoenix.Controller
  use SubstrateTest.Registry

  # @doc handles(path: "/users", method: :get)
  @doc SubstrateTest.Registry.handles(path: "/users", method: :get)
  # @doc handles(path: "/users/register", method: :post)
  # @doc handles: %{
  #   path: "/api/users/register",
  #   method: :post
  # }
  def list_users(conn, _params) do
    conn |> json(%{})
  end
end
