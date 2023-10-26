defmodule CanvasAppWeb.ProjectLive.Index do
  use CanvasAppWeb, :live_view
  alias CanvasApp.Projects
  alias CanvasApp.Projects.Project

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :projects, Projects.list_projects())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end



  defp apply_action(socket, :index, _params) do
    # projects = Projects.list_projects()

    socket
    |> assign(:page_title, "Projects Index")
    |> assign(:project, nil)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Project")
    |> assign(:project, %Project{})
  end
end
