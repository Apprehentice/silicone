---
-- An animation element using the @{love:AnAL} library.
-- @classmod Animation
-- @alias Animation

local class = require("middleclass")
local AnAL = require("AnAL")
local Base = require("silicone.elements.Base")

local Animation = class("silicone.Animation", Base)

---
-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes an Animation element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function Animation:initialize(spec, root)
  self.type = "Animation"
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

  self._animation = AnAL.newAnimation(spec.animation, spec.frameWidth, spec.frameHeight, spec.delay, spec.frames)
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Returns an animation's angle
-- @treturn number angle
function Animation:getAngle()
  return self.angle
end

---
-- Sets an animation's angle
-- @tparam number angle angle
function Animation:setAngle(angle)
  self.angle = angle
end

---
-- Returns an animation's X scale
-- @treturn number X scale
function Animation:getXScale()
  return self.xScale
end

---
-- Sets an animation's X scale
-- @tparam number x X scale
function Animation:setXScale(x)
  self.autoScale = false
  self.xScale = x
end

---
-- Returns an animation's Y scale
-- @treturn number Y scale
function Animation:getYScale()
  return self.yScale
end

---
-- Sets an animation's Y scale
-- @tparam number y Y scale
function Animation:setYScale(y)
  self.autoScale = false
  self.yScale = y
end

---
-- Returns an animation's scale
-- @treturn number X scale
-- @treturn number Y scale
function Animation:getScale()
  return self:getXScale(), self:getYScale()
end

---
-- Sets an animation's scale
-- @tparam number x X scale
-- @tparam number y Y scale
function Animation:setScale(x, y)
  self:setXScale(x)
  self:setYScale(y)
end

---
-- Returns whether or not the animation is set to auto scale
-- @treturn bool autoscale
function Animation:getAutoScale()
  return self.autoScale
end

---
-- Sets whether or not the animation should auto scale
-- @tparam bool scale autoscale
function Animation:setAutoScale(scale)
  self.autoScale = scale
end

---
-- LÖVE Callbacks.
-- LÖVE callback handlers for Silicone elements
-- @section LÖVE Callbacks

---
-- Updates an Animation
-- @tparam number dt Time since the last update in seconds
function Animation:update(dt)
  self._animation:update(dt)
end

---
-- AnAL Functions.
-- AnAL convenience functions for Silicone Animations
-- @section AnAL Functions

---
-- Generic AnAL function.
--
-- The Animation element implements all of AnAL's functions so you can
-- manipulate them just like you would a normal AnAL animation.
-- @function Animation:AnALFunction
-- @param ...
-- @see love:AnAL
-- @usage
-- -- ...
-- -- Create Animation 'animation'
-- -- ...
--
-- -- Set an Animation's speed to ~30 FPS
-- animation:setSpeed(0.333)

function Animation:addFrame(...)
  self._animation:addFrame(...)
end

function Animation:getCurrentFrame()
  return self._animation:getCurrentFrame()
end

function Animation:getSize()
  return self._animation:getSize()
end

function Animation:play()
  self._animation:play()
end

function Animation:reset()
  self._animation:reset()
end

function Animation:seek(...)
  self._animation:seek(...)
end

function Animation:setDelay(...)
  self._animation:setDelay(...)
end

function Animation:setMode(...)
  self._animation:setMode(...)
end

function Animation:setSpeed(...)
  self._animation:setSpeed(...)
end

function Animation:stop()
  self._animation:stop()
end

return Animation
