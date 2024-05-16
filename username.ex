defmodule Username do
  def sanitize(username) do
      # ä becomes ae
      # ö becomes oe
      # ü becomes ue
      # ß becomes ss
      subs = %{?ä => ~c"ae", ?ö => ~c"oe", ?ü => ~c"ue", ?ß => ~c"ss", ?_ => ~c"_"}
      case username do
          [] -> ~c""
          [hd | tl] when tl != [] and (hd >= ?a and hd <= ?z) or is_map_key(subs, hd) -> Map.get(subs, hd, [hd]) ++ sanitize(tl)
          [hd | tl] when tl != [] and (hd < ?a or hd > ?z) and not is_map_key(subs, hd) -> [] ++ sanitize(tl)
          [hd | tl] when tl == [] and (hd >= ?a and hd <= ?z) or is_map_key(subs, hd) -> Map.get(subs, hd, [hd])
          [hd | tl] when tl == [] and (hd < ?a or hd > ?z) and not is_map_key(subs, hd) -> []
          _ -> ~c""
      end
  end
end
