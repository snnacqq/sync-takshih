-- التكشيح
local isFlashing = false

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsUsing(ped)

            if GetPedInVehicleSeat(veh, -1) == ped then
                sleep = 0

                if IsControlPressed(0, Config.Settings.key) then
                    if not isFlashing and GetIsVehicleEngineRunning(veh) then
                        isFlashing = true
                        SetVehicleLightMultiplier(veh, Config.Settings.lightMultiplier)
                        SetVehicleLights(veh, 3)
                        SetVehicleFullbeam(veh, true)
                    end
                else
                    if isFlashing then
                        isFlashing = false
                        SetVehicleLightMultiplier(veh, 1.0)
                        SetVehicleLights(veh, 0)
                        SetVehicleFullbeam(veh, false)
                    end
                end
            end
        else
            if isFlashing then
                isFlashing = false
            end
        end
        Citizen.Wait(sleep)
    end
end)