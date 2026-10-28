--[[
    GUBBY HUB
    Aimbot | ESP | Velocidade | FOV
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local CoreGui           = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera      = workspace.CurrentCamera

local Theme = {
    Background   = Color3.fromRGB(255, 255, 255),
    PurpleAccent = Color3.fromRGB(155, 89, 255),
    Text         = Color3.fromRGB(30, 30, 30),
    SubText      = Color3.fromRGB(90, 90, 90),
    ButtonOff    = Color3.fromRGB(220, 50, 50),
    ButtonOn     = Color3.fromRGB(50, 190, 90),
    SliderTrack  = Color3.fromRGB(230, 230, 230),
    Border       = Color3.fromRGB(210, 210, 210),
}

local State = {
    Aimbot      = false,
    ESP         = false,
    FOV         = false,
    FOVSize     = 200,
    Speed       = 16,
    PurpleTheme = false,
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GubbyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 500)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -250)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MC = Instance.new("UICorner")
MC.CornerRadius = UDim.new(0, 14)
MC.Parent = MainFrame

local MS = Instance.new("UIStroke")
MS.Color = Theme.Border
MS.Thickness = 1
MS.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 56)
Header.BackgroundColor3 = Theme.Background
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HC = Instance.new("UICorner")
HC.CornerRadius = UDim.new(0, 14)
HC.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -110, 1, 0)
Title.Position = UDim2.new(0, 18, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "GUBBY HUB"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextColor3 = Theme.Text
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -110, 0, 16)
Subtitle.Position = UDim2.new(0, 18, 1, -20)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Universal • PC / Mobile"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 11
Subtitle.TextColor3 = Theme.SubText
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

local ThemeBtn = Instance.new("TextButton")
ThemeBtn.Size = UDim2.new(0, 40, 0, 40)
ThemeBtn.Position = UDim2.new(1, -52, 0, 8)
ThemeBtn.BackgroundColor3 = Theme.PurpleAccent
ThemeBtn.BorderSizePixel = 0
ThemeBtn.Text = "🎨"
ThemeBtn.Font = Enum.Font.GothamBold
ThemeBtn.TextSize = 18
ThemeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeBtn.Parent = Header

local TC = Instance.new("UICorner")
TC.CornerRadius = UDim.new(0, 10)
TC.Parent = ThemeBtn

local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -24, 1, -70)
Content.Position = UDim2.new(0, 12, 0, 62)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = Theme.Border
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.ScrollingDirection = Enum.ScrollingDirection.Y
Content.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = Content

local function UpdateTheme()
    local accent = State.PurpleTheme and Theme.PurpleAccent or Theme.Background
    local border = State.PurpleTheme and Theme.PurpleAccent or Theme.Border
    MainFrame.BackgroundColor3 = accent
    Header.BackgroundColor3 = accent
    MS.Color = border
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 44)
    btn.BackgroundColor3 = Theme.ButtonOff
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = Content
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = btn
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function SetBtn(b, on)
    b.BackgroundColor3 = on and Theme.ButtonOn or Theme.ButtonOff
end

local function ShowToast(text)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(0, 260, 0, 36)
    t.Position = UDim2.new(0.5, -130, 0, 12)
    t.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    t.BorderSizePixel = 0
    t.Text = text
    t.Font = Enum.Font.GothamBold
    t.TextSize = 13
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.ZIndex = 200
    t.Parent = ScreenGui
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = t
    task.delay(2.5, function() t:Destroy() end)
end

-- FOV Circle
local FOVCircle = Instance.new("Frame")
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false
FOVCircle.ZIndex = 4
FOVCircle.Parent = ScreenGui
local FC = Instance.new("UICorner")
FC.CornerRadius = UDim.new(1, 0)
FC.Parent = FOVCircle
local FS = Instance.new("UIStroke")
FS.Color = Color3.fromRGB(255, 255, 255)
FS.Thickness = 2
FS.Parent = FOVCircle

local function UpdateFOVVisual()
    local s = State.FOVSize
    FOVCircle.Size = UDim2.new(0, s * 2, 0, s * 2)
    FOVCircle.Position = UDim2.new(0.5, -s, 0.5, -s)
end

local function IsInsideFOV(head)
    if not State.FOV then return true end
    local sp, on = Camera:WorldToViewportPoint(head.Position)
    if not on then return false end
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    return (Vector2.new(sp.X, sp.Y) - center).Magnitude <= State.FOVSize
end

