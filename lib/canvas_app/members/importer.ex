defmodule CanvasApp.Members.Importer do

  alias CanvasApp.Members.User
  alias CanvasApp.Members

  def empty_csv_data do
    [["First Name", "Last Name", "Num", "Street", "City", "Zip"]]
    |> CSV.encode()
    |> Enum.to_list()
  end


  def preview(rows) do
    rows
    |> Enum.take(5)
    |> transform_keys()
    |> Enum.map(fn attrs ->
      Members.change_user(%User{}, attrs)
      |> Ecto.Changeset.apply_changes()
    end)
  end

  def import(rows) do
    IO.inspect(rows)
    rows
    |> transform_keys()
    |> Enum.map(fn attrs ->
      Members.create_user(attrs)
    end)
  end

  # "First Name" => "first_name"
  defp transform_keys(rows) do
    rows
    |> Enum.map(fn row ->
      Enum.reduce(row, %{}, fn {key, val}, map ->
        Map.put(map, underscore_key(key), val)
      end)
    end)
  end

  defp underscore_key(key) do
    key
    |> String.replace(" ", "")
    |> Phoenix.Naming.underscore()
  end

end
