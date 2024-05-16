defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount * ((100 - discount ) / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate()
    |> Kernel.*(22)
    |> Kernel.ceil()
    |> apply_discount(discount)
    |> Kernel.round()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    budget
    |> Kernel./(apply_discount(hourly_rate, discount))
    |> Kernel./(8)
    |> Float.floor(1)
  end
end
