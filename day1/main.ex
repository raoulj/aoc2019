defmodule ProcessList do
  defp processElement(num) do
    processElement(num, 0)
  end

  defp processElement(num, acc) do
    if num < 1 do
      acc
    else 
      incr = div(num, 3) - 2
      if incr < 1 do 
        processElement(incr, acc)
      else 
        processElement(incr, acc + incr)
      end
    end
  end 

  def process(l) do 
    process(l, 0)
  end 

  def process([head | tail], acc) do
    {converted, _} = :string.to_integer(head)
    if is_number(converted) do
      process(tail, acc + processElement(converted))
    else
      process(tail, acc)
    end
  end

  def process([], acc) do
    acc
  end
end

defmodule Day1 do
  def getAnswer() do
    input = AdventOfCodeInputRequester.get('1')
    IO.puts(ProcessList.process(input))
  end
end
