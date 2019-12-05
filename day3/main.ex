defmodule Day3 do
    def getWireCoordinateMap(coords, [head_direction | other_directions], wire_id) do
        last_coord = Enum.at(coords, -1)
        direction = String.at(head_direction, 0)
        amount = String.to_integer(String.slice(head_direction, 1..-1))
        start_x = elem(last_coord, 0)
        start_y = elem(last_coord, 1)
        step_count = elem(last_coord, 2)
        case direction do 
            "R" -> getWireCoordinateMap(coords ++ Enum.map((start_x + 1)..(start_x + amount), fn x -> {x, start_y, step_count + abs(x - start_x)} end), other_directions, wire_id)
            "L" -> getWireCoordinateMap(coords ++ Enum.map((start_x - 1)..(start_x - amount), fn x -> {x, start_y, step_count + abs(x - start_x)} end), other_directions, wire_id)
            "U" -> getWireCoordinateMap(coords ++ Enum.map((start_y + 1)..(start_y + amount), fn y -> {start_x, y, step_count + abs(y - start_y)} end), other_directions, wire_id)
            "D" -> getWireCoordinateMap(coords ++ Enum.map((start_y - 1)..(start_y - amount), fn y -> {start_x, y, step_count + abs(y - start_y)} end), other_directions, wire_id)
            _ -> throw(head_direction)
        end
    end

    def getWireCoordinateMap(coords, [], wire_id) do 
        Enum.sort_by(coords, fn {_x, _y, steps} -> steps end)
            |> Enum.uniq_by(fn {x, y, _s} -> {x, y} end)
            |> Map.new(fn ({x, y, steps}) -> {{x, y}, [{wire_id, steps}]} end)
    end

    def wiresToMaps(wires) do 
        Stream.with_index(wires)
            |> Enum.map(fn ({wire, index}) -> getWireCoordinateMap([{0,0,0}], wire, index) end)
            |> Enum.reduce(fn newCoordMap, accCoordMap -> Map.merge(newCoordMap, accCoordMap, fn _k, v1, v2 -> v1 ++ v2 end) end)
    end

    def mapsToIntersections(map, wireCount) do 
        Map.keys(map)
            |> Enum.filter(fn k -> Enum.count(Map.get(map, k)) == wireCount end)
    end

    def getAnswer1() do
        input = AdventOfCodeInputRequester.get('3')
        wires = Enum.slice(Enum.map(String.split(to_string(input), "\n"), fn s -> String.split(s, ",") end), 0..1)
        coordsToWireIds = wiresToMaps(wires)
        
        mapsToIntersections(coordsToWireIds, Enum.count(wires))
            |> Enum.map(fn k -> elem(k, 0) + elem(k, 1) end)
            |> Enum.sort()
            |> Enum.at(1)
    end

    def getAnswer2() do
        input = AdventOfCodeInputRequester.get('3')
        wires = Enum.slice(Enum.map(String.split(to_string(input), "\n"), fn s -> String.split(s, ",") end), 0..1)
        coordsToWireIds = wiresToMaps(wires)
        
        mapsToIntersections(coordsToWireIds, Enum.count(wires))
            |> Enum.map(fn k -> Map.get(coordsToWireIds, k) end)
            |> Enum.map(fn v -> Enum.reduce(v, 0, fn ({_id, count}, acc) -> acc + count end) end)
            |> Enum.sort()
            |> Enum.at(1)
    end
end