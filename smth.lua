-- =============================================================================
-- PART 1: GLOBAL FRAMEWORK INITIALIZATION
-- =============================================================================
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("BuildABoatToolHub") then
    CoreGui.BuildABoatToolHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BuildABoatToolHub"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 420) -- Formatted canvas ratio matching custom layout image
MainFrame.Position = UDim2.new(0.5, -260, 0.4, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(128, 128, 128) -- Master gray panel backdrop palette
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local ReopenButton = Instance.new("TextButton", ScreenGui)
ReopenButton.Size = UDim2.new(0, 140, 0, 40)
ReopenButton.Position = UDim2.new(0, 15, 0.85, 0)
ReopenButton.Text = "Open Tool Hub"
ReopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenButton.BackgroundColor3 = Color3.fromRGB(56, 56, 62)
ReopenButton.Font = Enum.Font.GothamBold
ReopenButton.TextSize = 13
ReopenButton.Visible = false
Instance.new("UICorner", ReopenButton).CornerRadius = UDim.new(0, 6)

local HeaderFrame = Instance.new("Frame", MainFrame)
HeaderFrame.Size = UDim2.new(1, 0, 0, 50)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- Dark header band tracking
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 12)

local HeaderFix = Instance.new("Frame", HeaderFrame)
HeaderFix.Size = UDim2.new(1, 0, 0, 15)
HeaderFix.Position = UDim2.new(0, 0, 1, -15)
HeaderFix.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
HeaderFix.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", HeaderFrame)
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Text = "BUILD A BOAT TOOL HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", HeaderFrame)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -14)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(240, 60, 60)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 14)

local SidebarFrame = Instance.new("Frame", MainFrame)
SidebarFrame.Size = UDim2.new(0, 110, 1, -50)
SidebarFrame.Position = UDim2.new(0, 0, 0, 50)
SidebarFrame.BackgroundColor3 = Color3.fromRGB(65, 65, 65) -- Dark contrast tab anchor stripe
Instance.new("UICorner", SidebarFrame).CornerRadius = UDim.new(0, 12)

local SidebarFix = Instance.new("Frame", SidebarFrame)
SidebarFix.Size = UDim2.new(0, 20, 1, 0)
SidebarFix.Position = UDim2.new(1, -20, 0, 0)
SidebarFix.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
SidebarFix.BorderSizePixel = 0

local NavListLayout = Instance.new("UIListLayout", SidebarFrame)
NavListLayout.Padding = UDim.new(0, 8)
NavListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
NavListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local NavPadding = Instance.new("UIPadding", SidebarFrame)
NavPadding.PaddingTop = UDim.new(0, 15)

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -110, 1, -50)
ContentContainer.Position = UDim2.new(0, 110, 0, 50)
ContentContainer.BackgroundTransparency = 1

local Pages = {}
local function createPage(name)
    local pf = Instance.new("ScrollingFrame", ContentContainer)
    pf.Name = name .. "Page"
    pf.Size = UDim2.new(1, 0, 1, 0)
    pf.BackgroundTransparency = 1
    pf.Visible = false
    pf.ScrollBarThickness = 4
    pf.CanvasSize = UDim2.new(0, 0, 0, 0)
    pf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Pages[name] = pf
    return pf
end

local StartPage = createPage("Start")
local CirclePage = createPage("Circle")
local AutoFarmPage = createPage("AutoFarm")

local activeTabBtn = nil
local function switchTab(name, button)
    for _, page in pairs(Pages) do page.Visible = false end
    Pages[name].Visible = true
    if activeTabBtn then activeTabBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 85) end
    activeTabBtn = button
    activeTabBtn.BackgroundColor3 = Color3.fromRGB(45, 120, 210)
end

local function addTabButton(text, targetPageName, order)
    local btn = Instance.new("TextButton", SidebarFrame)
    btn.Size = UDim2.new(0, 90, 0, 32)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 85)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.LayoutOrder = order
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function() switchTab(targetPageName, btn) end)
    return btn
end

