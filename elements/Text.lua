---
-- A rich text element that uses the @{love:Popo} library.
--
-- **Warning**: Modifying Text elements creates a new Popo object
-- for every call. Use setters sparingly.
-- @classmod Text

local class = require("middleclass")
local Base = require("silicone.elements.Base")
local Popo = require("popo.Text")

local Text = class("silicone.Text", Base)

-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes a Text element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function Text:initialize(spec, root)
  self.type = "Text"
  self.text = ""
  self.settings = {}
  Base.initialize(self, spec, root)
  self._popo = Popo(self.text, self.settings)
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Returns a Text elements text
-- @treturn string text
function Text:getText()
  return self.text
end

---
-- Sets a Text element's text
-- @tparam string text text
function Text:setText(text)
  self.text = text
  self._popo = Popo(self.text, self.settings)
end

---
-- Returns a Text element's settings
-- @treturn table settings
function Text:getSettings()
  return self.Settings
end

---
-- Sets a Text element's settings
-- @tparam table settings Popo settings
function Text:setSettings(settings)
  self.settings = settings
  self._popo = Popo(self.text, self.settings)
end

---
-- LÖVE Callbacks.
-- LÖVE callback handlers for Silicone elements
-- @section LÖVE Callbacks

---
-- Updates a Text element's Popo object
function Text:update(dt)
  self._popo:update(dt)
end

return Text
