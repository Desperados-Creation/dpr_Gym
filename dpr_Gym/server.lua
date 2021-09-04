ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('dpr_Gym:checkChip')
AddEventHandler('dpr_Gym:checkChip', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local oneQuantity = xPlayer.getInventoryItem('gym_membership').count
	
	if oneQuantity > 0 then
		TriggerClientEvent('dpr_Gym:trueMembership', source)
	else
		TriggerClientEvent('dpr_Gym:falseMembership', source)
	end
end)

RegisterServerEvent('dpr_Gym:buyMembership')
AddEventHandler('dpr_Gym:buyMembership', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getBank() >= 800) then
		xPlayer.removeAccountMoney('bank', 800)
		
		xPlayer.addInventoryItem('gym_membership', 1)				
		TriggerClientEvent('dpr_Gym:trueMembership', source)
		TriggerClientEvent('dpr_Gym:AchatAbonnement', source)
	else
		TriggerClientEvent('dpr_Gym:refus', source)
	end	
end)

RegisterServerEvent('dpr_Gym:buyWater')
AddEventHandler('dpr_Gym:buyWater', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 1) then
		xPlayer.removeMoney(1)
		
		xPlayer.addInventoryItem('water', 1)
		
		TriggerClientEvent('dpr_Gym:AchatEau', source)
	else
		TriggerClientEvent('dpr_Gym:refus', source)
	end		
end)

RegisterServerEvent('dpr_Gym:buyPowerade')
AddEventHandler('dpr_Gym:buyPowerade', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 4) then
		xPlayer.removeMoney(4)
		
		xPlayer.addInventoryItem('powerade', 1)
		
		TriggerClientEvent('dpr_Gym:AchatPowerade', source)
	else
		TriggerClientEvent('dpr_Gym:refus', source)
	end		
end)

-- Consommer
ESX.RegisterUsableItem('powerade', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('powerade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 70000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez consommés une ~g~powerade')
end)