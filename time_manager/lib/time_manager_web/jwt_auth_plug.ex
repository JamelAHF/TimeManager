defmodule TimeManagerWeb.JWTAuthPlug do
  import Plug.Conn

  alias TimeManagerWeb.Token
  alias TimeManager.TimeManagerWeb
  alias TimeManager.TimeManagerWeb.User


  def init(opts), do: opts

  def call(conn, _) do
    IO.puts("START AUTH Mid")
    bearer = get_req_header(conn, "authorization" ) |> List.first()
    if bearer == nil do
      conn |> send_resp(401, []) |> halt
    else
      token = bearer |> String.split(" ") |> List.last()
      signer = Joken.Signer.create("HS256", "dtM9oVghTTsRVClmY52trIv5999lxH9i5RqNNBcNu7ycNdnzkgr3GlZUA6OoUesw")
      with {:ok, %{"user_id" => user_id}} <-
            Token.verify_and_validate(token, signer),
          %User{} = user <- TimeManagerWeb.get_user(user_id) do
        conn = assign(conn, :current_user, user)
        conn
      else
        {:error, _reason} -> conn |> send_resp(401, []) |> halt
         _-> conn |> send_resp(401, []) |> halt
      end
    end
  end

end
