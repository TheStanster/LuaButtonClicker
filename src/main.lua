function love.load()
  button = {}
  button.x = 200
  button.y = 200
  button.size = 50

  score = 0
  time = 0
  timeLimit = 5
  myFont = love.graphics.newFont(20)

  windowX = love.graphics.getWidth()
  windowY = love.graphics.getHeight()
end

function love.update(dt)
  if math.ceil(time) < timeLimit then
    time = time + (1/60)
  end
end

function love.draw()
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("fill", button.x, button.y, button.size)

  love.graphics.setFont(myFont)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(score)
  love.graphics.print("Time elapsed: " , 100, 0)
  love.graphics.print(math.ceil(time) , 250, 0)
  if math.ceil(time) == timeLimit then
    love.graphics.clear()
    timeUp()
  end
end

function love.mousepressed(x, y, butt, isTouch)
  d = ((y - button.y)^2+(x - button.x)^2)^0.5
  if butt == 1 then
    if d >= -50 and d <= 50 then
      score = score + 1
      buttonRefresh()
    end
  end
end

function buttonRefresh()
  px = windowX-50
  py = windowY-50
  button.x = love.math.random(50, px)
  button.y = love.math.random(60, py)
end

function timeUp()
  px1 = ((windowX)/2)-250
  px2 = ((windowX)/2)+50
  py1= ((windowY)/2)
  py2= ((windowY)/2)
  love.graphics.print("Time's up! Your score is: " , px1, py1)
  love.graphics.print(score , px2, py2)
  function love.mousepressed(x, y, butt, isTouch)
    if butt == 1 then
      love.window.close()
    end
  end
end
