defmodule CanvasAppWeb.UserLive.Import do
  use CanvasAppWeb, :live_view
  alias CanvasApp.Members.Importer

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:parsed_rows, [])
     |> assign(:imported_users, [])
     |> assign(:sample_users, [])
     |> assign(:uploaded_files, [])
     |> allow_upload(:sample_csv, accept: ~w(.csv), max_entries: 1)}
  end

  @impl true
  def handle_event("reset", _, socket) do
    {
      :noreply,
      socket
      |> assign(:parsed_rows, [])
      |> assign(:imported_users, [])
      |> assign(:sample_users, [])
      |> assign(:uploaded_files, [])
    }
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("parse", _, socket) do
    parsed_rows = parse_csv(socket)

    IO.inspect(parsed_rows, label: "sdsrows")

    {
      :noreply,
      socket
      |> assign(:parsed_rows, parsed_rows)
      |> assign(:sample_users, Importer.preview(parsed_rows))
      |> assign(:uploaded_files, [])
    }
  end

  def handle_event("import", _, socket) do
    imported_users = Importer.import(socket.assigns.parsed_rows)

    {
      :noreply,
      socket
      |> assign(:sample_users, [])
      |> assign(:imported_users, imported_users)
    }
  end

  defp parse_csv(socket) do
    consume_uploaded_entries(socket, :sample_csv, fn %{path: path}, _entry ->
      rows =
        path
        |> File.stream!()
        |> CSV.decode!(headers: true)
        |> Enum.to_list()

      {:ok, rows}
    end)
    |> List.flatten()
  end
end
