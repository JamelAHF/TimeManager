defmodule TimeManagerWeb.UserView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      team_id: user.team,
      group_id: user.group
    }
  end

  def render("ack.json",%{success: success, message: message}) do
    %{success: success, message: message}
  end

  def render("login.json",%{success: success, message: message, token: token}) do
    %{success: success, message: message, token: token}
  end

  def render("errors.json",%{errors: errors}) do
    %{success: false, errors: errors}
  end

    def render("error.json",%{error: error}) do
      %{success: false, error: error}
    end

  def render("data.json", %{data: data}), do: %{success: true, data: data}
end
