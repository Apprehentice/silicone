---
-- The base object from which all Silicone element are derived.
-- @classmod Base

local class = require("middleclass")

local Base = class("silicone.Base")

---
-- Internal.
-- Internal methods
-- @section Interal

---
-- Initializes a Base element
-- @tparam table spec Menu specification
-- @tparam Root root Root element
function Base:initialize(spec, root)
  self.type = "Base"
  self.name = false
  self.x = 0
  self.y = 0
  self.xOffset = 0
  self.yOffset = 0
  self.width = 0
  self.height = 0
  self.widthOffset = 0
  self.heightOffset = 0
  self.origin = "top-left"
  self.anchor = "top-left"
  self.enabled = true
  self.skins = {}
  self.visible = true
  self.navigation = {
    up = nil,
    down = nil,
    left = nil,
    right = nil
  }
  self.children = {}

  self._root = root
  if spec then
    for k, v in pairs(spec) do
      if k ~= "children" and self[k] ~= nil then
        self[k] = v
        if k == "name" then
          self._root:_add_name(self)
        end
      end
    end

    if spec.children then
      for i, v in ipairs(spec.children) do
        self.children[i] = require("silicone.elements." .. v.type)(v, root)
        self.children[i]._parent = self
      end
    end
  end

  self._parent = false
  self._compiled_skin = {}

  self:addSkin(require("silicone.skins.default"))
end

---
-- Compiles an elements skin
function Base:_compile_skin()
  self._compiled_skin = {}

  local function merge(t1, t2)
    for k, v in pairs(t2) do
      if type(v) == "table" then
        t1[k] = (type(t1[k]) == "table" and t1[k]) or {}
        merge(t1[k], v)
      else
        t1[k] = v
      end
    end
  end

  for i, v in ipairs(self.skins) do
    merge(self._compiled_skin, v)
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
-- @see Root.find
function Base:find(key)
  return self._root:find(key)
end

---
-- Focus.
-- Methods related to element focus
-- @section Focus

---
-- Returns whether or not the current element can receive focus which,
-- by default, is determined by whether or not the element is visible
-- and enabled
-- @treturn bool Whether or not the element can receive focus
function Base:canFocus()
  return self.visible and self.enabled
end

---
-- Puts an element in focus
function Base:focus()
  self._root:pushFocus(self)
end

---
-- Returns whether or not an element has focus
-- @treturn bool Whether or not an element has focus
function Base:hasFocus()
  return self._root:peekFocus() == self or (self._parent and self._parent:hasFocus())
end

---
-- Children.
-- Methods for managing children

---
-- Adds a child to an element
-- @tparam Base child The element to add
-- @treturn Base The child that was added
function Base:addChild(child)
  assert(type(child) == "table", "bad argument #1 to 'addChild' (table expected, got " ..  type(child) .. ")")
  if not class.Object.isSubclassOf(child, Menu) then
    child = require("silicone.elements." .. child.type)(child)
  end

  table.insert(self.children, child)
  child._parent = self
  child:addSkin(self._compiled_skin)
  return child
end

---
-- Removes a child from an element
-- @tparam Base The child to remove
-- @treturn Base The child that was removed
function Base:removeChild(child)
  assert(type(child) == "table" and child["class"] and child["class"]["super"] and child.class.super == Menu, "bad argument #1 to 'addChild' (not a menu element)")
  for i, v in ipairs(self.children) do
    if v == child then
      self.children[i] = nil
      break
    end
  end
  return child
end

---
-- Removes an element from its parent. If the element is currently
-- in focus, it's also popped from the @{Root.popFocus|focus stack}.
function Base:remove()
  if self._root:peekFocus() == self then
    self._root:popFocus()
  end

  return self._parent:removeChild(self)
end

---
-- Getters/Setters.
-- Getters and setters for element properties
-- @section Getters/Setters

---
-- Returns an element's name
-- @treturn string|nil name
function Base:getName()
  return self.name
end

---
-- Sets an element's name
-- @raise error if name is taken
-- @param v name
function Base:setName(v)
  assert(Menu._index[v] == nil, "an element with the name '" .. tostring(v) .. "' already exists")
  Menu._index[self.name] = nil
  Menu._index[v] = self
  self.name = v
