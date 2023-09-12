defmodule CanvasAppWeb.AdminIndexLive do

  use CanvasAppWeb, :live_view

  def render(assigns) do
    ~H"""
       <div class="mx-auto max-w-sm border-2">
      <.header class="text-center">
        Upload members
        <:subtitle>
          use the follow button to bulk upload members into your personal space?

          <.button> csv Upload </.button>
        </:subtitle>
      </.header>


    </div>

    <div class="mx-auto max-w-sm border-2">
      <.header class="text-center">
        Invite your team members
        <:subtitle>

          <.button> invite team member </.button>
        </:subtitle>
      </.header>


    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket }
  end

end
