defmodule CanvasApp.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end
