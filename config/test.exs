config :substrate_test, SubstrateTest.Endpoint,
  http: [port: 4002],
  server: true,
  secret_key_base: "substrate"

config :logger, level: :debug
