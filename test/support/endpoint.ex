defmodule SubstrateTest.Endpoint do
  use Phoenix.Endpoint, otp_app: :substrate_test

  plug SubstrateTest.Router
end
