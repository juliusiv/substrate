# Substrate

![Build Status](https://github.com/juliusiv/substrate/workflows/ci/badge.svg) ![Docs Status](https://github.com/juliusiv/substrate/workflows/docs/badge.svg)

_Substrate_ combines [Open API Spex](https://github.com/open-api-spex/open_api_spex) and decentralized routing definitions for REST services. This package is heavily inspired by [Flask-Rebar](https://github.com/plangrid/flask-rebar).


## Features

- **Automatic OpenAPI generation** via Open API Spex.
- **Request, response, and query param validation** via Open API Spex.
- **Decentralized routing definitions** move route definitions out of the Phoenix router and into your controllers, alongside the rest of the endpoint's OpenAPI specifications.


## Example

```elixir
# lib/your_app_web/registry.ex

defmodule YourAppWeb.Registry do
  use Substrate.Registry, prefix: "/api"
end


# lib/your_app_web/router.ex

defmodule YourAppWeb.Router do
  use Phoenix.Router
  require Substrate

  Substrate.collect_all do
    entry(YourAppWeb.UserController, :list_users)
    entry(YourAppWeb.UserController, :get_users)
  end
end


# lib/your_app_web/controllers/users_controller.ex

defmodule YourAppWeb.UserListController do
  use Phoenix.Controller
  use YourAppWeb.Registry,
    path: "/users",
    pethod: :get

  def list_users(conn, _path_args_, _validated_params_, _request_body) do
    conn
    |> json(%{
      data: [%{name: "John McPhee"}]
    })
  end
end
```


## Installation

The package can be installed by adding `substrate` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:substrate, "~> 0.1"}
  ]
end
```
