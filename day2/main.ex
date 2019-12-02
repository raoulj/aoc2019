defmodule Program do 
  def run(code) do 
    run(code, 0)
  end

  def run(code, pointer) do 
    try do 
      {new_code, next_pointer} = do_operation(code, pointer)
      run(new_code, next_pointer)
    catch result -> result
    end
  end

  def do_operation(code, pointer) do
    opcode = Enum.at(code, pointer)
    case opcode do
      1 -> add(code, pointer)
      2 -> multiply(code, pointer)
      99 -> throw(Enum.at(code, 0))
    end
  end

  defp add(code, pointer) do
    [_opcode, op1, op2, dest] = Enum.drop(code, pointer) |> Enum.take(4)
    result = Enum.at(code, op1) + Enum.at(code, op2)
    {List.replace_at(code, dest, result), pointer + 4}
  end

  defp multiply(code, pointer) do
    [_opcode, op1, op2, dest] = Enum.drop(code, pointer) |> Enum.take(4)
    result = Enum.at(code, op1) * Enum.at(code, op2)
    {List.replace_at(code, dest, result), pointer + 4}
  end

end

defmodule Day2 do
  defp checkPair(code, noun, verb) do
    codeWithInputs = code |> 
      List.replace_at(1, noun) |> 
      List.replace_at(2, verb)
    result = Program.run(codeWithInputs)
    cond do 
      result == 19690720 -> {noun, verb}
      verb < 100 -> checkPair(code, noun, verb + 1)
      true -> checkPair(code, noun + 1, 0)
    end
    
  end 

  def getAnswer() do
    raw_input = AdventOfCodeInputRequester.get('2')
    

    processed = raw_input |>
      :string.split(",", :all) |> 
      Enum.map(fn s -> :string.to_integer(s) end) |> 
      Enum.map(fn ({i, _}) -> i end)

    {n, v} = checkPair(processed, 0, 0)
    100 * n + v
  end
end
