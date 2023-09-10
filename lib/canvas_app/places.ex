defmodule CanvasApp.Places do
  @moduledoc """
  The Places context.
  """

  import Ecto.Query, warn: false
  alias CanvasApp.Repo

  alias CanvasApp.Places.Location


  def list_locations do
    Repo.all(Location)
  end

  def get_location!(id), do: Repo.get!(Location, id)

  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

   def hello do
     IO.puts "hello"
   end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{data: %Location{}}

  """

  def get_location_with_users!(id) do
    Repo.get(Location, id) |> Repo.preload(:users)
  end


  def change_location(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end

  def find_location_by(attrs) do
    %{city: city, num: num, street: street, zip: zip} = attrs
    query = from l in Location,
      where: l.city == ^city and l.num == ^num and l.street == ^street and l.zip == ^zip,
      limit: 1

     Repo.one(query)
  end



end
