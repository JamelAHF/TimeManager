defmodule TimeManagerWeb.GroupController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeManagerWeb
  alias TimeManager.TimeManagerWeb.Group

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    groups = TimeManagerWeb.list_groups()
    render(conn, "index.json", groups: groups)
  end


  def create(conn, group_params) do
    with {:ok, %Group{} = group} <- TimeManagerWeb.create_group(group_params) do

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.group_path(conn, :show, group))
      |> render("show.json", group: group)
    end
  end

  def show(conn, group_params) do
    group = TimeManagerWeb.get_group!(group_params["id"])
    render(conn, "show.json", group: group)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = TimeManagerWeb.get_group!(id)

    with {:ok, %Group{} = group} <- TimeManagerWeb.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end

  def delete(conn,group_params) do
    group = TimeManagerWeb.get_group!(group_params["id"])

    with {:ok, %Group{}} <- TimeManagerWeb.delete_group(group) do
      send_resp(conn, :no_content, "")
    end
  end
end
