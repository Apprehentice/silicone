---
-- A canvas element for drawing canvases to Silicone menus
-- @classmod Canvas

local class = require("middleclass")
local Base = require("silicone.elements.Base")

local Canvas = class("silicone.Canvas", Base)

---
-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes a Canvas element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function Canvas:initialize(spec, root)
  self.type = "Canvas"
  Base.initialize(self, spec, root)
  self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Sets a canvas's width
-- @tparam number width width
-- @tparam bool norefresh suppress refreshing the canvas
function Canvas:setWidth(width, norefresh)
  self.width = width
  if not norefresh then
    self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
  end
end

---
-- Sets a canvas's height
-- @tparam number height height
-- @tparam bool norefresh suppress refreshing the canvas
function Canvas:setHeight(height, norefresh)
  self.height = height
  if not norefresh then
    self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
  end
end

---
-- Sets a canvas's dimensions
-- @tparam number w width
-- @tparam number h height
-- @tparam bool norefresh suppress refreshing the canvas
function Canvas:setDimensions(w, h, norefresh)
  self:setWidth(w, true)
  self:setHeight(h, true)
  if not norefresh then
    self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
  end
end

---
-- Get a canvas element's canvas
-- @treturn love:Canvas the canvas
function Canvas:getCanvas()
  return self._canvas
end

---
-- LÖVE Callbacks.
-- LÖVE callback handlers for Silicone elements
-- @section LÖVE Callbacks

---
-- Refreshes the canvas if the screen size changes
function Canvas:resize()
  self._canvas = love.graphics.newCanvas(self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

---
-- Draws the canvas element
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
