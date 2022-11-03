local createPropLocation = false

local function drawText(x, y, width, height, scale, text, r, g, b, a)
	SetTextFont(4)
	SetTextProportional(false)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow()
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width / 2, y - height / 2 + 0.005)
end

local function helpText(text)
	AddTextEntry('PGPROPTOPED', text)
	BeginTextCommandDisplayHelp('PGPROPTOPED')
	EndTextCommandDisplayHelp(0, false, false, -1)
end

local function notification(text)
	BeginTextCommandThefeedPost('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(false, true)
end

local function round(num, numDecimalPlaces)
	return tonumber(string.format('%.' .. (numDecimalPlaces or 0) .. 'f', num))
end

local function startPropCreation(boneIndex, prop)
	if not HasModelLoaded(prop) then
		RequestModel(prop)

		while not HasModelLoaded(prop) do
			Wait(10)
		end
	end
	local playerPed = PlayerPedId()
	local boneId = GetPedBoneIndex(playerPed, boneIndex)
	local coords = GetEntityCoords(playerPed)
	local object = CreateObject(prop, coords.x, coords.y, coords.z + 0.2,  true,  true, true)
	local x, y, z, rx, ry, rz, increment = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.01
	AttachEntityToEntity(object, playerPed, boneId, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
	CreateThread(function()
		while createPropLocation do
			for _, v in pairs(Config.Controls) do
				DisableControlAction(0, v.control, true)
			end

			if IsDisabledControlPressed(0, Config.Controls.RaiseZ.control) then
				z = round(z + increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.LowerZ.control) then
				z = round(z - increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.RaiseX.control) then
				x = round(x + increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.LowerX.control) then
				x = round(x - increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.RaiseY.control) then
				y = round(y + increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.LowerY.control) then
				y = round(y - increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.RaiseRX.control) then
				rx = round(rx + increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.LowerRX.control) then
				rx = round(rx - increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.RaiseRY.control) then
				ry = round(ry + increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.LowerRY.control) then
				ry = round(ry - increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.RaiseRZ.control) then
				rz = round(rz + increment, 2)
			end

			if IsDisabledControlPressed(0, Config.Controls.LowerRZ.control) then
				rz = round(rz - increment, 2)
			end

			if IsDisabledControlJustReleased(0, Config.Controls.Increment.control) then
				increment = round(increment + 0.01, 2)
			end

			if IsDisabledControlJustReleased(0, Config.Controls.Decrement.control) then
				increment = round(increment - 0.01, 2)
			end

			if IsDisabledControlJustReleased(0, Config.Controls.Cancel.control) then
				createPropLocation = false
			end

			DetachEntity(object, false, false)
			AttachEntityToEntity(object, playerPed, boneId, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			drawText(0.69, 1.45, 1.0,1.0,0.64 , "X: "..x..' Y: '..y..' Z: '..z..'        RX: '..rx..' RY: '..ry..' RZ: '..rz..'        Increment: '..increment, 255, 255, 255, 255)
			helpText(Config.HelpText)
			Wait(0)
		end
		DetachEntity(object, false, false)
		SetModelAsNoLongerNeeded(prop)
		SetEntityAsMissionEntity(object, false, false)
		DeleteObject(object)
	end)
end

RegisterCommand('ptpeditor', function(_, args)
	createPropLocation = not createPropLocation
	local bone, model = tonumber(args[1]), args[2] and joaat(args[2]) or 0
	if bone and IsModelValid(model) then
		if createPropLocation then
			startPropCreation(bone, model)
		end
	else
		notification(Config.ErrorModelText)
	end
end, false)

CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/ptpeditor', 'prop to player editor', {
		{ name = "bone ID", help = "Enter the bone ID you would like to attach the prop to." },
		{ name = "model", help = "The model you would like to attach to the player." }
	})
end)
