local class = require("middleclass")
local Base = require("Silicone.elements.Base")
local Button = require("Silicone.elements.Button")
local Label = require("Silicone.elements.Label")

local Spinner = class("Silicone.Spinner", Base)

function Spinner:initialize(spec, root)
  self.value = 0
  self.increment = 1
  Base.initialize(self, spec, root)

  self:addSkin({
    Spinner = {
      _faceValue = self.value,
      _spunUp = false,
      _spunDown = false
    }
    })
end

function Spinner:getValue()
  return self.value
end

function Spinner:setValue(value)
  self.value = value
  self._compiled_skin.Spinner._faceValue = self.value
end

function Spinner:getIncrememnt()
  return self.increment
end

function Spinner:setIncrement(inc)
  self.increment = inc
end

function Spinner:onUp()
  self._compiled_skin.Spinner._faceValue = self._compiled_skin.Spinner._faceValue + self.increment
  self._compiled_skin.Spinner._spunUp = true
end

function Spinner:onDown()
  self._compiled_skin.Spinner._faceValue = self._compiled_skin.Spinner._faceValue - self.increment
  self._compiled_skin.Spinner._spunDown = true
end

function Spinner:onConfirm()
  self.value = self._compiled_skin.Spinner._faceValue
  self._root:popFocus()
end

function Spinner:onCancel()
  self._compiled_skin.Spinner._faceValue = self.value
  self._root:popFocus()
end

return Spinner
