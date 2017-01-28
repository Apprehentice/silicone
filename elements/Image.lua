---
-- An image element.
-- @classmod Image
-- @alias Image

local class = require("middleclass")
local AnAL = require("AnAL")
local Base = require("silicone.elements.Base")

local Image = class("silicone.Image", Base)

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
  self.xShear = 0
  self.yShear = 0
  self.autoScale = true
  self.image = false
  Base.initialize(self, spec, root)

  if not spec.height and not spec.heightOffset then
    self.heightOffset = self.image:getHeight()
  end

  if not spec.width and not spec.widthOffset then
    self.widthOffset = self.image:getWidth()
  end
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Returns the @{love:Image} associated with the element
-- @treturn @{love:Image} Image
function MenuImage:getImage()
  return self.image
end

---
-- Sets the @{love:Image} associated with the element
-- @tparam @{love:Image} image Image
function MenuImage:setImage(image)
  self.image = image
end

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
-- Returns the shearing factor for the image's X-axis
-- @treturn number Shear factor
function MenuImage:getXShear()
  return self.xShear
end

---
-- Sets the shearing factor for the image's X-axis
-- @tparam number x Shear factor
function MenuImage:setXShear(x)
  self.xShear = x
end

---
-- Returns the shearing factor for the image's Y-axis
-- @treturn number Shear factor
function MenuImage:getYShear()
  return self.yShear
end

---
-- Sets the shearing factor for the image's X-axis
-- @tparam number y Shear factor
function MenuImage:setYShear(y)
  self.yShear = y
end

---
-- Returns the shearing factor for the image's X and Y axes
-- @treturn number X Shear factor
-- @treturn number Y Shear factor
function MenuImage:getShear()
  return self:getXShear(), self:getYShear()
end

---
-- Sets the shearing factor for the image's X and Y axes
-- @tparam number x X Shear factor
-- @tparam number y Y Shear factor
function MenuImage:setShear(x, y)
  self:setXShear(x)
  self:setYShear(y)
end

---
-- Returns the image element's absolute X position.
--

return Image
