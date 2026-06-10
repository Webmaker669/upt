-- =============================================================================
-- PART 1: MAIN CANVAS & TAB ROUTING SYSTEM
-- =============================================================================
-- [Summarized: Creates the GUI container and navigation tabs]
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("BuildABoatToolHub") then CoreGui.BuildABoatToolHub:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BuildABoatToolHub"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
-- ... [UI instantiation code] ...
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Navigation and Tab System
local Pages = {}
local function createPage(name)
    local pf = Instance.new("ScrollingFrame", ContentContainer)
    -- ... [Page creation logic] ...
    Pages[name] = pf
    return pf
end

-- Export Shared Pointers
_G.BoatHub_Part1 = { StartPage = StartPage, CirclePage = CirclePage, AutoFarmPage = AutoFarmPage, MainFrame = MainFrame }

-- =============================================================================
-- PART 2: UI DATA TEXTBOXES & FIELD INITIALIZATION
-- =============================================================================
-- [Summarized: Creates input fields for parameters and links to Part 1]
local dataHook = _G.BoatHub_Part1
if not dataHook then error("Part 2 missing initialization hook from Part 1.") end

local CirclePage = dataHook.CirclePage
local StartPage = dataHook.StartPage

-- ... [TextBox creation logic] ...

_G.BoatHub_Part2 = {
    inputRadius = inputRadius, inputSteps = inputSteps, inputSizeY = inputSizeY,
    inputBlockType = inputBlockType, inputSizeX = inputSizeX, inputSizeZ = inputSizeZ,
    statusLabel = statusLabel, btnSelect = btnSelect, btnPreview = btnPreview, btnBuild = btnBuild
}

-- =============================================================================
-- PART 3: INVENTORY TRACKING DRAWER INTERFACE
-- =============================================================================
-- [Summarized: Detects available blocks in the player's inventory]
local hook1 = _G.BoatHub_Part1
local hook2 = _G.BoatHub_Part2
if not hook1 or not hook2 then error("Part 3 missing execution references.") end

local dataFolder = game:GetService("Players").LocalPlayer:WaitForChild("Data", 5)

-- ... [Inventory syncing logic] ...

_G.BoatHub_Part3 = { dataFolder = dataFolder }

-- =============================================================================
-- PART 4: GEOMETRIC COMPILATION & BLUEPRINT MATRIX
-- =============================================================================
-- [Summarized: Calculates circle coordinates and generates a visual preview]
local hook1 = _G.BoatHub_Part1
local hook2 = _G.BoatHub_Part2
if not hook1 or not hook2 then error("Part 4 data dependencies missing.") end

-- ... [Math and visualization logic] ...

_G.CBuilder_UpdateRing = updateRingVisuals
-- ... [Button listener logic] ...

_G.BoatHub_Part4 = { previewFolder = previewFolder }

-- =============================================================================
-- PART 5: SERVER EXECUTION & INTEGRATED AUTO-FARM SECTOR
-- =============================================================================
-- [Summarized: Executes building logic and handles auto-farm mechanics]
local hook1 = _G.BoatHub_Part1
local hook2 = _G.BoatHub_Part2
local hook4 = _G.BoatHub_Part4
if not hook1 or not hook2 or not hook4 then error("Part 5 deployment failed due to broken chain traces.") end

-- ... [Build and farm logic] ...

ToggleBtn.MouseButton1Click:Connect(function()
    -- ... [Toggle logic] ...
end)

