defmodule Substrate.Registry do
  defmacro __using__(opts) do
    prefix = Keyword.get(opts, :prefix, "")

    quote do
      use Substrate.Controller
      alias Substrate.EndpointDefinition

      defmacro __using__(_opts) do
        quote do
          use Substrate.Controller
        end
      end

      def handles(opts) do
        path = Keyword.fetch!(opts, :path)
        path = Path.join(unquote(prefix), path)
        method = Keyword.get(opts, :method, :get)

        [handles: %EndpointDefinition{path: path, method: method}]
      end
    end
  end

  @doc """
  Create a scope with one path entry for each registered handler.
  """
  defmacro entry(module, function_name) do
    module = Macro.expand(module, __CALLER__)
    %{method: method, path: path} = module.endpoint_definition(function_name)

    quote do
      # Creating a scope for each endpoint is a bit redundant but it makes a nice sandbox for
      # each handler.
      scope "/" do
        unquote(method)(unquote(path), unquote(module), unquote(function_name))
      end
    end
  end
end
