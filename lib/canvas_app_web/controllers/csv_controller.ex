defmodule CanvasAppWeb.CsvController do
  use CanvasAppWeb, :controller
  alias CanvasApp.Members.Importer

  def index(conn, _params) do
    csv_data = Importer.empty_csv_data()

    send_download(
      conn,
      {:binary, csv_data},
      content_type: "application/csv",
      filename: "sample-import.csv"
    )
  end
end
