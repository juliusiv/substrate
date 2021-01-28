defmodule Substrate.RegistryTest do
  use SubstrateTest.ConnCase, async: true
  alias SubstrateTest.BooksController
  alias SubstrateTest.UserController
  alias Substrate.RouterArgs

  describe "creates routes" do
    test "creates the expected endpoint definition", _ do
      assert UserController.__substrate_handles__() == %RouterArgs{
               path: "/api/users/:id",
               method: :get
             }
      assert BooksController.__substrate_handles__() == %RouterArgs{
               path: "/api/books",
               method: :get
             }
    end
  end
end
