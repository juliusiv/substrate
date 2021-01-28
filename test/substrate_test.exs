defmodule Substrate.SubstrateTest do
  use SubstrateTest.ConnCase, async: true

  describe "creates routes" do
    test "does not 404", %{conn: conn} do
      conn = get(conn, "/api/users/123")
      assert conn.status == 200

      conn = get(conn, "/api/books")
      assert conn.status == 200
    end
  end

  describe "query param validation" do
    test "returns errors for invalid params", %{conn: conn} do
      # conn = get(conn, "/api/books", %{"genre" => "badbadnotgood" })
      conn = get(conn, "/api/books")
      IO.inspect(conn)
      assert conn.status == 400
    end
  end
end
