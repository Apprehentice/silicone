local class = require("middleclass")
local Base = require("Silicone.elements.Base")

local Panel = class("Silicone.Panel", Base)
function Panel:initialize(spec, root)
  -- NOTE: NEW properties go before the Base initializer
  Base.initialize(self, spec, root)
  -- Overrides appear after
  self.type = "Panel"
  self.visible = false
end

function Panel:focus()
  for i, v in ipairs(self.children) do
    if v:canFocus() then
      v:focus()
    end
  end
end

return Panel
