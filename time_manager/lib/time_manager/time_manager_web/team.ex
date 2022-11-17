defmodule TimeManager.TimeManagerWeb.Team do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__]}

  schema "teams" do
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :name, :string
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:start_time, :end_time, :name])
    |> validate_required([:start_time, :end_time, :name])
  end
end