end

---
-- Returns an element's X position
-- @treturn number X position
function Base:getX()
  return self.x
end

---
-- Sets an element's X position.
-- Coordinates are relative to the size of the element's parent.
-- @tparam number v X position
function Base:setX(v)
  self.x = v
end

---
-- Returns an element's Y position
-- @treturn number Y position
function Base:getY()
  return self.y
end

---
-- Sets an element's Y position.
-- Coordinates are relative to the size of the element's parent.
-- @tparam number v Y position
function Base:setY(v)
  self.y = v
end

---
-- Returns an element's position
-- @treturn number X position
-- @treturn number Y position
function Base:getPosition()
  return self:getX(), self:getY()
end

---
-- Sets an element's position
-- @tparam number x X position
-- @tparam number y Y position
function Base:setPosition(x, y)
  self:setX(x)
  self:setY(y)
end

---
-- Returns an element's X offset
-- @treturn number X offset
function Base:getXOffset()
  return self.xOffset
end

---
-- Sets an element's X offset
-- @tparam number v X offset
function Base:setXOffset(v)
  self.xOffset = v
end

---
-- Returns an element's Y offset
-- @treturn number Y offset
function Base:getYOffset()
  return self.yOffset
end

---
-- Sets an element's Y offset
-- @tparam number v Y offset
function Base:setYOffset(v)
  self.yOffset = v
end

-- Returns an element's offset
-- @treturn number X offset
-- @treturn number Y offset
function Base:getOffsets()
  return self:getXOffset(), self:getYOffset()
end

---
-- Sets an element's offset
-- @tparam number x X offset
-- @tparam number y Y offset
function Base:setOffsets(x, y)
  self:setXOffset(x)
  self:setYOffset(y)
end

---
-- Returns an element's width
-- @treturn number width
function Base:getWidth()
  return self.width
end

---
-- Sets an element's width.
-- Size is relative to the size of the element's parent.
-- @tparam number v width
function Base:setWidth(v)
  self.width = v
end

---
-- Returns an element's height
-- @treturn number height
function Base:getHeight()
  return self.height
end

---
-- Sets an element's height.
-- Size is relative to the size of the element's parent.
-- @tparam number v height
function Base:setHeight(v)
  self.height = v
end

---
-- Returns an element's dimensions
-- @treturn number width
-- @treturn number height
function Base:getDimensions()
  return self:getWidth(), self:getHeight()
end

---
-- Sets an element's dimensions
-- @tparam number w width
-- @tparam number h height
function Base:setDimensions(w, h)
  self:setWidth(w)
  self:setHeight(h)
end

---
-- Returns an element's width offset
-- @treturn number width offset
function Base:getWidthOffset()
  return self.widthOffset
end

---
-- Sets an element's width offset
-- @tparam number w width offset
function Base:setWidthOffset(w)
  self.widthOffset = w
end

---
-- Returns an element's height offset
-- @treturn number height offset
function Base:getHeightOffset()
  return self.heightOffset
end

---
-- Sets an element's height offset
-- @tparam number h height offset
function Base:setHeightOffset(h)
  self.heightOffset = h
end

---
-- Returns an element's width/height offsets
-- @treturn number width offset
-- @treturn number height offset
function Base:getWHOffsets()
  return self:getWidthOffset(), self:getHeightOffset()
end

---
-- Sets an element's width/height offsets
-- @tparam number w width offset
-- @tparam number h height offset
function Base:setWHOffsets(w, h)
  self:setWidthOffset(w)
  self:setHeightOffset(h)
end

---
-- Gets an element's origin
-- @treturn string origin
function Base:getOrigin()
  return self.origin
end

---
-- Sets an element's origin.
-- The origin is the point on an element that it will be referenced from when
-- drawn.
--
-- Possible values are
-- * top-left
-- * top-center
-- * top-right
-- * left
-- * center
-- * right
-- * bottom-left
-- * bottom-center
-- * bottom-right
--
-- Default: ``"top-left"``
-- @tparam string v origin
function Base:setOrigin(v)
  self.origin = v
end

