defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.TimeManagerWeb
  alias TimeManager.TimeManagerWeb.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = TimeManagerWeb.list_workingtimes()
    IO.inspect(workingtimes)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, working_time_params) do
    current_user = conn.assigns.current_user.id
    new_params = %{"start" =>working_time_params["start"], "end" =>working_time_params["end"], "user" => current_user}
    with {:ok, %WorkingTime{} = working_time} <- TimeManagerWeb.create_working_time(new_params) do

      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def show(conn, working_time_params) do
    working_time = TimeManagerWeb.get_working_time!(working_time_params["id"])
    IO.inspect(working_time)
    render(conn, "show.json", working_time: working_time)
  end

  def show_by_params(conn, working_time_params) do
    working_time = TimeManagerWeb.get_working_time_by_params!(working_time_params)
    IO.inspect(working_time)
    render(conn, "index.json", workingtimes: working_time)
  end

  def get_by_params(conn, working_time_params) do
    working_time = TimeManagerWeb.get_working_time_by_params!(working_time_params)
    IO.inspect(working_time)
    render(conn, "index.json", workingtimes: working_time)
  end


  def get_by_team(conn, working_time_params) do
    working_time = TimeManagerWeb.get_working_time_by_team!(working_time_params)
    IO.inspect(working_time)
    render(conn, "index.json", workingtimes: working_time)
  end

  def get_by_userparams(conn, working_time_params) do
    working_time = TimeManagerWeb.get_working_time_by_userparams!(working_time_params)
    IO.inspect(working_time)
    render(conn, "index.json", workingtimes: working_time)
  end



  def show_by_user(conn, working_time_params) do
    current_user = conn.assigns.current_user
    user = TimeManagerWeb.get_user(working_time_params["userID"])

    case current_user.group do # 6: admin // 7: Manager // 8: Employe simple
      6 -> working_time = TimeManagerWeb.get_working_time_by_user!(working_time_params["userID"])
        render(conn, "index.json", workingtimes: working_time)

      7 -> if current_user.team == user.team do
        working_time = TimeManagerWeb.get_working_time_by_user!(working_time_params["userID"])
        render(conn, "index.json", workingtimes: working_time)
        else
          conn |> render("errors.json", %{errors: "User not in your team"})
        end

      8 -> if current_user.id == user.id do
        working_time = TimeManagerWeb.get_working_time_by_user!(working_time_params["userID"])
        render(conn, "index.json", workingtimes: working_time)
        else
          conn |> render("errors.json", %{errors: "Can't access other employe"})
        end
      _ -> conn |> render("errors.json", %{errors: "Don't have acces rights"})
    end

  end

  def show_by_team(conn, working_time_params) do

    working_time = TimeManagerWeb.get_working_time_by_team_table!(working_time_params["team_id"])
    IO.inspect(working_time)
    render(conn, "index.json", workingtimes: working_time)

  end

  def update(conn, working_time_params) do
    working_time = TimeManagerWeb.get_working_time!(working_time_params["id"])

    with {:ok, %WorkingTime{} = working_time} <- TimeManagerWeb.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, working_time_params) do
    working_time = TimeManagerWeb.get_working_time!(working_time_params["id"])

    with {:ok, %WorkingTime{}} <- TimeManagerWeb.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end

  def update_by_params(conn, working_time_params) do
    IO.puts("hello")
    working_time = TimeManagerWeb.get_working_time!(working_time_params["workingtimesid"])
    IO.inspect(working_time_params)
    with {:ok, %WorkingTime{} = working_time} <- TimeManagerWeb.update_working_time_by_params(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end


  def delete_by_params(conn, working_time_params) do
    working_time = TimeManagerWeb.get_working_time!(working_time_params["workingtimesid"])

    with {:ok, %WorkingTime{}} <- TimeManagerWeb.delete_working_time_by_params(working_time) do
      send_resp(conn, :no_content, "")
    end
  end

end
