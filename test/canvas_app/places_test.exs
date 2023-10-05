defmodule CanvasApp.PlacesTest do
  use CanvasApp.DataCase

  alias CanvasApp.Places

  describe "locations" do
    alias CanvasApp.Places.Location

    import CanvasApp.PlacesFixtures

    @invalid_attrs %{city: nil, latitude: nil, longitude: nil, num: nil, street: nil, zip: nil}

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Places.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Places.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{
        city: "some city",
        latitude: 120.5,
        longitude: 120.5,
        num: "some num",
        street: "some street",
        zip: "some zip"
      }

      assert {:ok, %Location{} = location} = Places.create_location(valid_attrs)
      assert location.city == "some city"
      assert location.latitude == 120.5
      assert location.longitude == 120.5
      assert location.num == "some num"
      assert location.street == "some street"
      assert location.zip == "some zip"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Places.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()

      update_attrs = %{
        city: "some updated city",
        latitude: 456.7,
        longitude: 456.7,
        num: "some updated num",
        street: "some updated street",
        zip: "some updated zip"
      }

      assert {:ok, %Location{} = location} = Places.update_location(location, update_attrs)
      assert location.city == "some updated city"
      assert location.latitude == 456.7
      assert location.longitude == 456.7
      assert location.num == "some updated num"
      assert location.street == "some updated street"
      assert location.zip == "some updated zip"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Places.update_location(location, @invalid_attrs)
      assert location == Places.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Places.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Places.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Places.change_location(location)
    end
  end
end
