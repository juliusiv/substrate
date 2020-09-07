defmodule Substrate.ControllerTest do
  use SubstrateTest.ConnCase, async: true
  alias SubstrateTest.BookController
  alias SubstrateTest.UserController
  alias SubstrateTest.UserListController
  alias Substrate.RouterArgs

  describe "creates routes" do
    test "creates the expected endpoint definition", _ do
      assert UserListController.__substrate_handles__() == %RouterArgs{
               path: "/api/users",
               method: :get
             }
      assert UserController.__substrate_handles__() == %RouterArgs{
               path: "/api/users/:id",
               method: :get
             }
      assert BookController.__substrate_handles__() == %RouterArgs{
               path: "/api/books/:id",
               method: :get
             }
    end
  end
end
