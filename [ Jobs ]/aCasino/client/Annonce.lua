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

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.pos.blip.position.x, Config.pos.blip.position.y, Config.pos.blip.position.z)
    SetBlipAsShortRange(blip, true)
    SetBlipSprite(blip, 617)
    SetBlipColour(blip, 3)
    SetBlipScale(blip, 0.6)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName("Diamond Casino")
    EndTextCommandSetBlipName(blip)
end)


function AnnonceCasi()
    local AnnonceCasi = RageUI.CreateMenu("", "Menu Intéraction..")
        RageUI.Visible(AnnonceCasi, not RageUI.Visible(AnnonceCasi))
            while AnnonceCasi do
            Citizen.Wait(0)
            RageUI.IsVisible(AnnonceCasi, true, true, true, function()

                RageUI.ButtonWithStyle("→ Annonce Ouverture",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        ExecuteCommand'e type' 
                        exports['progressBars']:startUI((3 * 1000), ('Initialisation de l\'annonce en cours'))

                        Citizen.Wait((3* 1000))       
                        TriggerServerEvent('OCasino')
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end)
        
                RageUI.ButtonWithStyle("→ Annonce Fermeture",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand'e type' 
                        exports['progressBars']:startUI((3 * 1000), ('Initialisation de l\'annonce en cours'))

                        Citizen.Wait((3* 1000))   
                        TriggerServerEvent('FCasino')
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end)

                RageUI.ButtonWithStyle("→ Annonce Recrutement",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then    
                        ExecuteCommand'e type' 
                        exports['progressBars']:startUI((3 * 1000), ('Initialisation de l\'annonce en cours'))

                        Citizen.Wait((3* 1000))   
                        TriggerServerEvent('RCasino')
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end)

                        
                RageUI.Separator("↓ ~b~     Message    ~s~↓")
        
                RageUI.ButtonWithStyle("→ Message aux Employés",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                    ExecuteCommand'e type'  
                    local info = 'patron'
                    local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', 40)
                    exports['progressBars']:startUI((3 * 1000), ('Envoie du message en cours'))

                    Citizen.Wait((3* 1000))    
                    TriggerServerEvent('amau:casinojob', info, message)
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                end
                end)
        
                RageUI.ButtonWithStyle("→ Message Personnalisé",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand'e type' 
                        local te = KeyboardInput("Message", "", 100)
                        exports['progressBars']:startUI((3 * 1000), ('Envoie du message en cours'))
    
                        Citizen.Wait((3* 1000)) 
                        ExecuteCommand("ghyu " ..te)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end)
            

                RageUI.ButtonWithStyle("→ Fermer la ~r~session",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                    FreezeEntityPosition(PlayerPedId(), false)
                    RageUI.CloseAll()
                    end
                end)
        
    
            end, function()
            end, 1)

            if not RageUI.Visible(AnnonceCasi) then
            AnnonceCasi = RMenu:DeleteType("AnnonceCasi", true)
        end
    end
end

local position = {
    {x = 1087.30, y = 221.22, z = -49.20}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

      for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'casino' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.5 then
            DrawMarker(22,  1087.30,221.22,-49.200, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 127, 255 , 255 , 255, true, true, p19, true)
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour accéder à l'ordinateur",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    AnnonceCasi()
                    
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)