local startTabBtn = addTabButton("Hub Home", "Start", 1)
local circleTabBtn = addTabButton("Circle", "Circle", 2)
local farmTabBtn = addTabButton("Auto Farm", "AutoFarm", 3)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false ReopenButton.Visible = true end)
ReopenButton.MouseButton1Click:Connect(function() MainFrame.Visible = true ReopenButton.Visible = false end)

switchTab("Start", startTabBtn)

local function addInput(labelText, yPos, defaultValue, editable)
    local lbl = Instance.new("TextLabel", CirclePage)
    lbl.Size = UDim2.new(0, 150, 0, 28)
    lbl.Position = UDim2.new(0, 15, 0, yPos)
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(230, 230, 235)
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    
    local box = Instance.new("TextBox", CirclePage)
    box.Size = UDim2.new(0, 130, 0, 28)
    box.Position = UDim2.new(0, 175, 0, yPos)
    box.Text = defaultValue
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 13
    box.TextEditable = editable
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    return box
end

local inputRadius = addInput("Circle Radius / Range:", 20, "20", true)
local inputSteps = addInput("Total Parts Count:", 55, "30", true)
local inputSizeY = addInput("Block Height (Y):", 90, "2", true)
local inputBlockType = addInput("Active Block Type:", 125, "PlasticBlock", true)
local inputSizeX = addInput("Calculated Width (X):", 160, "0.00", false)
local inputSizeZ = addInput("Calculated Depth (Z):", 195, "0.00", false)

_G.CBuilder_CoreUI = {
    MainFrame = MainFrame, ScreenGui = ScreenGui, ReopenButton = ReopenButton, CloseBtn = CloseBtn,
    inputRadius = inputRadius, inputSteps = inputSteps, inputSizeY = inputSizeY,
    inputBlockType = inputBlockType, inputSizeX = inputSizeX, inputSizeZ = inputSizeZ,
    StartPage = StartPage, CirclePage = CirclePage, AutoFarmPage = AutoFarmPage
}
-- // END OF FILE: Part_1.lua //

-- =============================================================================
-- PART 2: CONTROL SECTOR & STATUS SYSTEM
-- =============================================================================
local core = _G.CBuilder_CoreUI
if not core then error("Sequence Interrupted: Part 1 missing from environment.") end

local CirclePage = core.CirclePage
local StartPage = core.StartPage

-- Home / Start Page Info Layout Configuration
local HomeTitle = Instance.new("TextLabel", StartPage)
HomeTitle.Size = UDim2.new(1, -30, 0, 30)
HomeTitle.Position = UDim2.new(0, 15, 0, 20)
HomeTitle.Text = "Welcome to the Integrated Tool Hub"
HomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeTitle.Font = Enum.Font.GothamBold
HomeTitle.TextSize = 16
HomeTitle.BackgroundTransparency = 1
HomeTitle.TextXAlignment = Enum.TextXAlignment.Left

local DiscDesc = Instance.new("TextLabel", StartPage)
DiscDesc.Size = UDim2.new(1, -30, 0, 40)
DiscDesc.Position = UDim2.new(0, 15, 0, 55)
DiscDesc.Text = "Join our community development tracker using the secure clipboard link panel below:"
DiscDesc.TextColor3 = Color3.fromRGB(220, 220, 225)
DiscDesc.Font = Enum.Font.Gotham
DiscDesc.TextSize = 12
DiscDesc.TextWrapped = true
DiscDesc.BackgroundTransparency = 1
DiscDesc.TextXAlignment = Enum.TextXAlignment.Left

local CopyBox = Instance.new("TextBox", StartPage)
CopyBox.Size = UDim2.new(1, -30, 0, 36)
CopyBox.Position = UDim2.new(0, 15, 0, 110)
CopyBox.Text = "https://discord.com"
CopyBox.TextColor3 = Color3.fromRGB(114, 137, 218)
CopyBox.BackgroundColor3 = Color3.fromRGB(44, 47, 51)
CopyBox.Font = Enum.Font.GothamBold
CopyBox.TextSize = 12
CopyBox.ClearTextOnFocus = false
CopyBox.TextEditable = false
Instance.new("UICorner", CopyBox).CornerRadius = UDim.new(0, 6)

