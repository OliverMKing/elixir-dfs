defmodule M do
  # Driver method to execute dfs with test data
  def main do
    # Define grid as 2d tuple
    grid = {
      {1, 2, 3},
      {4, 5, 6},
      {7, 8, 9}
    }

    answer = dfs(6, grid)
  end

  def neighbors(grid, point) do
    x = x(point)
    y = y(point)
    y_length = tuple_size(grid)
    x_length = tuple_size(elem(grid, 0))
    neighborsLeft(x, y, x_length, y_length, [])
  end

  def neighborsLeft(x, y, x_length, y_length, neighbors) do
    if x > 0 do
      neighborsRight(x, y, x_length, y_length, neighbors ++ [{x - 1, y}])
    else
      neighborsRight(x, y, x_length, y_length, neighbors)
    end
  end

  def neighborsRight(x, y, x_length, y_length, neighbors) do
    if x < x_length - 1 do
      neighborsUp(x, y, x_length, y_length, neighbors ++ [{x + 1, y}])
    else
      neighborsUp(x, y, x_length, y_length, neighbors)
    end
  end

  def neighborsUp(x, y, x_length, y_length, neighbors) do
    if y > 0 do
      neighborsDown(x, y, x_length, y_length, neighbors ++ [{x, y - 1}])
    else
      neighborsDown(x, y, x_length, y_length, neighbors)
    end
  end

  def neighborsDown(x, y, x_length, y_length, neighbors) do
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

      for neighbor <- unseen do
        dfs(value, grid, visited, neighbor)
      end
    end
  end
end
