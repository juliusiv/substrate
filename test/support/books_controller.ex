defmodule SubstrateTest.BooksController do
  use Phoenix.Controller
  alias OpenApiSpex.Schema
  import OpenApiSpex.Operation, only: [parameter: 5]

  # defmodule QueryParams do
  #   require OpenApiSpex
    
  #   OpenApiSpex.schema(%{
  #     type: :object,
  #     properties: %{
  #       genre: %Schema{type: :string, description: "Genre filter", enum: ["modern", "sci-fi"]},
  #     },
  #     required: []
  #   })
  # end

  use SubstrateTest.Registry,
    path: "/books",
    method: :get,
    operation_id: "Books.list",
    query_string_schema: [
      parameter(:genre, :query, :string, "doot", example: "stuff", required: true)
      # parameter(:genre, :path, :string, "doot", example: "stuff", required: false)
    ]

  def list_books(conn, _params) do
    conn |> json(%{})
  end
end
