defmodule Substrate do
  @doc """
  Mostly just a helper to make it nice to define entries.
  """
  defmacro collect(do_block) do
    quote do
      import Substrate, only: [entry: 2]

      pipeline :substrate do
        # plug OpenApiSpex.Plug.PutApiSpec, module: MyAppWeb.ApiSpec
        plug OpenApiSpex.Plug.PutApiSpec, module: SubstrateTest.Registry.ApiSpec
      end

      unquote(do_block)
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
        pipe_through :substrate
        unquote(method)(unquote(path), unquote(module), unquote(function_name))
      end
    end
  end
end