-- Circle Builder Control Canvas Items
local statusLabel = Instance.new("TextLabel", CirclePage)
statusLabel.Size = UDim2.new(1, -30, 0, 30)
statusLabel.Position = UDim2.new(0, 15, 0, 235)
statusLabel.Text = "Center Target Block: Not Selected"
statusLabel.TextColor3 = Color3.fromRGB(240, 90, 90)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.BackgroundTransparency = 1

local function createButton(text, yPos, color)
    local btn = Instance.new("TextButton", CirclePage)
    btn.Size = UDim2.new(1, -30, 0, 32)
    btn.Position = UDim2.new(0, 15, 0, yPos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = color
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local btnSelect = createButton("Select Center Target Block", 270, Color3.fromRGB(0, 122, 215))
local btnPreview = createButton("Hologram Preview Configuration: Disabled", 310, Color3.fromRGB(110, 110, 115))
local btnBuild = createButton("Commence Circle Construction", 350, Color3.fromRGB(46, 139, 87))

_G.CBuilder_Buttons = {
    statusLabel = statusLabel, btnSelect = btnSelect, btnPreview = btnPreview, btnBuild = btnBuild
}
-- // END OF FILE: Part_2.lua //

-- =============================================================================
-- PART 3: INVENTORY DRAWER POPUP AND SELECTION SYSTEM
-- =============================================================================
local core = _G.CBuilder_CoreUI
local buttons = _G.CBuilder_Buttons
if not core or not buttons then error("Sequence Interrupted: Part 2 tracking missing.") end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local dataFolder = LocalPlayer:WaitForChild("Data", 5)

local MainFrame = core.MainFrame
local CirclePage = core.CirclePage
local inputBlockType = core.inputBlockType

local BlockPanel = Instance.new("Frame", CirclePage)
BlockPanel.Size = UDim2.new(1, -30, 0, 180)
BlockPanel.Position = UDim2.new(0, 15, 0, 160)
BlockPanel.BackgroundColor3 = Color3.fromRGB(34, 34, 38)
BlockPanel.ZIndex = 5
BlockPanel.Visible = false
Instance.new("UICorner", BlockPanel).CornerRadius = UDim.new(0, 10)

local PanelTitle = Instance.new("TextLabel", BlockPanel)
PanelTitle.Size = UDim2.new(1, 0, 0, 30)
PanelTitle.Text = "AVAILABLE BUILDING MATERIALS"
PanelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PanelTitle.Font = Enum.Font.GothamBold
PanelTitle.BackgroundColor3 = Color3.fromRGB(44, 44, 50)
PanelTitle.TextSize = 11

local ScrollingFrame = Instance.new("ScrollingFrame", BlockPanel)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -40)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 35)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.SortOrder = Enum.SortOrder.Name

inputBlockType.Focused:Connect(function() BlockPanel.Visible = true end)

