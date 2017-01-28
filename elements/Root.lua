---
-- The root level element of all Silicone menu structures.
-- The Root element is the foundation for any Silicone menu hierarchy as it
-- handles all of Silicone's callbacks and fires them for its children.
--
-- Not all available methods are listed here. For more information, see
-- @{Base}.
-- @classmod Root

local class = require("middleclass")
local Base = require("silicone.elements.Base")

local Root = class("silicone.Root", Base)

---
-- Internal.
-- Internal methods
-- @section Internal

---
-- Initializes a Root element
-- @tparam table spec Menu specification
function Root:initialize(spec)
  self._index = setmetatable({}, { __mode = "v" })
  self._focus_stack = setmetatable({}, { __mode = "v" })

  Base.initialize(self, spec, self)

  self.type = "Root"
  self.width = love.graphics.getWidth()
  self.height = love.graphics.getHeight()
end

---
-- Adds a named element to the Root's name index
-- @tparam Base element Menu element
function Root:_add_name(element)
  assert(type(element) == "table" and element["class"] and element["class"]["super"] and element.class.super == Base, "bad argument #1 to '_add_name' (not a menu element)")
  if element.name then
    self._index[element.name] = element
  end
end

-- Elements of weak tables are prone to being collected by the garbage collector
-- Therefore, the focus stack may need to be restacked from time to time.

---
-- Reorders the focus stack so that it can be indexed.
--
-- This must be done regularly as elements in the focus stack may be
-- removed by the garbage collector.
function Root:_restack_focus()
  for i = 1, #self._focus_stack do
    if self._focus_stack[i] == nil then
      self._focus_stack[i] = self._focus_stack[i + 1]
      self._focus_stack[i + 1] = nil
    end
  end
end

---
-- Focus Stack.
-- Methods for manipulating the focus stack
-- @section Focus Stack

---
-- Pushes an element onto the focus stack and puts it in focus
-- @tparam Base element The element to push
-- @tparam bool norestack Suppress restacking the focus stack
function Root:pushFocus(element, norestack)
  assert(type(element) == "table" and element["class"] and element["class"]["super"] and element.class.super == Base, "bad argument #1 to 'pushFocus' (not a menu element)")
  if not norestack then self:_restack_focus() end
  local oldFocus = self._focus_stack[1]

  if self._focus_stack[2] == element then
    self:popFocus(true)
  else
    table.insert(self._focus_stack, 1, element)
  end

  if oldFocus then oldFocus:onLoseFocus() end
end

---
-- Pops the first element from the focus stack
-- @tparam bool norestack Suppress restacking the focus stack
-- @treturn Base The popped element
function Root:popFocus(norestack)
  if not norestack then self:_restack_focus() end
  local oldFocus = table.remove(self._focus_stack, 1)
  if oldFocus then oldFocus:onLoseFocus() end
  return oldFocus
end

---
-- Returns the first element on the focus stack
-- @tparam bool norestack Suppress restacking the focus stack
-- @treturn Base The element
function Root:peekFocus(norestack)
  if not norestack then self:_restack_focus() end
  return self._focus_stack[1]
end

---
-- Sets focus to the first available element in the focus stack
function Root:focus()
  for i, v in ipairs(self.children) do
    if v:canFocus() then
      v:focus()
      break
    end
  end
end

---
-- Querying.
-- Methods for finding other elements
-- @section Querying

---
-- Finds an element with the given name.
-- @tparam string key The name of the element
-- @treturn Base|nil The element
function Root:find(key)
  return self._index[key]
end

---
-- Events.
-- Methods for firing events when it's time for the menu to do something
-- @section Events

---
-- Updates all of a Root's children and resizes it to fit the screen.
-- @tparam number dt Time since the last update in seconds
-- @see love.update
function Root:update(dt)
  Base.update(self, dt)
  self.width = love.graphics.getWidth()
  self.height = love.graphics.getHeight()
end

---
-- Calls ``onLeft`` for the currently focused element
function Root:doLeft()
  if self:peekFocus() then
    self:peekFocus():onLeft()
  end
end

---
-- Calls ``onRight`` for the currently focused element
function Root:doRight()
  if self:peekFocus() then
    self:peekFocus():onRight()
  end
end

---
-- Calls ``onUp`` for the currently focused element
function Root:doUp()
  if self:peekFocus() then
    self:peekFocus():onUp()
  end
end

---
-- Calls ``onDown`` for the currently focused element
function Root:doDown()
  if self:peekFocus() then
    self:peekFocus():onDown()
  end
end

---
-- Calls ``onConfirm`` for the currently focused element
function Root:doConfirm()
  if self:peekFocus() then
    self:peekFocus():onConfirm()
  end
end

---
-- Calls ``onCancel`` for the currently focused element
function Root:doCancel()
  if self:peekFocus() then
    self:peekFocus():onCancel()
  end
end

---
-- Callbacks.
-- Callbacks do absolutely nothing on Root elements.
-- @section Callbacks

---
-- Does nothing
function Root:onFocus()
end

---
-- Does nothing
function Root:onLoseFocus()
end

---
-- Does nothing
function Root:onMouseMove()
end

---
-- Does nothing
function Root:onMouseDown()
end

---
-- Does nothing
function Root:onMouseUp()
end

---
-- Does nothing
function Root:onLeft()
end

---
-- Does nothing
function Root:onRight()
end

---
-- Does nothing
function Root:onUp()
end

---
-- Does nothing
function Root:onDown()
end

---
-- Does nothing
function Root:onConfirm()
end

---
-- Does nothing
function Root:onCancel()
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Returns a Root element's width (the screen width)
-- @treturn number The Root element's width
function Root:getAbsoluteWidth()
  return self.width
end

---
-- Returns a Root element's height (the screen height)
-- @treturn number The Root element's height
function Root:getAbsoluteHeight()
  return self.height
end

---
-- Returns a Root element's X coordinate (usually 0)
-- @treturn number The Root element's X coordinate
function Root:getAbsoluteX()
  return self.x
end

---
-- Returns a Root element's Y coordinate (usually 0)
-- @treturn number The Root element's Y coordinate
function Root:getAbsoluteY()
  return self.y
end

return Root
