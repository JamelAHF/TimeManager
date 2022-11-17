defmodule TimeManager.TimeManagerWebTest do
  use TimeManager.DataCase

  alias TimeManager.TimeManagerWeb

  describe "clocks" do
    alias TimeManager.TimeManagerWeb.Clock

    import TimeManager.TimeManagerWebFixtures

    @invalid_attrs %{sattus: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert TimeManagerWeb.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert TimeManagerWeb.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{sattus: true, time: ~U[2022-10-24 14:13:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManagerWeb.create_clock(valid_attrs)
      assert clock.sattus == true
      assert clock.time == ~U[2022-10-24 14:13:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{sattus: false, time: ~U[2022-10-25 14:13:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManagerWeb.update_clock(clock, update_attrs)
      assert clock.sattus == false
      assert clock.time == ~U[2022-10-25 14:13:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.update_clock(clock, @invalid_attrs)
      assert clock == TimeManagerWeb.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = TimeManagerWeb.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManagerWeb.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = TimeManagerWeb.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias TimeManager.TimeManagerWeb.WorkingTime

    import TimeManager.TimeManagerWebFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      working_time = working_time_fixture()
      assert TimeManagerWeb.list_workingtimes() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert TimeManagerWeb.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      valid_attrs = %{end: ~U[2022-10-24 14:14:00Z], start: ~U[2022-10-24 14:14:00Z]}

      assert {:ok, %WorkingTime{} = working_time} = TimeManagerWeb.create_working_time(valid_attrs)
      assert working_time.end == ~U[2022-10-24 14:14:00Z]
      assert working_time.start == ~U[2022-10-24 14:14:00Z]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{end: ~U[2022-10-25 14:14:00Z], start: ~U[2022-10-25 14:14:00Z]}

      assert {:ok, %WorkingTime{} = working_time} = TimeManagerWeb.update_working_time(working_time, update_attrs)
      assert working_time.end == ~U[2022-10-25 14:14:00Z]
      assert working_time.start == ~U[2022-10-25 14:14:00Z]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.update_working_time(working_time, @invalid_attrs)
      assert working_time == TimeManagerWeb.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = TimeManagerWeb.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> TimeManagerWeb.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = TimeManagerWeb.change_working_time(working_time)
    end
  end

  describe "teams" do
    alias TimeManager.TimeManagerWeb.Team

    import TimeManager.TimeManagerWebFixtures

    @invalid_attrs %{}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert TimeManagerWeb.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert TimeManagerWeb.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{}

      assert {:ok, %Team{} = team} = TimeManagerWeb.create_team(valid_attrs)
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{}

      assert {:ok, %Team{} = team} = TimeManagerWeb.update_team(team, update_attrs)
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.update_team(team, @invalid_attrs)
      assert team == TimeManagerWeb.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = TimeManagerWeb.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> TimeManagerWeb.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = TimeManagerWeb.change_team(team)
    end
  end

  describe "groups" do
    alias TimeManager.TimeManagerWeb.Group

    import TimeManager.TimeManagerWebFixtures

    @invalid_attrs %{}

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert TimeManagerWeb.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert TimeManagerWeb.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      valid_attrs = %{}

      assert {:ok, %Group{} = group} = TimeManagerWeb.create_group(valid_attrs)
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      update_attrs = %{}

      assert {:ok, %Group{} = group} = TimeManagerWeb.update_group(group, update_attrs)
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.update_group(group, @invalid_attrs)
      assert group == TimeManagerWeb.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = TimeManagerWeb.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> TimeManagerWeb.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = TimeManagerWeb.change_group(group)
    end
  end

  describe "teamaffects" do
    alias TimeManager.TimeManagerWeb.Teamaffect

    import TimeManager.TimeManagerWebFixtures

    @invalid_attrs %{}

    test "list_teamaffects/0 returns all teamaffects" do
      teamaffect = teamaffect_fixture()
      assert TimeManagerWeb.list_teamaffects() == [teamaffect]
    end

    test "get_teamaffect!/1 returns the teamaffect with given id" do
      teamaffect = teamaffect_fixture()
      assert TimeManagerWeb.get_teamaffect!(teamaffect.id) == teamaffect
    end

    test "create_teamaffect/1 with valid data creates a teamaffect" do
      valid_attrs = %{}

      assert {:ok, %Teamaffect{} = teamaffect} = TimeManagerWeb.create_teamaffect(valid_attrs)
    end

    test "create_teamaffect/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.create_teamaffect(@invalid_attrs)
    end

    test "update_teamaffect/2 with valid data updates the teamaffect" do
      teamaffect = teamaffect_fixture()
      update_attrs = %{}

      assert {:ok, %Teamaffect{} = teamaffect} = TimeManagerWeb.update_teamaffect(teamaffect, update_attrs)
    end

    test "update_teamaffect/2 with invalid data returns error changeset" do
      teamaffect = teamaffect_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManagerWeb.update_teamaffect(teamaffect, @invalid_attrs)
      assert teamaffect == TimeManagerWeb.get_teamaffect!(teamaffect.id)
    end

    test "delete_teamaffect/1 deletes the teamaffect" do
      teamaffect = teamaffect_fixture()
      assert {:ok, %Teamaffect{}} = TimeManagerWeb.delete_teamaffect(teamaffect)
      assert_raise Ecto.NoResultsError, fn -> TimeManagerWeb.get_teamaffect!(teamaffect.id) end
    end

    test "change_teamaffect/1 returns a teamaffect changeset" do
      teamaffect = teamaffect_fixture()
      assert %Ecto.Changeset{} = TimeManagerWeb.change_teamaffect(teamaffect)
    end
  end
end
