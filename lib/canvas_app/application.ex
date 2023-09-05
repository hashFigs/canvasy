defmodule CanvasApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CanvasAppWeb.Telemetry,
      # Start the Ecto repository
      CanvasApp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CanvasApp.PubSub},
      # Start Finch
      {Finch, name: CanvasApp.Finch},
      # Start the Endpoint (http/https)
      CanvasAppWeb.Endpoint
      # Start a worker by calling: CanvasApp.Worker.start_link(arg)
      # {CanvasApp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CanvasApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CanvasAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
