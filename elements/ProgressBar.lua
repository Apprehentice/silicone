local class = require("middleclass")
local Base = require("Silicone.elements.Base")

local ProgressBar = class("Silicone.ProgressBar", Base)

function ProgressBar:initialize(spec, root)
  self.value = 0
  Base.initialize(self, spec, root)

  self.value = math.max(0, math.min(self.value, 1))
end

function ProgressBar:getValue()
  return self.value
end

function ProgressBar:setValue(value)
  self.value = math.max(0, math.min(value, 1))
end
