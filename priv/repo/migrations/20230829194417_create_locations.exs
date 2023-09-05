defmodule CanvasApp.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :street, :string
      add :num, :string
      add :zip, :string
      add :city, :string
      add :latitude, :float
      add :longitude, :float

      timestamps()
    end
  end
end
