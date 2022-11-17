defmodule TimeManager.TimeManagerWeb.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset


  @derive {Jason.Encoder, except: [:__meta__]}
  schema "workingtimes" do
    field :start, :utc_datetime
    field :end, :utc_datetime
    field :user, :id
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user])
    |> validate_required([:start, :end, :user])
  end
end
