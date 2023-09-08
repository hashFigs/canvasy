defmodule CanvasAppWeb.UserLive.FormComponent do
  use CanvasAppWeb, :live_component

  alias CanvasApp.Members



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

        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:surname]} type="text" label="Surname" />
        <.input field={@form[:street]} type="text" label="Street" />
        <.input field={@form[:num]} type="text" label="Number" />
        <.input field={@form[:city]} type="text" label="City" />
        <.input field={@form[:zip]} type="number" label="Zip" />
        <.input field={@form[:latitude]} type="number" label="Latitude" step="any" />
        <.input field={@form[:longitude]} type="number" label="Longitude" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User</.button>
        </:actions>
      </.simple_form>
    </div>

  """
  end


  @impl true
  def update(%{user: user} = assigns, socket) do
    changeset = Members.change_user(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      socket.assigns.user
      |> Members.change_user(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    save_user(socket, socket.assigns.action, user_params)
  end

  defp save_user(socket, :edit, user_params) do
    case Members.update_user(socket.assigns.user, user_params) do
      {:ok, user} ->
        notify_parent({:saved, user})

        {:noreply,
         socket
         |> put_flash(:info, "user updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user(socket, :new, user_location_params) do




    #case Members.create_user( user_params) do
    IO.puts ("###!")
    IO.inspect(user_location_params)
    IO.puts ("###!")
    %{"city" => city, "latitude" => latitude, "longitude" => longitude, "name" => name, "num" => num, "street"=> street, "surname"=> surname, "zip" => zip} =  user_location_params
    location_params = %{street: street, num: num, zip: zip, city: city, latitude: latitude, longitude: longitude}
    user_params = %{name: name, surname: surname}


    case Members.create_association(user_params, location_params) do
      {:ok, _location, user} ->
        notify_parent({:saved, user})

        {:noreply,
         socket
         |> put_flash(:info, "user created successfully")
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
