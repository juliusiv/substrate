defmodule Substrate do
  @doc """
  Mostly just a helper make it nice to define entries.
  """
  defmacro collect_all(do_block) do
    quote do
      import Substrate.Registry, only: [entry: 2]
      unquote(do_block)
    end
  end
end
