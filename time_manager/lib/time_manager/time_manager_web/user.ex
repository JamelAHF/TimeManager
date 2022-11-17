defmodule TimeManager.TimeManagerWeb.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__, :password]}
  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string
    belongs_to :team, TimeManager.TimeManagerWeb.Team
    belongs_to :group, TimeManager.TimeManagerWeb.Group

  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [ :username, :email, :password, :group_id, :team_id])
    |> validate_required([:username, :email, :password])
    |> validate_length(:username, min: 2, max: 20)
    |> validate_length(:password, min: 8, max: 300)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> update_change(:username, &String.downcase(&1))
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
       %Ecto.Changeset{valid?: true, changes: %{password: password}} -> put_change(changeset, :password, Pbkdf2.hash_pwd_salt(password))
      _ -> changeset
    end
  end

end
