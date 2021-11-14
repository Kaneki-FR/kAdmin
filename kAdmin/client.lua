ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.TriggerServerCallback('kaneki_data:getUsergroup', function(group)
        playergroup = group
    end)
    SetNuiFocus(false, false)
    ESX.PlayerData = ESX.GetPlayerData()
end)

kaneki_emploie = false 
local kaneki__Emploie = RageUI.CreateMenu('Kaneki', 'Admin :',1450,20)
kaneki__Emploie .Closed = function()
    kaneki_emploie = false
end
kanekiEmploie = function()
     if kaneki_emploie then 
         RageUI.Visible(kaneki__Emploie, false)
         return
     else
        kaneki_emploie = true 
         RageUI.Visible(kaneki__Emploie, true)
         CreateThread(function()
         while kaneki_emploie do 
             RageUI.IsVisible(kaneki__Emploie,function()            

RageUI.Separator("~b~ID : "..  GetPlayerServerId(
   PlayerId()
))

RageUI.Separator('~r~Personnelle')

local ped = GetPlayerPed(-1)

RageUI.Checkbox("SuperRun", nil, superrun, {}, { 
    onChecked = function(index, items)
        SuperRun(ped)
        superrun = true
    end,
    onUnChecked = function(index, items)
        superrun = false
        SuperRun(ped)
end});

local ped = GetPlayerPed(-1)

RageUI.Checkbox("GodMode", nil, supergod, {}, { 
    onChecked = function(index, items)
        Godmode(ped)
        supergod = true
    end,
    onUnChecked = function(index, items)
        supergod = false
        Godmode(ped)
    Wait(0)
end});

local ped = GetPlayerPed(-1)

RageUI.Checkbox("NoClip", nil, noclip, {}, { 
    onChecked = function(index, items)
        NoClip()
        noclip = true
    end,
    onUnChecked = function(index, items)
        noclip = false
        NoClip()
    Wait(0)
end});

RageUI.Button("Faire spawn une voiture", nil, {RightLabel = "→"}, true, {
    onSelected = function()
    local car = Imput('Nom du vehicule','','',20)
    SetCar(car)
end});

RageUI.Button("Tp sur le marker", nil, {RightLabel = "→"}, true, {
    onSelected = function()
    ExecuteCommand('tpm')
    ESX.ShowNotification("<C>~g~Téleporter avec succes~w~<C>")
end});

RageUI.Button("Heal", nil, {RightLabel = "→"}, true, {
    onSelected = function()
        TriggerEvent('esx_status:set', 'hunger', 1000000)
        TriggerEvent('esx_status:set', 'thirst', 1000000)
        ESX.ShowNotification("<C>~g~Heal effectué~w~<C>")
end});

RageUI.Button("Give Argent Cash", nil, {RightLabel = "→"}, true, {
    onSelected = function()
        GiveArgentCash()
end});

RageUI.Button("Téleporter sur coordonnées", nil, {RightLabel = "→"}, true, {
    onSelected = function()
        local x = AdminKeyboardInput("Entrer la position X", "", 10)
		local y = AdminKeyboardInput("Entrer la position Y", "", 10)
		local z = AdminKeyboardInput("Entrer la position Z", "", 10)
            ExecuteCommand("setcoords "..x.." "..y.." "..z)
            ESX.ShowNotification("<C>~g~Bien TP~w~<C>")
end});

RageUI.Button("Réparer vehicule", nil, {RightLabel = "→"}, true, {
    onSelected = function()
        local plyVeh = GetVehiclePedIsIn(PlayerPedId(), false)
        SetVehicleFixed(plyVeh)
        SetVehicleDirtLevel(plyVeh, 0.0) 
        ESX.ShowNotification("<C>~g~Vehicule bien réparer~w~<C>")
end});



RageUI.Separator('~r~Serveur')

RageUI.Button("Suprimer les vehicule proche (50)", nil, {RightLabel = "→"}, true, {
    onSelected = function()
    ExecuteCommand('cardel 50')
    ESX.ShowNotification("<C>~g~Vehicule bien supprimer~w~<C>")
end});

RageUI.Button("Coordoner", nil, {RightLabel = "→"}, true, {
    onSelected = function()
    print(GetEntityCoords(
        PlayerPedId()
	))
    ESX.ShowNotification("~b~<C>Fait F8<C>")
end});

RageUI.Button("Angle", nil, {RightLabel = "→"}, true, {
    onSelected = function()
print (GetEntityHeading(
    PlayerPedId()
))
ESX.ShowNotification("~b~<C>Fait F8<C>")
end});


RageUI.Button("Revive Tout le monde", nil, {RightLabel = "→"}, true, {
    onSelected = function()
    ExecuteCommand('reviveall')
end});


                        end)
                    Wait(0)
                end
            end)
        end      
    end

