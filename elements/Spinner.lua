---
-- A spinner element for number input
-- @classmod Spinner

local class = require("middleclass")
local Base = require("silicone.elements.Base")
local Button = require("silicone.elements.Button")
local Label = require("silicone.elements.Label")

local Spinner = class("silicone.Spinner", Base)

-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes a Spinner element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function Spinner:initialize(spec, root)
  self.value = 0
  self.increment = 1
  self.min = false
  self.max = false
  Base.initialize(self, spec, root)

  self:addSkin({
    Spinner = {
      _faceValue = self.value,
      _spunUp = false,
      _spunDown = false
    }
  })
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Returns a spinner's value
-- @treturn number value
function Spinner:getValue()
  return self.value
end

---
-- Sets a spinner's value
-- @tparam number value value
function Spinner:setValue(value)
  self.value = value
  self._compiled_skin.Spinner._faceValue = self.value
end

---
-- Returns a spinner's increment
-- @treturn number increment
function Spinner:getIncrememnt()
  return self.increment
end

---
-- Sets a spinner's increment
-- @tparam number inc increment
function Spinner:setIncrement(inc)
  self.increment = inc
end

---
-- Returns a spinner's minimum value
-- @treturn number|false value
function Spinner:getMin()
  return self.min
end

---
-- Sets a spinner's minimum value
-- @tparam number|false min minimum value
function Spinner:setMin(min)
  self.min = min
end

---
-- Returns a spinner's maximum value
-- @treturn number|false value
function Spinner:getMax()
  return self.max
end

---
-- Sets a spinner's maximum value
-- @tparam number|false min maximum value
function Spinner:setMax()
  self.max = max
end

---
-- Silicone Callbacks.
-- Callbacks for menu functions
-- @section Silicone Callbacks

---
-- Incremements a spinner's value
function Spinner:onUp()
  self._compiled_skin.Spinner._faceValue = self._compiled_skin.Spinner._faceValue + self.increment

  if self.min then
    self._compiled_skin.Spinner._faceValue = math.max(self.min, self._compiled_skin.Spinner._faceValue)
  end

  if self.max then
    self._compiled_skin.Spinner._faceValue = math.min(self.max, self._compiled_skin.Spinner._faceValue)
  end

  self._compiled_skin.Spinner._spunUp = true
end

---
-- Decremements a spinner's value
function Spinner:onDown()
  self._compiled_skin.Spinner._faceValue = self._compiled_skin.Spinner._faceValue - self.increment

  if self.min then
    self._compiled_skin.Spinner._faceValue = math.max(self.min, self._compiled_skin.Spinner._faceValue)
  end

  if self.max then
    self._compiled_skin.Spinner._faceValue = math.min(self.max, self._compiled_skin.Spinner._faceValue)
  end

  self._compiled_skin.Spinner._spunDown = true
end

---
-- Commits a spinner's value
function Spinner:onConfirm()
  self.value = self._compiled_skin.Spinner._faceValue
  self._root:popFocus()
end

---
-- Discards a spinner's value
function Spinner:onCancel()
  self._compiled_skin.Spinner._faceValue = self.value
  self._root:popFocus()
end

return Spinner
