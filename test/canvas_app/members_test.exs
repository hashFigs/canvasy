defmodule CanvasApp.MembersTest do
  use CanvasApp.DataCase

  alias CanvasApp.Members
  alias CanvasApp.Places

  describe "users" do
    alias CanvasApp.Members.User

    import CanvasApp.MembersFixtures

    @invalid_attrs %{name: nil, surname: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Members.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Members.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", surname: "some surname"}

      assert {:ok, %User{} = user} = Members.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.surname == "some surname"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Members.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", surname: "some updated surname"}

      assert {:ok, %User{} = user} = Members.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.surname == "some updated surname"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Members.update_user(user, @invalid_attrs)
      assert user == Members.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Members.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Members.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Members.change_user(user)
    end

    test "crear asociacion" do
      {:ok, location, user} = Members.create_association()
      assert location.id == user.location_id
    end
  end
end
