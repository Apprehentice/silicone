---
-- A simple container element for other elements
-- @classmod Panel

local class = require("middleclass")
local Base = require("silicone.elements.Base")

local Panel = class("silicone.Panel", Base)

---
-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes a Panel element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function Panel:initialize(spec, root)
  -- NOTE: NEW properties go before the Base initializer
  Base.initialize(self, spec, root)
  -- Overrides appear after
  self.type = "Panel"
  self.visible = false
end

---
-- Focus.
-- Methods for handling element focus
-- @section Focus

---
-- Sets focus to the first available child of a panel
function Panel:focus()
  for i, v in ipairs(self.children) do
    if v:canFocus() then
      v:focus()
    end
  end
end

return Panel
