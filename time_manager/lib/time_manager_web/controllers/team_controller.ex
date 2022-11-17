defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeManagerWeb
  alias TimeManager.TimeManagerWeb.Team

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    teams = TimeManagerWeb.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, team_params) do
    with {:ok, %Team{} = team} <- TimeManagerWeb.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = TimeManagerWeb.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = TimeManagerWeb.get_team!(id)

    with {:ok, %Team{} = team} <- TimeManagerWeb.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = TimeManagerWeb.get_team!(id)

    with {:ok, %Team{}} <- TimeManagerWeb.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
