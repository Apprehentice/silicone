---
-- An image and animation element using the @{love:AnAL} library.
-- @classmod Image
-- @alias MenuImage

local class = require("middleclass")
local AnAL = require("AnAL")
local Base = require("silicone.elements.Base")

local MenuImage = class("silicone.Image", Base)

---
-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes an Image element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function MenuImage:initialize(spec, root)
  self.type = "Image"
  self.angle = 0
  self.xScale = 1
  self.yScale = 1
  self.autoScale = true
  Base.initialize(self, spec, root)

  if not spec.height and not spec.heightOffset then
    self.heightOffset = spec.frameHeight
  end

  if not spec.width and not spec.widthOffset then
    self.widthOffset = spec.frameWidth
  end

  self._animation = AnAL.newAnimation(spec.image, spec.frameWidth, spec.frameHeight, spec.delay, spec.frames)
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Returns an image's angle
-- @treturn number angle
function MenuImage:getAngle()
  return self.angle
end

---
-- Sets an image's angle
-- @tparam number angle angle
function MenuImage:setAngle(angle)
  self.angle = angle
end

---
-- Returns an image's X scale
-- @treturn number X scale
function MenuImage:getXScale()
  return self.xScale
end

---
-- Sets an image's X scale
-- @tparam number x X scale
function MenuImage:setXScale(x)
  self.autoScale = false
  self.xScale = x
end

---
-- Returns an image's Y scale
-- @treturn number Y scale
function MenuImage:getYScale()
  return self.yScale
end

---
-- Sets an image's Y scale
-- @tparam number y Y scale
function MenuImage:setYScale(y)
  self.autoScale = false
  self.yScale = y
end

---
-- Returns an image's scale
-- @treturn number X scale
-- @treturn number Y scale
function MenuImage:getScale()
  return self:getXScale(), self:getYScale()
end

---
-- Sets an image's scale
-- @tparam number x X scale
-- @tparam number y Y scale
function MenuImage:setScale(x, y)
  self:setXScale(x)
  self:setYScale(y)
end

---
-- Returns whether or not the image is set to auto scale
-- @treturn bool autoscale
function MenuImage:getAutoScale()
  return self.autoScale
end

---
-- Sets whether or not the image should auto scale
-- @tparam bool scale autoscale
function MenuImage:setAutoScale(scale)
  self.autoScale = scale
end

---
-- LÖVE Callbacks.
-- LÖVE callback handlers for Silicone elements
-- @section LÖVE Callbacks

---
-- Updates an Image
-- @tparam number dt Time since the last update in seconds
function MenuImage:update(dt)
  self._animation:update(dt)
end

---
-- AnAL Functions.
-- AnAL convenience functions for Silicone Images
-- @section AnAL Functions

---
-- Generic AnAL function.
--
-- The Image element implements all of AnAL's functions so you can
-- manipulate them just like you would a normal AnAL animation.
-- @function Image:AnALFunction
-- @param ...
-- @see love:AnAL
-- @usage
-- -- ...
-- -- Create Image 'image'
-- -- ...
--
-- -- Set an Image's speed to ~30 FPS
-- image:setSpeed(0.333)

function MenuImage:addFrame(...)
  self._animation:addFrame(...)
end

function MenuImage:getCurrentFrame()
  return self._animation:getCurrentFrame()
end

function MenuImage:getSize()
  return self._animation:getSize()
end

function MenuImage:play()
  self._animation:play()
end

function MenuImage:reset()
  self._animation:reset()
end

function MenuImage:seek(...)
  self._animation:seek(...)
end

function MenuImage:setDelay(...)
  self._animation:setDelay(...)
end

function MenuImage:setMode(...)
  self._animation:setMode(...)
end

function MenuImage:setSpeed(...)
  self._animation:setSpeed(...)
end

function MenuImage:stop()
  self._animation:stop()
end

return MenuImage
