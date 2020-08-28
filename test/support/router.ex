defmodule SubstrateTest.Router do
  use Phoenix.Router
  require Substrate

  Substrate.collect_all do
    entry(SubstrateTest.UserController, :list_users)
    entry(SubstrateTest.UserController, :get_user)
  end
end
