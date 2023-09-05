defmodule CanvasAppWeb.LocationLive.Show do
  use CanvasAppWeb, :live_view

  alias CanvasApp.Places
  alias CanvasApp.Members

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  @spec handle_params(map, any, %{
          :assigns => atom | %{:live_action => :edit | :show, optional(any) => any},
          optional(any) => any
        }) :: {:noreply, map}
  def handle_params(%{"id" => id}, _, socket) do


     members = Members.list_users()
     IO.inspect(members)

     [ member | _rest ] = members

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:location, Places.get_location!(id))
     |> assign(:member, member)}
  end

  defp page_title(:show), do: "Show Location"
  defp page_title(:edit), do: "Edit Location"
end
