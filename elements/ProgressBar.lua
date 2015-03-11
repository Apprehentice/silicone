---
-- A simple progress bar element
-- @classmod ProgressBar

local class = require("middleclass")
local Base = require("silicone.elements.Base")

local ProgressBar = class("silicone.ProgressBar", Base)

---
-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes a ProgressBar element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function ProgressBar:initialize(spec, root)
  self.value = 0
  Base.initialize(self, spec, root)

  self.value = math.max(0, math.min(self.value, 1))
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Returns the value of a ProgressBar
-- @treturn number value
function ProgressBar:getValue()
  return self.value
end

---
-- Sets the value of a ProgressBar
-- @tparam number value value
function ProgressBar:setValue(value)
  self.value = math.max(0, math.min(value, 1))
end
