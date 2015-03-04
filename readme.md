Silicone
========
Silicone is a key controlled event-driven UI for the LÖVE framework. Silicone was designed with gamepads in mind for games such as RPGs where the player will spend most of their time on the directional keys.

## Usage ##
The recommended method for creating menus with Silicone is shown below. This method utilizes a basic table structure to create what might normally be done with multiple getters and setters in other frameworks. Ideally, you would use something like a JSON parser to load menus from an external file. This functionality has not been implemented, however, as the preferred markup should be determined by the developer.

In this example, we show how to build a very simple menu with a panel, a button, and a text label for the button that will change from "Button" to "Hello!" when the button is pressed.
```Lua
local Silicone = require("Silicone")

local Root = Silicone({
  type = "Root",
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
```

As you can see, we create a Root object and define its structure in a table. In this table, we can nest the Root's children so that they will be created at the same time as the Root. Most, if not all, of an element's attributes can be set through this structure sans attributes that may require some additional processing such as skins.

## Skinning ##
Silicone can be configured to look and feel any way you like because the logic behind the drawing of an element has been abstracted away into skins. The default skin is a very basic resourceless skin that does little more than display the elements and provide some visual feedback upon interaction. Because of this, it is recommended that you design your own skin to suit your needs.


## To Do ##
* Write a better readme
* Create proper documentation
