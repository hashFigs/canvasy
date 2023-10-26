defmodule CanvasApp.Repo.Migrations.ProjectsAddUserIdColumn do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :user_id, references(:accounts, on_delete: :delete_all)
    end
  end
end
