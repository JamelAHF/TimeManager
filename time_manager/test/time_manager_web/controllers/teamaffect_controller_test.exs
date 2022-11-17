defmodule TimeManagerWeb.TeamaffectControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.TimeManagerWebFixtures

  alias TimeManager.TimeManagerWeb.Teamaffect

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all teamaffects", %{conn: conn} do
      conn = get(conn, Routes.teamaffect_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create teamaffect" do
    test "renders teamaffect when data is valid", %{conn: conn} do
      conn = post(conn, Routes.teamaffect_path(conn, :create), teamaffect: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.teamaffect_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.teamaffect_path(conn, :create), teamaffect: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update teamaffect" do
    setup [:create_teamaffect]

    test "renders teamaffect when data is valid", %{conn: conn, teamaffect: %Teamaffect{id: id} = teamaffect} do
      conn = put(conn, Routes.teamaffect_path(conn, :update, teamaffect), teamaffect: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.teamaffect_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, teamaffect: teamaffect} do
      conn = put(conn, Routes.teamaffect_path(conn, :update, teamaffect), teamaffect: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete teamaffect" do
    setup [:create_teamaffect]

    test "deletes chosen teamaffect", %{conn: conn, teamaffect: teamaffect} do
      conn = delete(conn, Routes.teamaffect_path(conn, :delete, teamaffect))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.teamaffect_path(conn, :show, teamaffect))
      end
    end
  end

  defp create_teamaffect(_) do
    teamaffect = teamaffect_fixture()
    %{teamaffect: teamaffect}
  end
end
