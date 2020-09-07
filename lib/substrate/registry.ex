defmodule Substrate.Registry do
  defmacro __using__(registry_opts) do
    prefix = Keyword.get(registry_opts, :prefix, "")

    quote do
      alias Substrate.RouterArgs

      defmacro __using__(opts) do
        path = Keyword.fetch!(opts, :path)
        path = Path.join(unquote(prefix), path)
        method = Keyword.get(opts, :method, :get)
        request_body_schema = Keyword.get(opts, :request_body_schema, nil)
        response_body_schema = Keyword.get(opts, :response_body_schema, nil)
        query_string_schema = Keyword.get(opts, :query_string_schema, nil)
        headers_schema = Keyword.get(opts, :headers_schema, nil)

        quote do
          def __substrate_handles__() do
            %RouterArgs{path: unquote(path), method: unquote(method)}
          end
        end
      end
    end
  end

  @doc """
  Create a scope with one path entry for each registered handler.
  """
  defmacro entry(module, function_name) do
    module = Macro.expand(module, __CALLER__)
    router_args = module.__substrate_handles__()
    %{method: method, path: path} = router_args

    quote do
      # Creating a scope for each endpoint is a bit redundant but it makes a nice sandbox for
      # each handler.
      scope "/" do
        unquote(method)(unquote(path), unquote(module), unquote(function_name))
      end
    end
  end
end
