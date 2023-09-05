defmodule CanvasApp.Places.Location do
  use Ecto.Schema
  import Ecto.Changeset
  alias CanvasApp.Members.User

  schema "locations" do
    field :city, :string
    field :latitude, :float
    field :longitude, :float
    field :num, :string
    field :street, :string
    field :zip, :string

    has_many :users, User
    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:street, :num, :zip, :city, :latitude, :longitude])
    |> validate_required([:street, :num, :zip, :city, :latitude, :longitude])
  end
end
