Citizen.CreateThread(function()
    while true do
        local waiting = 750
        local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, Config.pos.ascenceur.monter.x, Config.pos.ascenceur.monter.y, Config.pos.ascenceur.monter.z)
        
        if dist2 <= 10.0 then
            waiting = 0
            DrawMarker(Marker.Type, Config.pos.ascenceur.monter.x, Config.pos.ascenceur.monter.y, 81.09, nil, nil, nil, 90, nil, nil, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.R, Marker.Color.G, Marker.Color.B, 200)
        end

        if dist2 <= 1.0 then
                waiting = 0
            RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour entrée dans le ~b~Casino", time_display = 1 })
            if IsControlJustPressed(1,51) then
                DoScreenFadeOut(100)
                Citizen.Wait(750)
                ESX.Game.Teleport(PlayerPedId(), {x=Config.pos.ascenceur.descendre.x,y=Config.pos.ascenceur.descendre.y,z=Config.pos.ascenceur.descendre.z})
                DoScreenFadeIn(100)
            end   
        end
        Citizen.Wait(waiting)
    end
end)

Citizen.CreateThread(function()
    while true do
        local waiting = 750
        local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, Config.pos.ascenceur.descendre.x, Config.pos.ascenceur.descendre.y, Config.pos.ascenceur.descendre.z)

        if dist2 <= 10.0 then
            waiting = 0
        DrawMarker(Marker.Type, Config.pos.ascenceur.descendre.x, Config.pos.ascenceur.descendre.y, -48.99, nil, nil, nil, 90, nil, nil, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.R, Marker.Color.G, Marker.Color.B, 200)

        end

        if dist2 <= 1.0 then
            waiting = 0
            RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour sortir du ~b~Casino", time_display = 1 })
            if IsControlJustPressed(1,51) then
                DoScreenFadeOut(100)
                Citizen.Wait(750)
                ESX.Game.Teleport(PlayerPedId(), {x=Config.pos.ascenceur.monter.x,y=Config.pos.ascenceur.monter.y,z=Config.pos.ascenceur.monter.z})
                DoScreenFadeIn(100)
            end   
        end
        Citizen.Wait(waiting)
    end
end)