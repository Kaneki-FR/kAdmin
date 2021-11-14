ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("kaneki_data:trigger")
AddEventHandler("kaneki_data:trigger", function()
    T = source
    DropPlayer(T, "Notification")
end)

ESX.RegisterServerCallback('kaneki_data:getUsergroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    cb(group)
end)

--Argent cash
RegisterServerEvent("Admin:GiveArgentCash")
AddEventHandler("Admin:GiveArgentCash", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addMoney((total))
end)