local function updateInventoryLayout()
    for _, child in ipairs(ScrollingFrame:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    if not dataFolder then return end
    
    for _, item in ipairs(dataFolder:GetChildren()) do
        if item:IsA("ValueBase") and item.Value > 0 and not string.find(item.Name, "Tool") then
            local itemBtn = Instance.new("TextButton", ScrollingFrame)
            itemBtn.Size = UDim2.new(1, -5, 0, 26)
            itemBtn.Text = " " .. item.Name .. " (" .. tostring(item.Value) .. ")"
            itemBtn.TextColor3 = Color3.fromRGB(190, 190, 195)
            itemBtn.BackgroundColor3 = Color3.fromRGB(44, 44, 50)
            itemBtn.Font = Enum.Font.GothamSemibold
            itemBtn.TextSize = 11
            itemBtn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", itemBtn).CornerRadius = UDim.new(0, 4)
            
            itemBtn.MouseButton1Click:Connect(function()
                inputBlockType.Text = item.Name
                BlockPanel.Visible = false
                if _G.CBuilder_UpdateRing then _G.CBuilder_UpdateRing() end
            end)
        end
    end
end

if dataFolder then
    updateInventoryLayout()
    dataFolder.ChildAdded:Connect(updateInventoryLayout)
    dataFolder.ChildRemoved:Connect(updateInventoryLayout)
end

_G.CBuilder_Inventory = { BlockPanel = BlockPanel, dataFolder = dataFolder }
-- // END OF FILE: Part_3.lua //

-- =============================================================================
-- PART 4: TARGET ANALYSIS & HOLOGRAM PREVIEW MATRIX
-- =============================================================================
local core = _G.CBuilder_CoreUI
local buttons = _G.CBuilder_Buttons
local invData = _G.CBuilder_Inventory
if not core or not buttons or not invData then error("Sequence Interrupted: Part 3 elements missing.") end

local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local inputRadius, inputSteps, inputSizeY, inputSizeX, inputSizeZ = core.inputRadius, core.inputSteps, core.inputSizeY, core.inputSizeX, core.inputSizeZ
local statusLabel, btnSelect, btnPreview = buttons.statusLabel, buttons.btnSelect, buttons.btnPreview

local previewFolder = workspace:FindFirstChild("CirclePreviewFolder") or Instance.new("Folder", workspace)
previewFolder.Name = "CirclePreviewFolder"

local selectionBox = Instance.new("SelectionBox", CoreGui)
selectionBox.Color3 = Color3.fromRGB(0, 255, 255)
selectionBox.LineThickness = 0.04

local isSelecting = false

local function updateRingVisuals()
    previewFolder:ClearAllChildren()
    if not _G.CBuilder_CenterPos then return end
    
    local radius = tonumber(inputRadius.Text) or 20
    local steps = tonumber(inputSteps.Text) or 30
    local sizeY = tonumber(inputSizeY.Text) or 2
    local sizeZ = (2 * math.pi * radius) / steps
    local sizeX = (2 * radius * math.tan(math.pi / steps)) + 0.02
    
    inputSizeX.Text, inputSizeZ.Text = string.format("%.3f", sizeX), string.format("%.3f", sizeZ)
    if not _G.CBuilder_LivePreview then return end
    
    for i = 1, steps do
        local angle = (i / steps) * math.pi * 2
        local p = Vector3.new(_G.CBuilder_CenterPos.X + math.cos(angle) * radius, _G.CBuilder_CenterPos.Y, _G.CBuilder_CenterPos.Z + math.sin(angle) * radius)
        local hp = Instance.new("Part", previewFolder)
        hp.Size = Vector3.new(sizeX, sizeY, sizeZ)
        hp.CFrame = CFrame.lookAt(p, _G.CBuilder_CenterPos)
        hp.Transparency = 0.6
        hp.Color = Color3.fromRGB(0, 255, 255)
        hp.Anchored = true
        hp.CanCollide = false
    end
end

_G.CBuilder_UpdateRing = updateRingVisuals
for _, box in ipairs({inputRadius, inputSteps, inputSizeY}) do box:GetPropertyChangedSignal("Text"):Connect(updateRingVisuals) end

btnSelect.MouseButton1Click:Connect(function()
    if isSelecting then return end isSelecting = true
    statusLabel.Text, btnSelect.Text = "Click any base block node...", "Awaiting Target..."
    
    local rConn, cConn
    rConn = RunService.RenderStepped:Connect(function() selectionBox.Adornee = Mouse.Target end)
    cConn = Mouse.Button1Down:Connect(function()
        local t = Mouse.Target
        if t and t:IsA("BasePart") then
            _G.CBuilder_CenterPos = t.Position
            statusLabel.Text = "Target Locked: " .. t.Name
            statusLabel.TextColor3 = Color3.fromRGB(80, 240, 80)
            rConn:Disconnect() cConn:Disconnect()
            selectionBox.Adornee = nil isSelecting = false
            btnSelect.Text = "Select Center Target Block" updateRingVisuals()
        end
    end)
end)

btnPreview.MouseButton1Click:Connect(function()
    _G.CBuilder_LivePreview = not _G.CBuilder_LivePreview
    btnPreview.Text = _G.CBuilder_LivePreview and "Preview Configuration: Active" or "Preview Configuration: Disabled"
    btnPreview.BackgroundColor3 = _G.CBuilder_LivePreview and Color3.fromRGB(155, 80, 180) or Color3.fromRGB(110, 110, 115)
    updateRingVisuals()
end)

_G.CBuilder_PipelineData = { previewFolder = previewFolder, folder = workspace:WaitForChild("Blocks", 5):WaitForChild(LocalPlayer.Name, 5) }
-- // END OF FILE: Part_4.lua //

-- =============================================================================
-- PART 5: SERVER REMOTE PLACEMENT NETWORK PIPES
-- =============================================================================
local core = _G.CBuilder_CoreUI
local buttons = _G.CBuilder_Buttons
local invData = _G.CBuilder_Inventory
local pipeline = _G.CBuilder_PipelineData
if not core or not buttons or not invData or not pipeline then error("Sequence Interrupted: Part 4 pipelines missing.") end

local LocalPlayer = game:GetService("Players").LocalPlayer
local inputRadius, inputSteps, inputSizeY, inputBlockType = core.inputRadius, core.inputSteps, core.inputSizeY, core.inputBlockType
local statusLabel, btnBuild = buttons.statusLabel, buttons.btnBuild
local dataFolder = invData.dataFolder
local previewFolder, folder = pipeline.previewFolder, pipeline.folder

btnBuild.MouseButton1Click:Connect(function()
    if not _G.CBuilder_CenterPos then return end
    local blockStr = tostring(inputBlockType.Text)
    local inventoryItem = dataFolder and dataFolder:FindFirstChild(blockStr)
    
    if not inventoryItem or inventoryItem.Value <= 0 then
        statusLabel.Text = "Build Failed: Out of Blocks!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        return
    end
    
    local radius = tonumber(inputRadius.Text) or 20
    local steps = tonumber(inputSteps.Text) or 30
    local sizeY = tonumber(inputSizeY.Text) or 2
    local sizeZ = (2 * math.pi * radius) / steps
    local sizeX = (2 * radius * math.tan(math.pi / steps)) + 0.02
    
    local function getRF(n)
        local tl = LocalPlayer.Backpack:FindFirstChild(n) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(n))
        return tl and tl:FindFirstChild("RF")
    end
    
    local bRF, sRF, pRF = getRF("BuildingTool"), getRF("ScalingTool"), getRF("PaintingTool")
    if not bRF or not sRF or not pRF then statusLabel.Text = "Missing Tools!" return end
    
    previewFolder:ClearAllChildren()
    btnBuild.Text, btnBuild.Active = "Constructing Active Sector Matrix...", false
    
    for i = 1, steps do
        if inventoryItem.Value <= 0 then break end
        local angle = (i / steps) * math.pi * 2
        local p = Vector3.new(_G.CBuilder_CenterPos.X + math.cos(angle) * radius, _G.CBuilder_CenterPos.Y, _G.CBuilder_CenterPos.Z + math.sin(angle) * radius)
        local pCF, hCF = CFrame.lookAt(p, _G.CBuilder_CenterPos), CFrame.new(p) * CFrame.Angles(0, angle, 0)
        local initialCount = #folder:GetChildren()
        
        bRF:InvokeServer(blockStr, inventoryItem.Value, Instance.new("Part", nil), pCF, true, hCF, false)
        
        local newBlock, loops = nil, 0
        while not newBlock and loops < 30 do
            task.wait(0.01)
            if #folder:GetChildren() > initialCount then newBlock = folder:GetChildren()[#folder:GetChildren()] end
            loops = loops + 1
        end
        
        if newBlock then
            sRF:InvokeServer(newBlock, Vector3.new(sizeX, sizeY, sizeZ), pCF)
            task.wait(0.01)
            pRF:InvokeServer({{{newBlock, Color3.new(1, 1, 1)}, {newBlock, Color3.new(1, 1, 1)}, {newBlock, Color3.new(1, 1, 1)}, {newBlock, Color3.new(1, 1, 1)}}})
        end
        task.wait(0.02)
    end
    
    btnBuild.Text, btnBuild.Active = "Commence Circle Construction", true
    statusLabel.Text = "Matrix Sequence Completed!"
    statusLabel.TextColor3 = Color3.fromRGB(80, 240, 80)
end)
-- // END OF FILE: Part_5.lua //

