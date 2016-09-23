defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    %{rolls: [], can_take_score: false}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `:ok`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(any, integer) :: any | String.t
  def roll(_game, roll) when roll < 0 or roll > 10, do: {:error, "Pins must have a value from 0 to 10"}
  def roll(game, roll) do
    case append_roll(game.rolls, roll, 1) do
      {:error, error_msg} -> {:error, error_msg}
      {{roll}, frame_count} -> %{rolls: game.rolls ++ [{roll}], can_take_score: frame_count >= 10}
      {{a, roll}, frame_count} -> %{rolls: Enum.drop(game.rolls, -1) ++ [{a, roll}], can_take_score: frame_count >= 10}
    end
  end

  defp append_roll([{a}], roll, _frame_count) when a + roll > 10 and a < 10 and roll < 10,
    do: {:error, "Pin count exceeds pins on the lane"}
  defp append_roll([{a, b}], _roll, frame_count) when a + b < 10 and frame_count == 10,
    do: {:error, "Pin count exceeds pins on the lane"}

  defp append_roll([{10} | other_rolls], roll, frame_count), do: append_roll(other_rolls, roll, frame_count + 1)
  defp append_roll([{_a, _b} | other_rolls], roll, frame_count), do: append_roll(other_rolls, roll, frame_count + 1)

  defp append_roll([], roll, frame_count), do: {{roll}, frame_count}
  defp append_roll([{a}], roll, frame_count), do: {{a, roll}, frame_count}

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(any) :: integer | String.t
  def score(%{rolls: _rolls, can_take_score: can_take_score}) when not can_take_score,
    do: {:error, "Score cannot be taken until the end of the game"}
  def score(game) do
    scored_roles = score_strikes(game.rolls, [])
    scored_roles = score_spares(scored_roles, [])

    Enum.reduce(scored_roles, 0, 
      fn(elem, acc) -> 
        case elem do
          {x} -> acc + x
          {a, b} -> acc + a + b
        end
      end)
  end

  defp score_strikes([{10}, {10}, {10}], scored_roles), do: scored_roles ++ [{30}]
  defp score_strikes([{10}, {10}, {10} | other_rolls], scored_roles),
    do: score_strikes([{10}, {10} | other_rolls], scored_roles ++ [{30}])
  defp score_strikes([{10}, {10}, {a, b} | other_rolls], scored_roles),
    do: score_strikes([{10}, {a, b} | other_rolls], scored_roles ++ [{20 + a}])
  defp score_strikes([{10}, {a, b}], scored_roles),
    do: scored_roles ++ [{10 + a + b}]
  defp score_strikes([{10}, {a, b} | other_rolls], scored_roles),
    do: score_strikes([{a, b} | other_rolls], scored_roles ++ [{10 + a + b}])
  defp score_strikes([{a, b} | other_rolls], scored_roles), do: score_strikes(other_rolls, scored_roles ++ [{a, b}])
  defp score_strikes([{a}], scored_roles), do: scored_roles ++ [{a}]
  defp score_strikes([], scored_roles), do: scored_roles

  defp score_spares([{a, b}, {c}], scored_roles) when a + b == 10, do: scored_roles ++ [{a + b + c}]
  defp score_spares([{a, b}, {c, d} | other_rolls], scored_roles) when a + b == 10,
    do: score_spares([{c, d} | other_rolls], scored_roles ++ [{a + b + c}])
  defp score_spares([{a, b} | other_rolls], scored_roles), do: score_spares(other_rolls, scored_roles ++ [{a, b}])
  defp score_spares([{a} | other_rolls], scored_roles), do: score_spares(other_rolls, scored_roles ++ [{a}])
  defp score_spares([], scored_roles), do: scored_roles

end
