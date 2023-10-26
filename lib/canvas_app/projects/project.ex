defmodule CanvasApp.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias CanvasApp.Accounts.Account
  alias CanvasApp.Projects.Project
  alias CanvasApp.Repo


  schema "projects" do
    field :description, :string
    field :name, :string
    field :user_id, :integer

    belongs_to :account, Account
    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name, :description])
  end

  def delete_project(project_id) do
    # Fetch the project by ID
    project = Repo.get(Project, project_id)

    # Check if the project exists
    case project do
      nil -> {:error, "Project not found"}
      _ ->
        # Delete the project
        case Repo.delete(project) do
          {:ok, _deleted_project} -> {:ok, project}
          {:error, _reason} -> {:error, "Failed to delete project"}
        end
    end
  end


end
