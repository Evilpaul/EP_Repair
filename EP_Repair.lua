local EPRepair = CreateFrame("Frame"); -- create our frame
EPRepair:RegisterEvent("MERCHANT_SHOW"); -- we care about this event, so register

-- routine to output some string preceded by the formatted addon name
function EPRepair:MessageOutput(inputMessage)
	ChatFrame1:AddMessage(string.format("|cffDAFF8A[Repair]|r %s", inputMessage));
end;

-- convert raw money amount into gold, silver and copper amount and output to screen
function EPRepair:PrintMoney(money)
	money = math.floor(money);
	local copper = money % 100;
	money = math.floor(money / 100);
	local silver = money % 100;
	money = math.floor(money / 100);
	local gold = money;

	self:MessageOutput(string.format("Repaired for %d|cffd3c63ag|r %d|cffb0b0b0s|r %d|cffb2734ac|r", gold, silver, copper));
end

-- general check on viability of repair
function EPRepair:RepairMe()

	-- only continue if we talk to a repair guy
	if not CanMerchantRepair() then return; end;

	-- find the repair cost and if we need to repair
	local rawAmount, needRepair = GetRepairAllCost();

	-- only continue if we actually need a repair
	if (not needRepair) then return; end;

	-- check how much money we have
	local gold = GetMoney();

	-- repair if we have enough gold
	if (gold > rawAmount) then

		-- repair, at last
		RepairAllItems();

		-- tell me the wipe cost
		self:PrintMoney(rawAmount);
	else
		-- someone haxxored my goldz?
		self:MessageOutput("Cannot afford to repair!");
	end;

end;

-- handle the "MERCHANT_SHOW" event
EPRepair:SetScript("OnEvent", function(self, event, addon)
	self:RepairMe();
end);
