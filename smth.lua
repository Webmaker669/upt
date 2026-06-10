-- =============================================================================
-- PART 1: MAIN TRANS-SLATE WINDOW FRAMEWORK
-- =============================================================================
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("BuildABoatToolHub") then
    CoreGui.BuildABoatToolHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BuildABoatToolHub"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 550, 0, 420)
MainFrame.Position = UDim2.new(0.5, -275, 0.4, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local HeaderFrame = Instance.new("Frame", MainFrame)
HeaderFrame.Size = UDim2.new(1, 0, 0, 50)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 10)

local HeaderFix = Instance.new("Frame", HeaderFrame)
HeaderFix.Size = UDim2.new(1, 0, 0, 10)
HeaderFix.Position = UDim2.new(0, 0, 1, -10)
HeaderFix.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
HeaderFix.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", HeaderFrame)
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Text = "BUILD A BOAT TOOL HUB"
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", HeaderFrame)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -35, 0.5, -12)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 12)

local SidebarFrame = Instance.new("Frame", MainFrame)
SidebarFrame.Size = UDim2.new(0, 120, 1, -50)
SidebarFrame.Position = UDim2.new(0, 0, 0, 50)
SidebarFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
SidebarFrame.BorderSizePixel = 0
Instance.new("UICorner", SidebarFrame).CornerRadius = UDim.new(0, 10)

local SidebarFix = Instance.new("Frame", SidebarFrame)
SidebarFix.Size = UDim2.new(0, 15, 1, 0)
SidebarFix.Position = UDim2.new(1, -15, 0, 0)
SidebarFix.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
SidebarFix.BorderSizePixel = 0

local NavListLayout = Instance.new("UIListLayout", SidebarFrame)
NavListLayout.Padding = UDim.new(0, 6)
NavListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
NavListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local NavPadding = Instance.new("UIPadding", SidebarFrame)
NavPadding.PaddingTop = UDim.new(0, 12)

local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Size = UDim2.new(1, -120, 1, -50)
ContentContainer.Position = UDim2.new(0, 120, 0, 50)
ContentContainer.BackgroundTransparency = 1

local Pages = {}
local function createPage(name)
    local pf = Instance.new("ScrollingFrame", ContentContainer)
    pf.Name = name .. "Page"
    pf.Size = UDim2.new(1, 0, 1, 0)
    pf.BackgroundTransparency = 1
    pf.Visible = false
    pf.ScrollBarThickness = 2
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
    if activeTabBtn then activeTabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50) end
    activeTabBtn = button
    activeTabBtn.BackgroundColor3 = Color3.fromRGB(65, 135, 240)
end

local function addTabButton(text, targetPageName, order)
    local btn = Instance.new("TextButton", SidebarFrame)
    btn.Size = UDim2.new(0, 100, 0, 32)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 245)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
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

local ReopenButton = Instance.new("TextButton", ScreenGui)
ReopenButton.Size = UDim2.new(0, 140, 0, 40)
ReopenButton.Position = UDim2.new(0, 15, 0.85, 0)
ReopenButton.Text = "Open Tool Hub"
ReopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
ReopenButton.Font = Enum.Font.GothamBold
ReopenButton.TextSize = 13
ReopenButton.Visible = false
Instance.new("UICorner", ReopenButton).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false ReopenButton.Visible = true end)
ReopenButton.MouseButton1Click:Connect(function() MainFrame.Visible = true ReopenButton.Visible = false end)

switchTab("Start", startTabBtn)

_G.BoatHub_Part1 = { StartPage = StartPage, CirclePage = CirclePage, AutoFarmPage = AutoFarmPage, MainFrame = MainFrame }

-- =============================================================================
-- PART 2: DATA TEXTBOX FIELDS & COMPONENT CORRECTION
-- =============================================================================
local dataHook = _G.BoatHub_Part1
if not dataHook then error("Part 2 broken connection matrix link.") end

local CirclePage = dataHook.CirclePage
local AutoFarmPage = dataHook.AutoFarmPage
local StartPage = dataHook.StartPage

local HomeTitle = Instance.new("TextLabel", StartPage)
HomeTitle.Size = UDim2.new(1, -30, 0, 30)
HomeTitle.Position = UDim2.new(0, 15, 0, 20)
HomeTitle.Text = "Welcome to the Integrated Tool Hub"
HomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeTitle.Font = Enum.Font.GothamBold
HomeTitle.TextSize = 15
HomeTitle.BackgroundTransparency = 1
HomeTitle.TextXAlignment = Enum.TextXAlignment.Left

