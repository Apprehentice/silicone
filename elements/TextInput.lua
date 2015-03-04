local class = require("middleclass")
local Base = require("Silicone.elements.Base")

local TextInput = class("Silicone.TextInput", Base)

function TextInput:initialize(spec, root)
  self.text = ""
  self.length = 26
  Base.initialize(self, spec, root)

  self:addSkin({
    TextInput = {
      _faceText = self.text
    }
    })
end

function TextInput:focus()
  Base.focus(self)
  self._keyRepeat = love.keyboard.hasKeyRepeat()
  love.keyboard.setKeyRepeat(enable)
end

function TextInput:setText(text)
  self.text = string.sub(text, 1, self.length)
end

function TextInput:onConfirm()
  self.text = string.gsub(self._compiled_skin.TextInput._faceText, "%s+$", "")
  self._compiled_skin.TextInput._faceText = self.text
  love.keyboard.setKeyRepeat(self._keyRepeat)
  self._root:popFocus()
end

function TextInput:onCancel()
  self._compiled_skin.TextInput._faceText = self.text
  self._root:popFocus()
end

function TextInput:onLeft()
end

function TextInput:onRight()
end

function TextInput:textinput(text)
  if self:hasFocus() then
    self._compiled_skin.TextInput._faceText = self._compiled_skin.TextInput._faceText .. text
  end
end

function TextInput:keypressed(key)
  if self:hasFocus() and key == "backspace" then
    self._compiled_skin.TextInput._faceText = string.sub(self._compiled_skin.TextInput._faceText, 1, #self._compiled_skin.TextInput._faceText - 1)
  end
end

return TextInput
