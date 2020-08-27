use Mix.Config

config :phoenix, :json_library, Jason

config :substrate_test, SubstrateTest.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "does-not-matter",
