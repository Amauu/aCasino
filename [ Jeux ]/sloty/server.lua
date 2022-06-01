ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_slots:BetsAndMoney")
AddEventHandler("esx_slots:BetsAndMoney", function(bets)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    if xPlayer then
        local xItem = xPlayer.getInventoryItem('jetons')
        if xItem.count < 10 then
            TriggerClientEvent('esx:showNotification', _source, "Vous avez besoin d'au moins 10 jetons pour jouer!")
        else
            MySQL.Sync.execute("UPDATE users SET jetons=@jetons WHERE identifier=@identifier",{['@identifier'] = xPlayer.identifier, ['@jetons'] = xItem.count})
            TriggerClientEvent("esx_slots:UpdateSlots", _source, xItem.count)
            xPlayer.removeInventoryItem('jetons', xItem.count)
            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_casino', function (account)
                account.addMoney(xItem.count)
        end)
        end
    end
end)

RegisterServerEvent("esx_slots:updateCoins")
AddEventHandler("esx_slots:updateCoins", function(bets)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    if xPlayer then
        MySQL.Sync.execute("UPDATE users SET jetons=@jetons WHERE identifier=@identifier",{['@identifier'] = xPlayer.identifier, ['@jetons'] = bets})
    end
end)

RegisterServerEvent("esx_slots:PayOutRewards")
AddEventHandler("esx_slots:PayOutRewards", function(amount)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    if xPlayer then
        amount = math.floor(tonumber(amount))
        if amount > 0 then
            xPlayer.addInventoryItem('jetons', amount)
        end
        MySQL.Sync.execute("UPDATE users SET jetons=0 WHERE identifier=@identifier",{['@identifier'] = xPlayer.identifier})
    end
end)

RegisterServerEvent("route68_kasyno:getJoinChips")
AddEventHandler("route68_kasyno:getJoinChips", function()
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    MySQL.Async.fetchAll('SELECT jetons FROM users WHERE @identifier=identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] then
            local jetons = result[1].jetons
            if jetons > 0 then
                TriggerClientEvent('pNotify:SendNotification', _source, {text = 'Vous avez '..tostring(jetons)..' jetons, parce que vous êtes parti pendant le jeu de machines à sous.'})
                xPlayer.addInventoryItem('jetons', jetons)
                MySQL.Sync.execute("UPDATE users SET jetons=0 WHERE identifier=@identifier",{['@identifier'] = xPlayer.identifier})
            end
		end
	end)
end)