defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManagerWeb.Utils
  alias TimeManagerWeb.Token
  alias TimeManager.TimeManagerWeb
  alias TimeManager.TimeManagerWeb.User

  action_fallback TimeManagerWeb.FallbackController


  def index(conn, _params) do
    users = TimeManagerWeb.list_users()
    render(conn, "index.json", users: users)
  end

  def register(conn, user_params) do
    IO.puts("user params :::::::")
    IO.inspect(user_params)
    case TimeManagerWeb.create_user(user_params) do
      {:ok, _user} ->
        conn |> render("ack.json", %{success: true, message: "Registration Successful"})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn |> render("errors.json", %{errors: Utils.format_changeset_errors(changeset)})

      _ ->
        conn |> render("error.json", %{error: Utils.internal_server_error()})
    end
  end

  def login(conn, %{"username" => username, "password" => password }) do
    with %User{} = user <- TimeManagerWeb.get_user_by_username(username), true <- Pbkdf2.verify_pass(password, user.password) do
      signer = Joken.Signer.create("HS256", "dtM9oVghTTsRVClmY52trIv5999lxH9i5RqNNBcNu7ycNdnzkgr3GlZUA6OoUesw")

      extra_claims = %{user_id: user.id}
      {:ok, token, _claims} = Token.generate_and_sign(extra_claims, signer)

      conn |> render("login.json", %{success: true, message: "Login Successful", token: token})
    else
      _-> conn |> render("errors.json", %{errors: Utils.invalid_credentials()})
    end
  end

  def get_curr_usr(conn, _user_params) do
    current_user = conn.assigns.current_user
    #user = TimeManagerWeb.get_user(1)
    render(conn, "show.json", user: current_user)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- TimeManagerWeb.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = TimeManagerWeb.get_user!(id)
    render(conn, "user.json", user: user)
  end

  def update(conn, user_params) do
    IO.inspect(user_params)
    user = TimeManagerWeb.get_user!(user_params["user_id"])

    with {:ok, %User{} = user} <- TimeManagerWeb.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, user_params) do
    user = TimeManagerWeb.get_user!(user_params["id"])

    with {:ok, %User{}} <- TimeManagerWeb.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_user_from_id_list(conn, user_params) do
    user_list = TimeManagerWeb.get_user_from_id_list!(user_params["user_id_list"])
    render(conn, "index.json", users: user_list)
  end
end
