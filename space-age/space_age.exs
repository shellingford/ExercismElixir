defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.

  Given an age in seconds, calculate how old someone would be on:

	Earth: orbital period 365.25 Earth days, or 31557600 seconds
	Mercury: orbital period 0.2408467 Earth years
	Venus: orbital period 0.61519726 Earth years
	Mars: orbital period 1.8808158 Earth years
	Jupiter: orbital period 11.862615 Earth years
	Saturn: orbital period 29.447498 Earth years
	Uranus: orbital period 84.016846 Earth years
	Neptune: orbital period 164.79132 Earth years
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
  	calculate_years(planet, seconds)
  end

  defp calculate_years(:earth, seconds) do
  	seconds / 31557600
  end

  defp calculate_years(:mercury, seconds) do
  	seconds / (31557600 * 0.2408467)
  end

  defp calculate_years(:venus, seconds) do
  	seconds / (31557600 * 0.61519726)
  end

  defp calculate_years(:mars, seconds) do
  	seconds / (31557600 * 1.8808158)
  end

  defp calculate_years(:jupiter, seconds) do
  	seconds / (31557600 * 11.862615)
  end

  defp calculate_years(:saturn, seconds) do
  	seconds / (31557600 * 29.447498)
  end

  defp calculate_years(:neptune, seconds) do
  	seconds / (31557600 * 164.79132)
  end

  defp calculate_years(:uranus, seconds) do
  	seconds / (31557600 * 84.016846)
  end
end
