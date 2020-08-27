defmodule Substrate.Controller do
  @moduledoc """
  Used within a controller file to make sense of @doc annotations that spec a handler.
  """

  alias Substrate.Entry

  defmacro __using__(_opts) do
    quote do
      @doc false
      @spec entry(atom()) :: Entry.t()
      def entry(name),
        do: unquote(__MODULE__).__api_operation__(__MODULE__, name)

      defoverridable entry: 1
    end
  end

  @doc false
  @spec __api_operation__(module(), atom()) :: Entry.t() | nil
  def __api_operation__(module, name) do
    IO.inspect(module)
    IO.inspect(Code.fetch_docs(module))
    with {:ok, entry} <- get_docs(module, name) do
      entry
    else
      _ -> nil
    end
  end

  defp get_docs(module, name) do
    {:docs_v1, _anno, _lang, _format, _module_doc, mod_meta, mod_docs} = Code.fetch_docs(module)

    doc_for_function =
      Enum.find(mod_docs, fn
        {{:function, ^name, _}, _, _, _, _} -> true
        _ -> false
      end)
    IO.inspect(doc_for_function)

    case doc_for_function do
      {_, _, _, :none, %{handles: entry}} ->
        {:ok, entry}

      {_, _, _, :none, %{}} ->
        IO.warn("No docs found for function #{module}.#{name}/2")

      {_, _, _, :hidden, %{}} ->
        nil

      _ ->
        IO.warn("Invalid docs declaration found for function #{module}.#{name}/2")
        nil
    end
  end
end
