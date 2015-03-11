project = 'Silicone'
file = 'init.lua'
format = 'markdown'
not_luadoc = true
output = 'readme'
readme = 'readme.md'
examples = 'examples'
backtick_references = false

custom_see_handler('^(love%..*)$',function(name)
  local upat = "https://www.love2d.org/wiki/%s"
	local url = upat:format(name)
	return name, url
end)

custom_see_handler('^love:(.*)$',function(name)
  local upat = "https://www.love2d.org/wiki/%s"
	local url = upat:format(name)
	return name, url
end)
