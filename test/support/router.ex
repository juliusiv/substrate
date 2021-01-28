defmodule SubstrateTest.Router do
  use Phoenix.Router
  require Substrate

  Substrate.collect do
    entry(SubstrateTest.UserController, :get_user)
    entry(SubstrateTest.BooksController, :list_books)
  end
end
