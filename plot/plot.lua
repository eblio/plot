Plots = {
	--['id'] = {x, y, z, tableX, tableY, color, prop, }
}

-----------------------------------
-- Fonctions de calcul
-----------------------------------

local function Max(table)
	local max = -100000000000
	for i = 1, #table do
		if table[i] > max then
			max = table[i]
		end
	end
	return max
end

local function Min(table)
	local min = 100000000000
	for i = 1, #table do
		if table[i] < min then
			min = table[i]
		end
	end
	return min
end

local function CalculateProp(id)
	Plots[id].prop = {x = Plots[id].size.x/Max(Plots[id].graph.x), y = Plots[id].size.y/Max(Plots[id].graph.y)}
end

local function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.40*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

local function SendNotification(txt)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(txt)
	DrawNotification(true, true)
end

-----------------------------------
-- Commandes
-----------------------------------

RegisterCommand('plot', function(source, args)
    if args[1] == 'size' then
    	if #args == 4 and tonumber(args[3]) ~= nil and tonumber(args[4]) ~= nil then
    		Plot.Size(args[2], tonumber(args[3]), tonumber(args[4]))
    	else
    		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot size [ID] [x] [y].")
    	end
    elseif args[1] == 'coords' then
    	if #args == 5 and tonumber(args[3]) ~= nil and tonumber(args[4]) and tonumber(args[5]) then
    		local coords = GetEntityCoords(PlayerPedId())
    		Plot.Coords(args[2], coords["x"]+tonumber(args[3]), coords["y"]+tonumber(args[4]), coords["z"]+tonumber(args[5]))
    	else
    		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot coords [ID] [x] [y] [z] (must be numbers, relative to your position).")
    	end
    elseif args[1] == 'color' then
    	if #args == 6 and tonumber(args[3]) ~= nil and tonumber(args[4]) and tonumber(args[5]) and tonumber(args[6]) then
    		Plot.Color(args[2], tonumber(args[3]), tonumber(args[4]), tonumber(args[5]), tonumber(args[6]))
    	else
    		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot color [ID] [r] [g] [b] [a].")
    	end
    elseif args[1] == 'nbraxis' then
    	if #args == 3 and tonumber(args[3]) ~= nil then
    		Plot.NbrAxis(args[2], tonumber(args[3]))
    	else
    		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot nbraxis [ID] [nbr].")
    	end
    elseif args[1] == 'create' then
    	if #args == 2 then
    		Plot.Create(args[2])
    	else
    		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot create [ID].")
    	end
    elseif args[1] == 'graph' then

    	local x = {}
    	local y = {}
    	local passed = false
    	local finished = false

    	for i = 3,#args do
    		if tonumber(args[i]) ~= nil then
    			if not passed then
    				table.insert(x, tonumber(args[i]))
    			else
    				table.insert(y, tonumber(args[i]))
    			end
    		elseif args[i] == 'and' then
    			passed = true
    		elseif args[i] == 'end' then
    			Plot.Graph(args[2], x, y)
    			finished = true
    		else
    			SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot graph [ID] [x's] and [y's] end.")
    			break
    		end
    	end
    	if not passed or not finished then
    		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot graph [ID] [x's] and [y's] end.")
    	end
    elseif args[1] == 'show' then
    	if #args == 2 then
    		Plot.Show(args[2])
    	else
    		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot show [ID].")
    	end
    elseif args[1] == 'remove' then
    	if #args == 2 then
    		Plot.Remove(args[2])
    	else
    		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot remove [ID].")
    	end
    elseif args[1] == 'destroy' then
    	if #args == 2 then
    		Plot.Destroy(args[2])
    	else
    		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid arguments. Usage : /plot destroy [ID].")
    	end
    else
    	SendNotification("~r~~h~Plot Error : ~h~~w~Invalid command. Check the documentation for more informations.")
    end
end)

-----------------------------------
-- Fonctions utilisateur
-----------------------------------

Plot = {}

function Plot.Create(id)
	Plots[id] = {coords = {x = 0, y = 0, z = 0}, graph = {x = {1,1}, y = {1,1}}, color = {r = 60, g = 120, b = 250, a = 150}, prop = {x = 0, y = 0}, size = {x = 10, y = 2}, nbrOfAxis = 10, show = false}
	SendNotification("~y~~h~Success : ~h~~w~Plot created.")
end

function Plot.Coords(id, _x, _y, _z)
	if Plots[id] ~= nil then
		Plots[id].coords = {x = _x, y = _y, z = _z}
		SendNotification("~y~~h~Success : ~h~~w~Plot moved.")
	else
		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid plot ID (Coords).")
	end
