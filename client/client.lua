local open = false
local camera = nil

RegisterNetEvent('krs_idcard:openDocuments', function(data)
    print(json.encode(data, {indent = true}))  
    open = true
    SendNUIMessage({
        action = 'open',
        type = data.metadata.type,  
        firstName = data.metadata.firstName or 'Unknown',
        lastName = data.metadata.lastName or 'Unknown',
        dateOfBirth = data.metadata.dateOfBirth or 'Unknown',
        sex = data.metadata.sex or 'Unknown',
        height = data.metadata.height or 'Unknown',
        screenshot = data.metadata.screenshot or 'https://your-default-image-url.png',
        licenseData = data.metadata.licenseData or {}
    })
end)

local function isOpenDocument()
    return open
end

local function CloseAction()
    open = false
    SendNUIMessage({
        action = 'close',
    
    })
	SetNuiFocus(false, false)
end

local keybind = lib.addKeybind({
    name = 'close_idcard',
    description = 'press Delete to close ui',
    defaultKey = cfg.closeKeyDocument,
    onPressed = function(self)
        if not isOpenDocument() then return end 
        CloseAction()
    end,
})

local function lockKeys()
    CreateThread(function()
        while camera ~= nil do
            DisableAllControlActions(0)
            Wait(0)
        end
        EnableAllControlActions(0)
    end)
end

local function createDoc(documentType)
    local playerPed = cache.ped
    local playerCoords = GetEntityCoords(playerPed)
    lib.notify({title = 'Document Creation', icon = 'fa-solid fa-spinner', description = 'Processing photo, please wait...', type = 'success'})
    SetBlockingOfNonTemporaryEvents(playerPed, true)
    TaskStandStill(playerPed, -1)
    ClearPedTasksImmediately(playerPed)
    FreezeEntityPosition(playerPed, true)
    lockKeys()
    while GetEntitySpeed(playerPed) > 0 do Wait(25) end
    local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.75, 0)
    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(camera, true)
    RenderScriptCams(true, false, 0, true, true)
    SetCamCoord(camera, coords.x, coords.y, coords.z + 0.65)
    SetCamFov(camera, 20.0)
    SetCamRot(camera, 0.0, 0.0, GetEntityHeading(playerPed) + 180)
    PointCamAtPedBone(camera, playerPed, 31086, 0.0, 0.0, 0.03, 1)
    local camCoords = GetCamCoord(camera)
    TaskLookAtCoord(playerPed, camCoords.x, camCoords.y, camCoords.z, 5000, 1, 1)
    Wait(280) 
    exports['screenshot-basic']:requestScreenshotUpload(cfg.webhook, 'files[]', function(data)
        local resp = json.decode(data)
        local screenshot = nil
        for _, v in pairs(resp.attachments) do
            screenshot = v.url
        end
        while not screenshot do Wait(25) end
        TriggerServerEvent('krs_idcard:createDocument', screenshot, documentType)
        Wait(500)
        RenderScriptCams(false, true, 250, 1, 0)
        DestroyCam(camera, false)
        camera = nil
        SetBlockingOfNonTemporaryEvents(playerPed, false)
        FreezeEntityPosition(playerPed, false)
        ClearPedTasks(playerPed)
        TaskClearLookAt(playerPed)
    end)
end

exports('idcard', function(data, slot)
    exports.ox_inventory:useItem(data, function(data)
        if data then
            open = true
            TriggerEvent('krs_idcard:openDocuments', data)
            -- print(json.encode(data, {indent = true}))
        end
    end)
end)

exports('firearm_card', function(data, slot)
    exports.ox_inventory:useItem(data, function(data)
        if data then
            open = true
            TriggerEvent('krs_idcard:openDocuments', data)
            -- print(json.encode(data, {indent = true}))
        end
    end)
end)

exports('drive_license', function(data, slot)
    exports.ox_inventory:useItem(data, function(data)
        if data then
            open = true
            TriggerEvent('krs_idcard:openDocuments', data)
            -- print(json.encode(data, {indent = true}))
        end
    end)
end)

-- Create ID Card
RegisterCommand(cfg.createIdcard, function()
    createDoc('idcard')
end)

-- Create Weapon License
RegisterCommand(cfg.createWeaponCard, function()
    createDoc('firearm_card')
end)

-- Create Driving License
RegisterCommand(cfg.createDriveLicense, function()
    createDoc('drive_license')
end)