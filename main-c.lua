local blip = 0
local ingeklokt = false
local blips = false
local tijda = 0
local test = 0
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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if tijda > 0 then
            Wait(1000)
            tijda = tijda - 1
        end
    end
end)

-- In/uitklok cirkel

CreateThread(function()
    while true do
        if ESX.PlayerData.job.name == 'abc' then
            Citizen.Wait(0)
            DrawMarker(27, 210.61, -932.06, 30.69 - 0.98, 0.0, 0.0, 0.0, 0, 0, 0, 2.0, 2.0, 2.0, 0, 255, 0, 50, false, false, 2, nil, nil, false)
            Player = GetPlayerPed(-1)
            PlayerCoords = GetEntityCoords(Player)
            if GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 210.61, -932.06, 30.69, false) < 1 then
                ESX.ShowHelpNotification('Druk op ~INPUT_PICKUP~ om je kleding te veranderen')
                if IsControlJustReleased(1, 38) then
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ABCJob', {
                        title    = ('Garderobe'),
                        align    = 'top-right',
                        elements = {
                            {label = ('Bruger kleding'), value = 'citizen_wear'},
                            {label = ('Werk kleding'), value = 'ambulance_wear'},
                    }}, function(data, menu)
                        if data.current.value == 'citizen_wear' then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                ingeklokt = false
                                ESX.ShowNotification('Je bent uitdienst gegaan.')
                            end)
                            elseif data.current.value == 'ambulance_wear' then
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                if skin.sex == 0 then
                                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                                else
                                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                                end
                                ingeklokt = true
                                ESX.ShowNotification('Je bent nu indienst gegaan. Kijk achter je, bij de cirkels!')
                            end)
                        end
                
                        menu.close()
                    end, function(data, menu)
                        menu.close()
                    end)
                end
            end
        end
    end
end)

-- Werk cirkels
CreateThread(function()
    while true do
        Citizen.Wait(0)
        while ingeklokt == true do
            Citizen.Wait(0)
            PlayerCoords = GetEntityCoords(GetPlayerPed(-1))
            
            DrawMarker(27, 199.46, -945.14, 30.69 - 0.98, 0.0, 0.0, 0.0, 0, 0, 0, 2.0, 2.0, 2.0, 0, 255, 0, 50, false, false, 5, nil, nil, false)
            if GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 199.46, -945.14, 30.69, false) < 1 then
                ESX.ShowHelpNotification('Druk ~INPUT_PICKUP~ om A te produceren.')
                if IsControlJustPressed(1, 38) then
                    if  tijda == 0 then
                        TriggerServerEvent('abc:getitem', 'a', '1')
                        ESX.ShowNotification('Wacht nu ~r~10 ~s~seconde om de volgende te produceren!')
                        tijda = 10
                    elseif tijda >= 2 then
                        ESX.ShowNotification('Wacht nog ~r~' .. tijda .. '~s~ seconde om A te produceren!')
                    elseif tijda == 1 then
                        ESX.ShowNotification('Wacht nog ~r~1 ~s~seconde om A te produceren!')
                    end
                end
            end

            DrawMarker(27, 193.76, -941.15, 30.69 - 0.98, 0.0, 0.0, 0.0, 0, 0, 0, 2.0, 2.0, 2.0, 0, 255, 0, 50, false, false, 5, nil, nil, false)
            if GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 193.76, -941.15, 30.69, false) < 1 then
                ESX.ShowHelpNotification('Druk ~INPUT_PICKUP~ om alle A te veranderen naar B')
                if IsControlJustPressed(1, 38) then
                    TriggerServerEvent('abc:removeitemandgetitem', 'a', 'b')
                end
            end
                    
            DrawMarker(27, 188.83, -937.65, 30.69 - 0.98, 0.0, 0.0, 0.0, 0, 0, 0, 2.0, 2.0, 2.0, 0, 255, 0, 50, false, false, 5, nil, nil, false)
            if GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, 188.83, -937.65, 30.69, false) < 1 then
                ESX.ShowHelpNotification('Druk ~INPUT_PICKUP~ om alle B te verkopen.')
                if IsControlJustPressed(1, 38) then
                    TriggerServerEvent('abc:addcashfromitem', 'b', '100')
                end
            end
        end
    end
end)






