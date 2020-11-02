function love.load()
  button = {}
  button.x = 200
  button.y = 200
  button.radius = 50


  missed = 0
  score = 0
  accuracy = 0
  gameState = 1

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
  if time > 0 and gameState == 2 then
    time = time - dt
  end
  if time < 0 then
    time = 0
    gameState = 3
  end
end

function love.draw()
  love.graphics.draw(sprites.sky, 0, 0)

  love.graphics.setFont(myFont)
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Score: " .. score, 5, 5)
  love.graphics.print("Time left: " .. math.ceil(time), 100, 5)
  


  if gameState == 1 then
    love.graphics.printf("Click anywhere to start a game...", 0, love.graphics.getHeight()/2, love.graphics.getWidth(), "center")
    love.mouse.setVisible(true)
  end

  if gameState == 2 then
    love.mouse.setVisible(false)
    love.graphics.draw(sprites.target, button.x-button.radius, button.y-button.radius)
    love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
  end

  if gameState == 3 then
    love.mouse.setVisible(true) 
    timeUp()
  end
  

end

function love.mousepressed(x, y, butt, isTouch)
  d = distanceBetween(button.x, button.y, love.mouse.getX(), love.mouse.getY())
  if butt == 1 and gameState == 2 then
    if d <= button.radius then
      score = score + 1
      buttonRefreshScored()
    else
      missed = missed + 1
      buttonRefreshMissed()
    end
  elseif (gameState == 1 or gameState == 3) and butt == 1 then 
    newGame()
  elseif gameState == 3 and butt == 2 then 
    love.window.close()
  end
end

function buttonRefreshScored()
  pointX = windowX - button.radius
  pointY = windowY - button.radius
  button.x = love.math.random(button.radius, pointX)
  button.y = love.math.random(button.radius + 10, pointY)

end

function buttonRefreshMissed()
  pointX = windowX - button.radius
  pointY = windowY - button.radius
  button.x = love.math.random(button.radius, pointX)
  button.y = love.math.random(button.radius + 10, pointY)

end

function distanceBetween(x1, y1, x2, y2)
  return ((y2 - y1)^2+(x2 - x1)^2)^0.5
end

function newGame()
  missed = 0
  score = 0
  accuracy = 0
  time = timeLimit

  gameState = 2
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
  love.graphics.print(accuracy .. "%", px2, py2 + 20)
  
end
