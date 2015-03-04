local class = require("middleclass")
local AnAL = require("AnAL")
local Base = require("Silicone.elements.Base")

local MenuImage = class("Silicone.Image", Base)

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

function MenuImage:getAngle()
  return self.angle
end

function MenuImage:setAngle(angle)
  self.angle = angle
end

function MenuImage:getXScale()
  return self.xScale
end

function MenuImage:setXScale(x)
  self.autoScale = false
  self.xScale = x
end

function MenuImage:getYScale()
  return self.yScale
end

function MenuImage:setyScale(y)
  self.autoScale = false
  self.yScale = y
end

function MenuImage:getScale()
  return self.xScale, self.yScale
end

function MenuImage:setScale(x, y)
  self.xScale = x
  self.yScale = y
end

function MenuImage:getAutoScale()
  return self.autoScale
end

function MenuImage:setAutoScale(scale)
  self.autoScale = scale
end

-- AnAL tail calls
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

function MenuImage:update(dt)
  self._animation:update(dt)
end

return MenuImage
