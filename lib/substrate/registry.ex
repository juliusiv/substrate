defmodule Substrate.Registry do
  defmacro __using__(registry_opts) do
    prefix = Keyword.get(registry_opts, :prefix, "")
    router_module = Keyword.fetch!(registry_opts, :router) |> Macro.expand(__CALLER__)
    endpoint_module = Keyword.fetch!(registry_opts, :endpoint) |> Macro.expand(__CALLER__)
    api_spec_name = "#{__CALLER__.module}.ApiSpec"
    IO.inspect(__MODULE__)
    IO.inspect(__CALLER__.module |> to_string)
    IO.inspect(api_spec_name)

    quote do
      alias Substrate.RouterArgs

      defmodule unquote(api_spec_name |> String.to_atom) do
      # defmodule SubstrateTest.Registry.ApiSpec do
        alias OpenApiSpex.{Components, Info, OpenApi, Paths, Server}
        # alias MyAppWeb.{Endpoint, Router}
        @behaviour OpenApi

        @impl OpenApi
        def spec do
          %OpenApi{
            servers: [
              # Populate the Server info from a phoenix endpoint
              Server.from_endpoint(unquote(endpoint_module))
            ],
            info: %Info{
              title: "My App",
              version: "1.0"
            },
            # Populate the paths from a phoenix router
            paths: Paths.from_router(unquote(router_module))
          }
          |> OpenApiSpex.resolve_schema_modules() # Discover request/response schemas from path specs
        end
      end

      defmacro __using__(opts) do
        path = Keyword.fetch!(opts, :path)
        path = Path.join(unquote(prefix), path)
        method = Keyword.get(opts, :method, :get)
        request_body_schema = Keyword.get(opts, :request_body_schema, nil)
        operation_id = Keyword.fetch!(opts, :operation_id)
        # response_body_schema = Keyword.get(opts, :response_body_schema, %{200 => "Empty response"})
        # response_body_schema = Keyword.get(opts, :response_body_schema, %{200 => %{}})
        response_body_schema = Keyword.get(opts, :response_body_schema, %{})
        query_string_schema = Keyword.get(opts, :query_string_schema, nil)
        headers_schema = Keyword.get(opts, :headers_schema, nil)

        quote do
          if unquote(query_string_schema != nil) do
            plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true, operation_id: unquote(operation_id)
          end

          def open_api_operation(_action) do
            apply(__MODULE__, :__substrate_open_api_operation__, [])
          end

          def __substrate_open_api_operation__() do
            %OpenApiSpex.Operation{
              operationId: unquote(operation_id),
              parameters: unquote(query_string_schema),
              responses: unquote(Macro.escape(response_body_schema))
            }
          end

          def __substrate_handles__() do
            %RouterArgs{path: unquote(path), method: unquote(method)}
          end
        end
      end
    end
  end
end
