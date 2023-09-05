defmodule CanvasAppWeb.UserLive.Index do
  use CanvasAppWeb, :live_view
  alias CanvasApp.Members
  alias CanvasApp.Members.User
  alias CanvasApp.Places.Location


  @impl true
  def mount(_params, _session, socket) do

    {:ok, stream(socket, :users,  Members.list_users())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end




  defp apply_action(socket, :index, _params) do

   users = Members.list_users()

    IO.inspect(users)

    socket
    |> assign(:page_title, "Listing Locations")
    |> assign(:user, nil)

  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:location, %Location{})
    |> assign(:user, %User{})

  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Members.get_user!(id)
    {:ok, _} = Members.delete_user(user)

    {:noreply, stream_delete(socket, :users, user)}
  end


end
