defmodule CanvasAppWeb.LocationLive.Show do
  use CanvasAppWeb, :live_view

  alias CanvasApp.Places
  #alias CanvasApp.Members
  #alias CanvasApp.Repo

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

    ## Do AQUERI IN USERS AND GET THE ONE WITH LOCATION_ID = ID
    #location = Places.get_location!(id)
    #location_with_users = Repo.preload(location, :users)

     location = Places.get_location_with_users!(id)
     IO.inspect(location)
    # IO.inspect(members)
    # [ member | _rest ] = members

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:location, location)
     |> assign(:members, location.users)}
  end

  defp page_title(:show), do: "Show Location"
  defp page_title(:edit), do: "Edit Location"
end
