defmodule AdventOfCodeInputRequester do
  def get(day) do
    fetch(day)
  end

  defp fetch(day) do
    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)

    # Now we can make request:
    result =
      :httpc.request(:get, {'https://adventofcode.com/2019/day/' ++ day ++ '/input', [
      {'cookie', 'session=' ++ Environment.getToken()}
      ]}, [], [])
    case result do
      {:ok, {_status, _headers, body}} -> body
      {:error, {:headers_error, :not_strings}} -> IO.puts("header err")
      {:error, response} -> IO.puts(response)
      _ -> IO.puts(result)
    end
  end 
end 
