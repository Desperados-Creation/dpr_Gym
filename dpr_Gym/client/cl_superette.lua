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

Citizen.CreateThread(function()
	while true do
		local interval = 1
		local pos = GetEntityCoords(PlayerPedId())
		local dest = vector3(-1195.6551, -1577.7689, 4.6115)
        local distance = GetDistanceBetweenCoords(pos, dest, true)
		
		if distance > 15 then 
			interval = 200
		else
			interval = 1
			DrawMarker(29, -1195.6551, -1577.7689, 4.6115, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 80, false, true, 2, nil, nil, true)
			if distance < 1 then
				Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour accèder à notre supérette !", 1)
				if IsControlPressed(1, 51) then  
					OpenGymMenu()
                end 
            end
		end
	
		Citizen.Wait(interval)
	end
end)

-- Menu --
local open = false 
local Gym = RageUI.CreateMenu('Superette Gym', 'Interaction')
Gym.Display.Header = true 
Gym.Closed = function()
	open = false
end

function OpenGymMenu()
	if open then 
		open = false
		RageUI.Visible(Gym, false)
		return
	else
		open = true 
		RageUI.Visible(Gym, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(Gym,function() 

			RageUI.Separator("↓ ~b~   Gym    ~s~↓")
			RageUI.Button("Abonnement à l'année", "Vous permet de faire les exercices avec le suivit d'un coach", {RightLabel = "~g~800$"}, true , {
				onSelected = function()
                    TriggerServerEvent('dpr_Gym:buyMembership')
				end
			})

			RageUI.Button("Powerade", nil, {RightLabel = "~g~8$"}, true , {
				onSelected = function()
                    TriggerServerEvent('dpr_Gym:buyPowerade')
				end
			})

			RageUI.Button("Eau", nil, {RightLabel = "~g~5$"}, true , {
				onSelected = function()
                    TriggerServerEvent('dpr_Gym:buyWater')
				end
			})

			RageUI.Separator("↓ ~b~   Fermer   ~s~↓")
			RageUI.Button("~r~Fermer", "Fermer le menu", {RightLabel = "→→"}, true , {
				onSelected = function()
					RageUI.CloseAll()
				end
			})
			end)
		Wait(0)
		end
	 end)
  end
end

-- Message --
RegisterNetEvent('dpr_Gym:AchatAbonnement')
AddEventHandler('dpr_Gym:AchatAbonnement', function(car)
    -- Notification
	Citizen.Wait(1000) 
	ESX.ShowAdvancedNotification("Gym", "Coach", "Bienvenue parmis nous gamins, sa va pas être des vacances donc accroche toi bien !", "CHAR_MP_JULIO", 1)
    Citizen.Wait(10000) 
	ESX.ShowAdvancedNotification("Banque", "Conseiller", "Un prélèvement de ~r~800$ ~s~a été effectué sur votre compte pour un abonnement de gym !", "CHAR_BANK_MAZE", 2)
end)

RegisterNetEvent('dpr_Gym:AchatEau')
AddEventHandler('dpr_Gym:AchatEau', function(car)
    -- Notification
	Citizen.Wait(1000) 
	ESX.ShowAdvancedNotification("Gym", "Coach", "Bas sa picole dur ici !", "CHAR_MP_JULIO", 1)
end)

RegisterNetEvent('dpr_Gym:AchatPowerade')
AddEventHandler('dpr_Gym:AchatPowerade', function(car)
    -- Notification
	Citizen.Wait(1000) 
	ESX.ShowAdvancedNotification("Gym", "Coach", "N'en bois pas trop tu seras sur exité après !", "CHAR_MP_JULIO", 1)
end)

RegisterNetEvent('dpr_Gym:refus')
AddEventHandler('dpr_Gym:refus', function(car)
    -- Notification
    ESX.ShowAdvancedNotification("Banque", "Conseiller", "Paiement refusé ! Vous n'avez plus suffisamment d'argent !", "CHAR_BANK_MAZE", 2)
    RageUI.CloseAll()
end)