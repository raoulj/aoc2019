defmodule Day3 do
    def getWireCoordinateMap(coords, [head_direction | other_directions], wire_id) do
        last_coord = Enum.at(coords, -1)
        direction = String.at(head_direction, 0)
        amount = String.to_integer(String.slice(head_direction, 1..-1))
        start_x = elem(last_coord, 0)
        start_y = elem(last_coord, 1)
        case direction do 
            "R" -> getWireCoordinateMap(coords ++ Enum.map((start_x + 1)..(start_x + amount), fn x -> {x, start_y} end), other_directions, wire_id)
            "L" -> getWireCoordinateMap(coords ++ Enum.map((start_x - 1)..(start_x - amount), fn x -> {x, start_y} end), other_directions, wire_id)
            "U" -> getWireCoordinateMap(coords ++ Enum.map((start_y + 1)..(start_y + amount), fn y -> {start_x, y} end), other_directions, wire_id)
            "D" -> getWireCoordinateMap(coords ++ Enum.map((start_y - 1)..(start_y - amount), fn y -> {start_x, y} end), other_directions, wire_id)
            _ -> throw(head_direction)
        end
    end

    def getWireCoordinateMap(coords, [], wire_id) do 
        Map.new(coords, fn coord -> {coord, {wire_id}} end)
    end

    def getAnswer1() do
        input = AdventOfCodeInputRequester.get('3')
        wires = Enum.slice(Enum.map(String.split(to_string(input), "\n"), fn s -> String.split(s, ",") end), 0..1)

        coordsToWireIds = Stream.with_index(wires)
            |> Enum.map(fn ({wire, index}) -> getWireCoordinateMap([{0,0}], wire, index) end)
            |> Enum.reduce(fn newCoordMap, accCoordMap -> Map.merge(newCoordMap, accCoordMap, fn _k, v1, v2 -> {v1, v2} end) end)
        
        coordsToWireIds
            |> Map.keys()
            |> Enum.filter(fn k -> tuple_size(Map.get(coordsToWireIds, k)) == Enum.count(wires) end)
            |> Enum.map(fn k -> elem(k, 0) + elem(k, 1) end)
            |> Enum.sort()
            |> Enum.at(1)
    end
end