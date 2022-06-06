local createproplocation = false
RegisterCommand('ptpeditor', function(source, args, rawCommand)
	createproplocation = not createproplocation
	local bone, model = tonumber(args[1]), GetHashKey(args[2])
	if bone and IsModelValid(model) then
		if createproplocation then
			StartPropCreation(bone, model)
		end
	else
		Notification(Config.ErrorModelText)
	end
end)
Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/ptpeditor', 'prop to player editor', {
		{ name="bone ID", help="Enter the bone ID you would like to attach the prop to. " },
		{ name="model", help="The model you would like to attach to the player." }
	})
end)

function StartPropCreation(boneindex, prop)
	if not HasModelLoaded(prop) then
		RequestModel(prop)
	
		while not HasModelLoaded(prop) do
			Citizen.Wait(1)
		end
	end
	local Player = PlayerPedId()
	local boneid = GetPedBoneIndex(Player, boneindex)
	local x2,y2,z2 = table.unpack(GetEntityCoords(Player))
	local object = CreateObject(prop, x2, y2, z2+0.2,  true,  true, true)
	local x, y, z, rx, ry, rz, increment = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.01
	AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
	Citizen.CreateThread(function()
		while createproplocation do
			for k, v in pairs(Config.Controls) do
				DisableControlAction(0, v.control)
			end

			if IsDisabledControlPressed(0, Config.Controls.RaiseZ.control) then
				z = round(z+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Config.Controls.LowerZ.control) then 
				z = round(z-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Config.Controls.RaiseX.control) then 
				x = round(x+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Config.Controls.LowerX.control) then 
				x = round(x-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Config.Controls.RaiseY.control) then 
				y = round(y+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Config.Controls.LowerY.control) then 
				y = round(y-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Config.Controls.RaiseRX.control) then 
				rx = round(rx+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)		
			elseif IsDisabledControlPressed(0, Config.Controls.LowerRX.control) then 
				rx = round(rx-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Config.Controls.RaiseRY.control) then 
				ry = round(ry+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)		
			elseif IsDisabledControlPressed(0, Config.Controls.LowerRY.control) then 
				ry = round(ry-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Config.Controls.RaiseRZ.control) then 
				rz = round(rz+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)		
			elseif IsDisabledControlPressed(0, Config.Controls.LowerRZ.control) then 
				rz = round(rz-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlJustReleased(0, Config.Controls.Increment.control) then
				increment = round(increment+0.01, 2)
			elseif IsDisabledControlJustReleased(0, Config.Controls.Decrement.control) then
				increment = round(increment-0.01, 2)
			elseif IsDisabledControlJustReleased(0, Config.Controls.Cancel.control) then
				createproplocation = false
			end
			
			drawTxt(0.69, 1.45, 1.0,1.0,0.64 , "X: "..x..' Y: '..y..' Z: '..z..'        RX: '..rx..' RY: '..ry..' RZ: '..rz..'        Increment: '..increment, 255, 255, 255, 255)
			HelpText(Config.HelpText)
			Wait(0)
		end
		SetModelAsNoLongerNeeded(prop)
		DeleteObject(object)
	end)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function HelpText(text)
	AddTextEntry('PGPROPTOPED', text)
    BeginTextCommandDisplayHelp('PGPROPTOPED')
    EndTextCommandDisplayHelp(0, 0, false, -1)
end

function Notification(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(0,1)
end

function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end