end

function Plot.Graph(id, _x, _y)
	if #_x == #_y then
		if Plots[id] ~= nil then
			Plots[id].graph = {x = _x, y = _y}
			SendNotification("~y~~h~Success : ~h~~w~Plot changed.")
		else
			SendNotification("~r~~h~Plot Error : ~h~~w~Invalid plot ID (Graph).")
		end
	else
		SendNotification("~r~~h~Plot Error : ~h~~w~x and y must have the same dimensions [x = "..#_x..", y = "..#_y.."] (Graph).")
	end
end

function Plot.Color(id, _r, _g, _b, _a)
	if Plots[id] ~= nil then
		Plots[id].color = {r = _r, g = _g, b = _b, a = _a}
		SendNotification("~y~~h~Success : ~h~~w~Plot changed.")
	else
		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid plot ID (Color).")
	end
end

function Plot.Size(id, _x, _y)
	if Plots[id] ~= nil then
		Plots[id].size = {x = _x, y = _y}
		CalculateProp(id)
		SendNotification("~y~~h~Success : ~h~~w~Plot changed.")
	else
		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid plot ID (Size).")
	end
end

function Plot.NbrAxis(id, _nbrOfAxis)
	if Plots[id] ~= nil then
		Plots[id].nbrOfAxis = _nbrOfAxis
		SendNotification("~y~~h~Success : ~h~~w~Plot changed.")
	else
		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid plot ID (NbrAxis).")
	end
end

function Plot.Show(id)
	if Plots[id] ~= nil then
		CalculateProp(id)
		if not Plots[id].show then
			Plots[id].show = true
			Citizen.CreateThread(function()
				while Plots[id].show and Plots[id] ~= nil do
					Wait(10)
					for i = 1, #Plots[id].graph.y-1 do
						DrawLine(
									Plots[id].coords.x + Plots[id].graph.x[i]*Plots[id].prop.x, Plots[id].coords.y, Plots[id].coords.z + Plots[id].graph.y[i]*Plots[id].prop.y, 
									Plots[id].coords.x + Plots[id].graph.x[i+1]*Plots[id].prop.x, Plots[id].coords.y, Plots[id].coords.z + Plots[id].graph.y[i+1]*Plots[id].prop.y,  
									Plots[id].color.r, Plots[id].color.g, Plots[id].color.b, Plots[id].color.a
								)

						if i % (math.floor(#Plots[id].graph.y/Plots[id].nbrOfAxis)+1) == 0 then
							DrawText3D(Plots[id].coords.x + Plots[id].graph.x[i]*Plots[id].prop.x, Plots[id].coords.y, Plots[id].coords.z, string.format("%g", Plots[id].graph.x[i]))
							DrawText3D(Plots[id].coords.x, Plots[id].coords.y, Plots[id].coords.z + Plots[id].graph.y[i]*Plots[id].prop.y, string.format("%g", Plots[id].graph.y[i]))
						end
					end
					DrawLine(Plots[id].coords.x, Plots[id].coords.y, Plots[id].coords.z + Min({Min(Plots[id].graph.y)*Plots[id].prop.y,0}), Plots[id].coords.x, Plots[id].coords.y, Plots[id].coords.z + Max(Plots[id].graph.y)*Plots[id].prop.y, 0, 0, 0, 255)
					DrawLine(Plots[id].coords.x + Min({Min(Plots[id].graph.x)*Plots[id].prop.x,0}), Plots[id].coords.y, Plots[id].coords.z, Plots[id].coords.x + Max(Plots[id].graph.x)*Plots[id].prop.x, Plots[id].coords.y, Plots[id].coords.z, 0, 0, 0, 255)
				end
			end)
		else
			SendNotification("~r~~h~Plot Error : ~h~~w~You tried to show an already showing plot.")
		end
	else
		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid plot ID (Show).")
	end
end

function Plot.Remove(id)
	if Plots[id] ~= nil then
		Plots[id].show = false
		SendNotification("~y~~h~Success : ~h~~w~Plot removed.")
	else
		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid plot ID (Remove).")
	end
end

function Plot.Destroy(id)
	if Plots[id] ~= nil then
		Plot.Remove(id)
		Plots[id] = nil
		SendNotification("~y~~h~Success : ~h~~w~Plot destroyed.")
	else
		SendNotification("~r~~h~Plot Error : ~h~~w~Invalid plot ID (Destroy).")
	end
end