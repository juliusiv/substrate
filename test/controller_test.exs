defmodule Substrate.ControllerTest do
  use SubstrateTest.ConnCase, async: true
  alias SubstrateTest.UserController
  alias Substrate.EndpointDefinition

  describe "creates routes" do
    test "does not 404", _ do
      assert UserController.endpoint_definition(:list_users) == %EndpointDefinition{
               path: "/api/users",
               method: :get
             }
    end
  end
end
