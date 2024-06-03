require 'ruby2d'

# Ställer in fönstrets höjd och bredd
set height: 950
set width: 500

# Initierar variabler för hopp och markstatus samt hastigheter i y- och x-led
jump = 0
ground = 0
@y_velocity = 0
@x_velocity = 0

# Skapar en blå kvadrat som representerar spelkaraktären
@square = Square.new(x: 230, y: 855, size: 25, color: 'blue')

# Skapar en röd rektangel som representerar marken
@rectangle = Rectangle.new(x: 0, y: 890, width: 500, height: 30, color: 'red')

# Skapar flera plattformar med slumpmässiga färger
@platform = Rectangle.new(x: 200, y: 850, width: 50, height: 10, color: Color.new('random'))
@platform2 = Rectangle.new(x: 120, y: 800, width: 50, height: 10, color: Color.new('random'))
@platform3 = Rectangle.new(x: 20, y: 750, width: 50, height: 10, color: Color.new('random'))
@platform4 = Rectangle.new(x: 80, y: 680, width: 50, height: 10, color: Color.new('random'))
@platform5 = Rectangle.new(x: 240, y: 630, width: 50, height: 10, color: Color.new('random'))
@platform6 = Rectangle.new(x: 350, y: 550, width: 50, height: 10, color: Color.new('random'))
@platform7 = Rectangle.new(x: 230, y: 500, width: 50, height: 10, color: Color.new('random'))
@platform8 = Rectangle.new(x: 260, y: 400, width: 50, height: 10, color: Color.new('random'))
@platform9 = Rectangle.new(x: 180, y: 350, width: 50, height: 10, color: Color.new('random'))
@platform10 = Rectangle.new(x: 100, y: 270, width: 50, height: 10, color: Color.new('random'))
@platform11 = Rectangle.new(x: 150, y: 200, width: 50, height: 10, color: Color.new('random'))

# Hanterar tangenttryckningar
on :key_held do |event|
  case event.key
  when 'up'
    if jump == 1
      @square.y -= 5
      @y_velocity -= 2.5
      jump = 0
    end
  when 'left'
    @square.x -= 3
  when 'right'
    @square.x += 3
  end
end

# Uppdaterar spelet i varje frame
update do
  # Om marken inte är nådd, öka y-hastigheten för att simulera gravitation
  if Window.frames % 15 == 0 && ground == 0 
    @y_velocity += 0.5
  end

  # Kontrollera om spelkaraktären är på marken
  if @square.y >= 865
    ground = 1
    @y_velocity = 0
    jump = 1
  elsif @square.y < 865
    ground = 0
  end

  # Kontrollera om spelkaraktären är på någon av plattformarna
  [@platform, @platform2, @platform3, @platform4, @platform5, @platform6, @platform7, @platform8, @platform9, @platform10, @platform11].each do |platform|
    if @square.y + 25 >= platform.y && @square.x + 25 >= platform.x && @square.x <= platform.x + 50 && @square.y + 25 <= platform.y + 10
      ground = 1
      @y_velocity = 0
      jump = 1
    end
  end
  
  # Uppdaterar karaktärens position baserat på hastighet
  @square.x = (@square.x + @x_velocity)
  @square.y = (@square.y + @y_velocity)
end

# Visar fönstret
show
