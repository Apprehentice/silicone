local class = require("middleclass")

-- Menu object
local Menu = class("silicone.Base")

function Menu:initialize(spec, root)
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

function Menu:find(key)
  if self._parent then
    print("Passing find along...")
    return self._parent:find(key)
  end
end

function Menu:canFocus()
  return self.visible and self.enabled
end

function Menu:focus()
  self._root:pushFocus(self)
end

function Menu:hasFocus()
  return self._root:peekFocus() == self or (self._parent and self._parent:hasFocus())
end

function Menu:_compile_skin()
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

-- Getters/Setters

function Menu:addChild(child)
  assert(type(child) == "table", "bad argument #1 to 'addChild' (table expected, got " ..  type(child) .. ")")
  if not class.Object.isSubclassOf(child, Menu) then
    child = require("silicone.elements." .. child.type)(child)
  end

  table.insert(self.children, child)
  child._parent = self
  child:addSkin(self._compiled_skin)
  return child
end

function Menu:removeChild(child)
  assert(type(child) == "table" and child["class"] and child["class"]["super"] and child.class.super == Menu, "bad argument #1 to 'addChild' (not a menu element)")
  for i, v in ipairs(self.children) do
    if v == child then
      self.children[i] = nil
      break
    end
  end
  return child
end

function Menu:remove()
  if self:peekFocus() == self then
    self:popFocus()
  end

  self._parent:removeChild(self)
end

function Menu:getName()
  return self.name
end

function Menu:setName(v)
  assert(Menu._index[v] == nil, "an element with the name '" .. tostring(v) .. "' already exists")
  Menu._index[self.name] = nil
  Menu._index[v] = self
  self.name = v
end

function Menu:getX()
  return self.x
end

function Menu:setX(v)
  self.x = v
end

function Menu:getY()
  return self.y
end

function Menu:setY(v)
  self.y = v
end

function Menu:getPosition()
  return self.x, self.y
end

function Menu:setPosition(x, y)
  self.x = x
  self.y = y
end

function Menu:getXOffset()
  return self.xOffset
end

function Menu:setXOffset(v)
  self.xOffset = v
end

function Menu:getYOffset()
  return self.yOffset
end

function Menu:setYOffset(v)
  self.yOffset = v
end

function Menu:getOffsets()
  return self.xOffset, self.yOffset
end

function Menu:setOffsets(x, y)
  self.xOffset = x
  self.yOffset = y
end

function Menu:getWidth()
  return self.width
end

function Menu:setWidth(v)
  self.width = v
end

function Menu:getHeight()
  return self.height
end

function Menu:setHeight(v)
  self.height = v
end

function Menu:setDimensions(w, h)
  self.width = w
  self.height = h
end

function Menu:getWidthOffset()
  return self.widthOffset
end

function Menu:getHeightOffset()
  return self.heightOffset
end

function Menu:setWidthOffset(w)
  self.widthOffset = w
end

function Menu:setHeightOffset(h)
  self.heightOffset = h
end

function Menu:getPadding()
  return self.widthOffset, self.heightOffset
end

function Menu:setPadding(w, h)
  self.widthOffset = w
  self.heightOffset = h
end

function Menu:getOrigin()
  return self.origin
end

function Menu:setOrigin(v)
  self.origin = v
end

function Menu:getAttachment()
  return self.attachment
end

function Menu:setAttachment(v)
  self.attachment = v
end

function Menu:getAnchor()
  return self.anchor
end

function Menu:setAnchor(v)
  self.anchor = v
end

function Menu:getParent()
  return self._parent
end

function Menu:setParent(v)
  assert(type(v) == "table" and v["class"] and v["class"]["super"] and v.class.super == Menu, "bad argument #1 to 'setParent' (not a menu element)")
  if self._parent then
    self._parent:removeChild(self)
  end
  v:addChild(self)
end

function Menu:getEnabled()
  return self.enabled
end

function Menu:setEnabled(v)
  self.enabled = v
end

function Menu:enable()
  self.enabled = true
end

function Menu:disable()
  self.enabled = false
