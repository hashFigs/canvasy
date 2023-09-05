defmodule CanvasApp.Repo do
  use Ecto.Repo,
    otp_app: :canvas_app,
    adapter: Ecto.Adapters.Postgres
end
