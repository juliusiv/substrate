defmodule SubstrateTest.Registry do
  use Substrate.Registry,
    prefix: "/api",
    router: SubstrateTest.Router,
    endpoint: SubstrateTest.Endpoint
end
