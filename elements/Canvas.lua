local class = require("middleclass")
local Base = require("silicone.elements.Base")

local Canvas = class("silicone.Canvas", Base)

function Canvas:initialize(spec, root)
  self.type = "Canvas"
  Base.initialize(self, spec, root)
  self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

function Canvas:setWidth(width)
  self.width = width
  self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

function Canvas:setHeight(height)
  self.height = height
  self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

function Canvas:setDimensions(w, h)
  self.width = w
  self.height = h
  self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

function Canvas:resize()
  self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

function Canvas:draw()
  if not self.visible then return end

  if self._compiled_skin[self.type] then
    self._compiled_skin[self.type]["draw"](self)
  end

  local c = love.graphics.getCanvas()
  love.graphics.setCanvas(self._canvas)
  for i, v in ipairs(self.children) do
    v:draw()
  end
  love.graphics.setCanvas(c)
end

return Canvas
