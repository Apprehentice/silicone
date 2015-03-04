local class = require("middleclass")
local Base = require("Silicone.elements.Base")
local Label = require("Silicone.elements.Label")

local Button = class("Silicone.Button", Base)

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

function Button:isDown()
  return self.down
end

function Button:setState(down)
  self.down = down
end

function Button:isToggle()
  return self.toggle
end

function Button:setToggle(toggle)
  self.toggle = toggle
end

function Button:press()
  self.down = not self.down
  self._compiled_skin.Button._pressed = true
end

function Button:onConfirm()
  self:press()
end

function Button:update(dt)
  if not self.toggle then
    self.down = false
  end
end

return Button
