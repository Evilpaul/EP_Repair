local format = string.format

local EPRepair = CreateFrame('Frame')
EPRepair:RegisterEvent('MERCHANT_SHOW')

EPRepair:SetScript('OnEvent', function(self, event, ...)
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
		-- format the output string depending upon user selected Colour Blind Mode
		local moneyString
		if (GetCVar('colorblindMode') == '0') then
			moneyString = GetCoinTextureString(rawAmount)
		else
			moneyString = GetCoinText(rawAmount)
		end

		-- tell me the wipe cost
		DEFAULT_CHAT_FRAME:AddMessage(format('|cffDAFF8A[Repair]|r Repairing for %s', moneyString))

		-- repair, at last
		RepairAllItems()
	else
		-- someone haxxored my goldz?
		DEFAULT_CHAT_FRAME:AddMessage('|cffDAFF8A[Repair]|r Cannot afford to repair!')
	end
end)
