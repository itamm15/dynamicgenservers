defmodule Dynamicgenservers.Repo do
  use Ecto.Repo,
    otp_app: :dynamicgenservers,
    adapter: Ecto.Adapters.Postgres
end
