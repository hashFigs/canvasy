defmodule CanvasApp.Members.User do
  use Ecto.Schema
  import Ecto.Changeset
  #alias CanvasApp.Members.User
  alias CanvasApp.Places.Location

  schema "users" do
    field :name, :string
    field :surname, :string

    belongs_to :location, Location

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :surname])
    |> validate_required([:name, :surname])
  end

end
