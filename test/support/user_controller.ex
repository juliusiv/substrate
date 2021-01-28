defmodule SubstrateTest.UserController do
  use Phoenix.Controller

  use SubstrateTest.Registry,
    path: "/users/:id",
    operation_id: "Users.get",
    method: :get

  def get_user(conn, _params) do
    conn |> json(%{})
  end
end
