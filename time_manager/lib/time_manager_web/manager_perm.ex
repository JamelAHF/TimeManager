defmodule TimeManagerWeb.ManagerPlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    current_user = conn.assigns.current_user
    case current_user.group do # 6: admin // 7: Manager // 8: Employe simple
      6 -> conn
      7 -> conn

    _-> conn |> send_resp(401, []) |> halt
    end
  end

end
