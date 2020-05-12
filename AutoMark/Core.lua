-- Variables
local status = false;
local marks = {
	false, -- STAR
	false, -- Circle
	false, -- Diamond
	false, -- Traingle
	false, -- Moon
	false, -- Square
	false, -- Cross
	false, -- Skull
}

local marksAllowed = {
	false, -- STAR
	false, -- Circle
	false, -- Diamond
	false, -- Traingle
	false, -- Moon
	false, -- Square
	false, -- Cross
	false, -- Skull
}

local markGUID = {} -- Contains the GUID of the marked targets
local marksText = {} -- Contains the Names of the marked targets
local namesToMark = { -- Contains the names to check against
	"Guardian of Yogg-Saron"
}

local ubase;
local _debug;

-- Frame and moveable Functionality
UIConfig = CreateFrame("Frame", "AutoMark_ButtonFrame", UIParent, "UIPanelDialogTemplate");
UIConfig:SetSize(220,360); -- Width, Height
UIConfig:SetPoint("CENTER", UIParent, "CENTER");

--Frame Movability
UIConfig:SetMovable(true)
UIConfig:EnableMouse(true)
UIConfig:RegisterForDrag("LeftButton")
UIConfig:SetScript("OnDragStart", UIConfig.StartMoving)
UIConfig:SetScript("OnDragStop", UIConfig.StopMovingOrSizing)

