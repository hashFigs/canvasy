defmodule CanvasAppWeb.Live.Layouts.AdminLayout do
  use CanvasAppWeb, :live_view

  def render(assigns) do
    ~L"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Admin Zone - <%= @title %></title>
      <!-- Add your CSS and JavaScript includes here -->
    </head>
    <body>
      <header>
        <!-- Your header content here -->
          <h1> this is the layout template </h1>
      </header>
      <nav>
        <!-- Navigation menu for admin zone here -->
      </nav>
      <main>
        <%= assigns[:content] %> <!-- Render the LiveView content -->
      </main>
      <footer>
        <!-- Your footer content here -->
      </footer>
    </body>
    </html>
    """
  end
end
