local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData              = {}
local membership = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('dpr_Gym:trueMembership')
AddEventHandler('dpr_Gym:trueMembership', function()
	membership = true
end)

RegisterNetEvent('dpr_Gym:falseMembership')
AddEventHandler('dpr_Gym:falseMembership', function()
	membership = false
end)

RegisterNetEvent("XNL_NET:AddPlayerXP")
AddEventHandler("XNL_NET:AddPlayerXP", function(NetXPAmmount)
	XNL_AddPlayerXP(NetXPAmmount)
end)

Citizen.CreateThread(function()
	while true do
		local interval = 1
		local pos = GetEntityCoords(PlayerPedId())
		local dest = vector3(-1203.3242, -1570.6184, 4.6115)
        local distance = GetDistanceBetweenCoords(pos, dest, true)
		
		if distance > 10 then 
			interval = 200
		else
			interval = 1
			DrawMarker(2, -1203.3242, -1570.6184, 4.6115, 0, 0, 0, 0, 0, 0, 0.401, 0.401, 0.4001, 255, 0, 0, 80, false, true, 2, nil, nil, true)
			if distance < 1 then
				AddTextEntry("HELP", "Appuyer sur ~INPUT_CONTEXT~ pour faire des exercices sur les ~g~bras")
				DisplayHelpTextThisFrame("HELP", false)
				if IsControlJustPressed(0, Keys['E']) then
					
					TriggerServerEvent('dpr_Gym:checkChip')
					Citizen.Wait(1000)					
					
					if membership == true then
						ESX.ShowAdvancedNotification("Gym", "Coach", "Bon sa part sur une séries de bras, prend bien la barre et la fais pas tomber !", "CHAR_MP_JULIO", 1)
						local playerPed = GetPlayerPed(-1)
						TaskStartScenarioInPlace(playerPed, "world_human_muscle_free_weights", 0, true)
						Citizen.Wait(3000)
						ClearPedTasksImmediately(playerPed)
						ESX.ShowAdvancedNotification("Gym", "Coach", "Yo, t'as bien tafer prend une petite pose et on continues !", "CHAR_MP_JULIO", 1)
						
					elseif membership == false then
						ESX.ShowAdvancedNotification("Gym", "Coach", "Eh oh, malfrat, faut payer, tu te crois où ? Prend un abonement !", "CHAR_MP_JULIO", 1)
					end
				end	
            end
		end
	
		Citizen.Wait(interval)
	end
end)

Citizen.CreateThread(function()
	while true do
		local interval = 1
		local pos = GetEntityCoords(PlayerPedId())
		local dest = vector3(-1200.1284, -1570.9903, 4.6115)
        local distance = GetDistanceBetweenCoords(pos, dest, true)
		
		if distance > 10 then 
			interval = 200
		else
			interval = 1
			DrawMarker(2, -1200.1284, -1570.9903, 4.6115, 0, 0, 0, 0, 0, 0, 0.401, 0.401, 0.4001, 255, 0, 0, 80, false, true, 2, nil, nil, true)
			if distance < 1 then
				AddTextEntry("HELP", "Appuyer sur ~INPUT_CONTEXT~ pour faire des ~g~tractions")
				DisplayHelpTextThisFrame("HELP", false)
				if IsControlJustPressed(0, Keys['E']) then
					
					TriggerServerEvent('dpr_Gym:checkChip')
					Citizen.Wait(1000)					
					
					if membership == true then
						ESX.ShowAdvancedNotification("Gym", "Coach", "OK, tu prends la barre et tu joues pas les chochottes tu baisses tes bras jusqu'en bas !", "CHAR_MP_JULIO", 1)
						local playerPed = GetPlayerPed(-1)
						TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
						Citizen.Wait(30000)
						ClearPedTasksImmediately(playerPed)
						ESX.ShowAdvancedNotification("Gym", "Coach", "Petite pause et c'est reparti !", "CHAR_MP_JULIO", 1)
						
					elseif membership == false then
						ESX.ShowAdvancedNotification("Gym", "Coach", "Eh oh, malfrat, faut payer, tu te crois où ? Prend un abonement !", "CHAR_MP_JULIO", 1)
					end
				end
            end
		end
	
		Citizen.Wait(interval)
	end
end)