local function GetClosestHead()
    local closest, dist = nil, math.huge
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("Head") then return nil end
    local myHead = myChar.Head
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if head and hrp then
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 and IsInsideFOV(head) then
                    local d = (hrp.Position - myHead.Position).Magnitude
                    if d < dist then dist, closest = d, head end
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if not State.Aimbot then return end
    local head = GetClosestHead()
    if head then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
    end
end)

local AimbotBtn = CreateButton("Aimbot [OFF]", function()
    State.Aimbot = not State.Aimbot
    AimbotBtn.Text = "Aimbot [" .. (State.Aimbot and "ON" or "OFF") .. "]"
    SetBtn(AimbotBtn, State.Aimbot)
    if not State.Aimbot and State.FOV then
        State.FOV = false
        FOVCircle.Visible = false
        FOVBtn.Text = "FOV [OFF]"
        SetBtn(FOVBtn, false)
    end
end)

local FOVBtn = CreateButton("FOV [OFF]", function()
    if not State.Aimbot then
        ShowToast("ATIVE O AIMBOT PRIMEIRO")
        return
    end
    State.FOV = not State.FOV
    FOVBtn.Text = "FOV [" .. (State.FOV and "ON" or "OFF") .. "]"
    SetBtn(FOVBtn, State.FOV)
    FOVCircle.Visible = State.FOV
end)

-- FOV Slider
local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(1, -8, 0, 22)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "Tamanho do FOV: " .. State.FOVSize
FOVLabel.Font = Enum.Font.GothamBold
FOVLabel.TextSize = 14
FOVLabel.TextColor3 = Theme.Text
FOVLabel.TextXAlignment = Enum.TextXAlignment.Left
FOVLabel.Parent = Content

local FOVSlider = Instance.new("Frame")
FOVSlider.Size = UDim2.new(1, -8, 0, 30)
FOVSlider.BackgroundColor3 = Theme.SliderTrack
FOVSlider.BorderSizePixel = 0
FOVSlider.Active = true
FOVSlider.Parent = Content
local FSC = Instance.new("UICorner")
FSC.CornerRadius = UDim.new(0, 10)
FSC.Parent = FOVSlider

local FOVFill = Instance.new("Frame")
FOVFill.Size = UDim2.new((State.FOVSize - 40) / 460, 0, 1, 0)
FOVFill.BackgroundColor3 = Theme.ButtonOn
FOVFill.BorderSizePixel = 0
FOVFill.Parent = FOVSlider
local FFC = Instance.new("UICorner")
FFC.CornerRadius = UDim.new(0, 10)
FFC.Parent = FOVFill

local FOVKnob = Instance.new("Frame")
FOVKnob.Size = UDim2.new(0, 22, 0, 22)
FOVKnob.Position = UDim2.new((State.FOVSize - 40) / 460, -11, 0.5, -11)
FOVKnob.BackgroundColor3 = Theme.Background
FOVKnob.BorderSizePixel = 0
FOVKnob.Parent = FOVSlider
local FKC = Instance.new("UICorner")
FKC.CornerRadius = UDim.new(1, 0)
FKC.Parent = FOVKnob

local function ApplyFOVSize(v)
    v = math.clamp(math.floor(v), 40, 500)
    State.FOVSize = v
    FOVLabel.Text = "Tamanho do FOV: " .. v
    local p = (v - 40) / 460
    FOVFill.Size = UDim2.new(p, 0, 1, 0)
    FOVKnob.Position = UDim2.new(p, -11, 0.5, -11)
    UpdateFOVVisual()
end

local fovDrag = false
FOVSlider.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        fovDrag = true
        local rel = math.clamp((i.Position.X - FOVSlider.AbsolutePosition.X) / FOVSlider.AbsoluteSize.X, 0, 1)
        ApplyFOVSize(40 + rel * 460)
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if fovDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local rel = math.clamp((i.Position.X - FOVSlider.AbsolutePosition.X) / FOVSlider.AbsoluteSize.X, 0, 1)
        ApplyFOVSize(40 + rel * 460)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        fovDrag = false
    end
end)

-- ESP
local ESPObjects = {}

local function CreateESPFor(plr)
    if plr == LocalPlayer or ESPObjects[plr] then return end
    local box = Drawing.new("Square")
    box.Thickness = 1.5
    box.Color = Color3.fromRGB(155, 89, 255)
    box.Filled = false
    box.Visible = false
    local line = Drawing.new("Line")
    line.Thickness = 2
    line.Color = Color3.fromRGB(155, 89, 255)
    line.Visible = false
    ESPObjects[plr] = { Box = box, Line = line }
end

