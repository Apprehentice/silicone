local class = require("middleclass")
local Base = require("silicone.elements.Base")

local Label = class("silicone.Label", Base)

function Label:initialize(spec, root)
  self.text = ""
  Base.initialize(self, spec, root)
  self.width = 0
  self.height = 0
  self.heightOffset = self._compiled_skin.Label.font:getHeight()
  self.widthOffset = self._compiled_skin.Label.font:getWidth(self.text)
end

function Label:addSkin(skin)
  Base.addSkin(self, skin)
  self.height = 0
  self.heightOffset = self._compiled_skin.Label.font:getHeight()
end

function Label:setText(text)
  self.text = text
  self.heightOffset = self._compiled_skin.Label.font:getHeight()
  self.widthOffset = self._compiled_skin.Label.font:getWidth(self.text)
end

function Label:setHeight()
end

function Label:setWidth()
end

function Label:setHeightOffset()
end

function Label:setWidthOffset()
end

return Label
