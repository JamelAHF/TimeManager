defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeManagerWeb
  alias TimeManager.TimeManagerWeb.Clock

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = TimeManagerWeb.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, clock_params) do
    with {:ok, %Clock{} = clock} <- TimeManagerWeb.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, clock_params) do
    clock = TimeManagerWeb.get_clock!(clock_params["id"])
    render(conn, "show.json", clock: clock)
  end

  def show_last_clock(conn, _params) do
    current_user = conn.assigns.current_user
    clocks = TimeManagerWeb.get_clock_by_user!(current_user.id)
    render(conn, "index.json", clocks: clocks)
  end

  def create_clock_by_token(conn, clock_params) do
    c = %{"status" => clock_params["status"], "time" => clock_params["time"], "user" => conn.assigns.current_user.id}
    with {:ok, %Clock{} = clock} <- TimeManagerWeb.create_clock(c) do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

end
