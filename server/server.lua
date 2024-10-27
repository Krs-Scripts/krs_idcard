RegisterNetEvent('krs_idcard:openDocuments', function(metadata)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    TriggerClientEvent('krs_idcard:openDocuments', source, metadata) 
end)

RegisterNetEvent('krs_idcard:createDocument', function(screenshot, documentType)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    local metadata = {
        type = documentType, 
        firstName = xPlayer.get('firstName'),
        lastName = xPlayer.get('lastName'),
        dateOfBirth = xPlayer.get('dateofbirth'),
        sex = xPlayer.get('sex'),
        height = xPlayer.get('height'),
        screenshot = screenshot
    }

    print("Metadata:", json.encode(metadata, {indent = true}))

    local added, message = exports.ox_inventory:AddItem(source, documentType, 1, metadata)
    -- print("AddItem result:", added, "Message:", message)
    if added then
        xPlayer.showNotification('Documento creato con successo.')
    else
        xPlayer.showNotification('Errore nella creazione del documento.')
    end
end)
