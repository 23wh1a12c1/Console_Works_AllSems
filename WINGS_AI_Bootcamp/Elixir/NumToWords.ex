defmodule Fig2Words do
  @one_words ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
              "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
              "Seventeen", "Eighteen", "Nineteen"]

  @tens_words ["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]

  @w_system %{1_000_000_000_000 => "Trillion", 1_000_000_000 => "Billion", 1_000_000 => "Million", 1_000 => "Thousand", 1 => ""}
  @i_system %{1_000_000_000 => "Arab", 10_000_000 => "Crore", 100_000 => "Lakh", 1_000 => "Thousand", 1 => ""}

  def convert(n) when n < 20, do: Enum.at(@one_words, n)
  def convert(n) when n < 100, do: Enum.at(@tens_words, div(n, 10)) <> if rem(n, 10) > 0, do: " " <> Enum.at(@one_words, rem(n, 10)), else: ""
  def convert(n) when n in 100..999 do
    h = div(n, 100)
    r = rem(n, 100)
    if r == 0, do: Enum.at(@one_words, h) <> " hundred", else: Enum.at(@one_words, h) <> " hundred and " <> convert(r)
  end

  def convert(n, which) do
    system = if which == "w", do: @w_system, else: @i_system
    denoms = system |> Map.keys() |> Enum.sort(:desc)

    denoms
    |> Enum.reduce({"", n}, fn d, {acc, rem} ->
      {q, r} = {div(rem, d), rem(rem, d)}
      if q > 0, do: {acc <> " " <> convert(q) <> " " <> system[d], r}, else: {acc, rem}
    end)
    |> elem(0)
    |> String.trim()
  end
end

# Output
IO.puts(Fig2Words.convert(15))          # Fifteen
IO.puts(Fig2Words.convert(30))          # Thirty
IO.puts(Fig2Words.convert(671))         # Six hundred and seventy one
IO.puts(Fig2Words.convert(123456, "w")) # One Hundred and Twenty Three Thousand Four Hundred and Fifty Six
IO.puts(Fig2Words.convert(123456, "i")) # One Lakh Twenty Three Thousand Four Hundred and Fifty Six
