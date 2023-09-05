defmodule CanvasApp.PlacesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CanvasApp.Places` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        city: "some city",
        latitude: 120.5,
        longitude: 120.5,
        num: "some num",
        street: "some street",
        zip: "some zip"
      })
      |> CanvasApp.Places.create_location()

    location
  end
end
