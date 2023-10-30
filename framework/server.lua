local Framework = {}

if Config.Framework == 'qb' then
    local QBCore = exports['qb-core']:GetCoreObject()

    function Framework:GetCops()
        local amount = 0
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player ~= nil then
                if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
                    amount = amount + 1
                end
            end
        end
        return amount
    end

    function Framework:GetCopBonus(price)
        local copsamount = Framework:GetCops()
        if copsamount > 0 and copsamount < 3 then
			price = price * 1.2
		elseif copsamount >= 3 and copsamount <= 6 then
			price = price * 1.5
		elseif copsamount >= 7 and copsamount <= 10 then
			price = price * 2.0
		end
        return price
    end

    function Framework:AddMoney(source, type, amount, reason)
        local player = QBCore.Functions.GetPlayer(source)
        if not player then return false end
        return player.Functions.AddMoney(type, amount, reason)
    end

    function Framework:RemoveMoney(source, type, amount, reason)
        local player = QBCore.Functions.GetPlayer(source)
        if not player then return false end
        return player.Functions.RemoveMoney(type, amount, reason)
    end

    if Config.Inventory == 'oldqb' then
        function Framework:AddItem(source, item, amount)
            local player = QBCore.Functions.GetPlayer(source)
            if not player then return false end
            return player.Functions.AddItem(item, amount)
        end

        function Framework:RemoveItem(source, item, amount)
            local player = QBCore.Functions.GetPlayer(source)
            if not player then return false end
            return player.Functions.RemoveItem(item, amount)
        end
    end
end

if Config.Inventory == 'ox' then
    function Framework:AddItem(source, item, amount)
        exports.ox_inventory:AddItem(source, item, amount)
    end

    function Framework:RemoveItem(source, item, amount)
        exports.ox_inventory:RemoveItem(source, item, amount)
    end
end

if Config.Inventory == 'qb' then
    function Framework:AddItem(source, item, amount)
        exports['qb-inventory']:AddItem(source, item, amount)
    end

    function Framework:RemoveItem(source, item, amount)
        return exports['qb-inventory']:RemoveItem(source, item, amount)
    end
end

return Framework