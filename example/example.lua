Citizen.CreateThread(function()
	local x = {}
	local y = {}
	local z = {}
	for i = 1,1000 do
		y[i] = math.sin(i*0.1)*(1/i)
		z[i] = math.cos(i*0.1)/(1/i)
		x[i] = i*0.05
	end

	while true do
		Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		if IsControlJustReleased(1, 51) then
			Plot.Create('sin')
			Plot.Graph('sin', x, y)
			Plot.Coords('sin', coords["x"], coords["y"], coords["z"])
			Plot.Show('sin')

			Plot.Create('cos')
			Plot.Graph('cos', x, z)
			Plot.Coords('cos', coords["x"], coords["y"], coords["z"])
			Plot.Show('cos')
		end
	end
end)