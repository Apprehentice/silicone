local class = require("middleclass")
local Base = require("Silicone.elements.Base")
local Popo = require("Popo.Text")

local Text = class("Silicone.Text", Base)
function Text:initialize(spec, root)
  self.type = "Text"
  self.text = ""
  self.settings = {}
  Base.initialize(self, spec, root)
  self._popo = Popo(self.text, self.settings)
end

function Text:setText(text)
  self.text = text
  self._popo = Popo(self.text, self.settings)
end

function Text:getText()
  return self.text
end

function Text:setSettings(settings)
  self.settings = settings
  self._popo = Popo(self.text, self.settings)
end

function Text:getSettings()
  return self.Settings
end

function Text:update(dt)
  self._popo:update(dt)
end

return Text
