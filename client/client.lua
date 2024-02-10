Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)

        if IsVehicleHasLimiter(veh) then
            local vehLimit = GetVehicleLimiter(veh)
            if Config.UseKPH then
                local speed = GetEntitySpeed(veh) * Config.BaseSpeed.KPH -- KPH
                if speed >= vehLimit then
                    SetEntityMaxSpeed(veh, vehLimit / Config.BaseSpeed.KPH ) -- KPH
                end
            else
                local speed = GetEntitySpeed(veh) * Config.BaseSpeed.MPH -- MPH
                if speed >= vehLimit then
                    SetEntityMaxSpeed(veh, vehLimit / Config.BaseSpeed.MPH) -- MPH
                end
            end
        end
    end
end)


function IsVehicleHasLimiter(veh)
    local result = false

    if DoesEntityExist(veh) and IsEntityAVehicle(veh) then

        local vehModel = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
        if Config.VehicleSpeedLimiter[vehModel] ~= nil then
            result = true
        else
            result = false
        end
    end

    return result
end

function GetVehicleLimiter(veh)
    local vehModel = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
    local vehLimit = Config.VehicleSpeedLimiter[vehModel]
    return vehLimit
end