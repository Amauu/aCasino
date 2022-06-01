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

amauubar = false
RMenu.Add('barcasino', 'main', RageUI.CreateMenu("", "Casino"))
RMenu:Get('barcasino', 'main').Closed = function()
    amauubar = false
end

function bar()
    if not amauubar then
        amauubar = true
        RageUI.Visible(RMenu:Get('barcasino', 'main'), true)
    while amauubar do
        RageUI.IsVisible(RMenu:Get('barcasino', 'main'), true, true, true, function()    
         
        for k, v in pairs(Config.baritem) do
            RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = " ~g~$"..v.prix},true, function(Hovered, Active, Selected)
                if (Selected) then  
                local quantite = 1    
                local item = v.item
                local prix = v.prix
                local nom = v.nom    
                TriggerServerEvent('casino:achatbar', v, quantite)
            end
            end)

        end
    end, function()
    end)
        Wait(0)
    end
else
    amauubar = false
end
end

Citizen.CreateThread(function()
        while true do
        Citizen.Wait(0)
        local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.bar.position.x, Config.pos.bar.position.y, Config.pos.bar.position.z)
        if jobdist <= 15.0 then
            DrawMarker(6, Config.pos.bar.position.x, Config.pos.bar.position.y, Config.pos.bar.position.z-0.99, nil, nil, nil, -90, nil, nil, 0.3, 0.3, 0.3, 127, 255, 255, 155)
        end
        if jobdist <= 1.0 then
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'casino' then  
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au bar")
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    bar()
                    FreezeEntityPosition(PlayerPedId(), false)
                end   
            end
        end 
    end
end)