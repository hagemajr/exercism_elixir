defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn x ->
      Map.new(x, fn {key, val} ->
        if key == :name, do: {key, String.replace(val, old_word, new_word)}, else: {key, val}
      end)
    end)
  end

  def increase_quantity(item, count) do
      Map.new(item, fn {key, val} ->
        if key == :quantity_by_size, do: {key, Map.new(val, fn {size, cur_count} -> {size, cur_count+count} end)}, else: {key, val}
      end)
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_, count}, acc -> acc + count end)
  end
end
