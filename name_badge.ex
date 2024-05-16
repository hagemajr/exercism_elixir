defmodule NameBadge do
  def print(id, name, department) do
    name_str = "#{String.trim(name)} - "
    id_str = if id != nil do
      "[#{id}] - "
    else
        ""
    end
    department_str =  if department != nil do
      "#{String.upcase(department)}"
    else
        "OWNER"
    end
    id_str <> name_str <> department_str
  end
end
