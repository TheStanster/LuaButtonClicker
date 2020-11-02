function love.load()
  button = {}
  button.x = 200
  button.y = 200
  button.size = 50
  button.r = 1
  button.g = 0

  missed = 0
  score = 0
  accuracy = 0

  timeLimit = 5
  time = timeLimit
  myFont = love.graphics.newFont(20)

  windowX = love.graphics.getWidth()
  windowY = love.graphics.getHeight()

  --Load sprites
  sprites = {}
  sprites.sky = love.graphics.newImage('sprites/sky.png')
  sprites.target = love.graphics.newImage('sprites/target.png')
  sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')
    love.mouse.setVisible(false)

end

function love.update(dt)
  if time > 0 then
    time = time - dt
  end
  if time < 0 then
    time = 0
  end
end

function love.draw()
  love.graphics.draw(sprites.sky)
  love.graphics.setColor(button.r, button.g, 0)
  love.graphics.circle("fill", button.x, button.y, button.size)

  love.graphics.setFont(myFont)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(score)
  love.graphics.print("Time elapsed: " , 100, 0)
  love.graphics.print(math.ceil(time) , 250, 0)

  --Draw sprites
  love.graphics.draw(sprites.target, button.x-50, button.y-50)
  love.graphics.draw(sprites.crosshairs, love.mouse.getX()-40, love.mouse.getY()-40)

  if time == 0 then
    love.graphics.clear()
    timeUp()
  end
end

function love.mousepressed(x, y, butt, isTouch)
  -- d = ((y - button.y)^2+(x - button.x)^2)^0.5
  d = distanceBetween(button.x, button.y, love.mouse.getX(), love.mouse.getY())
  if butt == 1 then
    if d <= button.size then
      score = score + 1
      buttonRefreshScored()
    else
      missed = missed + 1
      buttonRefreshMissed()
    end
  end
end

function buttonRefreshScored()
  pointX = windowX - button.size
  pointY = windowY - button.size
  button.x = love.math.random(button.size, pointX)
  button.y = love.math.random(button.size + 10, pointY)
  button.r = 0
  button.g = 1
end

function buttonRefreshMissed()
  pointX = windowX - button.size
  pointY = windowY - button.size
  button.x = love.math.random(button.size, pointX)
  button.y = love.math.random(button.size + 10, pointY)
  button.r = 1
  button.g = 0
end

function distanceBetween(x1, y1, x2, y2)
  return ((y2 - y1)^2+(x2 - x1)^2)^0.5
end

function timeUp()
  if score > 0 then
    accuracy = (score / (score + missed))*100
  end
  px1 = ((windowX)/2)-250
  px2 = ((windowX)/2)+50
  py1= ((windowY)/2)
  py2= ((windowY)/2)
  love.graphics.print("Time's up! Your score is: ", px1, py1)
  love.graphics.print(score , px2, py2)
  love.graphics.print("Your accuracy was: ", px1, py1 + 20)
  love.graphics.print(accuracy , px2, py2 + 20)
  love.graphics.print("%" , px2 + 40, py2 + 20)
  love.mouse.setVisible(true)
  function love.mousepressed(x, y, butt, isTouch)
    if butt == 1 then
      love.window.close()
    end
  end
end
