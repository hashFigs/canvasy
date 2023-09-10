defmodule CanvasApp.Members do
  @moduledoc """
  The Members context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias CanvasApp.Places
  alias CanvasApp.Repo

  alias CanvasApp.Members.User
  alias CanvasApp.Places.Location
  alias CanvasApp.Places.MyGeocoder
  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

def create_association(user_params, location_params) do
 # location_params = %{street: "street", num: "num", zip: "zip", city: "city", latitude: 1.0, longitude: 1.0}
 # user_params = %{name: "name", surname: "surname"}

  # Create and insert the Location

  adress = "#{location_params.num}, #{location_params.street}, #{location_params.zip}, #{location_params.city}"
  {:ok, {:ok,%{"lat" => lat, "lng" => lng}}}= MyGeocoder.geocode_address(adress)

   geo_params = %{latitude: lat, longitude: lng}
   place_params = Map.merge(location_params, geo_params)

##

  location =
    case Places.find_location_by(location_params) do
      nil -> create_location(location_params)
      existing_location -> existing_location
    end




  #check if location exists
  IO.puts "HOL!!@@@"

  #location =  Places.find_location_by(location_params)


  IO.inspect(location, label: "location")

  #if it doesnt exist create
  #{:ok, location} = create_location(place_params)

  # Create and insert the User, associating it with the Location
  {:ok, user} = create_user_with_location(user_params, location)

  {:ok, location, user}
end

defp create_location(location_params) do
  %Location{}
  |> Location.changeset(location_params)
  |> Repo.insert()
end

defp create_user_with_location(user_params, location) do
  %User{}
  |> User.changeset(user_params)
  |> Ecto.Changeset.put_assoc(:location, location)
  |> Repo.insert()
end

def get_users_by_location(location) do

  from u in User,
    where: u.location_id == ^location.id,
    select: u
end



  def create_user(attrs \\ %{}) do
    #check if location exists
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()

  end


  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
