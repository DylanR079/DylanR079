ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('abc:getitem')
AddEventHandler('abc:getitem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    xPlayer.addInventoryItem(item, count)
end)

RegisterNetEvent('abc:removeitem')
AddEventHandler('abc:removeitem', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    xPlayer.removeInventoryItem(item, count)
end)

RegisterNetEvent('abc:removeitemandgetitem')
AddEventHandler('abc:removeitemandgetitem', function(item1, item2)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerInv = xPlayer.getInventoryItem(item1)
    local count = playerInv.count

    xPlayer.removeInventoryItem(item1, count)
    xPlayer.addInventoryItem(item2, count)
end)

RegisterNetEvent('abc:addcashfromitem')
AddEventHandler('abc:addcashfromitem', function(item, cashperitem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerInv = xPlayer.getInventoryItem(item)
    local count = playerInv.count
    local money = count * cashperitem
    print(money)

    xPlayer.removeInventoryItem(item, count)
    xPlayer.addMoney(money)
    print('ja')
end)