Keys.Register('F10', 'Kaneki', 'Ouvrir le menu Admin', function()
    ESX.TriggerServerCallback('kaneki_data:getUsergroup', function(group)
        if group == 'admin' then
        kanekiEmploie()
        elseif group == 'user' then
        ESX.ShowNotification("Vous devez être admin pour ouvrir ce menu.")
        end    
    end)
end)

-- Fonction

-- SuperSpeeed
SuperSpeed = false
SuperSpeed_speed = 1.5
function SuperRun()
    SuperSpeed = not SuperSpeed
    if SuperSpeed then -- activé
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)  
        superrun = true
        ESX.ShowNotification("<C>Super Run ~g~ON<C>")
    else -- désactivé
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        superrun = false
        ESX.ShowNotification("<C>Super Run ~r~OFF<C>")
    end
end



SuperGod = false
function Godmode()
    SuperGod = not SuperGod
    --godmod = GetPlayerInvincible(PlayerPedId())
    if SuperGod then
        SetEntityInvincible(GetPlayerPed(-1), true)
		SetPlayerInvincible(PlayerId(), true)
		SetEntityCanBeDamaged(GetPlayerPed(-1), false)
        ClearPedLastWeaponDamage(GetPlayerPed(-1))
        SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
		SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)            --SetEntityInvincible(PlayerPedId(), false)
        supergod = true
        ESX.ShowNotification("<C>GodMode ~g~ON<C>")
    else-- désactivé
        SetEntityInvincible(GetPlayerPed(-1), false)
		SetPlayerInvincible(PlayerId(), false)
		SetPedCanRagdoll(GetPlayerPed(-1), true)
		ClearPedLastWeaponDamage(GetPlayerPed(-1))
		SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), true)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)
        supergod = false
        ESX.ShowNotification("<C>GodMode ~r~OFF<C>")
    end
end


