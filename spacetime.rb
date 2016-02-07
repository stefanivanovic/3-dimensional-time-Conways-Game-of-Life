top_velocity = 30
universe_size = 20
particle_amount = 20.0
particles = []
def random2(num)
  num = (num * rand() * 2 ) - num
  return num
end
def dist(a,b)
  x = (a[0] - b[0]).abs
  y = (a[1] - b[1]).abs
  t = ((x**2) + (y**2)) ** (0.5)
  return t
end
def generator(vel,uni)
  vel1 = random2(vel)
  vel2 = random2(vel)
  cord1 = uni * rand()
  cord2 = uni * rand()
  array = [[cord1, cord2], [vel1, vel2]]
  return array
end
a = 1
while a <= particle_amount do
  item  = generator(top_velocity, universe_size)
  particles.push(item)
  a += 1
end

def printer(particles,size)
  a = 0
  while a < size
    b = 0
    message = ""
    while b < size
      c = 0
      amount = 0
      while c < particles.length do
        cord1 = particles[c][0][0]
        cord2 = particles[c][0][1]
        #puts String(cord1) + ", " + String(cord2)
        #puts String(a) + ", " + String(b)
        if (a < cord1)
          if (cord1 < (a + 0.5))
            if (b < cord2)
              if (cord2 < (b + 0.5))
                amount += 1
              end
            end
          end
        end
        c += 1
      end

      if amount == 0
        message = message + "  "
      else
        if amount < 10
          message = message + " " + String(amount)
        else
          message = message + String(amount)
        end
      end
      b += 0.5
    end
    puts message
    a += 0.5
  end
end


def den_eq(distance)
  den = 1.0 / ((distance ** 6.0) * 0.1)
  return den
end

def run(particles,universe_size,top_velocity)
  b = 0
  while b < particles.length
    c = 0
    density = 0
    comp_density = (Float(particles.length) / 2.5) * den_eq(0.6)
    while c < particles.length
      if c != b
        cord1 = particles[b][0]
        cord2 = particles[c][0]
        distance = dist(cord1, cord2)
        if distance < 0.6
          distance = 0.6
        end
        den = den_eq(distance)
        density += den
      end
      c += 1
    end

    #This part of the code makes black holes possible. If true == false is to turn it off
    if true == true
      if density > comp_density
        d = 0
        while d < particles.length
          if d != b
            cord1 = particles[b][0]
            cord2 = particles[d][0]
            distance = dist(cord1, cord2)
            den = den_eq(distance)
            density += den
          end
          d += 1
        end
      end
    end

    velocity = particles[b][1]
    vel1 = random2(top_velocity)
    vel2 = random2(top_velocity)
    vel1 += ( velocity[0] / 5.0 )
    vel2 += ( velocity[1] / 5.0 )

    vel1 = vel1 / density
    vel2 = vel2 / density


    new_cord1 = particles[b][0][0] + vel1
    new_cord1 = new_cord1 % universe_size
    new_cord2 = particles[b][0][1] + vel2
    new_cord2 = new_cord2 % universe_size
    particles[b][0][0] = new_cord1
    particles[b][0][1] = new_cord2

    b += 1
  end
  return particles
end

def rounds(particles, universe_size, top_velocity, number)
  a = 0
  while a < number
    new_particles = run(particles, universe_size, top_velocity)
    particles = new_particles
    a += 1
    #printer(particles,universe_size)
    #puts "-----------------------------------"
  end
  return particles
end

def speed_rounds(particles, universe_size, top_velocity, number)
  a = 0
  while a < number
    ratio = Float(a) / number
    top_velocity = (( ratio * 1.0 ) * top_velocity) + top_velocity
    new_particles = run(particles, universe_size, top_velocity)
    particles = new_particles
    a += 1
    #printer(particles,universe_size)
    #puts "-----------------------------------"
  end
  return particles
end

def avg_dist(particles)
  amount = particles.length
  total_distance = 0
  a = 0
  while a < amount
    b = 0
    while b < amount
      if b != a
        cord1 = particles[a][0]
        cord2 = particles[b][0]
        distance = dist(cord1, cord2)
        total_distance += distance
      end
      b += 1
    end
    a += 1
  end
  average_distance = total_distance / ( ( amount - 1) * amount)
end
printer(particles,universe_size)
puts "--------------------------------------------------------------------------------"
final_grid = rounds(particles, universe_size, top_velocity, 10000)
printer(final_grid,universe_size)
#puts "---------------------------------------"
#grid3 = run(final_grid, universe_size, top_velocity)
#printer(grid3, universe_size)
