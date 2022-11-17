defmodule TimeManagerWeb.AdminPlug do
  import Plug.Conn


  def init(opts), do: opts

  def call(conn, _) do
    IO.puts("MIDLEWARE")
    current_user = conn.assigns.current_user
    IO.inspect(current_user)
    case current_user.group.id do # 6: admin // 7: Manager // 8: Employe simple
      1 -> conn

    _-> conn |> send_resp(401, []) |> halt
    end
  end

end
