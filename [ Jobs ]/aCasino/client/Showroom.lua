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

local firstplaceshowroomsortie = {}

function ShowRoomOpenEnBas()
	local ShowroomMain = RageUI.CreateMenu("", "Casino")
        RageUI.Visible(ShowroomMain, not RageUI.Visible(ShowroomMain))
            while ShowroomMain do
            Citizen.Wait(0)
            RageUI.IsVisible(ShowroomMain, true, true, true, function()

                if FirstPlaceTake then 
                    RageUI.ButtonWithStyle("~r~Supprimer le 1", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            supprimervehiculeshowroom1()
                            FirstPlaceTake = false
                        end
                    end)
                else
                    RageUI.ButtonWithStyle("Emplacement 1", nil, {RightLabel = "Libre"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            spawn1()
                        end
                    end)
                end
            end, function()
            end)

            if not RageUI.Visible(ShowroomMain) then
            ShowroomMain = RMenu:DeleteType("ShowroomMain", true)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.showroom.menu.x, Config.pos.showroom.menu.y, Config.pos.showroom.menu.z)
        if jobdist <= Marker.DrawDistance and Config.jeveuxmarker then
            Timer = 0
            DrawMarker(Marker.Type, Config.pos.showroom.menu.x, Config.pos.showroom.menu.y, -48.99, nil, nil, nil, 90, nil, nil, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.R, Marker.Color.G, Marker.Color.B, 200)
            end
            if jobdist <= 1.0 then
                Timer = 0
                    RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour ouvrir ~b~Showroom", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        ShowRoomOpenEnBas()
                    end   
                end 
        Citizen.Wait(Timer)   
    end
end)

function supprimervehiculeshowroom1()
	while #firstplaceshowroomsortie > 0 do
		local vehicle = firstplaceshowroomsortie[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(firstplaceshowroomsortie, 1)
	end
end

function spawn1()
    local modele = KeyboardInput("Entrez le modèle", "", 100)
    RageUI.Popup({ message = "<C>Chargement du véhicule...", time_display = 1 })
    Wait(500)
    local car = GetHashKey(modele)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(car, Config.pos.showroom.show1.x, Config.pos.showroom.show1.y, Config.pos.showroom.show1.z, Config.pos.showroom.show1.h, true)
    FreezeEntityPosition(vehicle, true)
    SetVehicleDoorsLocked(vehicle, 4)
    SetEntityAsMissionEntity(vehicle, true, true) 
    table.insert(firstplaceshowroomsortie, vehicle)
    FirstPlaceTake = true
end
