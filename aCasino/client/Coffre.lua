ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



function CoffreCasi()
    local CCasi = RageUI.CreateMenu("", "Menu Intéraction..")
        RageUI.Visible(CCasi, not RageUI.Visible(CCasi))
            while CCasi do
            Citizen.Wait(0)
            RageUI.IsVisible(CCasi, true, true, true, function()

                    RageUI.ButtonWithStyle("→ Retirer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            CasiRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("→ Déposer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            CasiDeposeobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("→ Fermer le ~r~coffre",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                        FreezeEntityPosition(PlayerPedId(), false)
                        RageUI.CloseAll()
                        end
                    end)
                    
                end, function()
                end)
            if not RageUI.Visible(CCasi) then
            CCasi = RMenu:DeleteType("CCasi", true)
        end
    end
end

local position = {
    {x = 1089.34, y = 221.43, z = -49.20}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'casino' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.0 then
            wait = 0
        
            if dist <= 1.0 then
            DrawMarker(22,  1089.34,221.43,-49.20, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3,  127,255 , 255 , 255, true, true, p19, true)
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour ouvrir le coffre",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
					CoffreCasi()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

itemstock = {}
function CasiRetirerobjet()
    local StockCasi = RageUI.CreateMenu("", "Menu Intéraction..")
    ESX.TriggerServerCallback('KCasino:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(StockCasi, not RageUI.Visible(StockCasi))
        while StockCasi do
            Citizen.Wait(0)
                RageUI.IsVisible(StockCasi, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    ExecuteCommand'e pickup'
                                    TriggerServerEvent('KCasino:getStockItem', v.name, tonumber(count))
                                    CasiRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockCasi) then
            StockCasi = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function CasiDeposeobjet()
    local DeposerCasi = RageUI.CreateMenu("", "Menu Intéraction..")
    ESX.TriggerServerCallback('KCasino:getPlayerInventory', function(inventory)
        RageUI.Visible(DeposerCasi, not RageUI.Visible(DeposerCasi))
    while DeposerCasi do
        Citizen.Wait(0)
            RageUI.IsVisible(DeposerCasi, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            ExecuteCommand'e pickup'
                                            TriggerServerEvent('KCasino:putStockItems', item.name, tonumber(count))
                                            CasiDeposeobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DeposerCasi) then
                DeposerCasi = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end



function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end
