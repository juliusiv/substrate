defmodule Substrate.Entry do
  @enforce_keys :path
  defstruct method: :get,
            path: nil

  @type t :: %__MODULE__{
    method: :get | :post | :patch | :put | :delete | :head,
    path: String.t(),
  }
end
