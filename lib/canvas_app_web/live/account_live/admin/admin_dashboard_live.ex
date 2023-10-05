defmodule CanvasAppWeb.AccountLive.Admin.AdminDashboardLive do
  use CanvasAppWeb, :live_view

  # @layout CanvasAppWeb.Live.Layouts.AdminLayout

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
