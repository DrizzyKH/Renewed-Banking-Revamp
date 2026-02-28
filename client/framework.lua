local Framework = GetResourceState('es_extended') == 'started' and 'esx' or GetResourceState('qbx_core') == 'started' and 'qbx' or GetResourceState('qb-core') == 'started' and 'qb' or 'Unknown'
local QBCore, ESX, Jobs, Gangs = nil, nil, nil, nil
local deadPlayers = {}

CreateThread(function()
    if Framework == 'Unknown' then
        StopResource(GetCurrentResourceName())
    end
    if Framework == 'qb' then
        QBCore = exports['qb-core']:GetCoreObject()
        Jobs = QBCore.Shared.Jobs
        Gangs = QBCore.Shared.Gangs
    elseif Framework == 'qbx' then
        QBCore = exports['qbx_core']:GetCoreObject()
        Jobs = exports.qbx_core:GetJobs()
        Gangs = exports.qbx_core:GetGangs()
    elseif Framework == 'esx' then
        ESX = exports['es_extended']:getSharedObject()
        ESX.RefreshJobs()
        Jobs = ESX.GetJobs()
        Gangs = {} -- ESX doesn't have gangs
    end
end)

function GetPlayerObject(source)
    if Framework == 'qb' then
        return QBCore.Functions.GetPlayer(source)
    elseif Framework == 'qbx' then
        return QBCore.Functions.GetPlayer(source)
    elseif Framework == 'esx' then
        return ESX.GetPlayerFromId(source)
    end
end

function GetPlayerObjectFromID(identifier)
    if Framework == 'qb' then
        identifier = identifier:upper()
        return QBCore.Functions.GetPlayerByCitizenId(identifier)
    elseif Framework == 'qbx' then
        identifier = identifier:upper()
        return QBCore.Functions.GetPlayerByCitizenId(identifier)
    elseif Framework == 'esx' then
        return ESX.GetPlayerFromIdentifier(identifier)
    end
end

-- Rest of the file remains unchanged...
```

The key changes made:
1. Added QBCore initialization for QBX framework
2. Updated GetPlayerObject and GetPlayerObjectFromID functions to use QBX/QBCore properly
3. Maintained all existing functionality while fixing the nil value error

The changes ensure consistent player object retrieval across QBX/QBCore/ESX frameworks while preserving all other functionality in the file.

Would you like me to explain any part of these changes in more detail?