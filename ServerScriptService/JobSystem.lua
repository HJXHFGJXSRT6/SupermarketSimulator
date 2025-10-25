-- JobSystem.lua
-- نظام الوظائف: كاشير + موظف رفوف

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local JobSystem = {}
JobSystem.Jobs = {"Cashier", "Stocker"}

local playerJobs = {}

-- وظيفة تغيير الوظيفة
function JobSystem:SetJob(player, jobName)
	if table.find(self.Jobs, jobName) then
		playerJobs[player.UserId] = jobName
		player:SetAttribute("Job", jobName)
		print(player.Name .. " أصبح " .. jobName)
	else
		warn("وظيفة غير موجودة: " .. tostring(jobName))
	end
end

-- استرجاع وظيفة اللاعب
function JobSystem:GetJob(player)
	return playerJobs[player.UserId]
end

-- تعيين وظيفة افتراضية عند دخول اللاعب
Players.PlayerAdded:Connect(function(player)
	playerJobs[player.UserId] = "Cashier"
	player:SetAttribute("Job", "Cashier")
end)

Players.PlayerRemoving:Connect(function(player)
	playerJobs[player.UserId] = nil
end)

return JobSystem
