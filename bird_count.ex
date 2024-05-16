defmodule BirdCount do
  def today([]), do: nil
  def today([hd | _]), do: hd

  def increment_day_count([]), do: [1]
  def increment_day_count([hd | tl]), do: [hd + 1] ++ tl

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([hd | _]) when hd == 0, do: true
  def has_day_without_birds?([hd | tl]) when hd != 0, do: has_day_without_birds?(tl)
  
  def total([]), do: 0
  def total([hd | tl]) when tl == [], do: hd
  def total([hd | tl]) when tl != [], do: hd + total(tl)
  
  def busy_days([]), do: 0
  def busy_days([hd | tl]) when tl == [], do: if(hd >= 5, do: 1, else: 0)
  def busy_days([hd | tl]) when tl != [], do: if(hd >= 5, do: 1 + busy_days(tl), else: busy_days(tl))
end