---
-- Gets an element's anchor
-- @treturn string anchor
function Base:getAnchor()
  return self.anchor
end

---
-- Sets an element's anchor.
-- The anchor is the point on an element's parent that its position will be
-- referenced from when drawn.
--
-- Possible values are
-- * top-left
-- * top-center
-- * top-right
-- * left
-- * center
-- * right
-- * bottom-left
-- * bottom-center
-- * bottom-right
--
-- Default: ``"top-left"``
-- @tparam string v anchor
function Base:setAnchor(v)
  self.anchor = v
end

---
-- Returns an element's parent
-- @treturn Base parent
function Base:getParent()
  return self._parent
end

---
-- Sets an element's parent.
-- When called, the element is removed from its current parent and added
-- to the new one.
-- @tparam Base v parent
function Base:setParent(v)
  assert(type(v) == "table" and v["class"] and v["class"]["super"] and v.class.super == Menu, "bad argument #1 to 'setParent' (not a menu element)")
  if self._parent then
    self._parent:removeChild(self)
  end
  v:addChild(self)
end

---
-- Returns whether or not an element is enabled.
-- @treturn bool enabled
function Base:isEnabled()
  return self.enabled
end

---
-- Sets whether or not an element is enabled
-- @tparam bool v enabled
function Base:setEnabled(v)
  self.enabled = v
  if not v and self._root:peekFocus() == self then
    self._root:popFocus()
  end
end

---
-- Enables an element
function Base:enable()
  self.enabled = true
end

---
-- Disables an element
function Base:disable()
  self.enabled = false
  if self._root:peekFocus() == self then
    self._root:popFocus()
  end
end

---
-- Returns the compiled skin of an element
-- @treturn table skin
function Base:getSkin()
  return self._compiled_skin
end

---
-- Adds a skin to an element.
-- Skins are flattened together from an internal list of skins.
-- @tparam table skin skin
function Base:addSkin(skin)
  table.insert(self.skins, skin)
  self:_compile_skin()

  for i, v in ipairs(self.children) do
    v:addSkin(skin)
  end
end

---
-- Returns whether or not an element is visible
-- @treturn bool visible
function Base:isVisible()
  return self.visible
end

---
-- Sets whether ot not an element is visible
-- @tparam bool v visible
function Base:setVisible(v)
  self.visible = v
  if not v and self._root:peekFocus() == self then
    self._root:popFocus()
  end
end

---
-- Shows an element
function Base:show()
  self.visible = true
end

---
-- Hides an element
function Base:hide()
  self.visible = false
  if self._root:peekFocus() == self then
    self._root:popFocus()
  end
end

---
-- Absolute Positioning.
-- Methods for finding the absolute position of an element
-- @section Absolute Positioning

---
-- Resolve a position based on an anchor.
-- Using an anchor identifier and a reference point, this method resolves
-- to an absolute position.
-- @tparam string anchor anchor
-- @tparam number refX reference X coordinate
-- @tparam number refY reference Y coordinate
-- @treturn number absolute X coordinate
-- @treturn number absolute Y coordinate
function Base:resolveAnchor(anchor, refX, refY)
  local anchors = {
    ["top-left"] = {0, 0},
    ["top-center"] = {refX/2, 0},
    ["top-right"] = {refX, 0},
    ["left"] = {0, refY/2},
    ["center"] = {refX/2, refY/2},
    ["right"] = {refX, refY/2},
    ["bottom-left"] = {0, refY},
    ["bottom-center"] = {refX/2, refY},
    ["bottom-right"] = {refX, refY},
  }

  return anchors[anchor][1], anchors[anchor][2]
end

---
-- Returns the absolute X coordinate of an element
-- @treturn number absolute X coordinate
function Base:getAbsoluteX()
  local origin = self:resolveAnchor(self.origin, self:getAbsoluteWidth(), self:getAbsoluteHeight())
  local anchor = self:resolveAnchor(self.anchor, self._parent:getAbsoluteWidth(), self._parent:getAbsoluteHeight())
  return self._parent:getAbsoluteX() + ((self._parent:getAbsoluteWidth() * self.x) + self.xOffset + anchor - origin)
end

