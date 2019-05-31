defmodule BlockninjasApi.Repo do
  use Ecto.Repo,
    otp_app: :blockninjas_api,
    adapter: Ecto.Adapters.Postgres
end
