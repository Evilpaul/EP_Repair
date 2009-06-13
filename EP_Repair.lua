local EPRepair = CreateFrame("Frame")
EPRepair:RegisterEvent("MERCHANT_SHOW")

function EPRepair:MessageOutput(inputMessage)
	ChatFrame1:AddMessage(string.format("|cffDAFF8A[Repair]|r %s", inputMessage))
end

function EPRepair:RepairMe()

	-- only continue if we talk to a repair guy
	if not CanMerchantRepair() then return end

	-- find the repair cost and if we need to repair
	local rawAmount, needRepair = GetRepairAllCost()

	-- only continue if we actually need a repair
	if (not needRepair) then return end

	-- check how much money we have
	local gold = GetMoney()

	-- repair if we have enough gold
	if (gold > rawAmount) then

		-- repair, at last
		RepairAllItems()

		-- format the output string depending upon user selected Colour Blind Mode
		local moneyString
		if (GetCVar("colorblindMode") == "0") then
			moneyString = GetCoinTextureString(rawAmount)
		else
			moneyString = GetCoinText(rawAmount)
		end

		-- tell me the wipe cost
		self:MessageOutput(string.format("Repaired for %s", moneyString))

	else
		-- someone haxxored my goldz?
		self:MessageOutput("Cannot afford to repair!")
	end

end

-- handle the "MERCHANT_SHOW" event
EPRepair:SetScript("OnEvent", function(self, event, ...)
	self:RepairMe()
end)
