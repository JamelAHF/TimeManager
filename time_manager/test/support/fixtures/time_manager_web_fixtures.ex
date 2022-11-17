defmodule TimeManager.TimeManagerWebFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.TimeManagerWeb` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        sattus: true,
        time: ~U[2022-10-24 14:13:00Z]
      })
      |> TimeManager.TimeManagerWeb.create_clock()

    clock
  end

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~U[2022-10-24 14:14:00Z],
        start: ~U[2022-10-24 14:14:00Z]
      })
      |> TimeManager.TimeManagerWeb.create_working_time()

    working_time
  end

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManager.TimeManagerWeb.create_team()

    team
  end

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManager.TimeManagerWeb.create_group()

    group
  end

  @doc """
  Generate a teamaffect.
  """
  def teamaffect_fixture(attrs \\ %{}) do
    {:ok, teamaffect} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManager.TimeManagerWeb.create_teamaffect()

    teamaffect
  end
end
