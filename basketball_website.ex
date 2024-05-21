defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    do_extract_from_path(data, keys, length(keys))
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end

  defp do_extract_from_path(map, [hd | tl], keys_left)do
    cond do
      keys_left == 1 -> map[hd]
      tl == [] -> nil
      true -> do_extract_from_path(map[hd], tl, length(tl))
    end
  end
end
