defmodule Day4 do
    
    def hasRepeats?([head | rest]) do 
        cond do
            Enum.count(rest) == 0 -> false
            head == hd(rest) -> true
            true -> hasRepeats?(rest)
        end
    end

    def digitsIncrease?([head | rest]) do 
        cond do
            Enum.count(rest) == 0 -> true
            head > hd(rest) -> false
            true -> digitsIncrease?(rest)
        end
    end

    def getAnswer1() do
        353096..843212
            |> Enum.filter(&hasRepeats?(Integer.digits(&1)))
            |> Enum.filter(&digitsIncrease?(Integer.digits(&1)))
            |> Enum.count()
    end

    def hasRepeats2?([head | rest], acc) do 
        cond do
            (Enum.count(rest) == 0) -> acc == 2
            (head != hd(rest)) && (acc == 2) -> true
            head == hd(rest) -> hasRepeats2?(rest, acc + 1)
            true -> hasRepeats2?(rest, 1)
        end
    end

    def getAnswer2() do
        353096..843212
            |> Enum.filter(&hasRepeats2?(Integer.digits(&1), 1))
            |> Enum.filter(&digitsIncrease?(Integer.digits(&1)))
            |> Enum.count()
    end 
end