ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx_society:isBoss', 'casino', 'casino', 'society_casino', 'society_casino', 'society_casino', {type = 'private'})


RegisterServerEvent('OCasino')
AddEventHandler('OCasino', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Casino~w~', '~b~Annonce', 'Le Casino est ouvert !', 'CHAR_PAVEL', 8)
	end
end)

RegisterServerEvent('FCasino')
AddEventHandler('FCasino', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Casino~w~', '~b~Annonce', 'Le Casino est fermé !', 'CHAR_PAVEL', 8)
	end
end)


RegisterServerEvent('amauu:casinojob')
AddEventHandler('amauu:casinojob', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'casino' then
            TriggerClientEvent('amauu:casinojob', xPlayers[i], _raison, name, message)
        end
    end
end)

RegisterServerEvent('RCasino')
AddEventHandler('RCasino', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Casino~w~', '~b~Annonce', 'Recrutement en cours, rendez-vous au Casino !', 'CHAR_PAVEL', 8)

    end
end)



RegisterCommand('ghyu', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "casino" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Casino~w~', '~b~Annonce', ''..msg..'', 'CHAR_PAVEL', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_PAVEL', 0)
    end
else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_PAVEL', 0)
end
end, false)

ESX.RegisterServerCallback('KCasino:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_casino', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('KCasino:getStockItem')
AddEventHandler('KCasino:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_casino', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('KCasino:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('KCasino:putStockItems')
AddEventHandler('KCasino:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_casino', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

RegisterServerEvent("casino:achat")
AddEventHandler("casino:achat", function(count)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_casino', function (account)
    if xPlayer then
        local cash = xPlayer.getMoney()
        local kwota = math.floor(count * 1)
        local jetons = xPlayer.getInventoryItem('jetons')
        local jetonsQuantity = xPlayer.getInventoryItem('jetons').count
        if kwota > cash then
            TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent ou plus de place")
           
        elseif kwota <= cash then
            xPlayer.addInventoryItem('jetons', count)
            xPlayer.removeMoney(kwota)
            account.addMoney(kwota)
            TriggerClientEvent('esx:showNotification', source, 'Tu obtiens '..count..' jetons pour $'..kwota..'.')
        end
    end
end)
end)

RegisterServerEvent('casino:echange')
AddEventHandler('casino:echange', function(count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local jetons = 10
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_casino', function (account)
	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "jetons" then
			jetons = item.count
		end
	end
    if jetons > 0 then
        local kwota = math.floor(count * 1)
        xPlayer.removeInventoryItem('jetons', count)
        xPlayer.addMoney(kwota)
        account.removeMoney(kwota)
            TriggerClientEvent('esx:showNotification', source, 'Tu obtiens $'..kwota..' pour '..count..' jetons.')
        else 
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Pas assez de jeton(s)')
        end
    end)
end)

RegisterNetEvent('casino:achatbar')
AddEventHandler('casino:achatbar', function(v, quantite)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    local playerlimite = xPlayer.getInventoryItem(v.item).count
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_casino', function (account)
    if playerlimite >= 10 then
        TriggerClientEvent('esx:showNotification', source, "Ton inventaire est plein!")
    
    else
    if playerMoney >= v.prix * quantite then
        xPlayer.addInventoryItem(v.item, quantite)
        account.removeMoney(v.prix * quantite)

       TriggerClientEvent('esx:showNotification', source, "Tu as acheté ~g~x"..quantite.." ".. v.nom .."~s~ pour ~g~" .. v.prix * quantite.. "$")
    else
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de sous pour acheter ~g~"..quantite.." "..v.nom)
    end
end
end)
end)