---
-- Returns the absolute Y coordinate of an element
-- @treturn number absolute Y coordinate
function Base:getAbsoluteY()
  local origin = select(2, self:resolveAnchor(self.origin, self:getAbsoluteWidth(), self:getAbsoluteHeight()))
  local anchor = select(2, self:resolveAnchor(self.anchor, self._parent:getAbsoluteWidth(), self._parent:getAbsoluteHeight()))
  return self._parent:getAbsoluteY() + ((self._parent:getAbsoluteHeight() * self.y) + self.yOffset + anchor - origin)
end

---
-- Returns the absolute width of an element
-- @treturn number absolute width
function Base:getAbsoluteWidth()
  return self._parent:getAbsoluteWidth() * self.width + self.widthOffset
end

---
-- Returns the absolute height of an element
-- @treturn number absolute height
function Base:getAbsoluteHeight()
  return self._parent:getAbsoluteHeight() * self.height + self.heightOffset
end

---
-- LÖVE Callbacks.
-- LÖVE callback handlers for Silicone elements
-- @section LÖVE Callbacks

---
-- Generic LÖVE callback.
-- The Base element implements all of LÖVE's callbacks so elements may
-- make use of them. To use them, call them like you would a LÖVE callback.
-- @function Base:callback
-- @param ...
-- @usage
-- -- Calling update on a Silicone element
-- local base = Base()
-- function love.update(dt)
--   base:update(dt)
-- end

function Base:draw()
  if not self.visible then return end

  if self._compiled_skin[self.type] then
    self._compiled_skin[self.type]["draw"](self)
  end

  for i, v in ipairs(self.children) do
    v:draw()
  end
end

function Base:update(dt)
  for i, v in ipairs(self.children) do
    v:update(dt)
  end
end

function Base:gamepadaxis(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:gamepadaxis(a, b, c, d, e)
  end
end

function Base:gamepadpressed(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:gamepadpressed(a, b, c, d, e)
  end
end

function Base:gamepadreleased(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:gamepadreleased(a, b, c, d, e)
  end
end

function Base:joystickadded(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickadded(a, b, c, d, e)
  end
end

function Base:joystickaxis(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickaxis(a, b, c, d, e)
  end
end

function Base:joystickhat(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickhat(a, b, c, d, e)
  end
end

function Base:joystickpressed(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickpressed(a, b, c, d, e)
  end
end

function Base:joystickreleased(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickreleased(a, b, c, d, e)
  end
end

function Base:joystickremoved(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickremoved(a, b, c, d, e)
  end
end

function Base:keypressed(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:keypressed(a, b, c, d, e)
  end
end

function Base:keyreleased(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:keyreleased(a, b, c, d, e)
  end
end

function Base:mousefocus(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:mousefocus(a, b, c, d, e)
  end
end

function Base:mousepressed(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:mousepressed(a, b, c, d, e)
  end
end

function Base:mousereleased(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:mousereleased(a, b, c, d, e)
  end
end

function Base:resize()
  for i, v in ipairs(self.children) do
    v:resize()
  end
end

function Base:textinput(text)
  for i, v in ipairs(self.children) do
    v:textinput(text)
  end
end

---
-- Silicone Callbacks.
-- Callbacks for menu functions
-- @section Silicone Callbacks

local function nav(self, dir)
  if self.navigation[dir] then
    local context = self._root:find(self.navigation[dir])
    while context and not context:canFocus() do
      context = self._root:find(context.navigation[dir])
    end

    if context then
      self._root:pushFocus(context)
    end
  end
end

---
-- Callback for leftward navigation
function Base:onLeft()
  nav(self, "left")
end

---
-- Callback for rightward navigation
function Base:onRight()
  nav(self, "right")
end

---
-- Callback for upward navigation
function Base:onUp()
  nav(self, "up")
end

---
-- Callback for downward navigation
function Base:onDown()
  nav(self, "down")
end

---
-- Callback for the "confirm" action
function Base:onConfirm()
  if self._parent then
    self._parent:onConfirm()
  end
end

---
-- Callback for the "cancel" action
function Base:onCancel()
  if self._parent then
    self._parent:onCancel()
  end
end

return Base
