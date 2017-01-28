---
-- An element for text input
-- @classmod TextInput

local class = require("middleclass")
local Base = require("silicone.elements.Base")

local TextInput = class("silicone.TextInput", Base)

-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes a TextInput element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function TextInput:initialize(spec, root)
  self.text = ""
  self.length = false
  Base.initialize(self, spec, root)

  self:addSkin({
    TextInput = {
      _faceText = self.text
    }
  })
end

---
-- Returns a TextInput's text
-- @treturn string text
function TextInput:getText()
  return self.text
end

---
-- Sets a TextInput's text
-- @tparam string text text
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
  love.keyboard.setKeyRepeat(self._keyRepeat)
  self._root:popFocus()
end

---
-- Focus.
-- Methods for handling element focus
-- @section Focus

---
-- Puts a text input in focus
function TextInput:focus()
  Base.focus(self)
  self._keyRepeat = love.keyboard.hasKeyRepeat()
  love.keyboard.setKeyRepeat("enable")
end

---
-- Silicone Callbacks.
-- Callbacks for menu functions
-- @section Silicone Callbacks

---
-- Does nothing
function TextInput:onLeft()
end

---
-- Does nothing
function TextInput:onRight()
end

---
-- Callback for the "MouseDown" action
function TextInput:onMouseDown()
  if self._root:peekFocus() ~= self then
    self:focus()
  end
end

---
-- Callback for the "LoseFocus" action. ``TextInput:onCancel`` cannot be called
-- here as it modifies the root's focus stack.
function TextInput:onLoseFocus()
  if self._root:peekFocus(true) == self then return end
  self._compiled_skin.TextInput._faceText = self.text
  love.keyboard.setKeyRepeat(self._keyRepeat)
end

---
-- LÖVE Callbacks.
-- LÖVE callback handlers for Silicone elements
-- @section LÖVE Callbacks

---
-- Handles text input
function TextInput:textinput(text)
  if self:hasFocus() then
    self._compiled_skin.TextInput._faceText = self._compiled_skin.TextInput._faceText .. text
    if self.length then
      self._compiled_skin.TextInput._faceText = string.sub(self._compiled_skin.TextInput._faceText, self.length)
    end
  end
end

---
-- Handles backspace
function TextInput:keypressed(key)
  if self:hasFocus() and key == "backspace" then
    self._compiled_skin.TextInput._faceText = string.sub(self._compiled_skin.TextInput._faceText, 1, #self._compiled_skin.TextInput._faceText - 1)
  end
end

return TextInput
