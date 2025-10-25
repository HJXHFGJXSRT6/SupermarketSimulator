-- EconomySystem.lua
-- نظام الاقتصاد وكسب المال في السوبرماركت

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EconomySystem = {}
local playerMoney = {}
local REWARD_PER_PRODUCT = 10 -- المبلغ الثابت لكل منتج

-- إضافة المال للاعب
function EconomySystem:AddMoney(player, amount)
	if not playerMoney[player.UserId] then
		playerMoney[player.UserId] = 0
	end
	playerMoney[player.UserId] += amount
	player:SetAttribute("Money", playerMoney[player.UserId])
	print(player.Name .. " ربح " .. amount .. " وعنده الآن " .. playerMoney[player.UserId])
end

-- خصم المال
function EconomySystem:RemoveMoney(player, amount)
	if playerMoney[player.UserId] and playerMoney[player.UserId] >= amount then
		playerMoney[player.UserId] -= amount
		player:SetAttribute("Money", playerMoney[player.UserId])
	end
end

-- استرجاع الرصيد
function EconomySystem:GetMoney(player)
	return playerMoney[player.UserId] or 0
end

-- إعطاء كل لاعب رصيد ابتدائي
Players.PlayerAdded:Connect(function(player)
	playerMoney[player.UserId] = 100 -- يبدأ بـ 100
	player:SetAttribute("Money", 100)
end)

Players.PlayerRemoving:Connect(function(player)
	playerMoney[player.UserId] = nil
end)

-- مثال: حدث شراء منتج (يربط مع BuyItemEvent)
local buyEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("BuyItemEvent")
buyEvent.OnServerEvent:Connect(function(player)
	EconomySystem:AddMoney(player, REWARD_PER_PRODUCT)
end)

return EconomySystem
