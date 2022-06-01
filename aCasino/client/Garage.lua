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

function garageamauu()
    local garageamauu = RageUI.CreateMenu("", "Menu Intéraction..")
        RageUI.Visible(garageamauu, not RageUI.Visible(garageamauu))
            while garageamauu do
            Citizen.Wait(0)
            RageUI.IsVisible(garageamauu, true, true, true, function()

                RageUI.ButtonWithStyle("→ Sortir une Exemplar",nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                    if (Selected) then  
                    local model = GetHashKey("exemplar")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    exports['progressBars']:startUI((3 * 500), ('Sorti du véhicule'))
    
                    Citizen.Wait((3* 500)) 
                    local vehicle = CreateVehicle(model, 911.15,46.69,80.89, 147.77, true, true)
                    RageUI.CloseAll()
                    FreezeEntityPosition(PlayerPedId(), false)
                    end
                end)

                RageUI.ButtonWithStyle("→ Sortir un Baller",nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                    if (Selected) then  
                    local model = GetHashKey("baller2")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    exports['progressBars']:startUI((3 * 500), ('Sorti du véhicule'))
    
                    Citizen.Wait((3* 500)) 
                    local vehicle = CreateVehicle(model, 915.31,53.44,80.899, 147.77, true, true)
                    RageUI.CloseAll()
                    FreezeEntityPosition(PlayerPedId(), false)
                    end
                end)


    
            end, function()
            end, 1)

            if not RageUI.Visible(garageamauu) then
            garageamauu = RMenu:DeleteType("garageamauu", true)
        end
    end
end

  local position = {
	{x = 920.00, y = 40.72, z = 81.095}
}


Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'casino' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.5 then
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~p~E~w~] pour ouvrir le garage",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Salut Daniels !",
            
                        time_display = 1500
            
                    })
                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~o~Daniels~w~] Salut tu as besoin de quoi ?",
            
                        time_display = 1500
            
                    })
                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Il me faut un véhicule de fonction",
            
                        time_display = 1500
            
                    })
                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~o~Daniels~w~] Ok je regarde si c'est bon...",
            
                        time_display = 1500
            
                    })

                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~o~Daniels~w~] Oui parfait tiens regarde j'ai tout ça encore !",
            
                        time_display = 1500
            
                    })
                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Merci !",
            
                        time_display = 1500
            
                    })
                    Citizen.Wait(2000)
                    garageamauu()

        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

local npc2 = {
	{hash="s_m_m_cntrybar_01", x = 920.44, y = 40.47, z = 81.09, a=57.02},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npc2) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        TaskStartScenarioInPlace(ped2, 'WORLD_HUMAN_CLIPBOARD_FACILITY', 0, true)
		SetBlockingOfNonTemporaryEvents(ped2, true)
		FreezeEntityPosition(ped2, true)
		SetEntityInvincible(ped2, true)
	end
end)
------------- RANGER VOITURE ----------------


local Nabilaaa = {
    {x = 930.40, y = 62.49, z = 80.16}
}


function SquidGamepusamere(vehicle)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local props = ESX.Game.GetVehicleProperties(vehicle)
    local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
    local engineHealth = GetVehicleEngineHealth(current)

    if IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
        if engineHealth < 890 then
            ESX.ShowNotification("Votre véhicule est trop abimé, vous ne pouvez pas le ranger.")
        else
            ESX.Game.DeleteVehicle(vehicle)
            ESX.ShowNotification("~g~Le Véhicule a été rangé dans le garage.")
        end
    end
end

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(Nabilaaa) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'casino' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Nabilaaa[k].x, Nabilaaa[k].y, Nabilaaa[k].z)
        
            if dist <= 4.0 then
               wait = 0
               if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            DrawMarker(22,  929.31,60.76,80.47, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 127, 242, 255 , 255, true, true, p19, true)
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour donner ton véhicule à Daniels",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    DoScreenFadeOut(300)
                    Citizen.Wait(300)
                    DoScreenFadeIn(300)
					SquidGamepusamere()
            
        end
    end
    end
    end
    Citizen.Wait(wait)
    end
end
end)