--[[ Child Regions ]]

	--[[ TEXTS ]]
		-- Title Text
			UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.title:SetFontObject("GameFontHighlight");
			UIConfig.title:SetPoint("TOP", UIConfig, "TOP", 0, -10);
			UIConfig.title:SetText("Vollmer's AutoMarker");

		-- Static Status Text
			UIConfig.statusText = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.statusText:SetFontObject("GameFontHighlight");
			UIConfig.statusText:SetPoint("BOTTOMLEFT", UIConfig.title, "BOTTOMLEFT", 0, -25);
			UIConfig.statusText:SetText("STATUS:");

		-- Dynamic Status Text
			UIConfig.dynStatusText = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.dynStatusText:SetFontObject("GameFontHighlight");
			UIConfig.dynStatusText:SetPoint("LEFT", UIConfig.statusText, "RIGHT", 0, 0);
			UIConfig.dynStatusText:SetText("INACTIVE");

		-- Mark Boxes
			UIConfig.markBtn1 = CreateFrame("CheckButton", "UIConfig.markBtn1_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.markBtn1:SetPoint("LEFT", UIConfig, "LEFT", 10, 10);
			getglobal(UIConfig.markBtn1:GetName() .. "Text"):SetText("");
			UIConfig.markBtn1:SetSize(20,20);
			UIConfig.markBtn1:SetScript("onClick", function(self, evevnt, arg1)
				if self:GetChecked() then
					marksAllowed[1] = true
				else
					marksAllowed[1] = false
				end
			end)

			UIConfig.markBtn2 = CreateFrame("CheckButton", "UIConfig.markBtn2_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.markBtn2:SetPoint("BOTTOM", UIConfig.markBtn1, "BOTTOM", 0, -15);
			getglobal(UIConfig.markBtn2:GetName() .. "Text"):SetText("");
			UIConfig.markBtn2:SetSize(20,20);
			UIConfig.markBtn2:SetScript("onClick", function(self, evevnt, arg1)
				if self:GetChecked() then
					marksAllowed[2] = true
				else
					marksAllowed[2] = false
				end
			end)

			UIConfig.markBtn3 = CreateFrame("CheckButton", "UIConfig.markBtn3_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.markBtn3:SetPoint("BOTTOM", UIConfig.markBtn2, "BOTTOM", 0, -15);
			getglobal(UIConfig.markBtn3:GetName() .. "Text"):SetText("");
			UIConfig.markBtn3:SetSize(20,20);
			UIConfig.markBtn3:SetScript("onClick", function(self, evevnt, arg1)
				if self:GetChecked() then
					marksAllowed[3] = true
				else
					marksAllowed[3] = false
				end
			end)

			UIConfig.markBtn4 = CreateFrame("CheckButton", "UIConfig.markBtn4_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.markBtn4:SetPoint("BOTTOM", UIConfig.markBtn3, "BOTTOM", 0, -15);
			getglobal(UIConfig.markBtn4:GetName() .. "Text"):SetText("");
			UIConfig.markBtn4:SetSize(20,20);
			UIConfig.markBtn4:SetScript("onClick", function(self, evevnt, arg1)
				if self:GetChecked() then
					marksAllowed[4] = true
				else
					marksAllowed[4] = false
				end
			end)

			UIConfig.markBtn5 = CreateFrame("CheckButton", "UIConfig.markBtn5_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.markBtn5:SetPoint("BOTTOM", UIConfig.markBtn4, "BOTTOM", 0, -15);
			getglobal(UIConfig.markBtn5:GetName() .. "Text"):SetText("");
			UIConfig.markBtn5:SetSize(20,20);
			UIConfig.markBtn5:SetScript("onClick", function(self, evevnt, arg1)
				if self:GetChecked() then
					marksAllowed[5] = true
				else
					marksAllowed[5] = false
				end
			end)

			UIConfig.markBtn6 = CreateFrame("CheckButton", "UIConfig.markBtn6_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.markBtn6:SetPoint("BOTTOM", UIConfig.markBtn5, "BOTTOM", 0, -15);
			getglobal(UIConfig.markBtn6:GetName() .. "Text"):SetText("");
			UIConfig.markBtn6:SetSize(20,20);
			UIConfig.markBtn6:SetScript("onClick", function(self, evevnt, arg1)
				if self:GetChecked() then
					marksAllowed[6] = true
				else
					marksAllowed[6] = false
				end
			end)

			UIConfig.markBtn7 = CreateFrame("CheckButton", "UIConfig.markBtn7_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.markBtn7:SetPoint("BOTTOM", UIConfig.markBtn6, "BOTTOM", 0, -15);
			getglobal(UIConfig.markBtn7:GetName() .. "Text"):SetText("");
			UIConfig.markBtn7:SetSize(20,20);
			UIConfig.markBtn7:SetScript("onClick", function(self, evevnt, arg1)
				if self:GetChecked() then
					marksAllowed[7] = true
				else
					marksAllowed[7] = false
				end
			end)

			UIConfig.markBtn8 = CreateFrame("CheckButton", "UIConfig.markBtn8_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.markBtn8:SetPoint("BOTTOM", UIConfig.markBtn7, "BOTTOM", 0, -15);
			getglobal(UIConfig.markBtn8:GetName() .. "Text"):SetText("");
			UIConfig.markBtn8:SetSize(20,20);
			UIConfig.markBtn8:SetScript("onClick", function(self, evevnt, arg1)
				if self:GetChecked() then
					marksAllowed[8] = true
				else
					marksAllowed[8] = false
				end
			end)

		--Mark Text
			UIConfig.mark1 = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.mark1:SetFontObject("GameFontHighlight");
			UIConfig.mark1:SetPoint("LEFT", UIConfig.markBtn1, "LEFT", 20, 0);
			UIConfig.mark1:SetText("Mark 1:");

			UIConfig.mark2 = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.mark2:SetFontObject("GameFontHighlight");
			UIConfig.mark2:SetPoint("LEFT", UIConfig.markBtn2, "LEFT", 20, 0);
			UIConfig.mark2:SetText("Mark 1:");

			UIConfig.mark3 = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.mark3:SetFontObject("GameFontHighlight");
			UIConfig.mark3:SetPoint("LEFT", UIConfig.markBtn3, "LEFT", 20, 0);
			UIConfig.mark3:SetText("Mark 1:");

			UIConfig.mark4 = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.mark4:SetFontObject("GameFontHighlight");
			UIConfig.mark4:SetPoint("LEFT", UIConfig.markBtn4, "LEFT", 20, 0);
			UIConfig.mark4:SetText("Mark 1:");

			UIConfig.mark5 = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.mark5:SetFontObject("GameFontHighlight");
			UIConfig.mark5:SetPoint("LEFT", UIConfig.markBtn5, "LEFT", 20, 0);
			UIConfig.mark5:SetText("Mark 1:");

			UIConfig.mark6 = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.mark6:SetFontObject("GameFontHighlight");
			UIConfig.mark6:SetPoint("LEFT", UIConfig.markBtn6, "LEFT", 20, 0);
			UIConfig.mark6:SetText("Mark 1:");

			UIConfig.mark7 = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.mark7:SetFontObject("GameFontHighlight");
			UIConfig.mark7:SetPoint("LEFT", UIConfig.markBtn7, "LEFT", 20, 0);
			UIConfig.mark7:SetText("Mark 1:");

			UIConfig.mark8 = UIConfig:CreateFontString(nil, "OVERLAY");
			UIConfig.mark8:SetFontObject("GameFontHighlight");
			UIConfig.mark8:SetPoint("LEFT", UIConfig.markBtn8, "LEFT", 20, 0);
			UIConfig.mark8:SetText("Mark 1:");

		-- Input Box
			UIConfig.editBox = CreateFrame("EditBox", "UIConfig.editBox", UIConfig, "InputBoxTemplate");
			UIConfig.editBox:SetPoint("BOTTOM", UIConfig, "BOTTOM", 0, 45);
			UIConfig.editBox:SetSize(180, 20);
			UIConfig.editBox:SetAutoFocus(false);
			UIConfig.editBox:SetMultiLine(false);

	--[[ BUTTONS ]]
	-- UI Start Button
		UIConfig.startButton = CreateFrame("BUTTON", nil, UIConfig, "GameMenuButtonTemplate");
		UIConfig.startButton:SetPoint("RIGHT", UIConfig, "TOP", 0, -70);
		UIConfig.startButton:SetSize(100,30); -- Width, Height
		UIConfig.startButton:SetText("Start");
		UIConfig.startButton:SetNormalFontObject("GameFontNormalLarge");
		UIConfig.startButton:SetHighlightFontObject("GameFontHighlightLarge");
		UIConfig.startButton:SetScript("OnClick", function()
			UIConfig.dynStatusText:SetText("ACTIVE")
			if status == false then
				if #namesToMark > 0 then
					local textInt = #namesToMark
				else
					local textInt = 1
				end
			end
			local str = UIConfig.editBox:GetText(); -- Add input box names Case sensitive and space sensitive
			for word in str:gmatch('[^,]+') do
				namesToMark[textInt] = word
				textInt = textInt + 1
			end
			status = true
			if #namesToMark > 0 then
				print("Marking Targets named:") -- print out names to check against for safety
				for k=1, #namesToMark do
					print(namesToMark[k]);
				end
			else
				print("Nothing to check against.")
			end
			ubase = IsInRaid() and "raid" or "party" -- Set party or raid base
		end)

	-- UI Stop Button
		UIConfig.stopButton = CreateFrame("BUTTON", nil, UIConfig, "GameMenuButtonTemplate");
		UIConfig.stopButton:SetPoint("LEFT", UIConfig, "TOP", 0, -70);
		UIConfig.stopButton:SetSize(100,30); -- Width, Height
		UIConfig.stopButton:SetText("Stop");
		UIConfig.stopButton:SetNormalFontObject("GameFontNormalLarge");
		UIConfig.stopButton:SetHighlightFontObject("GameFontHighlightLarge");
		UIConfig.stopButton:SetScript("OnClick", function()
			status = false
			UIConfig.dynStatusText:SetText("INACTIVE")
		end)

	-- UI Reset Button
		UIConfig.resetButton = CreateFrame("BUTTON", nil, UIConfig, "GameMenuButtonTemplate");
		UIConfig.resetButton:SetPoint("RIGHT", UIConfig.stopButton, "TOP", 0, -70);
		UIConfig.resetButton:SetSize(100,30); -- Width, Height
		UIConfig.resetButton:SetText("Reset");
		UIConfig.resetButton:SetNormalFontObject("GameFontNormalLarge");
		UIConfig.resetButton:SetHighlightFontObject("GameFontHighlightLarge");
		UIConfig.resetButton:SetScript("OnClick", function()
			for i=1,8 do
				marks[i] = false;
				marksText[i] = "Inactive";
				markGUID[i] = 0;
			end
			local ubase = IsInRaid() and "raid" or "party"
			for i=1,GetNumGroupMembers() do -- Run loop for each raid/party member
				if UnitExists(ubase..i.."target") and (not UnitIsPlayer(ubase..i.."target")) then -- If target exists, else ignore
					SetRaidTarget(ubase..i.."target", 0) -- Try to remove marks for raidmembers targets
				end
			end

			status = false
			UIConfig.dynStatusText:SetText("INACTIVE")
		end)

	--[[ CHECK BUTTONS ]]
		-- Check Button 1
			UIConfig.checkBtn1 = CreateFrame("CheckButton", "UIConfig.checkBtn1_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.checkBtn1:SetPoint("BOTTOMLEFT", UIConfig, "BOTTOMLEFT", 5, 5);
			getglobal(UIConfig.checkBtn1:GetName() .. "Text"):SetText("Check Names");
		-- Check Button 2
			UIConfig.checkBtn2 = CreateFrame("CheckButton", "UIConfig.checkBtn2_GlobalName", UIConfig, "UICheckButtonTemplate");
			UIConfig.checkBtn2:SetPoint("BOTTOMRIGHT", UIConfig, "BOTTOMRIGHT", -40, 5);
			getglobal(UIConfig.checkBtn2:GetName() .. "Text"):SetText("Debug");

for j=1,8 do
	if marks[j] == true then
		marksText[j] = "Active"
	else
		marksText[j] = "Inactive"
	end
end

local f = CreateFrame("Frame");
function f:onUpdate(sinceLastUpdate)
	self.sinceLastUpdate = (self.sinceLastUpdate or 0) + sinceLastUpdate;
	if(self.sinceLastUpdate >= 0.2) then -- in seconds

		if UIConfig.checkBtn2:GetChecked() then
			_debug = true
		else 
			_debug = false
		end

		UIConfig.mark1:SetText("Star: "		..marksText[1]);
		UIConfig.mark2:SetText("Nipple: "	..marksText[2]);
		UIConfig.mark3:SetText("Diamond: "	..marksText[3]);
		UIConfig.mark4:SetText("Triangle: "	..marksText[4]);
		UIConfig.mark5:SetText("Moon: "		..marksText[5]);
		UIConfig.mark6:SetText("Square: "	..marksText[6]);
		UIConfig.mark7:SetText("Cross: "	..marksText[7]);
		UIConfig.mark8:SetText("Skull: "	..marksText[8]);

		ubase = IsInRaid() and "raid" or "party" -- Set party or raid base

		if status then -- If Start button has been pressed
			-- Check Own Target
			if UnitExists("target") then
				refinedCheckTarget("target");
			end

			-- Check Mouseover
			if UnitExists("mouseover")  then
				refinedCheckTarget("mouseover");
			end

			-- Check Raids Target
			for i=1,GetNumGroupMembers() do -- Run loop for each raid/party member
				if UnitExists(ubase..i.."target") then
					refinedCheckTarget(ubase..i.."target")
				end
			end
		end
		self.sinceLastUpdate = 0;
	end
end

function checkName(targetToCheck)
	-- If checkbutton is enabled check for name on list.
	if UIConfig.checkBtn1:GetChecked() then
		for i=1, #namesToMark do
			if UnitName(targetToCheck) == namesToMark[i] then
				return true
			end
		end
	else -- If checkbutton is not enabled return true
		return true
	end

	-- If name is not on the list we will end up here and return false
	return false
end

function refinedCheckTarget(targetToCheck)
	local markToUse = nil
-----------#Figure out if the target is supposed to get marked#---------------
	-- Don't mark already marked things
	if GetRaidTargetIndex(targetToCheck) ~= nil then
		return
	end
	-- Don't mark players
	if UnitIsPlayer(targetToCheck) then
		if _debug then
			--print("|cFFFF0000Can't mark players.")
		end
		return
	end
	-- Don't mark dead things.
	if UnitIsDead(targetToCheck) then
		if _debug then
			--print("|cFFFF0000Target ".. UnitName(targetToCheck) .. " is dead.")
		end
		return
	end
	-- Don't mark a GUID twice.
	for i=1, #markGUID do
		if UnitGUID(targetToCheck) == markGUID[i] then
			if _debug then
				print("|cFFFF0000This GUID has allready been marked once: "..GetUnitName(targetToCheck).."!")
			end
			return
		end
	end
	-- run checkName() function to see if the name is on the checklist
	if not checkName(targetToCheck) then 
		if _debug then
			print("|cFFFF0000Target ".. UnitName(targetToCheck) .. " not on check list.")
		end
		return 
	end
---------------------------------------------------------------------
	-- Figure out if a mark is free
	for i=1, 8 do
		if (not marks[i]) and (marksAllowed[i]) then
			markToUse = i
			break
		end
	end
	-- If a mark is availible mark the target and set mark as used and store GUID.
	if markToUse ~= nil then
		SetRaidTarget(targetToCheck, markToUse)
		marks[markToUse] = true; -- Set mark as used
		marksText[markToUse] = GetUnitName(targetToCheck); -- Set Name of marked target
		markGUID[markToUse] = UnitGUID(targetToCheck); -- Set GUID of marked target so we can check combat log later for targets death
		if _debug then
			print("|cFF00FF00Marked: "..GetUnitName(targetToCheck).." with mark: "..markToUse.."!")
		end
	else -- If no mark availible
		if _debug then
			print("|cFFFF0000No mark availible for target: "..GetUnitName(targetToCheck).."!")
		end
		return
	end
	return
end

f:SetScript("OnUpdate", f.onUpdate)

-------------#CHECK COMBAT LOG IF A MARKED UNIT HAS DIED#---------------------------
local f2 = CreateFrame("Frame")
f2:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f2:SetScript("OnEvent", function(self, event, timestamp, subevent, SourceGUID, sourceName, sourceFlags, destGUID, destName, ...)
	if subevent == "UNIT_DIED" then 
		for i=1, #markGUID do
			if markGUID[i] == destGUID then
				if _debug then
					print("|cFFFFFF00" .. destName .. " died! Clearing mark: " .. i)
				end
				marks[i] = false; -- Set mark as availible
				marksText[i] = "Inactive" -- Set mark text as inactive
				markGUID[i] = nil; -- Remove GUID incase the same GUID could show up later and disrubt
			end
		end
	end	
end)
---------------------------#DEBUGGING FUNCTIONS#-----------------------------
function showMarks()
	for i=1,#marks do
		if marks[i] then
			print("|cFFFF0000mark "..i.." is: taken")
		else
			print("|cFF00FF00mark "..i.." is: free")
		end
	end
end
--------------------------#SLASH COMMANDS#----------------------------------
SLASH_AUTOMARK1 = "/am"
SlashCmdList["AUTOMARK"] = function(msg)
	UIConfig:Show();
end