-- =============================================================================
-- PART 6: AUTOMATED STAGE FARM ENGINE
-- =============================================================================
local core = _G.CBuilder_CoreUI
if not core then error("Sequence Interrupted: Global UI framework mapping missing.") end

local Workspace = game:GetService("Workspace")
local LocalPlayer = game:GetService("Players").LocalPlayer
local AutoFarmPage = core.AutoFarmPage

local FarmTitle = Instance.new("TextLabel", AutoFarmPage)
FarmTitle.Size = UDim2.new(1, -30, 0, 30)
FarmTitle.Position = UDim2.new(0, 15, 0, 20)
FarmTitle.Text = "Automated Stage Progression Farm"
FarmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmTitle.Font = Enum.Font.GothamBold
FarmTitle.TextSize = 15
FarmTitle.BackgroundTransparency = 1
FarmTitle.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBtn = Instance.new("TextButton", AutoFarmPage)
ToggleBtn.Size = UDim2.new(1, -30, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 65)
ToggleBtn.Text = "Auto Stage Farm: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

local toggled, platform, loopThreadActive = false, nil, false

local function managePlatform(cframe)
    if not toggled then return end
    if not platform or not platform.Parent then
        platform = Instance.new("Part")
        platform.Name = "AntiFallPlatform"
        platform.Size = Vector3.new(12, 1, 12)
        platform.Material = Enum.Material.Glass
        platform.Transparency = 0.5
        platform.Color = Color3.fromRGB(0, 255, 255)
        platform.Anchored = true
        platform.CanCollide = true
        platform.Parent = Workspace
    end
    platform.CFrame = cframe * CFrame.new(0, -3.5, 0)
