defmodule SubstrateTest.Router do
  use Phoenix.Router
  require Substrate

  Substrate.collect do
    entry(SubstrateTest.UserListController, :list_users)
    entry(SubstrateTest.UserController, :get_user)

    entry(SubstrateTest.BookController, :get_book)
  end
end