local function RemoveESPFor(plr)
    local o = ESPObjects[plr]
    if o then
        if o.Box then o.Box:Remove() end
        if o.Line then o.Line:Remove() end
        ESPObjects[plr] = nil
    end
end

local function UpdateESP()
    for plr, o in pairs(ESPObjects) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hrp and head and hum and hum.Health > 0 and State.ESP then
            local hp, hv = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
            local rp, rv = Camera:WorldToViewportPoint(hrp.Position)
            if hv and rv then
                local h = math.abs(rp.Y - hp.Y) * 2
                local w = h * 0.55
                o.Box.Size = Vector2.new(w, h)
                o.Box.Position = Vector2.new(hp.X - w / 2, hp.Y - h / 2)
                o.Box.Visible = true
                local fp, fv = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                if fv then
                    o.Line.From = Vector2.new(fp.X - w / 2, fp.Y)
                    o.Line.To = Vector2.new(fp.X + w / 2, fp.Y)
                    o.Line.Visible = true
                else
                    o.Line.Visible = false
                end
            else
                o.Box.Visible = false
                o.Line.Visible = false
            end
        else
            o.Box.Visible = false
            o.Line.Visible = false
        end
    end
end

local ESPBtn = CreateButton("ESP [OFF]", function()
    State.ESP = not State.ESP
    ESPBtn.Text = "ESP [" .. (State.ESP and "ON" or "OFF") .. "]"
    SetBtn(ESPBtn, State.ESP)
    if State.ESP then
        for _, plr in ipairs(Players:GetPlayers()) do CreateESPFor(plr) end
    else
        for plr in pairs(ESPObjects) do RemoveESPFor(plr) end
    end
end)

Players.PlayerAdded:Connect(function(plr) if State.ESP then CreateESPFor(plr) end end)
Players.PlayerRemoving:Connect(function(plr) RemoveESPFor(plr) end)
RunService.RenderStepped:Connect(UpdateESP)

-- Velocidade
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -8, 0, 22)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidade: 16"
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 14
SpeedLabel.TextColor3 = Theme.Text
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = Content

local SpeedSlider = Instance.new("Frame")
SpeedSlider.Size = UDim2.new(1, -8, 0, 40)
SpeedSlider.BackgroundColor3 = Theme.SliderTrack
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Active = true
SpeedSlider.Parent = Content
local SSC = Instance.new("UICorner")
SSC.CornerRadius = UDim.new(0, 10)
SSC.Parent = SpeedSlider

local SpeedFill = Instance.new("Frame")
SpeedFill.Size = UDim2.new(0.5, 0, 1, 0)
SpeedFill.BackgroundColor3 = Theme.ButtonOn
SpeedFill.BorderSizePixel = 0
SpeedFill.Parent = SpeedSlider
local SFC = Instance.new("UICorner")
SFC.CornerRadius = UDim.new(0, 10)
SFC.Parent = SpeedFill

local SpeedKnob = Instance.new("Frame")
SpeedKnob.Size = UDim2.new(0, 22, 0, 22)
SpeedKnob.Position = UDim2.new(0.5, -11, 0.5, -11)
SpeedKnob.BackgroundColor3 = Theme.Background
SpeedKnob.BorderSizePixel = 0
SpeedKnob.Parent = SpeedSlider
local SKC = Instance.new("UICorner")
SKC.CornerRadius = UDim.new(1, 0)
SKC.Parent = SpeedKnob

local function ApplySpeed(v)
    v = math.clamp(v, 1, 30)
    State.Speed = v
    SpeedLabel.Text = "Velocidade: " .. v
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = v end
    local p = (v - 1) / 29
    SpeedFill.Size = UDim2.new(p, 0, 1, 0)
    SpeedKnob.Position = UDim2.new(p, -11, 0.5, -11)
end

local speedDrag = false
SpeedSlider.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        speedDrag = true
        local rel = (i.Position.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X
        ApplySpeed(math.floor(1 + rel * 29 + 0.5))
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if speedDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local rel = (i.Position.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X
        ApplySpeed(math.floor(1 + rel * 29 + 0.5))
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        speedDrag = false
    end
end)

LocalPlayer.CharacterAdded:Connect(function(c)
    task.wait(0.5)
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = State.Speed end
end)

ThemeBtn.MouseButton1Click:Connect(function()
    State.PurpleTheme = not State.PurpleTheme
    UpdateTheme()
end)

SetBtn(AimbotBtn, false)
SetBtn(FOVBtn, false)
SetBtn(ESPBtn, false)
ApplySpeed(16)
UpdateFOVVisual()

print("[Gubby Hub] Carregado.")
