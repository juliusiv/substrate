defmodule Substrate.Controller do
  @moduledoc """
  Used within a controller file to make sense of @doc annotations that spec a handler.
  """

  alias Substrate.EndpointDefinition

  defmacro __using__(_opts) do
    quote do
      @doc false
      @spec endpoint_definition(atom()) :: EndpointDefinition.t()
      def endpoint_definition(name),
        do: unquote(__MODULE__).__endpoint_definition__(__MODULE__, name)

      defoverridable endpoint_definition: 1
    end
  end

  @doc false
  @spec __endpoint_definition__(module(), atom()) :: EndpointDefinition.t() | nil
  def __endpoint_definition__(module, name) do
    with {:ok, definition} <- get_docs(module, name) do
      definition
    else
      _ -> nil
    end
  end

  defp get_docs(module, name) do
    {:docs_v1, _anno, _lang, _format, _module_doc, _mod_meta, mod_docs} = Code.fetch_docs(module)

    doc_for_function =
      Enum.find(mod_docs, fn
        {{:function, ^name, _}, _, _, _, _} -> true
        _ -> false
      end)

    case doc_for_function do
      {_, _, _, :none, %{handles: definition}} ->
        {:ok, definition}

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
