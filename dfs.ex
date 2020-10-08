defmodule M do
  # Driver method to execute dfs with test data
  def main do
    # Define grid as 2d tuple
    grid = {
      {1, 2, 3},
      {4, 5, 6},
      {7, 8, 9}
    }

    {search, _} = IO.gets("Enter a number from 1 to 9: ") |> Integer.parse()
    answer = dfs(search, grid)
  end

  def neighbors(grid, point) do
    x = x(point)
    y = y(point)
    y_length = tuple_size(grid)
    x_length = tuple_size(elem(grid, 0))
    _neighborsLeft(x, y, x_length, y_length, [])
  end

  def _neighborsLeft(x, y, x_length, y_length, neighbors) do
    if x > 0 do
      _neighborsRight(x, y, x_length, y_length, neighbors ++ [{x - 1, y}])
    else
      _neighborsRight(x, y, x_length, y_length, neighbors)
    end
  end

  def _neighborsRight(x, y, x_length, y_length, neighbors) do
    if x < x_length - 1 do
      _neighborsUp(x, y, x_length, y_length, neighbors ++ [{x + 1, y}])
    else
      _neighborsUp(x, y, x_length, y_length, neighbors)
    end
  end

  def _neighborsUp(x, y, x_length, y_length, neighbors) do
    if y > 0 do
      _neighborsDown(x, y, x_length, y_length, neighbors ++ [{x, y - 1}])
    else
      _neighborsDown(x, y, x_length, y_length, neighbors)
    end
  end

  def _neighborsDown(x, y, x_length, y_length, neighbors) do
    if y < y_length - 1 do
      neighbors ++ [{x, y + 1}]
    else
      neighbors
    end
  end

  def x(point) do
    elem(point, 0)
  end

  def y(point) do
    elem(point, 1)
  end

  def dfs(value, grid, seen \\ MapSet.new(), point \\ {0, 0}) do
    x = x(point)
    y = y(point)
    currValue = elem(elem(grid, y), x)

    if currValue == value do
      point
    else
      neighbors = neighbors(grid, point)
      visited = MapSet.put(seen, point)

      unseen =
        Enum.filter(neighbors, fn neighbor ->
          !MapSet.member?(visited, neighbor)
        end)

      try do
        for neighbor <- unseen do
          case dfs(value, grid, visited, neighbor) do
            {x, y} -> throw({x, y})
            _ -> "Not solution"
          end
        end
      catch
        {x, y} -> {x, y}
        _ -> "There was an error"
      end
    end
  end
end
