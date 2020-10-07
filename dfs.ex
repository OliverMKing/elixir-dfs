defmodule M do
  # Driver method to execute dfs with test data
  def main do
    # Define grid as 2d tuple
    grid = {
      {1, 2, 3},
      {4, 5, 6},
      {7, 8, 9}
    }

    search = IO.gets("What number do you want to search for? (enter 1 - 9) ")
  end

  def neighbors(grid, point) do
    x = elem(point, 0)
    y = elem(point, 1)
    y_length = tuple_size(grid)
    x_length = tuple_size(elem(grid, 0))
    neighborsLeft(x, y, x_length, y_length, [])
  end

  def neighborsLeft(x, y, x_length, y_length, neighbors) do
    if x > 0 && x < x_length do
      neighborsRight(x, y, x_length, y_length, neighbors ++ [{x - 1, y}])
    else
      neighborsRight(x, y, x_length, y_length, neighbors)
    end
  end

  def neighborsRight(x, y, x_length, y_length, neighbors) do
    if x < x_length && x > 0 do
      neighborsUp(x, y, x_length, y_length, neighbors ++ [{x + 1, y}])
    else
      neighborsUp(x, y, x_length, y_length, neighbors)
    end
  end

  def neighborsUp(x, y, x_length, y_length, neighbors) do
    if y > 0 && y < y_length do
      neighborsDown(x, y, x_length, y_length, neighbors ++ [{x, y - 1}])
    else
      neighborsDown(x, y, x_length, y_length, neighbors)
    end
  end

  def neighborsDown(x, y, x_length, y_length, neighbors) do
    if y < y_length && y > 0 do
      neighbors ++ [{x, y + 1}]
    else
      neighbors
    end
  end
end
