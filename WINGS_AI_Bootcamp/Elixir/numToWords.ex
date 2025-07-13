defmodule NumToWords do
  @ones ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
  @teens ["Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen",
          "Sixteen", "Seventeen", "Eighteen", "Nineteen"]
  @tens ["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]

  def two_digit(num) when num == 0, do: ""
  def two_digit(num) when num < 10, do: Enum.at(@ones, num)
  def two_digit(num) when num >= 10 and num < 20, do: Enum.at(@teens, num - 10)
  def two_digit(num) do
    tens = div(num, 10)
    ones = rem(num, 10)
    tens_word = Enum.at(@tens, tens)
    ones_word = if ones != 0, do: " " <> Enum.at(@ones, ones), else: ""
    tens_word <> ones_word
  end

  def three_digit(num) do
    hundred = div(num, 100)
    rest = rem(num, 100)
    res = if hundred > 0, do: Enum.at(@ones, hundred) <> " Hundred", else: ""
    if rest > 0 do
      res <> (if res != "", do: " ", else: "") <> two_digit(rest)
    else
      res
    end
  end

  @american_scale ["", "Thousand", "Million", "Billion", "Trillion"]
  def num_to_words_american(num) when num == 0, do: "Zero"
  def num_to_words_american(num) do
    do_american(num, 0, [])
    |> Enum.reject(&(&1 == ""))
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defp do_american(0, _, acc), do: acc
  defp do_american(num, idx, acc) do
    part = rem(num, 1000)
    segment = if part > 0 do
      seg = three_digit(part)
      scale = Enum.at(@american_scale, idx)
      if scale != "", do: seg <> " " <> scale, else: seg
    else
      ""
    end
    do_american(div(num, 1000), idx + 1, [segment | acc])
  end

  @indian_scale ["", "Thousand", "Lakh", "Crore", "Arab"]
  def num_to_words_indian(0), do: "Zero"
  def num_to_words_indian(num) do
    part = rem(num, 1000)
    words = [three_digit(part)]
    do_indian(div(num, 1000), 1, words)
    |> Enum.reject(&(&1 == ""))
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defp do_indian(0, _, acc), do: acc
  defp do_indian(num, idx, acc) do
    part = rem(num, 100)
    segment = if part > 0 do
      seg = two_digit(part)
      scale = Enum.at(@indian_scale, idx)
      if scale != "", do: seg <> " " <> scale, else: seg
    else
      ""
    end
    do_indian(div(num, 100), idx + 1, [segment | acc])
  end
end

# Example usage:
IO.puts("American System:")
IO.puts(NumToWords.num_to_words_american(123456789))
IO.puts(NumToWords.num_to_words_american(1000100))
IO.puts(NumToWords.num_to_words_american(0))

IO.puts("\nIndian System:")
IO.puts(NumToWords.num_to_words_indian(123456789))
IO.puts(NumToWords.num_to_words_indian(1000100))
IO.puts(NumToWords.num_to_words_indian(0))

