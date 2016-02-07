def printer(grid2)
  n = 0
  while n < grid2.length
    m = 0
    name = ""
    while m < grid2.length
      name += String(grid2[n][m])
      m += 1
    end
    puts name
    n += 1
  end
end
def onoff(d)
  if rand() < d
    return 1
  else
    return 0
  end
end
def grid_maker
  density = 0.1
  grid_size = 16
  j = 0
  grid = []
  while j < grid_size do
    i = 0
    array = []
    while i < grid_size do
      #array.push(0)
      array.push(onoff(density))
      i += 1.0
    end
    grid.push(array)
    j += 1.0
  end
  return grid
end

def det_grid
  grid_size = 16
  j = 0
  grid = []
  while j < grid_size do
    i = 0
    array = []
    while i < grid_size do
      array.push(0)
      i += 1.0
    end
    grid.push(array)
    j += 1.0
  end
  grid[0][0] = 1
  return grid
end

def vote_rule(array)
  a = 0
  new_array = []
  while a < array.length
    sa = a - 1
    ba = a + 1
    sa = sa % array.length
    ba = sa % array.length
    total = array[sa] + array[a] + array[ba]
    choice = 0
    if total > 1
      choice = 1
    end
    new_array[a] = choice
    a += 1
  end
  return new_array
end

def add_rule(array)
  a = 0
  new_array = []
  while a < array.length
    sa = a - 1
    choice = array[sa] + array[a]
    choice = choice % 2
    new_array[a] = choice
    a += 1
  end
  return new_array
end

def run(grid,w, rule)
  new_grid = []
  grid_size = grid.length
  if w == 1
    a = 0
    while a < grid_size
      new_array = "ERROR"
      if rule == 1
        new_array = vote_rule(grid[a])
      elsif rule == 2
        new_array = add_rule(grid[a])
      else
        puts "ERROR"
      end
      new_grid.push(new_array)
      a += 1
    end
  elsif w == 2
    temp_grid = []
    new_temp = []
    c = 0
    while c < grid_size
      temp_grid.push([])
      c += 1
    end
    a = 0
    while a < grid_size
      b = 0
      while b < grid_size
        temp_grid[b][a] = grid[a][b]
        b += 1
      end
      a += 1
    end

    d = 0
    while d < grid_size
      new_array = "ERROR"
      if rule == 1
        new_array = vote_rule(temp_grid[d])
      elsif rule == 2
        new_array = add_rule(temp_grid[d])
      else
        puts "ERROR"
      end
      new_temp.push(new_array)
      d += 1
    end

    e = 0
    while e < grid_size
      new_grid.push([])
      e += 1
    end
    f = 0
    while f < grid_size
      g = 0
      while g < grid_size
        new_grid[g][f] = new_temp[f][g]
        g += 1
      end
      f += 1
    end
  else
    puts "ERROR"
  end
  return new_grid
end
def analize(grid)
  c = 0
  array1 = []
  array2 = []
  while c < grid.length
    array1.push(0)
    array2.push(0)
    c += 1
  end
  a = 0
  while a < grid.length
    b = 0
    total = 0
    while b < grid.length
      array1[a] += grid[a][b]
      array2[a] += grid[b][a]
      b += 1
    end
    a += 1
  end
  d = 0
  while d < grid.length
    if array1[d] == 0
      puts "BOOM!"
    end
    if array2[d] == 0
      puts "BOOM!"
    end
    d += 1
  end
end
def play(g, array, rule)
  grid = g
  a = 0
  final_array = []
  while a < array.length
    final_array.push(messure(grid))
    w = array[a]
    new_grid = run(grid, w, rule)
    grid = new_grid
    a += 1
  end
  #return new_grid
  return final_array
end

def array_maker
  big_array = []
  array1 = []
  c = 0
  while c < 50
    d = c % 2
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
  while c3 < 1000
    array3.push(1)
    c3 += 1
  end
  big_array.push(array3)

  return big_array
end

def messure(grid)
  total = 0
  grid_size = grid.length
  q = 0
  total = 0
  while q < grid_size
    r = 0
    while r < grid_size
      total += grid[q][r]
      r += 1
    end
    q += 1
  end
  return total
end

big_array = array_maker
array1 = big_array[0]
array2 = big_array[1]
array3 = big_array[2]

#grid = grid_maker
grid = grid_maker
#printer(grid)
#puts "--------------------"
final = play(grid, array1, 2)
#printer(final)
z4 = 0
total = []
while z4 < final.length
  total.push(0)
  z4 += 1
end

z5 = 0
while z5 < 5000
  grid = grid_maker
  final = play(grid, array1, 1)
  z6 = 0
  while z6 < final.length
    total[z6] += final[z6]
    z6 += 1
  end
  z5 += 1
end
z7 = 0
while z7 < total.length
  total[z7] = total[z7] / 5000.0
  z7 += 1
end
puts total
