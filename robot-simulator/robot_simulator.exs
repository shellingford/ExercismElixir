defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create do
    create(:north, {0, 0})
  end

  def create(direction, position) do
    cond do
      valid_direction?(direction) == false ->
        {:error, "invalid direction"}
      valid_position?(position) == false ->
        {:error, "invalid position"}
      true ->
        %{direction: direction, position: position}
    end
  end

  defp valid_position?({a, b}) when is_integer(a) and is_integer(b) do
    true
  end

  defp valid_position?(_position), do: false

  defp valid_direction?(direction) when direction in [:north, :east, :south, :west] do
    true
  end

  defp valid_direction?(_direction), do: false

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    do_simulate(robot, String.graphemes(instructions))
  end

  defp do_simulate(%{direction: direction, position: position}, [instruction | other_instructions]) when instruction in ["R", "L"] do
    new_direction = change_direction(direction, instruction)
    do_simulate(%{direction: new_direction, position: position}, other_instructions)
  end

  defp do_simulate(%{direction: direction, position: position}, ["A" | other_instructions]) do
    new_position = advance_position(position, direction)
    do_simulate(%{direction: direction, position: new_position}, other_instructions)
  end

  defp do_simulate(robot, []) do
    robot
  end

  defp do_simulate(_robot, _instructions) do
    { :error, "invalid instruction" }
  end

  defp change_direction(:north, "L"), do: :west
  defp change_direction(:west, "L"), do: :south
  defp change_direction(:south, "L"), do: :east
  defp change_direction(:east, "L"), do: :north


  defp change_direction(:north, "R"), do: :east
  defp change_direction(:east, "R"), do: :south
  defp change_direction(:south, "R"), do: :west
  defp change_direction(:west, "R"), do: :north

  defp advance_position({x, y}, :north), do: {x, y + 1}
  defp advance_position({x, y}, :south), do: {x, y - 1}
  defp advance_position({x, y}, :east), do: {x + 1, y}
  defp advance_position({x, y}, :west), do: {x - 1, y}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(robot) do
    robot.position
  end
end
