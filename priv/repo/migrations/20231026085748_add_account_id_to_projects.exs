defmodule CanvasApp.Repo.Migrations.AddAccountIdToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :account_id, references(:accounts, on_delete: :nothing)
    end
  end
end
