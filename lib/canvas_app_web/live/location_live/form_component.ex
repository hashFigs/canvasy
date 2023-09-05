defmodule CanvasAppWeb.LocationLive.FormComponent do
  use CanvasAppWeb, :live_component

  alias CanvasApp.Places
  alias CanvasApp.Places.Location



  @impl true
  def render(assigns) do
    ~H"""


  <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage location records in your database.</:subtitle>
      </.header>

      <h1> this is the new User / location form </h1>

      <.simple_form
        for={@form}
        id="location-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <.input field={@form[:street]} type="text" label="Street" />
        <.input field={@form[:num]} type="text" label="Number" />
        <.input field={@form[:city]} type="text" label="City" />
        <.input field={@form[:zip]} type="number" label="Zip" />
        <.input field={@form[:latitude]} type="number" label="Latitude" step="any" />
        <.input field={@form[:longitude]} type="number" label="Longitude" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Location</.button>
        </:actions>
      </.simple_form>
    </div>

  """
  end


  @impl true
  def update(%{location: location} = assigns, socket) do
    changeset = Places.change_location(location)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"location" => location_params}, socket) do
    changeset =
      socket.assigns.location
      |> Places.change_location(location_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"location" => location_params}, socket) do
    save_location(socket, socket.assigns.action, location_params)
  end

  defp save_location(socket, :edit, location_params) do
    case Places.update_location(socket.assigns.location, location_params) do
      {:ok, location} ->
        notify_parent({:saved, location})

        {:noreply,
         socket
         |> put_flash(:info, "Location updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_location(socket, :new, location_params) do
    case Places.create_location( location_params) do
      {:ok, location} ->
        notify_parent({:saved, location})

        {:noreply,
         socket
         |> put_flash(:info, "Location created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
