-- Includes
local facing = require("facing")

-- Init facing module
facing.initList()
facing.initFacing("north")

-- Command line args
local x = tonumber(arg[1])
local y = tonumber(arg[2])
local z = tonumber(arg[3])

-- Check for command line args; gives usage if error
if x == nil or y == nil or z == nil then
	term.setCursorPos(1, 1)
	term.clear()
	print("Usage: quarryV3 <x> <y> <z>")
end

-- Mines forward a given distance
local function mineForward(distance)
	for i = 1, distance do
		turtle.dig()
		turtle.forward()
	end
end

-- Moves turtle to be ready to mine the next line
local function reposition()
	if facing.getCurrentFacing() == "north" then
		turtle.turnRight()
		turtle.dig()
		turtle.forward()
		turtle.turnRight()
		facing.setFacing("south")
		return
	elseif facing.getCurrentFacing() == "south" then
		turtle.turnLeft()
		turtle.dig()
		turtle.forward()
		turtle.turnLeft()
		facing.setFacing("north")
		return
	end
end

-- Moves turtle to the starting mining position
local function home()
	if z % 2 == 0 then
		facing.setFacing("west")
		for i = 1, z do
			turtle.forward()
		end
	else
		facing.setFacing("south")
		for i = 1, x do
			turtle.forward()
		end

		facing.setFacing("west")
		for i = 1, z do
			turtle.forward()
		end
	end

	turtle.setFacing("north")
end

-- Mines a horizontal layer
local function mineLayer()
	for i = 1, z do
		mineForward(x)
		if i ~= z then
			reposition()
		end
	end

	home()
end

-- Main
local function quarryV3()
	-- Setup turtle
	turtle.dig()
	turtle.forward()

	-- Mining algorithm
	for i = 1, y, 1 do
		mineLayer()
		if i ~= y then
			turtle.digDown()
			turtle.down()
		end
	end

	-- Return to starting position
	for i = 1, y do
		turtle.up()
	end

	turtle.back()
end

quarryV3()