local CopyBox = Instance.new("TextBox", StartPage)
CopyBox.Size = UDim2.new(1, -30, 0, 36)
CopyBox.Position = UDim2.new(0, 15, 0, 60)
CopyBox.Text = "https://discord.com"
CopyBox.TextColor3 = Color3.fromRGB(114, 137, 218)
CopyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
CopyBox.Font = Enum.Font.GothamBold
CopyBox.TextSize = 11
CopyBox.ClearTextOnFocus = false
CopyBox.TextEditable = false
Instance.new("UICorner", CopyBox).CornerRadius = UDim.new(0, 6)

local function addCircleInput(labelText, yPos, defaultValue, editable)
    local lbl = Instance.new("TextLabel", CirclePage)
    lbl.Size = UDim2.new(0, 150, 0, 26)
    lbl.Position = UDim2.new(0, 15, 0, yPos)
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(210, 210, 215)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.Gotham
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local box = Instance.new("TextBox", CirclePage)
    box.Size = UDim2.new(0, 140, 0, 26)
    box.Position = UDim2.new(0, 175, 0, yPos)
    box.Text = defaultValue
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 12
    box.TextEditable = editable
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    return box
end

local inputRadius = addCircleInput("Circle Radius / Range:", 20, "20", true)
local inputSteps = addCircleInput("Total Parts Count:", 50, "30", true)
local inputSizeY = addCircleInput("Block Height (Y):", 80, "2", true)
local inputBlockType = addCircleInput("Active Block Type:", 110, "PlasticBlock", true)
local inputSizeX = addCircleInput("Calculated Width (X):", 140, "0.00", false)
local inputSizeZ = addCircleInput("Calculated Depth (Z):", 170, "0.00", false)

local statusLabel = Instance.new("TextLabel", CirclePage)
statusLabel.Size = UDim2.new(1, -30, 0, 25)
statusLabel.Position = UDim2.new(0, 15, 0, 205)
statusLabel.Text = "Center Target Block: Not Selected"
statusLabel.TextColor3 = Color3.fromRGB(240, 90, 90)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.BackgroundTransparency = 1

