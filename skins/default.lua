default = {}

default.Label = {
  font = love.graphics.newFont(12),
  color = {255, 255, 255},
  focusColor = {255, 0, 0}
}

function default.Label.draw(self)
  if self:hasFocus() then
    love.graphics.setColor(unpack(self._compiled_skin.Label.focusColor))
  else
    love.graphics.setColor(unpack(self._compiled_skin.Label.color))
  end
  love.graphics.setFont(self._compiled_skin.Label.font)
  love.graphics.print(self.text, self:getAbsoluteX(), self:getAbsoluteY())
end

default.Panel = {
  color = {0, 0, 255}
}

function default.Panel.draw(self)
  love.graphics.setColor(unpack(self._compiled_skin.Panel.color))
  love.graphics.rectangle("fill", self:getAbsoluteX(), self:getAbsoluteY(), self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

default.Text = {}
function default.Text.draw(self)
  self._popo:draw(self:getAbsoluteX(), self:getAbsoluteY())
end

default.Canvas = {}
function default.Canvas.draw(self)
  love.graphics.draw(self._canvas)
end

default.Image = {}
function default.Image.draw(self)
  local xs = self.autoScale and self:getAbsoluteWidth()/self._animation:getWidth() or self.xScale
  local ys = self.autoScale and self:getAbsoluteHeight()/self._animation:getHeight() or self.yScale
  self._animation:draw(self:getAbsoluteX(), self:getAbsoluteY(), self.angle, xs, ys)
end

default.Button = {
  color = {
    bg = {
      default = {127, 0, 127},
      focus = {127, 0, 0},
      down = {0, 127, 0}
    }
  }
}

function default.Button.draw(self)
  if self._compiled_skin.Button._pressed or self.down then
    self._compiled_skin.Button._pressed = false
    love.graphics.setColor(unpack(self._compiled_skin.Button.color.bg.down))
  elseif self:hasFocus() then
    love.graphics.setColor(unpack(self._compiled_skin.Button.color.bg.focus))
  else
    love.graphics.setColor(unpack(self._compiled_skin.Button.color.bg.default))
  end

  love.graphics.rectangle("fill", self:getAbsoluteX(), self:getAbsoluteY(), self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

default.Spinner = {
  color = {
    outline = {
      default = {255, 255, 255, 0},
      focus = {255, 255, 255, 255},
      spun = {255, 0, 0, 255}
    },
    text = {255, 255, 255, 255}
  },
  font = love.graphics.newFont(12),
  _spunUp = false,
  _spundown = false
}

function default.Spinner.draw(self)
  if self._compiled_skin.Spinner._spunUp or self._compiled_skin.Spinner._spunDown then
    self._compiled_skin.Spinner._spunUp = false
    self._compiled_skin.Spinner._spunDown = false
    love.graphics.setColor(unpack(self._compiled_skin.Spinner.color.outline.spun))
  elseif self:hasFocus() then
    love.graphics.setColor(unpack(self._compiled_skin.Spinner.color.outline.focus))
  else
    love.graphics.setColor(unpack(self._compiled_skin.Spinner.color.outline.default))
  end

  love.graphics.rectangle("line", self:getAbsoluteX(), self:getAbsoluteY(), self:getAbsoluteWidth(), self:getAbsoluteHeight())

  love.graphics.setColor(unpack(self._compiled_skin.Spinner.color.text))
  love.graphics.setFont(default.Spinner.font)
  love.graphics.printf(self._compiled_skin.Spinner._faceValue or 0, self:getAbsoluteX(), self:getAbsoluteY(), self:getAbsoluteWidth(), "center")
end

default.TextInput = {
  color = {
    outline = {
      default = {255, 255, 255, 0},
      focus = {255, 255, 255, 255}
    },
    cursor = {
      default = {255, 255, 255, 0},
      focus = {255, 255, 255, 255}
    },
    text = {255, 255, 255}
  },
  font = love.graphics.newFont(12),
}

function default.TextInput.draw(self)
  if self:hasFocus() then
    love.graphics.setColor(unpack(self._compiled_skin.TextInput.color.outline.focus))
  else
    love.graphics.setColor(unpack(self._compiled_skin.TextInput.color.outline.default))
  end

  love.graphics.rectangle("line", self:getAbsoluteX(), self:getAbsoluteY(), self:getAbsoluteWidth(), self:getAbsoluteHeight())

  love.graphics.setColor(unpack(self._compiled_skin.TextInput.color.text))
  love.graphics.setFont(self._compiled_skin.TextInput.font)
  love.graphics.printf(self._compiled_skin.TextInput._faceText or "", self:getAbsoluteX(), self:getAbsoluteY(), self:getAbsoluteWidth(), "center")
end

default.ProgressBar = {
  color = {
    outline = {255, 255, 255},
    bg = {0, 255, 255}
  }
}

function default.ProgressBar.draw(self)
  love.graphics.setColor(unpack(default.ProgressBar.color.bg))
  love.graphics.rectangle("fill", self:getAbsoluteX(), self:getAbsoluteY(), self:getAbsoluteWidth() * self.value, self:getAbsoluteHeight())
  love.graphics.setColor(unpack(default.ProgressBar.color.outline))
  love.graphics.rectangle("line", self:getAbsoluteX(), self:getAbsoluteY(), self:getAbsoluteWidth(), self:getAbsoluteHeight())
end

return default
