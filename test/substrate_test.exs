defmodule SubstrateTest.SubstrateTest do
  use SubstrateTest.ConnCase, async: true

  describe "creates routes" do
    test "does not 404", _ do
      conn =
        :get
        |> Plug.Test.conn("/api/users")
        |> SubstrateTest.Router.call([])

      assert conn.status == 200

      conn =
        :get
        |> Plug.Test.conn("/api/users/123")
        |> SubstrateTest.Router.call([])
      
      assert conn.status == 200
    end
  end
end
