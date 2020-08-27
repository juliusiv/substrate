defmodule SubstrateTest.Router do
  use Phoenix.Router
  require Substrate

  Substrate.collect_all do
    entry(SubstrateTest.UserController, :list_users)
  end
end
