defmodule CanvasApp.MembersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CanvasApp.Members` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name",
        surname: "some surname"
      })
      |> CanvasApp.Members.create_user()

    user
  end
end
