local position_x = 311.61
local position_y = -594.13
local position_z = 42.30
local heading = 337.34

local isAtPed = false

-- Placing the ped
CreateThread(function()
    if not isPedLoaded then
        RequestModel("csb_trafficwarden")
        while not HasModelLoaded("csb_trafficwarden") do
            Wait(10)
        end
    end     

    local ped = CreatePed(4,"csb_trafficwarden",position_x,position_y,position_z,heading,true,false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)

    -- Set Ped health so it cant die
    SetEntityInvincible(ped, true)
    SetEntityProofs(ped, true, true, true, true, true, true, true, true) 
end)


-- Creating Info Bar
CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = Vdist(playerCoords,position_x,position_y,position_z) 
        isAtPed = false
        if distance < 2.0 then
            isAtPed = true
        end
        Wait(1)
    end

end)
-- Healing the player
CreateThread(function()


    while true do
        local playerPed = PlayerPedId()
        if isAtPed then
            showInfobar('Press ~g~E~s~, to get a treatment!')
            if IsControlJustReleased(0, 38) then
                SetEntityHealth(playerPed,500)
                ShowNotification('You are feeling good!')
            end
        end
        Wait(1)
    end
end)





function showInfobar(msg)
    CurrentActionMsg  = msg
    SetTextComponentFormat('STRING')
    AddTextComponentString(CurrentActionMsg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function ShowNotification(text)
    SetNotificationTextEntry('STRING')
       AddTextComponentString(text)
    DrawNotification(false, true)
end
   
