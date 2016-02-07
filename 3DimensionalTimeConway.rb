tested_array = [1, 2, 3, 2, 2, 1, 2, 3, 1, 2, 3, 1, 1, 3, 1, 3, 3, 2, 1, 3, 1, 2, 3, 3, 1, 3, 3, 3, 2, 2, 2, 1, 3, 2, 1, 2, 3, 3, 2, 1, 3, 1, 1, 3, 1, 3, 2, 3, 3, 1, 1, 2, 3, 1, 2, 3, 3, 1, 3, 3, 1, 2, 1, 1, 1, 1, 3, 1, 1, 2, 3, 2, 2, 1, 3, 2, 1, 2, 3, 1, 3, 3, 3, 1, 1, 1, 1, 1, 1, 3, 3, 2, 2, 2, 1, 2, 2, 2, 3, 2]
worst_array = [3, 3, 1, 1, 2, 1, 2, 3, 1, 2, 1, 2, 1, 1, 1, 1, 3, 1, 3, 1, 1, 3, 2, 3, 3, 2, 1, 2, 1, 2, 2, 3, 1, 2, 1, 1, 1, 2, 2, 3, 3, 2, 3, 2, 2, 2, 2, 1, 2, 3]
def messure(grid)
  total = 0
  grid_size = grid.length
  q = 0
  total = 0
  while q < grid_size
    r = 0
    while r < grid_size
      s = 0
      while s < grid_size
        total += grid[q][r][s]
        s += 1
      end
      r += 1
    end
    q += 1
  end
  return total
end

def play(g, array)
  a = 0
  grid = g
  while a < array.length
    w = array[a]
    grid2 = run(grid, w)
    grid = grid2
    a += 1
  end
  total = messure(grid)
  return total
end

def run(grid, w)
  grid_size = grid.length
  if w == 4

  else
    new_grid = []
    l = 0
    while l < grid_size do
      k = 0
      while k < grid_size do
        if k == 0
          new_grid.push([])
        end
        j = 0
        while j < grid_size do
          if j == 0
            new_grid[l].push([])
          end
          x = "Error"
          y = "Error"
          z = "Error"
          if w == 1
            z = l
            x = k
            y = j
          elsif w == 2
            z = k
            x = l
            y = j
          elsif w == 3
            z = j
            x = l
            y = k
          else
            puts "Error: w != 1,2,3"
          end

          sx = x - 1
          bx = x + 1
          sy = y - 1
          by = y + 1

          sx = sx % grid_size
          bx = bx % grid_size
          sy = sy % grid_size
          by = by % grid_size

          sk = "error"
          bk = "error"
          sl = "error"
          bl = "error"
          sj = "error"
          bj = "error"
          if w == 1
            sl = z
            #l = z
            bl = z
            sk = sx
            #k = x
            bk = bx
            sj = sy
            #j = y
            bj = by
          elsif w == 2
            sl = sx
            #l = x
            bl = bx
            sk = z
            #k = z
            bk = z
            sj = sy
            #j = y
            bj = by
          elsif w == 3
            sl = sx
            #l = x
            bl = bx
            sk = sy
            #k = y
            bk = by
            sj = z
            #j = z
            bj = z
          else
            puts "Error: w != 1,2,3"
          end

          number = grid[sl][sk][bj] + grid[sl][k][sj] + grid[sl][bk][j]
          number += grid[l][sk][sj] + grid[l][bk][bj]
          number += grid[bl][sk][j] + grid[bl][k][bj] + grid[bl][bk][sj]

          alive = grid[l][k][j]

          if number < 2
            should_live = 0
          elsif number > 3
            should_live = 0
          else
            if alive == 1
              should_live = 1
            else
              if number == 3
                should_live = 1
              else
                should_live = 0
              end
            end
          end

          new_grid[l][k][j] = should_live

          j += 1
        end
        k += 1
      end
      l += 1
    end
  end
  return new_grid
end

def onoff(d)
  if rand() < d
    return 1
  else
    return 0
  end
end

def grid_maker
  grid_size = 20
  density = 0.3

  j = 0
  grid = []
  while j < grid_size do
    i = 0
    array = []
    while i < grid_size do
      k = 0
      mini_array = []
      while k < grid_size do
        mini_array.push(onoff(density))
        k += 1
      end
      i += 1.0
      array.push(mini_array)
    end
    grid.push(array)
    j += 1.0
  end

  return grid
end

def game(the_array)
  grid = grid_maker
  return play(grid, the_array)
end

def array_maker
  big_array = []
  array1 = []
  c = 0
  while c < 50
    d = c % 3
    d += 1
    array1.push(d)
    c += 1
  end
  big_array.push(array1)

  c2 = 0
  array2 = []
  while c2 < 50
    d = "error"
    if c2 < 67
      d = 1
    elsif c2 < 134
      d = 2
    else
      d = 3
    end
    array2.push(d)
    c2 += 1
  end
  big_array.push(array2)

  c3 = 0
  array3 = []
  while c3 < 50
    array3.push(1)
    c3 += 1
  end
  big_array.push(array3)

  return big_array
end

def prosses
  message2 = ""
  array = []
  c3 = 0
  while c3 < 100
    thing = c3 % 3
    thing += 1
    array.push(thing)
    c3 += 1
  end
  a = 0
  while a < 100
    arr1 = array
    arr2 = array
    arr3 = array
    arr1[a] = 1
    arr1[a] = 2
    arr1[a] = 3

    total1 = 0
    total2 = 0
    total3 = 0

    times = 20

    b = 0
    while b < times
      total1 += game(arr1)
      total2 += game(arr2)
      total3 += game(arr3)
      b += 1
    end

    choice = "error"
    if total1 < total2
      if total1 < total3
        choice = 1
      else
        choice = 3
      end
    else
      if total2 < total3
        choice = 2
      else
        choice = 3
      end
    end
    puts choice
    array[a] = choice
    message2 = ", " + String(choice)
    a += 1
  end
  puts message2
  return array
end

def game_graph(array)
  scores = []
  a = 0
  grid = grid_maker
  while a < array.length
    w = array[a]
    grid2 = run(grid, w)
    grid = grid2
    if ( a % 2 ) == 0
      scores.push(messure(grid))
    end
    a += 1
  end
  return scores
end

big_array = array_maker
array1 = big_array[0]
array2 = big_array[1]
array3 = big_array[2]

#puts worst_array.length
#prosses
z = 0
total_scores = []
z3 = 0
while z3 < 25
  total_scores.push(0)
  z3 += 1
end
while z < 10
  scores = game_graph(worst_array)
  z2 = 0
  puts String(z + 1) + "/10"
  while z2 < scores.length
    total_scores[z2] += scores[z2]
    z2 += 1
  end
  z += 1
end
z4 = 0
while z4 < total_scores.length
  total_scores[z4] = total_scores[z4] / 10.0
  z4 += 1
end
puts total_scores

#prosses

#v = 0
#total1 = 0
#total2 = 0
#while v < 50
#  #total1 += game(array1)
#  total2 += game(worst_array)
#  v += 1
#end
#av1 = total1 / 100.0
#av2 = total2 / 100.0
#puts av1
#puts av2
#mes = " "
#temp = 0
#while temp < 100
#  var = gets.chomp
#  mes = mes + ", " + var
#  temp += 1
#end
#puts mes
