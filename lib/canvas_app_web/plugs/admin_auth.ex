defmodule CanvasAppWeb.Plugs.AdminAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias CanvasApp.Accounts.Account

  def init(_opts), do: nil

  def call(conn, _opts) do
    case conn.assigns[:current_account] do
      %Account{admin: true} = account ->
        # Handle the case where the email matches
        IO.puts("holaa admin! !!****")
        IO.inspect(account, limit: :infinity)

        conn
        |> assign(:current_account, account)
        |> put_flash(:success, "Welcome to your admin dashboard")

      _ ->
        IO.puts("holaa others !!!****")
        IO.inspect(conn, limit: :infinity)
        # Handle all other cases
        conn
        |> put_flash(:error, "Access denied. You must be an admin to access this page.")
        |> redirect(to: ~s"/")
        |> halt()
    end
  end
end
