defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_, second} = volume_pair
    second
  end

  def to_milliliter({:cup, amt}) do
    {:milliliter, amt * 240}
  end

  def to_milliliter({:fluid_ounce, amt}) do
    {:milliliter, amt * 30}
  end

  def to_milliliter({:teaspoon, amt}) do
    {:milliliter, amt * 5}
  end

  def to_milliliter({:tablespoon, amt}) do
    {:milliliter, amt * 15}
  end

  def to_milliliter({:milliliter, amt}) do
    {:milliliter, amt}
  end

  def from_milliliter({:milliliter, amt}, :milliliter) do
    {:milliliter, amt}
  end

  def from_milliliter({:milliliter, amt}, :cup) do
    {:cup, amt / 240}
  end

  def from_milliliter({:milliliter, amt}, :fluid_ounce) do
    {:fluid_ounce, amt / 30}
  end

  def from_milliliter({:milliliter, amt}, :teaspoon) do
    {:teaspoon, amt / 5}
  end

  def from_milliliter({:milliliter, amt}, :tablespoon) do
    {:tablespoon, amt / 15}
  end

  def convert({from_unit, amt}, to_unit) do
    cond do
      from_unit == :milliliter -> from_milliliter({from_unit, amt}, to_unit)
      to_unit == :milliliter -> to_milliliter({from_unit, amt})
      true -> 
        to_milliliter({from_unit, amt})
        |> from_milliliter(to_unit)
    end
  end
end
