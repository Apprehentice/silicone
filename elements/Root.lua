local class = require("middleclass")
local Base = require("silicone.elements.Base")

local Root = class("silicone.Root", Base)
function Root:initialize(spec)
  self._index = setmetatable({}, { __mode = "v" })
  self._focus_stack = setmetatable({}, { __mode = "v" })

  Base.initialize(self, spec, self)

  self.type = "Root"
  self.width = love.graphics.getWidth()
  self.height = love.graphics.getHeight()
end

function Root:_add_name(element)
  self._index[element.name] = element
end

-- Elements of weak tables are prone to being collected by the garbage collector
-- Therefore, the focus stack may need to be restacked from time to time.
function Root:_restack_focus()
  for i = 1, #self._focus_stack do
    if self._focus_stack[i] == nil then
      self._focus_stack[i] = self._focus_stack[i + 1]
      self._focus_stack[i + 1] = nil
    end
  end
end

function Root:pushFocus(element, norestack)
  assert(type(element) == "table" and element["class"] and element["class"]["super"] and element.class.super == Base, "bad argument #1 to 'pushFocus' (not a menu element)")
  if not norestack then self:_restack_focus() end

  if self._focus_stack[2] == element then
    self:popFocus(true)
  end

  table.insert(self._focus_stack, 1, element)
end

function Root:popFocus(norestack)
  if not norestack then self:_restack_focus() end
  return table.remove(self._focus_stack, 1)
end

function Root:peekFocus(norestack)
  if not norestack then self:_restack_focus() end
  return self._focus_stack[1]
end

function Root:find(key)
  return self._index[key]
end

function Root:update(dt)
  Base.update(self, dt)
  self.width = love.graphics.getWidth()
  self.height = love.graphics.getHeight()
end

function Root:focus()
  for i, v in ipairs(self.children) do
    if v:canFocus() then
      v:focus()
    end
  end
end

function Root:doLeft()
  if self:peekFocus() then
    self:peekFocus():onLeft()
  end
end

function Root:doRight()
  if self:peekFocus() then
    self:peekFocus():onRight()
  end
end

function Root:doUp()
  if self:peekFocus() then
    self:peekFocus():onUp()
  end
end

function Root:doDown()
  if self:peekFocus() then
    self:peekFocus():onDown()
  end
end

function Root:doConfirm()
  if self:peekFocus() then
    self:peekFocus():onConfirm()
  end
end

function Root:doCancel()
  if self:peekFocus() then
    self:peekFocus():onCancel()
  end
end

function Root:onFocus()
  self.children[1]:focus()
end

function Root:onLeft()
end

function Root:onRight()
end

function Root:onUp()
end

function Root:onDown()
end

function Root:onConfirm()
end

function Root:onCancel()
end

function Root:getAbsoluteWidth()
  return self.width
end

function Root:getAbsoluteHeight()
  return self.height
end

function Root:getAbsoluteX()
  return self.x
end

function Root:getAbsoluteY()
  return self.y
end

return Root
