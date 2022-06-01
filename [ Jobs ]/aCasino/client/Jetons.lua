ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

amauu = false
RMenu.Add('cshop', 'main', RageUI.CreateMenu("", "~b~Accueil"))
RMenu:Get('cshop', 'main').Closed = function()
    amauu = false
end

function echangecas()
    if not amauu then
        amauu = true
        RageUI.Visible(RMenu:Get('cshop', 'main'), true)
    while amauu do
        RageUI.IsVisible(RMenu:Get('cshop', 'main'), true, true, true, function()
            RageUI.ButtonWithStyle("Acheter Jeton(s)", nil, {RightLabel = "→"}, true,function(h,a,s)
                if s then
                    local quantity = KeyboardInput("Montant", "", 15)
                    if quantity == nil then
                        RageUI.Popup({message = "~r~Montant invalide"})
                    else
                    TriggerServerEvent('casino:achat', quantity)		
                    end
                end
            end) 
            RageUI.ButtonWithStyle("Echanger Jeton(s)", nil, {RightLabel = "→"}, true,function(h,a,s)
                if s then
                    local quantity = KeyboardInput("Montant", "", 15)
                    if quantity == nil then
                        RageUI.Popup({message = "~r~Montant invalide"})
                    else
                        TriggerServerEvent('casino:echange', quantity)
                    end
                end
            end) 
        end, function()
        end)
            Wait(0)
        end
    else
        amauu = false
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.pos.echangejeton.position.x, Config.pos.echangejeton.position.y, Config.pos.echangejeton.position.z)
            if dist <= 15.0 then
                DrawMarker(22,  Config.pos.echangejeton.position.x, Config.pos.echangejeton.position.y, Config.pos.echangejeton.position.z-0.00, nil, nil, nil, 90, nil, nil, 0.3, 0.3, 0.3, 127, 255 , 255 , 255, true, true, p19, true)
            end
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour parler à l'hotesse")
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    echangecas()
                    FreezeEntityPosition(PlayerPedId(), false)
            end   
        end
    end
end)