local function appendCircleButton(text, yPos, color)
    local btn = Instance.new("TextButton", CirclePage)
    btn.Size = UDim2.new(1, -30, 0, 30)
    btn.Position = UDim2.new(0, 15, 0, yPos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = color
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    return btn
end

local btnSelect = appendCircleButton("Select Center Target Block", 235, Color3.fromRGB(35, 115, 200))
local btnPreview = appendCircleButton("Hologram Preview Configuration: Disabled", 270, Color3.fromRGB(90, 90, 95))
local btnBuild = appendCircleButton("Commence Circle Construction", 305, Color3.fromRGB(45, 140, 85))

local FarmTitle = Instance.new("TextLabel", AutoFarmPage)
FarmTitle.Size = UDim2.new(1, -30, 0, 25)
FarmTitle.Position = UDim2.new(0, 15, 0, 15)
FarmTitle.Text = "Automated Stage Progression Farm"
FarmTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
FarmTitle.Font = Enum.Font.GothamBold
FarmTitle.TextSize = 14
FarmTitle.BackgroundTransparency = 1
FarmTitle.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBtn = Instance.new("TextButton", AutoFarmPage)
ToggleBtn.Size = UDim2.new(1, -30, 0, 40)
ToggleBtn.Position = UDim2.new(0, 15, 0, 45)
ToggleBtn.Text = "Auto Farm: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

local function addFarmField(labelText, yPos, defaultValue)
    local lbl = Instance.new("TextLabel", AutoFarmPage)
    lbl.Size = UDim2.new(0, 180, 0, 26)
    lbl.Position = UDim2.new(0, 15, 0, yPos)
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(210, 210, 215)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.Gotham
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local box = Instance.new("TextBox", AutoFarmPage)
    box.Size = UDim2.new(1, -230, 0, 26)
    box.Position = UDim2.new(0, 205, 0, yPos)
    box.Text = defaultValue
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    box.Font = Enum.Font.GothamSemibold
    box.TextSize = 12
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    return box
end

local inputSpeed = addFarmField("Teleport Speed Delay (s):", 100, "1.5")
local inputWebhook = addFarmField("Discord Webhook URL Addon:", 135, "")
local inputWebInterval = addFarmField("Webhook Send Interval (Loops):", 170, "5")

local DisclaimerLabel = Instance.new("TextLabel", AutoFarmPage)
DisclaimerLabel.Size = UDim2.new(1, -30, 0, 35)
DisclaimerLabel.Position = UDim2.new(0, 15, 0, 205)
DisclaimerLabel.Text = "* Privacy Notice: All webhooks are processed purely on the local client side. Your webhook URL is never saved, transmitted externally, or shared."
DisclaimerLabel.TextColor3 = Color3.fromRGB(165, 165, 170)
DisclaimerLabel.TextSize = 10
DisclaimerLabel.Font = Enum.Font.Gotham
DisclaimerLabel.TextWrapped = true
DisclaimerLabel.BackgroundTransparency = 1
DisclaimerLabel.TextXAlignment = Enum.TextXAlignment.Left

_G.CBuilder_SpeedBox = inputSpeed
_G.CBuilder_WebhookBox = inputWebhook
_G.CBuilder_IntervalBox = inputWebInterval
_G.CBuilder_FarmToggle = ToggleBtn

_G.BoatHub_Part2 = {
    inputRadius = inputRadius, inputSteps = inputSteps, inputSizeY = inputSizeY,
    inputBlockType = inputBlockType, inputSizeX = inputSizeX, inputSizeZ = inputSizeZ,
    statusLabel = statusLabel, btnSelect = btnSelect, btnPreview = btnPreview, btnBuild = btnBuild
}

-- =============================================================================
-- PART 3: RECTIFICATION & VISUAL INVENTORY LAYOUTS
-- =============================================================================
local hook1 = _G.BoatHub_Part1
local hook2 = _G.BoatHub_Part2
if not hook1 or not hook2 then error("Part 3 configuration mapping error.") end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local dataFolder = LocalPlayer:WaitForChild("Data", 5)

local CirclePage = hook1.CirclePage
local inputBlockType = hook2.inputBlockType

local BlockPanel = Instance.new("Frame", CirclePage)
BlockPanel.Size = UDim2.new(1, -30, 0, 140)
BlockPanel.Position = UDim2.new(0, 15, 0, 345)
BlockPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
BlockPanel.ZIndex = 5
BlockPanel.Visible = false
Instance.new("UICorner", BlockPanel).CornerRadius = UDim.new(0, 8)

local PanelTitle = Instance.new("TextLabel", BlockPanel)
PanelTitle.Size = UDim2.new(1, 0, 0, 25)
PanelTitle.Text = "AVAILABLE CONFIGURATION BLOCKS"
PanelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PanelTitle.Font = Enum.Font.GothamBold
PanelTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
PanelTitle.TextSize = 10

local ScrollingFrame = Instance.new("ScrollingFrame", BlockPanel)
ScrollingFrame.Size = UDim2.new(1, -16, 1, -30)
ScrollingFrame.Position = UDim2.new(0, 8, 0, 28)
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
            itemBtn.Size = UDim2.new(1, -5, 0, 24)
            itemBtn.Text = " " .. item.Name .. " (" .. tostring(item.Value) .. ")"
            itemBtn.TextColor3 = Color3.fromRGB(200, 200, 205)
            itemBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
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

-- =============================================================================
-- PART 4: BLUEPRINT MATH MATRIX RENDERING
-- =============================================================================
local hook1 = _G.BoatHub_Part1
local hook2 = _G.BoatHub_Part2
if not hook1 or not hook2 then error("Part 4 environment linkage failure.") end

local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local inputRadius, inputSteps, inputSizeY, inputSizeX, inputSizeZ = hook2.inputRadius, hook2.inputSteps, hook2.inputSizeY, hook2.inputSizeX, hook2.inputSizeZ
local statusLabel, btnSelect, btnPreview = hook2.statusLabel, hook2.btnSelect, hook2.btnPreview

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
    btnPreview.BackgroundColor3 = _G.CBuilder_LivePreview and Color3.fromRGB(155, 80, 180) or Color3.fromRGB(90, 90, 95)
    updateRingVisuals()
end)

_G.BoatHub_Part4 = { previewFolder = previewFolder }

-- =============================================================================
-- PART 5: TOOL INVOKERS MATRIX EXECUTION ENGINE
-- =============================================================================
local hook1 = _G.BoatHub_Part1
local hook2 = _G.BoatHub_Part2
local hook4 = _G.BoatHub_Part4
if not hook1 or not hook2 or not hook4 then error("Part 5 dependencies missing from environment thread.") end