function SetCar(kaneki_car)
    kaneki_car = GetHashKey(kaneki_car)
    RequestModel(kaneki_car)
    while not HasModelLoaded(kaneki_car) do RequestModel(kaneki_car) Wait(50)end
    x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    vehicle = CreateVehicle(kaneki_car,GetEntityCoords(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
    SetVehicleWindowTint(vehicle, 3)
    SetVehicleNumberPlateText(vehicle, "/car")
end

--NoClip

local noclip = false
local noclip_speed = 1.0

function NoClip()
  noclip = not noclip
  local ped = GetPlayerPed(-1)
  if noclip then -- activé
    SetEntityInvincible(ped, true)
	SetEntityVisible(ped, false, false)
	invisible = true
	ESX.ShowNotification("<C>Noclip ~g~activé<C>")
  else -- désactivé
    SetEntityInvincible(ped, false)
	SetEntityVisible(ped, true, false)
	invisible = false
	ESX.ShowNotification("<C>Noclip ~r~désactivé<C>")
  end
end

function getPosition()
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
    return x,y,z
  end
  
  function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
    local pitch = GetGameplayCamRelativePitch()
  
    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)
  
    local len = math.sqrt(x*x+y*y+z*z)
    if len ~= 0 then
      x = x/len
      y = y/len
      z = z/len
    end
  
    return x,y,z
  end
  
  function isNoclip()
    return noclip
  end
  
  Citizen.CreateThread(function()
      while true do
        local Timer = 500
        if noclip then
          local ped = GetPlayerPed(-1)
          local x,y,z = getPosition()
          local dx,dy,dz = getCamDirection()
          local speed = noclip_speed
    
          -- reset du velocity
          SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
          Timer = 0  
          -- aller vers le haut
          if IsControlPressed(0,32) then -- MOVE UP
            x = x+speed*dx
            y = y+speed*dy
            z = z+speed*dz
          end
    
          -- aller vers le bas
          if IsControlPressed(0,269) then -- MOVE DOWN
            x = x-speed*dx
            y = y-speed*dy
            z = z-speed*dz
          end
    
          SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
        end
        Citizen.Wait(Timer)
      end
    end)

-- Argent Cash
    function GiveArgentCash()
        local amount = AdminKeyboardInput("Combien?", "", 8)
    
        if amount ~= nil then
            amount = tonumber(amount)
            
            if type(amount) == 'number' then
                TriggerServerEvent('Admin:GiveArgentCash', amount)
                ESX.ShowNotification("~g~Give argent cash effectué~w~ "..amount.." €")
            end
        end
    end

 -- Keybord imput   
    function AdminKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
        AddTextEntry('FMMC_KEY_TIP1', TextEntry)
        blockinput = true
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
            Wait(0)
        end 
            
        if UpdateOnscreenKeyboard() ~= 2 then
            local result = GetOnscreenKeyboardResult()
            Wait(500)
            blockinput = false
            return result
        else
            Wait(500)
            blockinput = false
            return nil
        end
    end

--Give véhicule avec clées
local voituregive = {}

function give_vehi(veh)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    
    Citizen.Wait(10)
    ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
            local plate = GeneratePlate()
            table.insert(voituregive, vehicle)        
            --print(plate)
            local vehicleProps = ESX.Game.GetVehicleProperties(voituregive[#voituregive])
            vehicleProps.plate = plate
            SetVehicleNumberPlateText(voituregive[#voituregive] , plate)
            TriggerServerEvent('fAdmin:vehicule', vehicleProps, plate, veh)
        
    end)
end

local voituregivejoueur = {}

function give_vehijoueur(veh, IdSelected)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    
    Citizen.Wait(10)
    ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
            local plate = GeneratePlate()
            table.insert(voituregivejoueur, vehicle)        
            --print(plate)
            local vehicleProps = ESX.Game.GetVehicleProperties(voituregivejoueur[#voituregivejoueur])
            vehicleProps.plate = plate
            SetVehicleNumberPlateText(voituregivejoueur[#voituregivejoueur] , plate)
            TriggerServerEvent('fAdmin:vehiculejoueur', vehicleProps, plate, IdSelected, veh)
        
    end)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function Imput(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", 200)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(100)
    end 
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

function ShowHelpNotification(msg, thisFrame, beep, duration)
    AddTextEntry('tmyHelpNotification', msg)

    if thisFrame then
        DisplayHelpTextThisFrame('tmyHelpNotification', false)
    else
        if beep == nil then beep = true end
        BeginTextCommandDisplayHelp('tmyHelpNotification')
        EndTextCommandDisplayHelp(0, false, beep, duration or -1)
    end
end

ShowNotification = function(msg, flash, saveToBrief, hudColorIndex)
	if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('esxNotification', msg)
	BeginTextCommandThefeedPost('esxNotification')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end



ShowAdvancedNotification = function(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('AdvancedNotification', msg)
	BeginTextCommandThefeedPost('AdvancedNotification')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end
