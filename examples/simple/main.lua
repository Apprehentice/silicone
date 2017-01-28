-- Create a simple menu containing a panel which contains a button.
-- The button should start with the text "Button" and change its text
-- to "Hello!" when it has been pressed.

local Silicone = require("Silicone")

local Root = Silicone({
  children = {
    {
      type = "Panel",
      name = "mainPanel",
      width = 0.9,
      height = 0.9,
      origin = "center",
      anchor = "center",
      children = {
        {
          type = "Button",
          name = "button1",
          width = 0.1,
          height = 0.05,
          origin = "center",
          anchor = "center",
          children = {
            {
              type = "Label",
              name = "button1.label1",
              text = "Button",
              origin = "center",
              anchor = "center"
            }
          }
        }
      }
    }
  }
})

local button1 = Root:find("button1")
function button1:onConfirm()
  self:press()
  Root:find("button1.label1"):setText("Hello!")
end

local mainPanel = Root:find("mainPanel")
mainPanel:show()

Root:focus()

function love.draw()
  Root:draw()
end

function love.update(dt)
  Root:update(dt)
end

function love.keypressed(key)
  if key == "return" then
    Root:doConfirm()
  end
end

function love.mousemoved(x, y, dx, dy, istouch)
  Root:doMouseMove(x, y, dx, dy, istouch)
end

function love.mousepressed(x, y, button, istouch)
  Root:doMouseDown(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
  Root:doMouseUp(x, y, button, istouch)
end
