local main_menu = ContextUI:CreateMenu(2)
local sub_porte = ContextUI:CreateSubMenu(main_menu)
local sub_vitesse = ContextUI:CreateSubMenu(main_menu)

local limit = "~r~+"

ContextUI:IsVisible(main_menu, function(Entity)
    ContextUI:Button("Allumer/Eteindre le moteur", "", function(onSelected)
        if (onSelected) then
            local veh = GetVehiclePedIsIn(PlayerPedId())
            if GetIsVehicleEngineRunning(veh) then
                SetVehicleEngineOn(veh, false, true, true)
                ContextUI:OnClosed()
            else
                SetVehicleEngineOn(veh, true, true, true)
                ContextUI:OnClosed()
            end
        end
    end)

    ContextUI:Button("Gestion des portes", "", function(onSelected) end, sub_porte)
    ContextUI:Button("Limiteur de vitesse ("..limit.."~s~)", "", function(onSelected) end, sub_vitesse)
end)

ContextUI:IsVisible(sub_porte, function(Entity)
    ContextUI:Button("Avant gauche", "", function(onSelected)
        if (onSelected) then
            if not avantg then
                avantg = true
                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
            elseif avantg then
                avantg = false
                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
            end
        end
    end)
    ContextUI:Button("Avant droite", "", function(onSelected)
        if (onSelected) then
            if not avantd then
                avantd = true
                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
            elseif avantd then
                avantd = false
                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
            end
        end
    end)
    ContextUI:Button("Arrière gauche", "", function(onSelected)
        if (onSelected) then
            if not arrg then
                arrg = true
                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
            elseif arrg then
                arrg = false
                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
            end
        end
    end)
    ContextUI:Button("Arrière droite", "", function(onSelected)
        if (onSelected) then
            if not arrd then
                arrd = true
                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
            elseif arrd then
                arrd = false
                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
            end
        end
    end)
    ContextUI:Button("Coffre", "", function(onSelected)
        if (onSelected) then
            if not coffre then
                coffre = true
                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
            elseif coffre then
                coffre = false
                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
            end
        end
    end)ContextUI:Button("Câpot", "", function(onSelected)
        if (onSelected) then
            if not capot then
                capot = true
                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
            elseif capot then
                capot = false
                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
            end
        end
    end)
end)

ContextUI:IsVisible(sub_vitesse, function(Entity)
    local veh = GetVehiclePedIsIn(PlayerPedId())
    local carSpeed = GetEntitySpeed(veh) * 3.6
    ContextUI:Button("Limitation : ~b~"..limit, "", function(onSelected)
        if (onSelected) then
            local speedLimit = _UltiClient:input("Limitation de vitesse", "", 5, false)
            limit = speedLimit.."km/h"
            SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), speedLimit/3.7)
        end
    end)

    ContextUI:Button("Désactivation", "", function(onSelected)
        if (onSelected) then
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                limit = "~r~+"
                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0.0)
            end
        end
    end)
end)

Keys.Register("LMENU", "LMENU", "ENABLE", function()
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        ContextUI.Focus = not ContextUI.Focus;
    end
end)