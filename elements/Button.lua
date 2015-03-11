---
-- A button element for providing visual feedback to the selection of options.
-- @classmod Button

local class = require("middleclass")
local Base = require("silicone.elements.Base")
local Label = require("silicone.elements.Label")

local Button = class("silicone.Button", Base)

---
-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes a Button element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function Button:initialize(spec, root)
  self.toggle = false
  self.down = false
  Base.initialize(self, spec, root)

  self:addSkin({
    Button = {
      _pressed = false
    }
    })
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Returns whether or not the button is down
-- @treturn bool down
function Button:isDown()
  return self.down
end

---
-- Sets the button's "down" state
-- @tparam bool down state
function Button:setState(down)
  self.down = down
end

---
-- Toggles the button's state
function Button:press()
  self.down = not self.down
  self._compiled_skin.Button._pressed = true
end

---
-- Returns whether or not the button is a toggle
-- @treturn bool toggle
function Button:isToggle()
  return self.toggle
end

---
-- Sets whether or not the button is a toggle
-- @tparam bool toggle toggle
function Button:setToggle(toggle)
  self.toggle = toggle
end

---
-- LÖVE Callbacks.
-- LÖVE callback handlers for Silicone elements
-- @section LÖVE Callbacks

---
-- Resets the button's state if it is not a toggle
function Button:update(dt)
  if not self.toggle then
    self.down = false
  end
end

---
-- Silicone Callbacks.
-- Callbacks for menu functions
-- @section Silicone Callbacks

---
-- Callback for the "confirm" action
function Button:onConfirm()
  self:press()
end

return Button
