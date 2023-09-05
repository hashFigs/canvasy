defmodule CanvasAppWeb.ErrorJSONTest do
  use CanvasAppWeb.ConnCase, async: true

  test "renders 404" do
    assert CanvasAppWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert CanvasAppWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
