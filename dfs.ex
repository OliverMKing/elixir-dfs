defmodule M do
  # Driver method to execute dfs with test data
  def main do
    # Define grid as 2d tuple
    grid = {
      {1, 2, 3},
      {4, 5, 6},
      {7, 8, 9}
    }

    # Prompts user to enter number
    {search, _} = IO.gets("Enter a number from 1 to 9: ") |> Integer.parse()

    # Searches for number in grid and outputs
    {x, y} = dfs(search, grid)
    IO.puts("#{search} can be found at x = #{x} and y = #{y}")
  end

  # Returns all neighbors of a point
  def neighbors(grid, point) do
    {x, y} = point
    y_length = tuple_size(grid)
    x_length = tuple_size(elem(grid, 0))
    _neighborsLeft(x, y, x_length, y_length, [])
  end

  # Returns neighbor to the left if needed
  def _neighborsLeft(x, y, x_length, y_length, neighbors) do
    if x > 0 do
      _neighborsRight(x, y, x_length, y_length, neighbors ++ [{x - 1, y}])
    else
      _neighborsRight(x, y, x_length, y_length, neighbors)
    end
  end

  # Returns neighbor to the right if needed
  def _neighborsRight(x, y, x_length, y_length, neighbors) do
    if x < x_length - 1 do
      _neighborsUp(x, y, x_length, y_length, neighbors ++ [{x + 1, y}])
    else
      _neighborsUp(x, y, x_length, y_length, neighbors)
    end
  end

  # Returns neighbor up if needed
  def _neighborsUp(x, y, x_length, y_length, neighbors) do
    if y > 0 do
      _neighborsDown(x, y, x_length, y_length, neighbors ++ [{x, y - 1}])
    else
      _neighborsDown(x, y, x_length, y_length, neighbors)
    end
  end

  # Returns neighbor down if needed
  def _neighborsDown(x, y, x_length, y_length, neighbors) do
    if y < y_length - 1 do
      neighbors ++ [{x, y + 1}]
    else
      neighbors
    end
  end

  # Searches grid for value using depth first search
  def dfs(value, grid, seen \\ MapSet.new(), point \\ {0, 0}) do
    {x, y} = point
    currValue = elem(elem(grid, y), x)

    # If the current point is our target return the point
    if currValue == value do
      point
    else
      # Get neighbors of current point and find what we haven't visited
      neighbors = neighbors(grid, point)
      visited = MapSet.put(seen, point)

      unseen =
        Enum.filter(neighbors, fn neighbor ->
          !MapSet.member?(visited, neighbor)
        end)

      # Loop through our neighbors and recursively dfs until target value is found
      # Try catch blocks are used when it's impossible to otherwise retrieve a value in Elixir
      # Typically they are used for error handling but this is a situtation where it's impossible
      # to prematurely terminate the search without try / catch
      try do
        for neighbor <- unseen do
          case dfs(value, grid, visited, neighbor) do
            {x, y} -> throw({x, y})
            _ -> "Not solution"
          end
        end

        # Target value has been found, return it
      catch
        {x, y} -> {x, y}
        _ -> "There was an error"
      end
    end
  end
end
