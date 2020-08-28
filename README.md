# Substrate

_Substrate_ combines [Open API Spex](https://github.com/open-api-spex/open_api_spex) and decentralized routing definitions for REST services.

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

defmodule YourAppWeb.UsersController do
  use Phoenix.Controller
  alias YourAppWeb.Registry

  @doc Registry.handles(path: "/users", method: :get)
  def list_users(conn, _path_args_, _validated_params_, _request_body) do
    conn
    |> json(%{
      data: [%{name: "John McPhee"}]
    })
  end

  @doc Registry.handles(path: "/users/:id", method: :get)
  def get_user(conn, %{id: user_id}, nil, nil) do
    conn
    |> json(%{
      data: %{name: "John McPhee"}
    })
  end
end
```
