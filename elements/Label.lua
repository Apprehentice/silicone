---
-- A simple text element
-- @classmod Label

local class = require("middleclass")
local Base = require("silicone.elements.Base")

local Label = class("silicone.Label", Base)

---
-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes a Label element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function Label:initialize(spec, root)
  self.text = ""
  Base.initialize(self, spec, root)
  self.width = 0
  self.height = 0
  self.heightOffset = self._compiled_skin.Label.font:getHeight()
  self.widthOffset = self._compiled_skin.Label.font:getWidth(self.text)
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Adds a skin to a label
-- @see Base.addSkin
function Label:addSkin(skin)
  Base.addSkin(self, skin)
  self.height = 0
  self.heightOffset = self._compiled_skin.Label.font:getHeight()
end

---
-- Returns a label's text
-- @treturn string text
function Label:getText()
  return self.text
end

---
-- Sets a label's text
-- @tparam string text text
function Label:setText(text)
  self.text = text
  self.heightOffset = self._compiled_skin.Label.font:getHeight()
  self.widthOffset = self._compiled_skin.Label.font:getWidth(self.text)
end

---
-- Does nothing.
-- Label height is implicit.
function Label:setHeight()
end

---
-- Does nothing.
-- Label width is implicit.
function Label:setWidth()
end

---
-- Does nothing.
-- Label height is implicit.
function Label:setHeightOffset()
end

---
-- Does nothing.
-- Label width is implicit.
function Label:setWidthOffset()
end

return Label