end

function Menu:getSkin()
  return self._compiled_skin
end

function Menu:addSkin(skin)
  table.insert(self.skins, skin)
  self:_compile_skin()

  for i, v in ipairs(self.children) do
    v:addSkin(skin)
  end
end

function Menu:getVisible()
  return self.visible
end

function Menu:setVisible(v)
  self.visible = v
end

function Menu:show()
  self.visible = true
end

function Menu:hide()
  self.visible = false
end

-- Helper functions

function Menu:resolveAnchor(anchor, refX, refY)
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

function Menu:getAbsoluteX()
  local origin = self:resolveAnchor(self.origin, self:getAbsoluteWidth(), self:getAbsoluteHeight())
  local anchor = self:resolveAnchor(self.anchor, self._parent:getAbsoluteWidth(), self._parent:getAbsoluteHeight())
  return self._parent:getAbsoluteX() + ((self._parent:getAbsoluteWidth() * self.x) + self.xOffset + anchor - origin)
end

function Menu:getAbsoluteY()
  local origin = select(2, self:resolveAnchor(self.origin, self:getAbsoluteWidth(), self:getAbsoluteHeight()))
  local anchor = select(2, self:resolveAnchor(self.anchor, self._parent:getAbsoluteWidth(), self._parent:getAbsoluteHeight()))
  return self._parent:getAbsoluteY() + ((self._parent:getAbsoluteHeight() * self.y) + self.yOffset + anchor - origin)
end

function Menu:getAbsoluteWidth()
  return self._parent:getAbsoluteWidth() * self.width + self.widthOffset
end

function Menu:getAbsoluteHeight()
  return self._parent:getAbsoluteHeight() * self.height + self.heightOffset
end

--Love callbacks

function Menu:draw()
  if not self.visible then return end

  if self._compiled_skin[self.type] then
    self._compiled_skin[self.type]["draw"](self)
  end

  for i, v in ipairs(self.children) do
    v:draw()
  end
end

function Menu:update(dt)
  for i, v in ipairs(self.children) do
    v:update(dt)
  end
end

function Menu:gamepadaxis(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:gamepadaxis(a, b, c, d, e)
  end
end

function Menu:gamepadpressed(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:gamepadpressed(a, b, c, d, e)
  end
end

function Menu:gamepadreleased(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:gamepadreleased(a, b, c, d, e)
  end
end

function Menu:joystickadded(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickadded(a, b, c, d, e)
  end
end

function Menu:joystickaxis(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickaxis(a, b, c, d, e)
  end
end

function Menu:joystickhat(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickhat(a, b, c, d, e)
  end
end

function Menu:joystickpressed(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickpressed(a, b, c, d, e)
  end
end

function Menu:joystickreleased(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickreleased(a, b, c, d, e)
  end
end

function Menu:joystickremoved(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:joystickremoved(a, b, c, d, e)
  end
end

function Menu:keypressed(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:keypressed(a, b, c, d, e)
  end
end

function Menu:keyreleased(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:keyreleased(a, b, c, d, e)
  end
end

function Menu:mousefocus(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:mousefocus(a, b, c, d, e)
  end
end

function Menu:mousepressed(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:mousepressed(a, b, c, d, e)
  end
end

function Menu:mousereleased(a, b, c, d, e)
  for i, v in ipairs(self.children) do
    v:mousereleased(a, b, c, d, e)
  end
end

function Menu:resize()
  for i, v in ipairs(self.children) do
    v:resize()
  end
end

function Menu:textinput(text)
  for i, v in ipairs(self.children) do
    v:textinput(text)
  end
end

-- Menu callbacks

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

function Menu:onLeft()
  nav(self, "left")
end

function Menu:onRight()
  nav(self, "right")
end

function Menu:onUp()
  nav(self, "up")
end

function Menu:onDown()
  nav(self, "down")
end

function Menu:onConfirm()
  if self._parent then
    self._parent:onConfirm()
  end
end

function Menu:onCancel()
  if self._parent then
    self._parent:onCancel()
  end
end

return Menu
