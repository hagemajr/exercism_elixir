defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, result} = NaiveDateTime.from_iso8601(string)
    result
  end

  def before_noon?(datetime) do
    if datetime.hour < 12 do
      true
    else
      false
    end
  end

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      NaiveDateTime.add(checkout_datetime, 28*24*60*60)
    else
      NaiveDateTime.add(checkout_datetime, 29*24*60*60)
    end
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    diff = actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)

    if diff <= 0, do: 0, else: diff
  end

  def monday?(datetime) do
    if Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1, do: true, else: false
  end

  def calculate_late_fee(checkout, return, rate) do
    return_date = datetime_from_string(return)
    new_rate = if monday?(return_date), do: rate / 2, else: rate
    datetime_from_string(checkout)
    |> return_date()
    |> days_late(return_date)
    |> Kernel.*(new_rate)
    |> trunc()
  end
end