local LocalPlayer = game:GetService("Players").LocalPlayer
local inputRadius, inputSteps, inputSizeY, inputBlockType = hook2.inputRadius, hook2.inputSteps, hook2.inputSizeY, hook2.inputBlockType
local statusLabel, btnBuild = hook2.statusLabel, hook2.btnBuild
local previewFolder = hook4.previewFolder

local dataFolder = LocalPlayer:WaitForChild("Data", 5)
local folder = workspace:WaitForChild("Blocks", 5):WaitForChild(LocalPlayer.Name, 5)

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

-- =============================================================================
-- PART 6: AUTOMATED AUTO-FARM ENGINE WITH WEBHOOK DISPATCHER
-- =============================================================================
local core = _G.BoatHub_Part1
if not core then error("Part 6 Deployment Failed: Core layout missing from memory.") end

local Workspace = game:GetService("Workspace")
local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

-- Direct static pointer fetches from our global storage
local inputSpeed = _G.CBuilder_SpeedBox
local inputWebhook = _G.CBuilder_WebhookBox
local inputWebInterval = _G.CBuilder_IntervalBox
local ToggleBtn = _G.CBuilder_FarmToggle

if not inputSpeed or not inputWebhook or not ToggleBtn then
    error("Part 6 Global Error: Part 2 elements could not be loaded from memory.")
end

local toggled, platform, loopThreadActive = false, nil, false
local totalLoopsCompleted = 0
local initialGoldValue = 0

-- Safely cache starting gold amount
local goldValueObject = LocalPlayer:WaitForChild("Data", 5) and LocalPlayer.Data:WaitForChild("Gold", 5)
if goldValueObject then initialGoldValue = goldValueObject.Value end

-- Dispatches formatted gold logs to your webhook (only if a valid URL is provided)
local function sendWebhookUpdate()
    local url = tostring(inputWebhook.Text)
    -- If the webhook box is empty or not a valid Discord link, completely skip it
    if url == "" or not string.find(url, "://discord.com") then return end
    
    local currentGold = goldValueObject and goldValueObject.Value or 0
    local goldEarned = currentGold - initialGoldValue
    
    local payloadData = {
        username = "Tool Hub Tracker",
        embeds = {{
            title = "Auto Farm Progress Update",
            color = 3066993,
            fields = {
                {name = "Local Account Profile", value = "`" .. LocalPlayer.Name .. "`", inline = true},
                {name = "Loops Documented", value = "`" .. tostring(totalLoopsCompleted) .. "`", inline = true},
                {name = "Net Profits Generated", value = "`" .. tostring(goldEarned) .. " Gold`", inline = false},
                {name = "Current Ledger Balance", value = "`" .. tostring(currentGold) .. " Gold`", inline = true}
            },
            footer = {text = "Automated Hub Log Distribution Systems"}
        }}
    }
    
    task.spawn(function()
        pcall(function()
            local request = syn and syn.request or http and http.request or http_request or request
            if request then
                request({
                    Url = url,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = HttpService:JSONEncode(payloadData)
                })
            end
        end)
    end)
end

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
    
    local speedDelay = tonumber(inputSpeed.Text) or 1.5
    
    for i = 1, 10 do
        if not toggled or not isCharacterReady() then break end
        local currentStage = normalStages:FindFirstChild("CaveStage" .. i)
        local targetPart = currentStage and currentStage:FindFirstChild("DarknessPart")
        if targetPart then
            ToggleBtn.Text = "Traveling: Stage " .. i
            managePlatform(targetPart.CFrame)
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPart.CFrame
        end
        task.wait(speedDelay)
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
        
        totalLoopsCompleted = totalLoopsCompleted + 1
        
        -- Check if it is time to send a webhook update based on your interval setting
        local targetInterval = tonumber(inputWebInterval.Text) or 5
        if totalLoopsCompleted % targetInterval == 0 then
            sendWebhookUpdate()
        end
    end
    loopThreadActive = false
end

-- Triggers the auto farm loop smoothly every time your character respawns at base
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

-- Farm Tab Button Trigger (Works completely independent of webhooks)
ToggleBtn.MouseButton1Click:Connect(function()
    toggled = not toggled
    if toggled then
        ToggleBtn.Text = "Auto Farm: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 140, 85)
        if isCharacterReady() then task.spawn(runFarmCycle) end
    else
        ToggleBtn.Text = "Auto Farm: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        removePlatform()
    end
end)

LocalPlayer.CharacterRemoving:Connect(removePlatform)
-- // END OF FILE: Part6.lua //