end

local function removePlatform() if platform then platform:Destroy() platform = nil end end
local function isCharacterReady()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    return char and hum and hrp and hum.Health > 0
end

local function runFarmCycle()
    if not toggled or loopThreadActive then return end
    loopThreadActive = true
    local normalStages = Workspace:FindFirstChild("BoatStages") and Workspace.BoatStages:FindFirstChild("NormalStages")
    if not normalStages then loopThreadActive = false return end
    
    for i = 1, 10 do
        if not toggled or not isCharacterReady() then break end
        local currentStage = normalStages:FindFirstChild("CaveStage" .. i)
        local targetPart = currentStage and currentStage:FindFirstChild("DarknessPart")
        if targetPart then
            ToggleBtn.Text = "Traveling: Stage " .. i
            managePlatform(targetPart.CFrame)
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPart.CFrame
        end
        task.wait(1.5)
    end
    
    if toggled and isCharacterReady() then
        local endStage = normalStages:FindFirstChild("TheEnd")
        local chestTrigger = endStage and endStage:FindFirstChild("GoldenChest") and endStage.GoldenChest:FindFirstChild("Trigger")
        if chestTrigger then
            ToggleBtn.Text = "Opening Chest..."
            managePlatform(chestTrigger.CFrame)
            LocalPlayer.Character.HumanoidRootPart.CFrame = chestTrigger.CFrame
        end
        task.wait(4)
        removePlatform()
        ToggleBtn.Text = "Resetting..."
    end
    loopThreadActive = false
end

LocalPlayer.CharacterAdded:Connect(function()
    if toggled then
        for cooldown = 6, 1, -1 do
            if not toggled then break end
            ToggleBtn.Text = "Starting in " .. cooldown .. "s..."
            task.wait(1)
        end
        local claimRemote = Workspace:FindFirstChild("ClaimRiverResultsGold")
        if claimRemote then claimRemote:FireServer() end
        if toggled and isCharacterReady() then task.spawn(runFarmCycle) end
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    toggled = not toggled
    if toggled then
        ToggleBtn.Text = "Auto Stage Farm: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        if isCharacterReady() then task.spawn(runFarmCycle) end
    else
        ToggleBtn.Text = "Auto Stage Farm: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        removePlatform()
    end
end)
LocalPlayer.CharacterRemoving:Connect(removePlatform)
-- // END OF FILE: Part_6.lua //

