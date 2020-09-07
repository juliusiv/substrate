defmodule SubstrateTest.Schemas do
  alias OpenApiSpex.Schema

  defmodule User do
    require OpenApiSpex
    
    OpenApiSpex.schema(%{
      title: "User",
      description: "A user",
      type: :object,
      properties: %{
        name: %Schema{type: :string, description: "User name", pattern: ~r/[a-zA-Z][a-zA-Z0-9_]+/},
        email: %Schema{type: :string, description: "Email address", format: :email}
      },
      required: [:name, :email]
    })
  end

  defmodule Book do
    require OpenApiSpex
    
    OpenApiSpex.schema(%{
      title: "Book",
      description: "A book",
      type: :object,
      properties: %{
        author: %Schema{type: :string, description: "Author name"},
        title: %Schema{type: :string, description: "Book title"}
      },
      required: [:author, :title]
    })
  end
end