Citizen.CreateThread(function()
	while true do
		local interval = 1
		local pos = GetEntityCoords(PlayerPedId())
		local dest = vector3(-1202.9837, -1565.1718, 4.6115)
        local distance = GetDistanceBetweenCoords(pos, dest, true)
		
		if distance > 10 then 
			interval = 200
		else
			interval = 1
			DrawMarker(2, -1202.9837, -1565.1718, 4.6115, 0, 0, 0, 0, 0, 0, 0.401, 0.401, 0.4001, 255, 0, 0, 80, false, true, 2, nil, nil, true)
			if distance < 1 then
				AddTextEntry("HELP", "Appuyer sur ~INPUT_CONTEXT~ pour faire des ~g~pompes")
				DisplayHelpTextThisFrame("HELP", false)
				if IsControlJustPressed(0, Keys['E']) then
					
					TriggerServerEvent('dpr_Gym:checkChip')
					Citizen.Wait(1000)					
					
					if membership == true then
						ESX.ShowAdvancedNotification("Gym", "Coach", "Je parie que tu ne passeras pas les 20 pompes.", "CHAR_MP_JULIO", 1)		
						local playerPed = GetPlayerPed(-1)
						TaskStartScenarioInPlace(playerPed, "world_human_push_ups", 0, true)
						Citizen.Wait(30000)
						ClearPedTasksImmediately(playerPed)
						ESX.ShowAdvancedNotification("Gym", "Coach", "T'es déjà fatigué ?", "CHAR_MP_JULIO", 1)
						
					elseif membership == false then
						ESX.ShowAdvancedNotification("Gym", "Coach", "Eh oh, malfrat, faut payer, tu te crois où ? Prend un abonement !", "CHAR_MP_JULIO", 1)
					end							
				end	
            end
		end
	
		Citizen.Wait(interval)
	end
end)

Citizen.CreateThread(function()
	while true do
		local interval = 1
		local pos = GetEntityCoords(PlayerPedId())
		local dest = vector3(-1204.7958, -1560.1906, 4.6115)
        local distance = GetDistanceBetweenCoords(pos, dest, true)
		
		if distance > 10 then 
			interval = 200
		else
			interval = 1
			DrawMarker(2, -1204.7958, -1560.1906, 4.6115, 0, 0, 0, 0, 0, 0, 0.401, 0.401, 0.4001, 255, 0, 0, 80, false, true, 2, nil, nil, true)
			if distance < 1 then
				AddTextEntry("HELP", "Appuyer sur ~INPUT_CONTEXT~ pour faire du ~g~yoga")
				DisplayHelpTextThisFrame("HELP", false)
				if IsControlJustPressed(0, Keys['E']) then
					
					TriggerServerEvent('dpr_Gym:checkChip')
					Citizen.Wait(1000)					
					
					if membership == true then
						ESX.ShowAdvancedNotification("Gym", "Coach", "T'es tendu pour faire cet exercice ou quoi ?", "CHAR_MP_JULIO", 1)
						local playerPed = GetPlayerPed(-1)
						TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
						Citizen.Wait(30000)
						ClearPedTasksImmediately(playerPed)
						ESX.ShowAdvancedNotification("Gym", "Coach", "Aller pas de pause on enchaine !", "CHAR_MP_JULIO", 1)
						
					elseif membership == false then
						ESX.ShowAdvancedNotification("Gym", "Coach", "Eh oh, malfrat, faut payer, tu te crois où ? Prend un abonement !", "CHAR_MP_JULIO", 1)
					end
				end	
            end
		end
	
		Citizen.Wait(interval)
	end
end)

Citizen.CreateThread(function()
	while true do
		local interval = 1
		local pos = GetEntityCoords(PlayerPedId())
		local dest = vector3(-1206.1055, -1565.1589, 4.6115)
        local distance = GetDistanceBetweenCoords(pos, dest, true)
		
		if distance > 10 then 
			interval = 200
		else
			interval = 1
			DrawMarker(2, -1206.1055, -1565.1589, 4.6115, 0, 0, 0, 0, 0, 0, 0.401, 0.401, 0.4001, 255, 0, 0, 80, false, true, 2, nil, nil, true)
			if distance < 1 then
				AddTextEntry("HELP", "Appuyer sur ~INPUT_CONTEXT~ pour faire des ~g~Abdos")
				DisplayHelpTextThisFrame("HELP", false)
				if IsControlJustPressed(0, Keys['E']) then

					TriggerServerEvent('dpr_Gym:checkChip')
					Citizen.Wait(1000)					
					
					if membership == true then
						ESX.ShowAdvancedNotification("Gym", "Coach", "On va voir ce que t'as dans le bide !", "CHAR_MP_JULIO", 1)
						local playerPed = GetPlayerPed(-1)
						TaskStartScenarioInPlace(playerPed, "world_human_sit_ups", 0, true)
						Citizen.Wait(30000)
						ClearPedTasksImmediately(playerPed)
						ESX.ShowAdvancedNotification("Gym", "Coach", "Je t'autorise à prendre une pause, picole un coup et ces repartit !", "CHAR_MP_JULIO", 1)
							
					elseif membership == false then
						ESX.ShowAdvancedNotification("Gym", "Coach", "Eh oh, malfrat, faut payer, tu te crois où ? Prend un abonement !", "CHAR_MP_JULIO", 1)
					end
				end	
            end
		end
	
		Citizen.Wait(interval)
	end
end)

-- Blip --
local blips = {
	{title="Salle de musculation", colour=7, id=311, x = -1201.2257, y = -1568.8670, z = 4.6101}
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

