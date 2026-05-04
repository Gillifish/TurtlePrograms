local navi = require("navigation")
local scanner = require("scanner")
local facing = require("facing")

local target = arg[1]
local radius = arg[2]

facing.initList()
facing.initFacing("north")

local data = scanner.scan(target, radius)

if data == nil then
	print("[GN] No ores of that name found...")
	return
end


for _, block in ipairs(data) do
	local trans = navi.getTransform()
	block.x = block.x - trans.x
	block.y = block.y - trans.y
	block.z = block.z - trans.z

	navi.directMine(block)
end