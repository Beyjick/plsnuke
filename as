loadstring(game:HttpGet("https://raw.githubusercontent.com/darkdexv2/universalavatarchanger/main/avatarchanger"))()

local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local UserInputService   = game:GetService("UserInputService")
local RunService         = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local CoreGui            = game:GetService("CoreGui")
local CollectionService  = game:GetService("CollectionService")
local Lighting           = game:GetService("Lighting")
local Debris             = game:GetService("Debris")
local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local STORAGE_KEY    = "FazoxNuke2026_"..tostring(player.UserId)
local ROBUX_ICON     = "rbxasset://textures/ui/common/robux@3x.png"
local ROBUX_THUMB    = "rbxthumb://type=Asset&id=11713337409&w=150&h=150"
local NUKE_THRESHOLD = 10000
local NUKE_LAND_POS  = Vector3.new(166.436, 6.485, 307.588)

local function createLoadingScreen()
    local loadGui = Instance.new("ScreenGui")
    loadGui.Name = "FazoxLoader"
    loadGui.ResetOnSpawn = false
    loadGui.DisplayOrder = 99999
    loadGui.IgnoreGuiInset = true
    loadGui.Parent = playerGui

    local danceSnd = Instance.new("Sound")
    danceSnd.SoundId = "rbxassetid://1837823558"
    danceSnd.Volume = 0.9
    danceSnd.Looped = false
    danceSnd.Parent = playerGui
    pcall(function() danceSnd:Play() end)
    task.delay(10, function() pcall(function() danceSnd:Stop(); danceSnd:Destroy() end) end)

    local bg = Instance.new("Frame", loadGui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(4,3,8)
    bg.BorderSizePixel = 0

    local dancerFrame = Instance.new("Frame", bg)
    dancerFrame.Size = UDim2.fromOffset(110, 110)
    dancerFrame.AnchorPoint = Vector2.new(0, 1)
    dancerFrame.Position = UDim2.new(0.06, 0, 0.88, 0)
    dancerFrame.BackgroundTransparency = 1
    dancerFrame.ZIndex = 20
    local dancerLbl = Instance.new("TextLabel", dancerFrame)
    dancerLbl.Size = UDim2.new(1,0,1,0)
    dancerLbl.BackgroundTransparency = 1
    dancerLbl.Text = "🕺"
    dancerLbl.TextSize = 70
    dancerLbl.Font = Enum.Font.GothamBlack
    dancerLbl.TextXAlignment = Enum.TextXAlignment.Center
    dancerLbl.TextYAlignment = Enum.TextYAlignment.Center
    dancerLbl.TextColor3 = Color3.fromRGB(255,255,255)
    dancerLbl.ZIndex = 20
    local dancerCaption = Instance.new("TextLabel", bg)
    dancerCaption.Size = UDim2.fromOffset(200, 20)
    dancerCaption.AnchorPoint = Vector2.new(0, 1)
    dancerCaption.Position = UDim2.new(0.02, 0, 0.92, 0)
    dancerCaption.BackgroundTransparency = 1
    dancerCaption.Text = "Loading... stay calm! 🎶"
    dancerCaption.Font = Enum.Font.GothamBold
    dancerCaption.TextSize = 12
    dancerCaption.TextColor3 = Color3.fromRGB(200,150,255)
    dancerCaption.TextXAlignment = Enum.TextXAlignment.Left
    dancerCaption.ZIndex = 20
    task.spawn(function()
        local t = 0
        while loadGui and loadGui.Parent do
            task.wait(0.04)
            t = t + 0.04
            pcall(function()
                dancerLbl.Rotation = math.sin(t * 5) * 20
                dancerFrame.Position = UDim2.new(0.06, 0, 0.88 + math.sin(t * 6) * 0.025, 0)
            end)
        end
    end)

    local stemGlow = Instance.new("Frame", bg)
    stemGlow.Size = UDim2.fromOffset(60, 0)
    stemGlow.AnchorPoint = Vector2.new(0.5, 1)
    stemGlow.Position = UDim2.fromScale(0.5, 0.72)
    stemGlow.BackgroundColor3 = Color3.fromRGB(255, 160, 40)
    stemGlow.BackgroundTransparency = 0
    stemGlow.BorderSizePixel = 0
    stemGlow.ZIndex = 4
    Instance.new("UICorner", stemGlow).CornerRadius = UDim.new(0, 8)
    task.delay(0.05, function()
        TweenService:Create(stemGlow, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(80, 260), BackgroundTransparency = 0.5,
            BackgroundColor3 = Color3.fromRGB(180, 100, 30)
        }):Play()
        task.wait(1.2)
        TweenService:Create(stemGlow, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play()
    end)

    local mushroomTop = Instance.new("Frame", bg)
    mushroomTop.Size = UDim2.fromOffset(0, 0)
    mushroomTop.AnchorPoint = Vector2.new(0.5, 0.5)
    mushroomTop.Position = UDim2.fromScale(0.5, 0.38)
    mushroomTop.BackgroundColor3 = Color3.fromRGB(255, 120, 20)
    mushroomTop.BackgroundTransparency = 0
    mushroomTop.BorderSizePixel = 0
    mushroomTop.ZIndex = 5
    Instance.new("UICorner", mushroomTop).CornerRadius = UDim.new(0.5, 0)
    task.delay(0.08, function()
        TweenService:Create(mushroomTop, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(320, 200)
        }):Play()
        task.wait(0.5)
        TweenService:Create(mushroomTop, TweenInfo.new(1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(460, 300),
            BackgroundColor3 = Color3.fromRGB(80, 40, 20),
            BackgroundTransparency = 0.7
        }):Play()
    end)

    local mushroomInner = Instance.new("Frame", bg)
    mushroomInner.Size = UDim2.fromOffset(0, 0)
    mushroomInner.AnchorPoint = Vector2.new(0.5, 0.5)
    mushroomInner.Position = UDim2.fromScale(0.5, 0.38)
    mushroomInner.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    mushroomInner.BackgroundTransparency = 0.2
    mushroomInner.BorderSizePixel = 0
    mushroomInner.ZIndex = 6
    Instance.new("UICorner", mushroomInner).CornerRadius = UDim.new(0.5, 0)
    task.delay(0.05, function()
        TweenService:Create(mushroomInner, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(180, 120)
        }):Play()
        task.wait(0.4)
        TweenService:Create(mushroomInner, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(300, 200), BackgroundTransparency = 1
        }):Play()
    end)

    local shockwave1 = Instance.new("Frame", bg)
    shockwave1.Size = UDim2.fromOffset(0,0)
    shockwave1.AnchorPoint = Vector2.new(0.5,0.5)
    shockwave1.Position = UDim2.fromScale(0.5, 0.72)
    shockwave1.BackgroundColor3 = Color3.fromRGB(255,200,50)
    shockwave1.BackgroundTransparency = 0.3
    shockwave1.BorderSizePixel = 0
    Instance.new("UICorner",shockwave1).CornerRadius = UDim.new(1,0)
    task.delay(0.08, function()
        TweenService:Create(shockwave1, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(1800, 300), BackgroundTransparency = 1
        }):Play()
    end)

    local shockwave2 = Instance.new("Frame", bg)
    shockwave2.Size = UDim2.fromOffset(0,0)
    shockwave2.AnchorPoint = Vector2.new(0.5,0.5)
    shockwave2.Position = UDim2.fromScale(0.5, 0.72)
    shockwave2.BackgroundColor3 = Color3.fromRGB(255,100,10)
    shockwave2.BackgroundTransparency = 0.35
    shockwave2.BorderSizePixel = 0
    Instance.new("UICorner",shockwave2).CornerRadius = UDim.new(1,0)
    task.delay(0.22, function()
        TweenService:Create(shockwave2, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(1500, 240), BackgroundTransparency = 1
        }):Play()
    end)

    local shockwave3 = Instance.new("Frame", bg)
    shockwave3.Size = UDim2.fromOffset(0,0)
    shockwave3.AnchorPoint = Vector2.new(0.5,0.5)
    shockwave3.Position = UDim2.fromScale(0.5, 0.72)
    shockwave3.BackgroundColor3 = Color3.fromRGB(200,30,80)
    shockwave3.BackgroundTransparency = 0.4
    shockwave3.BorderSizePixel = 0
    Instance.new("UICorner",shockwave3).CornerRadius = UDim.new(1,0)
    task.delay(0.40, function()
        TweenService:Create(shockwave3, TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(1200, 200), BackgroundTransparency = 1
        }):Play()
    end)

    for i = 1, 6 do
        local dustCloud = Instance.new("Frame", bg)
        dustCloud.Size = UDim2.fromOffset(0, 0)
        dustCloud.AnchorPoint = Vector2.new(0.5, 0.5)
        dustCloud.Position = UDim2.fromScale(0.5 + (i-3.5)*0.06, 0.72)
        dustCloud.BackgroundColor3 = Color3.fromRGB(160, 120, 80)
        dustCloud.BackgroundTransparency = 0.2
        dustCloud.BorderSizePixel = 0
        dustCloud.ZIndex = 3
        Instance.new("UICorner", dustCloud).CornerRadius = UDim.new(0.5, 0)
        local delay = 0.05 + i * 0.04
        local sz = 80 + math.random(0, 60)
        task.delay(delay, function()
            TweenService:Create(dustCloud, TweenInfo.new(1.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(sz, sz), BackgroundTransparency = 1
            }):Play()
        end)
    end

    local flashFrame = Instance.new("Frame", bg)
    flashFrame.Size = UDim2.new(1,0,1,0)
    flashFrame.BackgroundColor3 = Color3.fromRGB(255,255,220)
    flashFrame.BackgroundTransparency = 0
    flashFrame.BorderSizePixel = 0
    flashFrame.ZIndex = 9
    TweenService:Create(flashFrame, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()

    local fireball = Instance.new("Frame", bg)
    fireball.Size = UDim2.fromOffset(0,0)
    fireball.AnchorPoint = Vector2.new(0.5,0.5)
    fireball.Position = UDim2.fromScale(0.5, 0.72)
    fireball.BackgroundColor3 = Color3.fromRGB(255,180,30)
    fireball.BackgroundTransparency = 0
    fireball.BorderSizePixel = 0
    fireball.ZIndex = 7
    Instance.new("UICorner",fireball).CornerRadius = UDim.new(1,0)
    task.delay(0.04, function()
        TweenService:Create(fireball, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(200,200)
        }):Play()
        task.wait(0.25)
        TweenService:Create(fireball, TweenInfo.new(1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.fromOffset(80,80),
            BackgroundColor3 = Color3.fromRGB(180,60,200),
            BackgroundTransparency = 0.4
        }):Play()
    end)

    local bgGlow = Instance.new("Frame", bg)
    bgGlow.Size = UDim2.fromOffset(700,700)
    bgGlow.AnchorPoint = Vector2.new(0.5,0.5)
    bgGlow.Position = UDim2.fromScale(0.5,0.38)
    bgGlow.BackgroundColor3 = Color3.fromRGB(80,20,140)
    bgGlow.BackgroundTransparency = 1
    bgGlow.BorderSizePixel = 0
    bgGlow.ZIndex = 2
    Instance.new("UICorner",bgGlow).CornerRadius = UDim.new(1,0)
    task.delay(0.5, function()
        TweenService:Create(bgGlow, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.72
        }):Play()
    end)

    for i = 1, 10 do
        local ray = Instance.new("Frame", bg)
        ray.AnchorPoint = Vector2.new(0.5, 1)
        ray.Position = UDim2.fromScale(0.5, 0.72)
        ray.Size = UDim2.fromOffset(3, 0)
        ray.BackgroundColor3 = Color3.fromRGB(255, 220, 60)
        ray.BackgroundTransparency = 0.15
        ray.BorderSizePixel = 0
        ray.Rotation = (i-1) * 36
        ray.ZIndex = 2
        task.delay(0.06, function()
            TweenService:Create(ray, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(3, 350 + math.random(0,120)),
                BackgroundTransparency = 1
            }):Play()
        end)
    end
    for i = 1, 10 do
        local ray = Instance.new("Frame", bg)
        ray.AnchorPoint = Vector2.new(0.5, 1)
        ray.Position = UDim2.fromScale(0.5, 0.72)
        ray.Size = UDim2.fromOffset(2, 0)
        ray.BackgroundColor3 = Color3.fromRGB(255, 140, 20)
        ray.BackgroundTransparency = 0.25
        ray.BorderSizePixel = 0
        ray.Rotation = (i-1) * 36 + 18
        ray.ZIndex = 2
        task.delay(0.14, function()
            TweenService:Create(ray, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(2, 250 + math.random(0,100)),
                BackgroundTransparency = 1
            }):Play()
        end)
    end

    task.spawn(function()
        for i = 1, 28 do
            task.delay(0.04 + i*0.035, function()
                pcall(function()
                    local debris = Instance.new("Frame", bg)
                    local angle = math.random()*math.pi*2
                    local speed = math.random(60,240)
                    local sz = math.random(3,10)
                    debris.Size = UDim2.fromOffset(sz,sz)
                    debris.AnchorPoint = Vector2.new(0.5,0.5)
                    debris.Position = UDim2.fromScale(0.5, 0.72)
                    debris.BackgroundColor3 = Color3.fromHSV(0.07+math.random()*0.07, 0.8+math.random()*0.2, 1)
                    debris.BackgroundTransparency = 0
                    debris.BorderSizePixel = 0
                    debris.ZIndex = 8
                    Instance.new("UICorner",debris).CornerRadius = UDim.new(0.5,0)
                    local targetX = 0.5 + math.cos(angle)*speed/1920
                    local targetY = 0.72 + math.sin(angle)*speed/1080
                    TweenService:Create(debris, TweenInfo.new(0.8+math.random()*0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.fromScale(targetX, targetY),
                        BackgroundTransparency = 1,
                        Size = UDim2.fromOffset(1,1)
                    }):Play()
                end)
            end)
        end
    end)

    local scanLine = Instance.new("Frame", bg)
    scanLine.Size = UDim2.new(1,0,0,1)
    scanLine.Position = UDim2.new(0,0,0,0)
    scanLine.BackgroundColor3 = Color3.fromRGB(200,160,255)
    scanLine.BackgroundTransparency = 0.5
    scanLine.BorderSizePixel = 0
    scanLine.ZIndex = 10
    task.spawn(function()
        while loadGui and loadGui.Parent do
            TweenService:Create(scanLine, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                Position = UDim2.new(0,0,1.02,0)
            }):Play()
            task.wait(2.05)
            scanLine.Position = UDim2.new(0,0,-0.02,0)
        end
    end)

    local center = Instance.new("Frame", bg)
    center.AnchorPoint = Vector2.new(0.5, 0.5)
    center.Position = UDim2.fromScale(0.5, 0.5)
    center.Size = UDim2.fromOffset(420, 310)
    center.BackgroundTransparency = 1
    center.BorderSizePixel = 0
    center.ZIndex = 12

    local nukeSymbol = Instance.new("TextLabel", center)
    nukeSymbol.Size = UDim2.fromOffset(100,100)
    nukeSymbol.AnchorPoint = Vector2.new(0.5,0)
    nukeSymbol.Position = UDim2.fromOffset(210,5)
    nukeSymbol.BackgroundTransparency = 1
    nukeSymbol.Text = "☢"
    nukeSymbol.Font = Enum.Font.GothamBlack
    nukeSymbol.TextSize = 68
    nukeSymbol.TextColor3 = Color3.fromRGB(255,200,50)
    nukeSymbol.TextTransparency = 1
    nukeSymbol.ZIndex = 13

    local ring1 = Instance.new("Frame", center)
    ring1.Size = UDim2.fromOffset(110,110); ring1.AnchorPoint=Vector2.new(0.5,0)
    ring1.Position=UDim2.fromOffset(210,0); ring1.BackgroundTransparency=1; ring1.ZIndex=12
    Instance.new("UICorner",ring1).CornerRadius=UDim.new(1,0)
    local rs1=Instance.new("UIStroke",ring1); rs1.Color=Color3.fromRGB(255,180,30); rs1.Thickness=2.5; rs1.Transparency=1

    local ring2 = Instance.new("Frame", center)
    ring2.Size=UDim2.fromOffset(130,130); ring2.AnchorPoint=Vector2.new(0.5,0)
    ring2.Position=UDim2.fromOffset(210,-10); ring2.BackgroundTransparency=1; ring2.ZIndex=12
    Instance.new("UICorner",ring2).CornerRadius=UDim.new(1,0)
    local rs2=Instance.new("UIStroke",ring2); rs2.Color=Color3.fromRGB(180,80,255); rs2.Thickness=1.5; rs2.Transparency=1

    local titleLbl = Instance.new("TextLabel", center)
    titleLbl.Size = UDim2.new(1,0,0,52)
    titleLbl.Position = UDim2.fromOffset(0,115)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "FAZOX NUKE"
    titleLbl.Font = Enum.Font.GothamBlack
    titleLbl.TextSize = 46
    titleLbl.TextColor3 = Color3.fromRGB(235,200,255)
    titleLbl.TextXAlignment = Enum.TextXAlignment.Center
    titleLbl.TextTransparency = 1
    titleLbl.ZIndex = 13
    titleLbl.TextStrokeColor3 = Color3.fromRGB(140,40,220)
    titleLbl.TextStrokeTransparency = 1

    local subLbl = Instance.new("TextLabel", center)
    subLbl.Size = UDim2.new(1,0,0,20)
    subLbl.Position = UDim2.fromOffset(0,168)
    subLbl.BackgroundTransparency = 1
    subLbl.Text = "V 3   C U S T O M   E D I T I O N"
    subLbl.Font = Enum.Font.GothamBold
    subLbl.TextSize = 12
    subLbl.TextColor3 = Color3.fromRGB(160,100,230)
    subLbl.TextXAlignment = Enum.TextXAlignment.Center
    subLbl.TextTransparency = 1
    subLbl.ZIndex = 13

    local sep = Instance.new("Frame", center)
    sep.Size = UDim2.fromOffset(0,1)
    sep.AnchorPoint = Vector2.new(0.5,0)
    sep.Position = UDim2.fromOffset(210,196)
    sep.BackgroundColor3 = Color3.fromRGB(160,60,255)
    sep.BackgroundTransparency = 0.3
    sep.BorderSizePixel = 0
    sep.ZIndex = 13

    local steps = {
        "Arming warhead...",
        "Loading blast radius...",
        "Connecting detonator...",
        "Preparing shockwave...",
        "ARMED & READY ☢"
    }
    local stepLbl = Instance.new("TextLabel", center)
    stepLbl.Size = UDim2.new(1,0,0,20)
    stepLbl.Position = UDim2.fromOffset(0,208)
    stepLbl.BackgroundTransparency = 1
    stepLbl.Text = steps[1]
    stepLbl.Font = Enum.Font.Gotham
    stepLbl.TextSize = 13
    stepLbl.TextColor3 = Color3.fromRGB(170,140,210)
    stepLbl.TextXAlignment = Enum.TextXAlignment.Center
    stepLbl.TextTransparency = 1
    stepLbl.ZIndex = 13

    local barBg = Instance.new("Frame", center)
    barBg.Size = UDim2.fromOffset(300,6)
    barBg.Position = UDim2.fromOffset(210,240)
    barBg.AnchorPoint = Vector2.new(0.5,0)
    barBg.BackgroundColor3 = Color3.fromRGB(30,20,55)
    barBg.BorderSizePixel = 0
    barBg.ZIndex = 13
    Instance.new("UICorner",barBg).CornerRadius = UDim.new(1,0)

    local barFill = Instance.new("Frame", barBg)
    barFill.Size = UDim2.fromOffset(0,6)
    barFill.BackgroundColor3 = Color3.fromRGB(220,80,255)
    barFill.BorderSizePixel = 0
    barFill.ZIndex = 14
    Instance.new("UICorner",barFill).CornerRadius = UDim.new(1,0)

    local barTip = Instance.new("Frame", barFill)
    barTip.Size = UDim2.fromOffset(20,6)
    barTip.AnchorPoint = Vector2.new(1,0)
    barTip.Position = UDim2.new(1,0,0,0)
    barTip.BackgroundColor3 = Color3.fromRGB(255,200,255)
    barTip.BackgroundTransparency = 0.2
    barTip.BorderSizePixel = 0
    barTip.ZIndex = 15
    Instance.new("UICorner",barTip).CornerRadius = UDim.new(1,0)

    local pctLbl = Instance.new("TextLabel", center)
    pctLbl.Size = UDim2.fromOffset(60,20)
    pctLbl.Position = UDim2.fromOffset(290,253)
    pctLbl.BackgroundTransparency = 1
    pctLbl.Text = "0%"
    pctLbl.Font = Enum.Font.GothamBold
    pctLbl.TextSize = 12
    pctLbl.TextColor3 = Color3.fromRGB(180,120,240)
    pctLbl.TextXAlignment = Enum.TextXAlignment.Right
    pctLbl.TextTransparency = 1
    pctLbl.ZIndex = 13

    local topBorder = Instance.new("Frame", bg)
    topBorder.Size = UDim2.fromOffset(0,2)
    topBorder.Position = UDim2.fromScale(0.5,0)
    topBorder.AnchorPoint = Vector2.new(0.5,0)
    topBorder.BackgroundColor3 = Color3.fromRGB(220,100,255)
    topBorder.BackgroundTransparency = 0
    topBorder.BorderSizePixel = 0
    topBorder.ZIndex = 16
    task.delay(0.5, function()
        TweenService:Create(topBorder, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.65,0,0,2)
        }):Play()
    end)
    local botBorder = Instance.new("Frame", bg)
    botBorder.Size = UDim2.fromOffset(0,2)
    botBorder.Position = UDim2.fromScale(0.5,1)
    botBorder.AnchorPoint = Vector2.new(0.5,1)
    botBorder.BackgroundColor3 = Color3.fromRGB(220,100,255)
    botBorder.BackgroundTransparency = 0
    botBorder.BorderSizePixel = 0
    botBorder.ZIndex = 16
    task.delay(0.5, function()
        TweenService:Create(botBorder, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.65,0,0,2)
        }):Play()
    end)

    task.delay(0.7, function()
        TweenService:Create(rs1, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Transparency=0.2}):Play()
        TweenService:Create(rs2, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.1), {Transparency=0.4}):Play()
        TweenService:Create(nukeSymbol, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextTransparency=0, TextStrokeTransparency=0.4}):Play()
        TweenService:Create(titleLbl, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.15), {TextTransparency=0, TextStrokeTransparency=0.3}):Play()
        TweenService:Create(subLbl, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.3), {TextTransparency=0}):Play()
        TweenService:Create(stepLbl, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.4), {TextTransparency=0}):Play()
        TweenService:Create(pctLbl, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.4), {TextTransparency=0}):Play()
        TweenService:Create(sep, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.2), {Size=UDim2.fromOffset(260,1)}):Play()
    end)

    task.spawn(function()
        local angle = 0
        while loadGui and loadGui.Parent do
            task.wait(0.04)
            angle = angle + 1.2
            pcall(function() nukeSymbol.Rotation = angle end)
        end
    end)
    task.spawn(function()
        local t = 0
        while loadGui and loadGui.Parent do
            t = t + 0.05
            local pulse = math.abs(math.sin(t * 2)) * 0.35
            pcall(function()
                rs1.Transparency = 0.2 + pulse
                rs2.Transparency = 0.35 + pulse * 0.5
            end)
            task.wait(0.05)
        end
    end)

    task.spawn(function()
        local tc = 0
        while loadGui and loadGui.Parent and fireball and fireball.Parent do
            tc = tc + 0.06
            local col = Color3.fromHSV(0.75 + math.sin(tc)*0.05, 0.6+math.abs(math.sin(tc))*0.3, 0.8+math.abs(math.sin(tc*1.5))*0.2)
            TweenService:Create(fireball, TweenInfo.new(0.08), {BackgroundColor3=col}):Play()
            task.wait(0.08)
        end
    end)

    local function animateLoad(callback)
        task.spawn(function()
            task.wait(0.8)
            local totalDur = 2.4
            for i, stepText in ipairs(steps) do
                local pct = math.floor((i / #steps) * 100)
                local barW = (pct/100) * 300
                barFill.BackgroundColor3 = Color3.fromRGB(255,150,255)
                TweenService:Create(barFill, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(220,80,255)}):Play()
                TweenService:Create(barFill, TweenInfo.new(totalDur/#steps*0.85, Enum.EasingStyle.Quad), {Size=UDim2.fromOffset(barW,6)}):Play()
                pctLbl.Text = pct.."%"
                stepLbl.Text = stepText
                local miniFlash = Instance.new("Frame", bg)
                miniFlash.Size = UDim2.new(1,0,1,0)
                miniFlash.BackgroundColor3 = Color3.fromRGB(200,80,255)
                miniFlash.BackgroundTransparency = 0.92
                miniFlash.BorderSizePixel = 0
                miniFlash.ZIndex = 15
                TweenService:Create(miniFlash, TweenInfo.new(0.3), {BackgroundTransparency=1}):Play()
                task.delay(0.35, function() pcall(function() miniFlash:Destroy() end) end)
                task.wait(totalDur / #steps)
            end
            pctLbl.Text = "100%"
            task.wait(0.25)
            pcall(function() danceSnd:Stop(); danceSnd:Destroy() end)
            local endFlash = Instance.new("Frame", bg)
            endFlash.Size = UDim2.new(1,0,1,0)
            endFlash.BackgroundColor3 = Color3.fromRGB(200,80,255)
            endFlash.BackgroundTransparency = 0.6
            endFlash.BorderSizePixel = 0
            endFlash.ZIndex = 17
            TweenService:Create(endFlash, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency=1}):Play()
            TweenService:Create(bg, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency=1}):Play()
            TweenService:Create(center, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.fromScale(0.5, 0.44)
            }):Play()
            task.wait(0.6)
            loadGui:Destroy()
            if callback then callback() end
        end)
    end

    return animateLoad
end

local startLoad = createLoadingScreen()

local SOUNDS = {
    Click          = "rbxassetid://9671800097",
    Select         = "rbxassetid://9671800097",
    Success        = "rbxassetid://14674229054",
    Error          = "rbxassetid://2865227271",
    Applause       = "rbxassetid://9009370950",
    Coins          = "rbxassetid://8982092797",
    DonationLevel1 = "rbxassetid://15333945695",
    DonationLevel2 = "rbxassetid://15333946014",
    DonationLevel3 = "rbxassetid://15333945376",
    DonationLevel4 = "rbxassetid://15333945889",
    DonationLevel5 = "rbxassetid://15333945597",
    FallingCoins   = "rbxassetid://15333946247",
    NukeAlarm      = "rbxassetid://5156373841",
    NukePreLaunch  = "rbxassetid://132456187",
    NukePreThrust  = "rbxassetid://5652831542",
    NukePreThrust2 = "rbxassetid://8175700177",
    NukeLaunch     = "rbxassetid://5801273676",
    NukeThrust     = "rbxassetid://2852749304",
    NukeFall       = "rbxassetid://121207170835589",
    NukeLand       = "rbxassetid://7157159568",
    NukeLandHands  = "rbxassetid://137692077473399",
    Explosion      = "rbxassetid://7128851174",
    Explosion2     = "rbxassetid://5801257793",
    ShakeNuke      = "rbxassetid://100317721519328",
    NukePopUp      = "rbxassetid://87329228181408",
    NukeApplause   = "rbxassetid://15333946247",
}
local DONATION_SND = {
    {min=1,      max=99,        snd="DonationLevel1"},
    {min=100,    max=999,       snd="DonationLevel2"},
    {min=1000,   max=9999,      snd="DonationLevel3"},
    {min=10000,  max=99999,     snd="DonationLevel4"},
    {min=100000, max=math.huge, snd="DonationLevel5"},
}

local function loadBalance()
    local ok,v=pcall(function()
        if isfile and isfile(STORAGE_KEY..".txt") then return tonumber(readfile(STORAGE_KEY..".txt")) or 11637263872 end
        return 11637263872
    end)
    return (ok and v) or 11637263872
end
local function saveBalance(n) pcall(function() if writefile then writefile(STORAGE_KEY..".txt",tostring(n)) end end) end
local CFG = {
    balance       = loadBalance(),
    customName    = "", nameEnabled=false, nameColor=Color3.fromRGB(255,255,255),
    developerBadge=false, vipBadge=false,
    badgeColor    = Color3.fromRGB(255,70,71), badgeText="Developer", showCheckmark=true,
    enableSounds  = true, updateStandRaised=true, notifStyle="both",
    nukeEnabled   = true, showOwnedWarning=true, hideOwnBody=true,
    nukeAlarmDur  = 5, nukeBillboard=true,
    uiStyle       = "krato",
    bbLine1       = "{player} Donated",
    bbLine3       = "to {user}",
    bbUseCustomName = false,
    bbCustomName    = "",
    nukeOnGamepass  = true,
    purchasedItems={}, balanceLabels={}, processedFrames={},
    isMenuOpen=false,
    currentPurchase={name="Donation",price=0,username="Player",assetId=nil,imageId=nil},
}

local function fmt(n)
    local s=tostring(math.floor(math.max(0,n)))
    return s:reverse():gsub("(%d%d%d)","%1,"):reverse():gsub("^,","")
end
local function parseN(str)
    if not str then return nil end
    local s=tostring(str):gsub(",",""):gsub("%s","")
    local n,suf=s:match("^(%d+%.?%d*)([KkMmBb]?)$")
    if n then
        n=tonumber(n)
        if suf=="K"or suf=="k" then n=n*1e3
        elseif suf=="M"or suf=="m" then n=n*1e6
        elseif suf=="B"or suf=="b" then n=n*1e9 end
        return math.floor(n)
    end
    return tonumber(s)
end

local _activeNukeSounds = {}
local function trackSnd(s) if s then table.insert(_activeNukeSounds,s) end; return s end
local function stopAllNukeSounds()
    for _,s in ipairs(_activeNukeSounds) do
        pcall(function() if s and s.Parent then s:Stop(); task.delay(0.1,function() pcall(function() s:Destroy() end) end) end end)
    end
    table.clear(_activeNukeSounds)
end

local function playS(id,vol,pitch,par)
    if not CFG.enableSounds then return end
    local s=Instance.new("Sound")
    s.SoundId=id; s.Volume=vol or 1; s.PlaybackSpeed=pitch or 1
    s.RollOffMaxDistance=10000; s.Parent=par or workspace; s:Play()
    s.Ended:Connect(function() pcall(function() s:Destroy() end) end)
    Debris:AddItem(s,15); return s
end
local function playSnd(name,vol,pitch) return playS(SOUNDS[name],vol,pitch) end

local function playDonSnd(amount)
    if not CFG.enableSounds then return end
    local sname=DONATION_SND[#DONATION_SND].snd
    for _,e in ipairs(DONATION_SND) do if amount>=e.min and amount<=e.max then sname=e.snd;break end end
    playS(SOUNDS[sname],1.5)
end

local function closeRealPrompts()
    task.spawn(function()
        for _=1,8 do
            pcall(function()
                for _,g in pairs(CoreGui:GetChildren()) do
                    if g:IsA("ScreenGui") then
                        local l=g.Name:lower()
                        if l:find("purchase")or l:find("prompt")or l:find("marketplace") then
                            g.Enabled=false; task.delay(0.05,function() pcall(function() g:Destroy() end) end)
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end
local function regBal(lbl) table.insert(CFG.balanceLabels,lbl); pcall(function() lbl.Text=fmt(CFG.balance) end) end
local function unregBal(lbl) for i,v in ipairs(CFG.balanceLabels) do if v==lbl then table.remove(CFG.balanceLabels,i);break end end end
local function syncBal() for _,lbl in ipairs(CFG.balanceLabels) do pcall(function() if lbl and lbl.Parent then lbl.Text=fmt(CFG.balance) end end) end end
local function setBal(v) v=math.max(0,math.floor(v)); CFG.balance=v; syncBal(); saveBalance(v) end
local function updateStandUI(amount)
    if not CFG.updateStandRaised then return end
    task.spawn(function()
        pcall(function()
            for _,f in ipairs(playerGui:GetDescendants()) do
                if f:IsA("TextLabel") and f.Name=="Raised" then
                    local cur=tonumber((f.Text or "0"):gsub("%D","")) or 0
                    f.Text=fmt(cur+amount).." raised"
                end
            end
        end)
    end)
end
local function updateLeaderboard(amount)
    pcall(function()
        local ccg=playerGui:FindFirstChild("CustomCoreGui"); if not ccg then return end
        local pl=ccg:FindFirstChild("Playerlist"); if not pl then return end
        local sf=pl:FindFirstChild("ScrollingFrame"); if not sf then return end
        local uf=sf:FindFirstChild("User"..tostring(player.UserId)); if not uf then return end
        local st=uf:FindFirstChild("Stats"); if not st then return end
        local don=st:FindFirstChild("Donated"); if not don then return end
        local cur=parseN((don.Text or ""):gsub("[^%d,]","")) or 0
        for _,c in ipairs(don:GetChildren()) do c:Destroy() end; don.Text=""
        local ico=Instance.new("ImageLabel"); ico.Size=UDim2.new(0,16,0,16); ico.Position=UDim2.new(0,0,0.5,-8)
        ico.BackgroundTransparency=1; ico.Image=ROBUX_ICON; ico.ImageColor3=Color3.fromRGB(59,255,56); ico.Parent=don
        local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-20,1,0); lbl.Position=UDim2.new(0,20,0,0)
        lbl.BackgroundTransparency=1; lbl.Text=fmt(cur+amount); lbl.TextColor3=Color3.fromRGB(59,255,56)
        lbl.Font=Enum.Font.GothamSemibold; lbl.TextSize=14; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=don
    end)
end

local function showNotif(opts)
    local sg=playerGui:FindFirstChild("_FazoxNotifGui")
    if not sg then sg=Instance.new("ScreenGui"); sg.Name="_FazoxNotifGui"; sg.ResetOnSpawn=false; sg.DisplayOrder=12010; sg.Parent=playerGui end
    local wrap=Instance.new("Frame",sg); wrap.AnchorPoint=Vector2.new(0.5,1); wrap.Position=UDim2.new(0.5,0,1.15,0)
    wrap.Size=UDim2.fromOffset(0,52); wrap.AutomaticSize=Enum.AutomaticSize.X; wrap.BackgroundTransparency=1; wrap.BorderSizePixel=0
    local pill=Instance.new("Frame",wrap); pill.AnchorPoint=Vector2.new(0.5,0.5); pill.Position=UDim2.new(0.5,0,0.5,0)
    pill.Size=UDim2.fromOffset(0,52); pill.AutomaticSize=Enum.AutomaticSize.X; pill.BackgroundColor3=opts.Color or Color3.fromRGB(30,30,40); pill.BorderSizePixel=0
    Instance.new("UICorner",pill).CornerRadius=UDim.new(1,0)
    local stroke=Instance.new("UIStroke",pill); stroke.Color=Color3.new(1,1,1); stroke.Transparency=0.75; stroke.Thickness=2
    local pad=Instance.new("UIPadding",pill); pad.PaddingLeft=UDim.new(0,22); pad.PaddingRight=UDim.new(0,22); pad.PaddingTop=UDim.new(0,10); pad.PaddingBottom=UDim.new(0,10)
    local lay=Instance.new("UIListLayout",pill); lay.FillDirection=Enum.FillDirection.Horizontal; lay.VerticalAlignment=Enum.VerticalAlignment.Center; lay.Padding=UDim.new(0,8); lay.SortOrder=Enum.SortOrder.LayoutOrder
    if opts.Icon then local ico=Instance.new("ImageLabel",pill); ico.Image=opts.Icon; ico.ImageColor3=Color3.new(1,1,1); ico.Size=UDim2.fromOffset(22,22); ico.BackgroundTransparency=1; ico.LayoutOrder=1 end
    local lbl=Instance.new("TextLabel",pill); lbl.Text=opts.Text or ""; lbl.Font=Enum.Font.GothamBold; lbl.TextSize=20; lbl.TextColor3=Color3.new(1,1,1); lbl.BackgroundTransparency=1; lbl.AutomaticSize=Enum.AutomaticSize.XY; lbl.LayoutOrder=2
    pill.BackgroundTransparency=1; lbl.TextTransparency=1
    TweenService:Create(pill,TweenInfo.new(0.2),{BackgroundTransparency=0}):Play()
    TweenService:Create(lbl,TweenInfo.new(0.2),{TextTransparency=0}):Play()
    TweenService:Create(wrap,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0.88,0)}):Play()
    task.delay(opts.Duration or 3,function()
        if not (wrap and wrap.Parent) then return end
        TweenService:Create(pill,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
        TweenService:Create(lbl,TweenInfo.new(0.3),{TextTransparency=1}):Play()
        local tout=TweenService:Create(wrap,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,1.15,0)})
        tout:Play(); tout.Completed:Connect(function() pcall(function() wrap:Destroy() end) end)
    end)
end

local function showGreenDonation(amount,recipientName)
    playDonSnd(amount)
    local sg=playerGui:FindFirstChild("_GreenDonGui")
    if not sg then sg=Instance.new("ScreenGui"); sg.Name="_GreenDonGui"; sg.ResetOnSpawn=false; sg.DisplayOrder=12003; sg.Parent=playerGui end
    local wrap=Instance.new("Frame",sg); wrap.AnchorPoint=Vector2.new(0.5,1); wrap.Position=UDim2.new(0.5,0,1.15,0)
    wrap.Size=UDim2.fromOffset(0,64); wrap.AutomaticSize=Enum.AutomaticSize.X; wrap.BackgroundTransparency=1
    local pill=Instance.new("Frame",wrap); pill.AnchorPoint=Vector2.new(0.5,0.5); pill.Position=UDim2.new(0.5,0,0.5,0)
    pill.Size=UDim2.fromOffset(0,64); pill.AutomaticSize=Enum.AutomaticSize.X; pill.BackgroundColor3=Color3.fromRGB(0,140,60); pill.BorderSizePixel=0
    Instance.new("UICorner",pill).CornerRadius=UDim.new(1,0)
    local pad=Instance.new("UIPadding",pill); pad.PaddingLeft=UDim.new(0,28); pad.PaddingRight=UDim.new(0,28); pad.PaddingTop=UDim.new(0,12); pad.PaddingBottom=UDim.new(0,12)
    local lay=Instance.new("UIListLayout",pill); lay.FillDirection=Enum.FillDirection.Horizontal; lay.VerticalAlignment=Enum.VerticalAlignment.Center; lay.Padding=UDim.new(0,10)
    local ico=Instance.new("ImageLabel",pill); ico.Image=ROBUX_ICON; ico.Size=UDim2.fromOffset(28,28); ico.BackgroundTransparency=1; ico.ImageColor3=Color3.fromRGB(180,255,180); ico.LayoutOrder=1
    local txt=Instance.new("TextLabel",pill); txt.Text="you donated "..fmt(amount).." to "..tostring(recipientName).."!"; txt.Font=Enum.Font.GothamBlack; txt.TextSize=22; txt.TextColor3=Color3.new(1,1,1); txt.BackgroundTransparency=1; txt.AutomaticSize=Enum.AutomaticSize.XY; txt.LayoutOrder=2
    pill.BackgroundTransparency=1; txt.TextTransparency=1
    TweenService:Create(pill,TweenInfo.new(0.2),{BackgroundTransparency=0}):Play()
    TweenService:Create(txt,TweenInfo.new(0.2),{TextTransparency=0}):Play()
    TweenService:Create(wrap,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0.82,0)}):Play()
    task.delay(4,function()
        if not (wrap and wrap.Parent) then return end
        TweenService:Create(pill,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play(); TweenService:Create(txt,TweenInfo.new(0.3),{TextTransparency=1}):Play()
        local t=TweenService:Create(wrap,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,1.15,0)}); t:Play(); t.Completed:Connect(function() pcall(function() wrap:Destroy() end) end)
    end)
end

local function showSentGiftNotification()
    local sg=playerGui:FindFirstChild("_SentGiftGui")
    if not sg then sg=Instance.new("ScreenGui"); sg.Name="_SentGiftGui"; sg.ResetOnSpawn=false; sg.DisplayOrder=12005; sg.Parent=playerGui end
    local wrap=Instance.new("Frame",sg); wrap.AnchorPoint=Vector2.new(0.5,1); wrap.Position=UDim2.new(0.5,0,1.2,0); wrap.Size=UDim2.fromOffset(0,62); wrap.AutomaticSize=Enum.AutomaticSize.X; wrap.BackgroundTransparency=1
    local container=Instance.new("Frame",wrap); container.AnchorPoint=Vector2.new(0.5,0.5); container.Position=UDim2.new(0.5,0,0.5,0); container.Size=UDim2.fromOffset(0,62); container.AutomaticSize=Enum.AutomaticSize.X; container.BackgroundColor3=Color3.fromRGB(255,20,110); container.BorderSizePixel=0
    Instance.new("UICorner",container).CornerRadius=UDim.new(1,0)
    local cStroke=Instance.new("UIStroke",container); cStroke.Color=Color3.new(1,1,1); cStroke.Transparency=0.3; cStroke.Thickness=3
    local padding=Instance.new("UIPadding",container); padding.PaddingLeft=UDim.new(0,28); padding.PaddingRight=UDim.new(0,28); padding.PaddingTop=UDim.new(0,12); padding.PaddingBottom=UDim.new(0,12)
    local layout=Instance.new("UIListLayout",container); layout.FillDirection=Enum.FillDirection.Horizontal; layout.VerticalAlignment=Enum.VerticalAlignment.Center; layout.HorizontalAlignment=Enum.HorizontalAlignment.Center; layout.Padding=UDim.new(0,8)
    local icon=Instance.new("ImageLabel",container); icon.Image="rbxassetid://15047358527"; icon.ImageColor3=Color3.new(1,1,1); icon.Size=UDim2.fromOffset(28,28); icon.BackgroundTransparency=1; icon.ImageTransparency=1; icon.LayoutOrder=1
    local sentWord=Instance.new("TextLabel",container); sentWord.Text="sent"; sentWord.Font=Enum.Font.GothamBlack; sentWord.TextSize=24; sentWord.TextColor3=Color3.new(1,1,1); sentWord.BackgroundTransparency=1; sentWord.TextTransparency=1; sentWord.AutomaticSize=Enum.AutomaticSize.XY; sentWord.LayoutOrder=2
    local giftWord=Instance.new("TextLabel",container); giftWord.Text="gift!"; giftWord.Font=Enum.Font.GothamBlack; giftWord.TextSize=24; giftWord.TextColor3=Color3.fromRGB(255,230,60); giftWord.BackgroundTransparency=1; giftWord.TextTransparency=1; giftWord.AutomaticSize=Enum.AutomaticSize.XY; giftWord.LayoutOrder=3
    container.BackgroundTransparency=1; cStroke.Transparency=1
    playS(SOUNDS.Success,1.4)
    TweenService:Create(wrap,TweenInfo.new(0.55,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,0,0.88,0)}):Play()
    TweenService:Create(container,TweenInfo.new(0.18),{BackgroundTransparency=0}):Play()
    TweenService:Create(cStroke,TweenInfo.new(0.18),{Transparency=0.3}):Play()
    TweenService:Create(icon,TweenInfo.new(0.22,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{ImageTransparency=0}):Play()
    TweenService:Create(sentWord,TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{TextTransparency=0}):Play()
    task.delay(0.32,function()
        if not (giftWord and giftWord.Parent) then return end
        playS(SOUNDS.Coins,1.6)
        TweenService:Create(giftWord,TweenInfo.new(0.18,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{TextTransparency=0,TextSize=32}):Play()
        task.delay(0.18,function()
            if not (giftWord and giftWord.Parent) then return end
            TweenService:Create(giftWord,TweenInfo.new(0.14,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextSize=24,TextColor3=Color3.new(1,1,1)}):Play()
        end)
    end)
    task.delay(3.5,function()
        if not (wrap and wrap.Parent) then return end
        local fo=TweenInfo.new(0.35,Enum.EasingStyle.Quad,Enum.EasingDirection.In)
        TweenService:Create(container,fo,{BackgroundTransparency=1}):Play(); TweenService:Create(cStroke,fo,{Transparency=1}):Play()
        TweenService:Create(icon,fo,{ImageTransparency=1}):Play()
        TweenService:Create(sentWord,fo,{TextTransparency=1}):Play()
        TweenService:Create(giftWord,fo,{TextTransparency=1}):Play()
        local t=TweenService:Create(wrap,TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,1.2,0)}); t:Play(); t.Completed:Connect(function() pcall(function() wrap:Destroy() end) end)
    end)
end

local addLiveDonationEntry
local function fireNotifs(recipientName,amount,style)
    style=style or CFG.notifStyle
    local online=false
    for _,p in ipairs(Players:GetPlayers()) do if p.Name:lower()==(recipientName or ""):lower() then online=true;break end end
    if style=="none" then return end
    if style=="pink" then task.delay(0.3,function() showSentGiftNotification() end)
    elseif style=="green" then showGreenDonation(amount,recipientName)
    else if online then showGreenDonation(amount,recipientName) else task.delay(0.3,function() showSentGiftNotification() end) end end
    addLiveDonationEntry(CFG.customName and #CFG.customName>0 and CFG.customName or player.Name, recipientName, amount)
end

local activeBBs={}
local function removeBBs() for _,bb in ipairs(activeBBs) do pcall(function() if bb and bb.Parent then bb:Destroy() end end) end; activeBBs={} end
local function applyBadges(char)
    removeBBs(); local head=char:FindFirstChild("Head"); if not head then return end
    local hum=char:FindFirstChild("Humanoid"); if hum then hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None end
    local bb=Instance.new("BillboardGui"); bb.Name="FazoxBadgeBB"; bb.Adornee=head; bb.Size=UDim2.fromOffset(260,70); bb.StudsOffsetWorldSpace=Vector3.new(0,3,0); bb.AlwaysOnTop=true; bb.LightInfluence=0; bb.Parent=head; table.insert(activeBBs,bb)
    local bRow=Instance.new("Frame",bb); bRow.AutomaticSize=Enum.AutomaticSize.X; bRow.Size=UDim2.new(0,0,0,20); bRow.Position=UDim2.new(0.5,0,0,8); bRow.AnchorPoint=Vector2.new(0.5,0); bRow.BackgroundTransparency=1
    local bList=Instance.new("UIListLayout",bRow); bList.FillDirection=Enum.FillDirection.Horizontal; bList.HorizontalAlignment=Enum.HorizontalAlignment.Center; bList.VerticalAlignment=Enum.VerticalAlignment.Center; bList.Padding=UDim.new(0,4)
    local function mkPill(parent,text,col,order) local f=Instance.new("Frame",parent); f.AutomaticSize=Enum.AutomaticSize.X; f.Size=UDim2.new(0,0,0,20); f.BackgroundColor3=col; f.BorderSizePixel=0; f.LayoutOrder=order; Instance.new("UICorner",f).CornerRadius=UDim.new(1,0); local pad=Instance.new("UIPadding",f); pad.PaddingLeft=UDim.new(0,9); pad.PaddingRight=UDim.new(0,9); local lbl=Instance.new("TextLabel",f); lbl.Text=text; lbl.AutomaticSize=Enum.AutomaticSize.X; lbl.Size=UDim2.new(0,0,1,0); lbl.BackgroundTransparency=1; lbl.TextColor3=Color3.new(1,1,1); lbl.TextSize=11; lbl.Font=Enum.Font.GothamBold end
    if CFG.developerBadge then mkPill(bRow,CFG.badgeText or "Developer",CFG.badgeColor or Color3.fromRGB(255,70,71),1) end
    if CFG.vipBadge then mkPill(bRow,"VIP",Color3.fromRGB(254,168,8),2) end
    local nRow=Instance.new("Frame",bb); nRow.AutomaticSize=Enum.AutomaticSize.XY; nRow.Size=UDim2.new(0,0,0,18); nRow.Position=UDim2.new(0.5,0,0,33); nRow.AnchorPoint=Vector2.new(0.5,0); nRow.BackgroundTransparency=1
    local nList=Instance.new("UIListLayout",nRow); nList.FillDirection=Enum.FillDirection.Horizontal; nList.VerticalAlignment=Enum.VerticalAlignment.Center; nList.HorizontalAlignment=Enum.HorizontalAlignment.Center; nList.Padding=UDim.new(0,3)
    if CFG.nameEnabled and CFG.customName and #CFG.customName>0 then
        if CFG.showCheckmark then local ckBox=Instance.new("Frame",nRow); ckBox.Size=UDim2.fromOffset(16,16); ckBox.BackgroundColor3=Color3.fromRGB(30,100,255); ckBox.BorderSizePixel=0; ckBox.LayoutOrder=1; Instance.new("UICorner",ckBox).CornerRadius=UDim.new(0,4); local ckl=Instance.new("TextLabel",ckBox); ckl.Size=UDim2.new(1,0,1,0); ckl.BackgroundTransparency=1; ckl.Text="✓"; ckl.TextColor3=Color3.fromRGB(255,255,255); ckl.TextSize=11; ckl.Font=Enum.Font.GothamBold; ckl.TextXAlignment=Enum.TextXAlignment.Center; ckl.TextYAlignment=Enum.TextYAlignment.Center end
        local nl=Instance.new("TextLabel",nRow); nl.AutomaticSize=Enum.AutomaticSize.XY; nl.Size=UDim2.new(0,0,0,0); nl.BackgroundTransparency=1; nl.Text=CFG.customName; nl.TextColor3=CFG.nameColor; nl.TextSize=13; nl.Font=Enum.Font.GothamBold; nl.LayoutOrder=2
    end
end
player.CharacterAdded:Connect(applyBadges)
if player.Character then applyBadges(player.Character) end

local _overlayGui=nil
local function setHide(v)
    local char=player.Character; if not char then return end
    pcall(function() for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") or p:IsA("Decal") then p.LocalTransparencyModifier=v and 1 or 0 end end end)
end
local function destroyOverlay() if _overlayGui then pcall(function() _overlayGui:Destroy() end); _overlayGui=nil end end
local function spawnOverlay(userId,username)
    destroyOverlay()
    local ok,err=pcall(function()
        _overlayGui=Instance.new("ScreenGui"); _overlayGui.Name="FazoxAvatarOverlay"; _overlayGui.ResetOnSpawn=false; _overlayGui.DisplayOrder=5000; _overlayGui.Parent=playerGui
    end)
    if not ok then return false,"GUI error: "..tostring(err) end
    return true
end

local function spawnCoinRain(recipientName)
    task.spawn(function()
        pcall(function()
            local targetHRP=nil
            for _,p in ipairs(Players:GetPlayers()) do
                if p.Name:lower()==(recipientName or ""):lower() and p.Character then
                    targetHRP=p.Character:FindFirstChild("HumanoidRootPart"); break
                end
            end
            local myHRP=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local spawnPos=myHRP and myHRP.Position+Vector3.new(0,5,0) or Vector3.new(0,10,0)
            local FLIGHT_DUR=1.4
            local COIN_COUNT=12
            local FULL_SIZE=Vector3.new(1.4,0.2,1.4)
            for ci=1,COIN_COUNT do
                task.delay(ci*0.07,function()
                    pcall(function()
                        local coin=Instance.new("Part"); coin.Shape=Enum.PartType.Cylinder; coin.Size=Vector3.new(0.01,0.01,0.01); coin.BrickColor=BrickColor.new("Bright yellow"); coin.Material=Enum.Material.SmoothPlastic; coin.CastShadow=false; coin.Anchored=false; coin.CanCollide=false; coin.Transparency=0
                        coin.CFrame=CFrame.new(spawnPos+Vector3.new(math.random(-2,2),0,math.random(-2,2))); coin.Parent=workspace; Debris:AddItem(coin,8)
                        local lt=Instance.new("PointLight",coin); lt.Color=Color3.fromRGB(255,210,40); lt.Brightness=7; lt.Range=20
                        local att0=Instance.new("Attachment",coin); local att1=Instance.new("Attachment",coin); att1.Position=Vector3.new(0,0,-2)
                        local trail=Instance.new("Trail",coin); trail.Attachment0=att0; trail.Attachment1=att1; trail.Lifetime=0.22; trail.MinLength=0; trail.LightEmission=1
                        trail.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255,230,60)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,80,0))}); trail.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.1),NumberSequenceKeypoint.new(1,1)}); trail.Enabled=false
                        local bb=Instance.new("BillboardGui",coin); bb.Size=UDim2.fromOffset(54,54); bb.StudsOffset=Vector3.new(0,2,0); bb.AlwaysOnTop=false
                        local ico=Instance.new("ImageLabel",bb); ico.Size=UDim2.fromScale(1,1); ico.BackgroundTransparency=1; ico.Image=ROBUX_ICON; ico.ImageColor3=Color3.fromRGB(255,215,30); ico.ImageTransparency=1
                        TweenService:Create(coin,TweenInfo.new(0.14,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=FULL_SIZE}):Play(); TweenService:Create(ico,TweenInfo.new(0.12),{ImageTransparency=0}):Play()
                        task.wait(0.10); trail.Enabled=true
                        local elapsed=0; local spinAng=0; local coinDone=false; local flyConn
                        local function impactCoin() if coinDone then return end; coinDone=true; flyConn:Disconnect(); trail.Enabled=false; TweenService:Create(coin,TweenInfo.new(0.15,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=Vector3.new(0.01,0.01,0.01),Transparency=1}):Play(); TweenService:Create(lt,TweenInfo.new(0.12),{Brightness=0}):Play(); TweenService:Create(ico,TweenInfo.new(0.10),{ImageTransparency=1}):Play(); task.delay(0.25,function() pcall(function() coin:Destroy() end) end) end
                        flyConn=RunService.Heartbeat:Connect(function(dt) if not (coin and coin.Parent) then flyConn:Disconnect(); return end; elapsed=elapsed+dt; local t=math.min(elapsed/FLIGHT_DUR,1); local eased=t==1 and 1 or 1-math.pow(2,-10*t); spinAng=spinAng+dt*620; local curTarget=targetHRP and targetHRP.Position or spawnPos; local flat=spawnPos:Lerp(curTarget,eased); local arcH=4*t*(1-t)*8; local newPos=flat+Vector3.new(0,arcH,0); local dir=(curTarget-newPos); local targetCF=CFrame.new(newPos,newPos+(dir.Magnitude>0.01 and dir.Unit or Vector3.new(0,0,1)))*CFrame.Angles(0,math.rad(spinAng),0)*CFrame.Angles(0,0,math.rad(90)); pcall(function() coin.CFrame=targetCF end); coin.Size=FULL_SIZE*(1-eased*0.15); if (newPos-curTarget).Magnitude<3.2 or t>=1 then impactCoin() end end)
                    end)
                end)
            end
        end)
    end)
end

local function resolveBBText(template,playerName,recipName)
    local s=template or ""
    local actualPlayer = (CFG.bbUseCustomName and CFG.bbCustomName and #CFG.bbCustomName>0) and CFG.bbCustomName or playerName
    s=s:gsub("{player}", actualPlayer or "?")
    s=s:gsub("{user}", recipName or "?")
    return s
end

local function showNukeBillboard(amount,recipientName,buyerName)
    task.spawn(function()
        local landPos=NUKE_LAND_POS
        local startY=landPos.Y+18
        local endY=landPos.Y+110
        local carrier=Instance.new("Part"); carrier.Size=Vector3.new(0.1,0.1,0.1); carrier.Transparency=1; carrier.Anchored=true; carrier.CanCollide=false; carrier.CFrame=CFrame.new(landPos.X,startY,landPos.Z); carrier.Parent=workspace; Debris:AddItem(carrier,45)
        local donBB=Instance.new("BillboardGui",carrier); donBB.Size=UDim2.fromOffset(500,260); donBB.AlwaysOnTop=true; donBB.MaxDistance=900; donBB.LightInfluence=0
        local card=Instance.new("Frame",donBB); card.Size=UDim2.fromScale(1,1); card.BackgroundTransparency=1; card.AnchorPoint=Vector2.new(0.5,0.5); card.Position=UDim2.fromScale(0.5,0.5)
        local logoImg=Instance.new("ImageLabel",card); logoImg.Size=UDim2.fromOffset(200,200); logoImg.AnchorPoint=Vector2.new(0.5,0.5); logoImg.Position=UDim2.fromScale(0.5,0.5); logoImg.BackgroundTransparency=1; logoImg.Image=ROBUX_THUMB; logoImg.ImageColor3=Color3.fromRGB(200,200,200); logoImg.ImageTransparency=0.15; logoImg.ZIndex=1
        local line1=Instance.new("TextLabel",card); line1.Size=UDim2.new(1,0,0,38); line1.Position=UDim2.new(0,0,0,10); line1.BackgroundTransparency=1; line1.Text="@"..string.upper(resolveBBText(CFG.bbLine1,buyerName or player.Name,recipientName)); line1.Font=Enum.Font.GothamBlack; line1.TextSize=28; line1.TextColor3=Color3.fromRGB(255,255,255); line1.TextStrokeTransparency=0; line1.TextStrokeColor3=Color3.fromRGB(200,80,0); line1.TextXAlignment=Enum.TextXAlignment.Center; line1.ZIndex=5
        local line2=Instance.new("TextLabel",card); line2.Size=UDim2.new(1,0,0,120); line2.Position=UDim2.new(0,0,0,50); line2.BackgroundTransparency=1; line2.Text=fmt(amount); line2.Font=Enum.Font.GothamBlack; line2.TextSize=88; line2.TextColor3=Color3.fromRGB(255,213,0); line2.TextStrokeTransparency=0; line2.TextStrokeColor3=Color3.fromRGB(120,50,0); line2.TextXAlignment=Enum.TextXAlignment.Center; line2.ZIndex=5
        local line3=Instance.new("TextLabel",card); line3.Size=UDim2.new(1,0,0,34); line3.Position=UDim2.new(0,0,0,178); line3.BackgroundTransparency=1; line3.Text="TO @"..string.upper(resolveBBText(CFG.bbLine3,buyerName or player.Name,recipientName)); line3.Font=Enum.Font.GothamBlack; line3.TextSize=26; line3.TextColor3=Color3.fromRGB(255,255,255); line3.TextStrokeTransparency=0; line3.TextStrokeColor3=Color3.fromRGB(200,80,0); line3.TextXAlignment=Enum.TextXAlignment.Center; line3.ZIndex=5
        local riseConn; local riseElapsed=0; local RISE_TOTAL=22
        riseConn=RunService.Heartbeat:Connect(function(dt)
            if not (carrier and carrier.Parent) then riseConn:Disconnect(); return end
            riseElapsed=riseElapsed+dt
            local t=math.min(riseElapsed/RISE_TOTAL,1)
            local eased=1-math.pow(1-t,2)
            carrier.CFrame=CFrame.new(landPos.X,startY+(endY-startY)*eased,landPos.Z)
            if t>=1 then riseConn:Disconnect() end
        end)
        task.delay(34,function() if donBB and donBB.Parent then TweenService:Create(donBB,TweenInfo.new(2.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{StudsOffsetWorldSpace=Vector3.new(0,0,0)}):Play() end end)
    end)
end

local _donRunning  = false
local _lastDonTick = -999

addLiveDonationEntry = function(donorDisplayName, recipientRealName, amount)
    if _donRunning then return end
    local now = tick()
    if now - _lastDonTick < 10 then return end
    _donRunning  = true
    _lastDonTick = now

    task.spawn(function() pcall(function()
        local mapUICont = playerGui:WaitForChild("MapUIContainer", 5)
        if not mapUICont then _donRunning = false; return end
        local mapUI = mapUICont:WaitForChild("MapUI", 5)
        if not mapUI then _donRunning = false; return end
        local liveDon = mapUI:WaitForChild("LiveDonations", 5)
        if not liveDon then _donRunning = false; return end

        local scroll = liveDon
        for _, v in ipairs(liveDon:GetChildren()) do
            if v:IsA("ScrollingFrame") or
               (v:IsA("Frame") and v.Name ~= "UIListLayout" and v.Name ~= "UIPadding") then
                scroll = v; break
            end
        end

        local donThumb = ""
        local recThumb = ""
        local isOnline = false

        pcall(function()
            donThumb = Players:GetUserThumbnailAsync(
                player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
        pcall(function()
            local rp = Players:FindFirstChild(recipientRealName or "")
            if rp then
                isOnline = true
                recThumb = Players:GetUserThumbnailAsync(
                    rp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            else
                local ok, uid = pcall(function()
                    return Players:GetUserIdFromNameAsync(recipientRealName or "")
                end)
                if ok and uid then
                    recThumb = Players:GetUserThumbnailAsync(
                        uid, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                end
            end
        end)

        local CARD_H = 90; local AVA = 60; local PAD = 10
        local TOP = (CARD_H - AVA) / 2

        local clone = Instance.new("Frame")
        clone.Name        = "FazoxDonCard"
        clone.LayoutOrder = -math.floor(tick())
        clone.Size        = UDim2.new(1, -6, 0, CARD_H)
        clone.BackgroundColor3       = Color3.fromRGB(40, 20, 60)
        clone.BackgroundTransparency = 0.1
        clone.BorderSizePixel        = 0
        Instance.new("UICorner", clone).CornerRadius = UDim.new(0, CARD_H / 2)
        local stroke = Instance.new("UIStroke", clone)
        stroke.Color = Color3.fromRGB(180, 130, 255); stroke.Transparency = 0.6; stroke.Thickness = 1

        local function mkCircleAva(parent, img, anchorRight)
            local f = Instance.new("Frame", parent)
            f.Size = UDim2.fromOffset(AVA, AVA)
            f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            f.BorderSizePixel  = 0
            if anchorRight then
                f.AnchorPoint = Vector2.new(1, 0)
                f.Position    = UDim2.new(1, -PAD, 0, TOP)
            else
                f.Position = UDim2.fromOffset(PAD, TOP)
            end
            Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
            local s = Instance.new("UIStroke", f)
            s.Color = Color3.fromRGB(120, 80, 200); s.Thickness = 2.5
            local i = Instance.new("ImageLabel", f)
            i.Size = UDim2.new(1, 0, 1, 0)
            i.BackgroundTransparency = 1
            i.Image = img; i.ScaleType = Enum.ScaleType.Crop
            Instance.new("UICorner", i).CornerRadius = UDim.new(1, 0)
        end
        mkCircleAva(clone, donThumb, false)
        mkCircleAva(clone, recThumb, true)

        local amtF = Instance.new("Frame", clone)
        amtF.AnchorPoint = Vector2.new(0.5, 0.5)
        amtF.Position    = UDim2.new(0.5, 0, 0.42, 0)
        amtF.Size        = UDim2.new(0, 0, 0, 30)
        amtF.AutomaticSize = Enum.AutomaticSize.X
        amtF.BackgroundTransparency = 1
        local lay = Instance.new("UIListLayout", amtF)
        lay.FillDirection = Enum.FillDirection.Horizontal
        lay.VerticalAlignment = Enum.VerticalAlignment.Center
        lay.Padding = UDim.new(0, 3)
        local rIco = Instance.new("ImageLabel", amtF)
        rIco.Size = UDim2.fromOffset(18, 18)
        rIco.BackgroundTransparency = 1
        rIco.Image = ROBUX_ICON
        rIco.ImageColor3 = Color3.fromRGB(255, 255, 255)
        rIco.LayoutOrder = 1
        local amtL = Instance.new("TextLabel", amtF)
        amtL.Size = UDim2.new(0, 0, 1, 0)
        amtL.AutomaticSize = Enum.AutomaticSize.X
        amtL.BackgroundTransparency = 1
        amtL.Text = fmt(amount)
        amtL.Font = Enum.Font.GothamBlack
        amtL.TextSize = 20
        amtL.TextColor3 = Color3.fromRGB(255, 255, 255)
        amtL.LayoutOrder = 2

        local sub = Instance.new("TextLabel", clone)
        sub.AnchorPoint = Vector2.new(0.5, 0)
        sub.Position    = UDim2.new(0.5, 0, 0.58, 0)
        sub.Size        = UDim2.new(0.5, 0, 0, 14)
        sub.BackgroundTransparency = 1
        sub.Text   = "donated to"
        sub.Font   = Enum.Font.Gotham
        sub.TextSize = 10
        sub.TextColor3 = Color3.fromRGB(200, 180, 240)
        sub.TextXAlignment = Enum.TextXAlignment.Center

        clone.Position = UDim2.new(-1.1, 0, 0, 0)
        clone.Parent   = scroll

        local pillColor = isOnline and Color3.fromRGB(40, 190, 90) or Color3.fromRGB(220, 50, 100)
        local pill = Instance.new("Frame", clone)
        pill.Name = "FazoxPill"
        pill.Size = UDim2.fromOffset(54, 13)
        pill.AnchorPoint = Vector2.new(0.5, 0)
        pill.Position = UDim2.new(0.5, 0, 0, 3)
        pill.BackgroundColor3 = pillColor
        pill.BorderSizePixel = 0; pill.ZIndex = 8
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)
        local pl = Instance.new("TextLabel", pill)
        pl.Size = UDim2.new(1, 0, 1, 0); pl.BackgroundTransparency = 1
        pl.Text = isOnline and "● Online" or "● Offline"
        pl.Font = Enum.Font.GothamBold; pl.TextSize = 7
        pl.TextColor3 = Color3.fromRGB(255, 255, 255)
        pl.TextXAlignment = Enum.TextXAlignment.Center; pl.ZIndex = 9

        TweenService:Create(clone,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 3, 0, 0)}):Play()

        task.delay(28, function() pcall(function()
            TweenService:Create(clone,
                TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {BackgroundTransparency = 1}):Play()
            task.wait(0.7); clone:Destroy()
        end) end)

        task.wait(1)
        _donRunning = false
    end) end)
end

local function findNukeTemplate()
    local template=nil
    pcall(function() local n=workspace.Map.NukeIsland.NukePlatform.Other.RobuxNuke; if n and (n:IsA("Model")or n:IsA("BasePart")) then template=n; return end; n=workspace.Map.NukeIsland.Nuke; if n and (n:IsA("Model")or n:IsA("BasePart")) then template=n end end)
    if template then return template end
    pcall(function() local function findByName(parent,depth) if depth>6 or template then return end; for _,c in ipairs(parent:GetChildren()) do if c.Name=="Nuke" and (c:IsA("Model")or c:IsA("BasePart")) then template=c; return end; findByName(c,depth+1) end end; findByName(workspace,0) end)
    return template
end
local function playNukeSnd(id,vol,pitch,looped)
    if not CFG.enableSounds then return {Stop=function()end,Destroy=function()end} end
    local s=Instance.new("Sound"); s.SoundId=id or ""; s.Volume=vol or 1; s.PlaybackSpeed=pitch or 1; s.Looped=looped or false; s.RollOffMaxDistance=10000; s.Parent=workspace; s:Play(); trackSnd(s)
    if not looped then s.Ended:Connect(function() pcall(function() s:Destroy() end) end); Debris:AddItem(s,18) end
    return s
end
local function RescaleParticle(p,s) if not p then return end; pcall(function() p.Speed=NumberRange.new(p.Speed.Min*s,p.Speed.Max*s); p.Acceleration=p.Acceleration*s; local kps=p.Size.Keypoints; local nkps={}; for _,kp in ipairs(kps) do table.insert(nkps,NumberSequenceKeypoint.new(kp.Time,kp.Value*s,kp.Envelope*s)) end; p.Size=NumberSequence.new(nkps) end) end
local function makeBloom(intensity,size,threshold) local b=Instance.new("BloomEffect"); b.Name="FazoxNukeBloom"; b.Enabled=true; b.Intensity=intensity; b.Size=size; b.Threshold=threshold or 0.25; b.Parent=Lighting; return b end
local function screenShake(duration,amplitude) local cam=workspace.CurrentCamera; if not cam then return end; task.spawn(function() local elapsed=0; local conn; conn=RunService.RenderStepped:Connect(function(dt) elapsed=elapsed+dt; if elapsed>=duration then conn:Disconnect(); return end; local fade=1-(elapsed/duration); local ox=(math.random()-0.5)*amplitude*fade*2; local oy=(math.random()-0.5)*amplitude*fade*2; pcall(function() cam.CFrame=cam.CFrame*CFrame.new(ox,oy,0) end) end) end) end

local _nukeActive=false; local _nukeOrigCFGlobal=nil; local _nukeCloneRef=nil; local _nukeSetCFRef=nil; local _nukeRestoreFunc=nil
local function resetNukeNow() pcall(function() if _nukeRestoreFunc then _nukeRestoreFunc(); _nukeRestoreFunc=nil elseif _nukeCloneRef and _nukeOrigCFGlobal and _nukeSetCFRef then _nukeSetCFRef(_nukeOrigCFGlobal); _nukeActive=false end end) end

local function triggerNuke(recipientName, amount)
    if not CFG.nukeEnabled then return end
    if _nukeActive then showNotif({Color=Color3.fromRGB(255,140,0),Text="Nuke already in progress!",Duration=2}); return end
    _nukeActive=true
    table.clear(_activeNukeSounds)

    task.spawn(function()
        local alarmSnd=playNukeSnd(SOUNDS.NukeAlarm,2.5,1,true)
        task.delay(CFG.nukeAlarmDur+4,function() pcall(function() alarmSnd:Stop(); alarmSnd:Destroy() end) end)

        local nukeTemplate=findNukeTemplate()
        if not nukeTemplate then
            showNotif({Color=Color3.fromRGB(255,60,60),Text="Nuke model not found!",Duration=5})
            pcall(function() alarmSnd:Stop(); alarmSnd:Destroy() end); _nukeActive=false; return
        end

        local _origNukeCF=nil
        pcall(function() if nukeTemplate:IsA("BasePart") then _origNukeCF=nukeTemplate.CFrame else _origNukeCF=nukeTemplate:GetPivot() end end)
        if not _origNukeCF then _nukeActive=false; return end

        local original=nukeTemplate; local clone=nil
        pcall(function() clone=original:Clone() end)
        if not clone then _nukeActive=false; return end

        pcall(function()
            for _,p in ipairs(clone:GetDescendants()) do
                if p:IsA("Sound") then p.Volume = 0; p:Stop(); p.Looped = false end
            end
        end)

        pcall(function()
            for _,p in ipairs(original:GetDescendants()) do if p:IsA("BasePart") then p.LocalTransparencyModifier=1 end; if p:IsA("Sound") then p:SetAttribute("_origVol", p.Volume); p.Volume=0; p:Stop() end end
            if original:IsA("BasePart") then original.LocalTransparencyModifier=1 end
        end)

        local function doRestoreNuke()
            pcall(function() clone:Destroy() end)
            pcall(function() for _,p in ipairs(original:GetDescendants()) do if p:IsA("BasePart") then p.LocalTransparencyModifier=0 end; if p:IsA("Sound") then p.Volume=p:GetAttribute("_origVol") or 1 end end; if original:IsA("BasePart") then original.LocalTransparencyModifier=0 end end)
            _nukeActive=false
        end

        _nukeOrigCFGlobal=_origNukeCF; _nukeCloneRef=clone; _nukeRestoreFunc=doRestoreNuke

        local function getBasePart() if clone:IsA("BasePart") then return clone end; return clone.PrimaryPart or clone:FindFirstChildWhichIsA("BasePart") end
        local function setCF(cf) if clone:IsA("BasePart") then pcall(function() clone.CFrame=cf end) else pcall(function() clone:PivotTo(cf) end) end end
        _nukeSetCFRef=setCF

        local CenterEmitPoint=clone:FindFirstChild("CenterEmitPoint"); local ThrustEmitPoint=clone:FindFirstChild("ThrustEmitPoint")
        local Frame=nil; pcall(function() Frame=clone.BillboardGuiAnimation.Frame end)
        local Objects=clone:FindFirstChild("Objects"); local confettiBoxTemplate=nil
        if Objects then pcall(function() local cb=Objects:FindFirstChild("ConfettiBox"); if cb then confettiBoxTemplate=cb:Clone() end end); pcall(function() Objects:Destroy() end) end

        local landPos=NUKE_LAND_POS
        local bp=getBasePart(); if not bp then clone:Destroy(); return end
        for _,p in ipairs(clone:GetDescendants()) do if p:IsA("BasePart") then p.Anchored=true; p.CanCollide=false end end
        if clone:IsA("BasePart") then clone.Anchored=true; clone.CanCollide=false end

        local platformCF=_origNukeCF; local platformPos=platformCF.Position
        setCF(platformCF); clone.Parent=workspace

        local smokeFolder=Instance.new("Folder"); smokeFolder.Parent=workspace; Debris:AddItem(smokeFolder,35)
        local function spawnGroundSmoke(pos,count)
            for i=1,count do task.delay(i*0.05,function() pcall(function()
                local p=Instance.new("Part"); p.Size=Vector3.new(0.5,0.5,0.5); p.Transparency=1; p.Anchored=true; p.CanCollide=false; p.CastShadow=false
                p.CFrame=CFrame.new(pos+Vector3.new(math.random(-3,3),0,math.random(-3,3))); p.Parent=smokeFolder
                local sm=Instance.new("Smoke",p); sm.Color=Color3.fromRGB(230,230,230); sm.Opacity=math.random(60,80)/100; sm.RiseVelocity=math.random(8,14); sm.Size=math.random(4,7)
            end) end) end
        end

        alarmSnd:Stop()

        playNukeSnd(SOUNDS.NukePreLaunch,2,0.8)
        task.delay(0.5,function() playNukeSnd(SOUNDS.NukePreThrust,1.8,0.85) end)
        task.delay(1.2,function() playNukeSnd(SOUNDS.NukePreThrust2,1.5,0.9) end)

        local function spawnLaunchSmokeBurst(pos, count, radius, size, dur)
            for i=1,count do task.delay(i*0.04, function() pcall(function()
                local p=Instance.new("Part"); p.Shape=Enum.PartType.Ball
                p.Size=Vector3.new(size,size,size); p.Transparency=0.18
                p.Anchored=true; p.CanCollide=false; p.CastShadow=false
                local angle=math.random()*math.pi*2; local r=math.random()*radius
                p.CFrame=CFrame.new(pos+Vector3.new(math.cos(angle)*r, math.random(-2,4), math.sin(angle)*r))
                p.BrickColor=BrickColor.new("Medium stone grey"); p.Material=Enum.Material.SmoothPlastic
                p.Parent=smokeFolder
                TweenService:Create(p,TweenInfo.new(dur,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=Vector3.new(size*5,size*5,size*5),Transparency=1}):Play()
                task.delay(dur+0.5,function() pcall(function() p:Destroy() end) end)
            end) end) end
        end

        spawnLaunchSmokeBurst(platformPos, 20, 6, 8, 2.8)
        spawnGroundSmoke(platformPos-Vector3.new(0,5,0), 14)

        local SHAKE_DUR=1.5; local shakeElapsed=0; local shakeConn
        shakeConn=RunService.Heartbeat:Connect(function(dt)
            if not (clone and clone.Parent) then shakeConn:Disconnect(); return end
            shakeElapsed=shakeElapsed+dt
            if shakeElapsed>=SHAKE_DUR then shakeConn:Disconnect(); return end
            local intensity=0.15+(shakeElapsed/SHAKE_DUR)*0.45
            local vx=(math.random()-0.5)*intensity*2
            local vz=(math.random()-0.5)*intensity*2
            local vy=math.sin(shakeElapsed*22)*0.1
            pcall(function() setCF(CFrame.new(platformPos+Vector3.new(vx,vy,vz))) end)
        end)
        task.wait(SHAKE_DUR)
        if shakeConn then shakeConn:Disconnect() end

        local RISE_HEIGHT = 340
        local RISE_DUR    = 4.0

        local function launchTrailSmoke(startPos)
            task.spawn(function()
                local lastY=startPos.Y-8; local smokeConn
                smokeConn=RunService.Heartbeat:Connect(function()
                    local currentPos=nil; pcall(function() if clone:IsA("BasePart") then currentPos=clone.Position else currentPos=clone:GetPivot().Position end end)
                    if not currentPos then return end
                    if currentPos.Y > lastY + 4 then
                        lastY=currentPos.Y
                        pcall(function()
                            local altitude=(currentPos.Y-startPos.Y)/RISE_HEIGHT
                            local puffSize=math.max(2.5, 9*(1-altitude*0.6))
                            local puff=Instance.new("Part"); puff.Shape=Enum.PartType.Ball
                            puff.Size=Vector3.new(puffSize,puffSize,puffSize); puff.Transparency=0.22
                            puff.Anchored=true; puff.CanCollide=false; puff.CastShadow=false
                            puff.BrickColor=BrickColor.new("Medium stone grey"); puff.Material=Enum.Material.SmoothPlastic
                            puff.CFrame=CFrame.new(currentPos+Vector3.new(math.random(-2,2),-3,math.random(-2,2))); puff.Parent=smokeFolder
                            local expandSize=puffSize*5
                            TweenService:Create(puff,TweenInfo.new(5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=Vector3.new(expandSize,expandSize,expandSize),Transparency=1}):Play()
                            task.delay(5.5,function() pcall(function() puff:Destroy() end) end)
                        end)
                    end
                    if not (clone and clone.Parent) then smokeConn:Disconnect() end
                end)
            end)
        end

        spawnLaunchSmokeBurst(platformPos, 16, 3, 6, 1.6)
        playNukeSnd(SOUNDS.NukeLaunch,4,1)
        task.delay(0.3,function() playNukeSnd(SOUNDS.NukeThrust,2.5,1) end)
        if ThrustEmitPoint then pcall(function() ThrustEmitPoint.SmokeLaunch:Emit(90); for _,v in pairs(ThrustEmitPoint:GetChildren()) do v.Enabled=true end; ThrustEmitPoint.SmokeRing.Enabled=false; ThrustEmitPoint.SmokeLaunch.Enabled=false; ThrustEmitPoint.BigShockwave.Enabled=false; ThrustEmitPoint.Flare:Emit(30); ThrustEmitPoint.SmokeRing:Emit(90) end) end
        if CenterEmitPoint then pcall(function() CenterEmitPoint.Rays1.Enabled=true; CenterEmitPoint.Rays2.Enabled=true; CenterEmitPoint.Rays3.Enabled=true end) end
        pcall(function() clone.Sparkles.Enabled=true end)
        launchTrailSmoke(platformPos)

        local bloom=makeBloom(1.2,24,0.2)
        TweenService:Create(bloom,TweenInfo.new(0.35,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Intensity=2.8,Size=42}):Play()
        task.delay(0.4,function() TweenService:Create(bloom,TweenInfo.new(2.8,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Intensity=-1,Size=8}):Play() end)

        local riseElapsed=0; local riseConn
        riseConn=RunService.Heartbeat:Connect(function(dt)
            if not (clone and clone.Parent) then riseConn:Disconnect(); return end
            riseElapsed=riseElapsed+dt
            local rt=math.min(riseElapsed/RISE_DUR,1)
            local ease
            if rt < 0.12 then
                ease=(rt/0.12)*(rt/0.12)*0.03
            else
                local rt2=(rt-0.12)/0.88
                ease=0.03+0.97*(rt2==1 and 1 or (1-math.pow(2,-8*rt2)))
            end
            local riseY=ease*RISE_HEIGHT
            local wobFade=math.max(0,1-rt*3)
            local wobX=math.sin(riseElapsed*2.4)*0.4*wobFade
            local wobZ=math.cos(riseElapsed*1.9)*0.4*wobFade
            local horizX=platformPos.X+(landPos.X-platformPos.X)*ease+wobX
            local horizZ=platformPos.Z+(landPos.Z-platformPos.Z)*ease+wobZ
            local newPos=Vector3.new(horizX, platformPos.Y+riseY, horizZ)
            pcall(function() setCF(CFrame.new(newPos)) end)
            if rt>=1 then riseConn:Disconnect() end
        end)
        task.wait(RISE_DUR)
        if riseConn then riseConn:Disconnect() end

        local peakPos=Vector3.new(landPos.X, platformPos.Y+RISE_HEIGHT, landPos.Z)

        for i=1,6 do task.delay(i*0.06,function() pcall(function()
            local puff=Instance.new("Part"); puff.Shape=Enum.PartType.Ball; puff.Size=Vector3.new(12,12,12); puff.Transparency=0.2; puff.Anchored=true; puff.CanCollide=false; puff.CastShadow=false
            local mushroomColor = i<=3 and BrickColor.new("Bright orange") or BrickColor.new("Medium stone grey")
            puff.BrickColor=mushroomColor; puff.Material=Enum.Material.SmoothPlastic
            local spread = (i-1)*8
            puff.CFrame=CFrame.new(peakPos+Vector3.new(math.random(-spread,spread),0,math.random(-spread,spread))); puff.Parent=smokeFolder
            TweenService:Create(puff,TweenInfo.new(4.0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=Vector3.new(80+i*10,60+i*8,80+i*10),Transparency=1}):Play()
            task.delay(4.5,function() pcall(function() puff:Destroy() end) end)
        end) end) end

        task.wait(0.25)
        playNukeSnd(SOUNDS.NukeFall,2.5,1)

        local TILT_DUR=0.8; local tiltElapsed=0; local tiltConn
        local startTiltCF=CFrame.new(peakPos)
        local endTiltCF=CFrame.new(peakPos,landPos)*CFrame.Angles(-math.pi/2,0,0)
        tiltConn=RunService.Heartbeat:Connect(function(dt)
            if not (clone and clone.Parent) then tiltConn:Disconnect(); return end
            tiltElapsed=tiltElapsed+dt
            local t=math.min(tiltElapsed/TILT_DUR,1)
            local eased=math.sin(t*math.pi/2)
            pcall(function() setCF(startTiltCF:Lerp(endTiltCF,eased)) end)
            if t>=1 then tiltConn:Disconnect() end
        end)
        task.wait(TILT_DUR)
        if tiltConn then tiltConn:Disconnect() end

        local DIVE_DUR  = 1.75
        local DIVE_SPIN = 580
        local diveStart=tick(); local diveStartPos=peakPos; local diveDone=false; local diveConn

        task.spawn(function()
            while not diveDone do
                task.wait(0.05)
                local curPos=nil; pcall(function() if clone:IsA("BasePart") then curPos=clone.Position else curPos=clone:GetPivot().Position end end)
                if curPos then pcall(function()
                    local puff=Instance.new("Part"); puff.Shape=Enum.PartType.Ball; puff.Size=Vector3.new(4,4,4); puff.Transparency=0.28; puff.Anchored=true; puff.CanCollide=false; puff.CastShadow=false
                    puff.BrickColor=BrickColor.new("Medium stone grey"); puff.Material=Enum.Material.SmoothPlastic
                    puff.CFrame=CFrame.new(curPos+Vector3.new(math.random(-1,1),1,math.random(-1,1))); puff.Parent=smokeFolder
                    TweenService:Create(puff,TweenInfo.new(2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=Vector3.new(16,16,16),Transparency=1}):Play()
                    task.delay(2.5,function() pcall(function() puff:Destroy() end) end)
                end) end
            end
        end)

        diveConn=RunService.Heartbeat:Connect(function()
            if not (clone and clone.Parent) then diveConn:Disconnect(); return end
            local elapsed=tick()-diveStart; local progress=math.min(elapsed/DIVE_DUR,1)
            local eased=progress*progress*(3-2*progress)
            eased=math.max(0,math.min(1,eased))
            local pos=diveStartPos:Lerp(landPos,eased); local spinAngle=math.rad(DIVE_SPIN*elapsed)
            pcall(function() setCF(CFrame.new(pos,landPos)*CFrame.Angles(-math.pi/2,0,0)*CFrame.Angles(0,spinAngle,0)) end)
            if progress>=1 then diveConn:Disconnect(); diveDone=true end
        end)

        local waited=0; while not diveDone and waited<DIVE_DUR+1.5 do task.wait(0.03); waited=waited+0.03 end
        if diveConn then diveConn:Disconnect() end; diveDone=true

        local impactCF=CFrame.new(landPos+Vector3.new(0,2,0)); setCF(impactCF); bp.Transparency=1; bp.Size=Vector3.new(0.1,0.1,0.1)

        playNukeSnd(SOUNDS.NukeLandHands,5.5,1)
        task.delay(0.04,function() playNukeSnd(SOUNDS.Explosion,4,1) end)
        task.delay(0.08,function() playNukeSnd(SOUNDS.Explosion2,3.5,0.95) end)
        task.delay(0.12,function() playNukeSnd(SOUNDS.ShakeNuke,3.5,1) end)
        task.delay(0.22,function() playNukeSnd(SOUNDS.NukeLand,3,1) end)
        task.delay(0.40,function() playNukeSnd(SOUNDS.Applause,2,1) end)
        task.delay(0.55,function() playNukeSnd(SOUNDS.FallingCoins,2.5,1) end)
        task.delay(0.70,function() playNukeSnd(SOUNDS.Coins,2,1) end)

        screenShake(4,0.8)
        pcall(function() clone.PreThruster:Stop(); clone.Thruster:Stop(); clone.Thruster2:Stop(); clone.Explosion.TimePosition=0.75; clone.Explosion:Play(); clone.ChimeLoop.Volume=0; clone.ApplauseLoop.Volume=0; clone.CoinsLoop.Volume=0 end)

        bloom.Intensity=2.2; bloom.Size=55
        TweenService:Create(bloom,TweenInfo.new(10,Enum.EasingStyle.Circular,Enum.EasingDirection.Out),{Intensity=-1,Size=10}):Play()

        if ThrustEmitPoint then pcall(function() for _,v in pairs(ThrustEmitPoint:GetChildren()) do v.Enabled=false end end) end
        pcall(function() clone.Sparkles.Enabled=false end)
        if CenterEmitPoint then pcall(function() for _,v in pairs(CenterEmitPoint:GetChildren()) do v.Enabled=false end; CenterEmitPoint.SparkleExplosion:Emit(140); CenterEmitPoint.Shockwave:Emit(25); CenterEmitPoint.FractalBurst:Emit(5); CenterEmitPoint.RaysBig:Emit(30); CenterEmitPoint.Spark1:Emit(150); CenterEmitPoint.Spark2:Emit(150); CenterEmitPoint.Spark3:Emit(80) end) end
        pcall(function() clone.Sparks.Enabled=true; TweenService:Create(clone.Sparks,TweenInfo.new(30,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Rate=0}):Play() end)

        if confettiBoxTemplate then pcall(function() local cb=confettiBoxTemplate:Clone(); cb.Position=landPos+Vector3.new(0,5,0); cb.Parent=workspace; TweenService:Create(cb,TweenInfo.new(10,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=Vector3.new(1000,100,1000)}):Play(); task.spawn(function() for _,v in pairs(cb:GetChildren()) do if v:IsA("ParticleEmitter") then v.Enabled=true end end; task.wait(50); for _,v in pairs(cb:GetChildren()) do if v:IsA("ParticleEmitter") then TweenService:Create(v,TweenInfo.new(40),{Rate=0}):Play() end end; task.wait(45); cb.Size=Vector3.new(0,0,0); task.wait(20); cb:Destroy() end) end) end

        task.delay(0.3,function() if CFG.nukeBillboard then showNukeBillboard(amount,recipientName,player.Name) end end)
        task.delay(0.5,function() addLiveDonationEntry(CFG.customName and #CFG.customName>0 and CFG.customName or player.Name, recipientName, amount) end)
        task.delay(0.2,function() spawnCoinRain(recipientName) end)
        task.delay(10,function() pcall(function() bloom:Destroy() end) end)

        task.delay(14,function()
            stopAllNukeSounds()
            pcall(function()
                for _,s in ipairs(clone:GetDescendants()) do if s:IsA("Sound") then s:Stop() end end
            end)
        end)

        task.spawn(function()
            task.wait(30)
            pcall(function()
                if not _origNukeCF then return end
                local bp2=getBasePart(); if not bp2 then return end
                local retStartCF=nil; pcall(function() if clone:IsA("BasePart") then retStartCF=clone.CFrame else retStartCF=clone:GetPivot() end end)
                if not retStartCF then return end
                local retStartPos=retStartCF.Position; local retTargetPos=_origNukeCF.Position; local retDur=4; local retElapsed=0
                if CFG.enableSounds then playNukeSnd(SOUNDS.NukePreThrust,2,1.05); task.delay(0.9,function() playNukeSnd(SOUNDS.NukeLaunch,3,1.1) end) end
                local retConn; retConn=RunService.Heartbeat:Connect(function(dt) retElapsed=retElapsed+dt; local t=math.min(retElapsed/retDur,1); local ease=t<0.5 and 4*t*t*t or 1-(-2*t+2)^3/2; local lerpPos=retStartPos:Lerp(retTargetPos,ease); local arcH=60*math.sin(t*math.pi); local spinA=math.rad(300*retElapsed); local newPos=lerpPos+Vector3.new(0,arcH,0); pcall(function() setCF(CFrame.new(newPos,retTargetPos)*CFrame.Angles(-math.pi/2,0,0)*CFrame.Angles(0,spinA,0)) end); if t>=1 then retConn:Disconnect(); pcall(function() setCF(_origNukeCF) end); if CFG.enableSounds then playNukeSnd(SOUNDS.NukeLandHands,3.5,1); task.delay(0.5,function() playNukeSnd(SOUNDS.NukeLand,4,1) end) end; task.delay(1.5,function() doRestoreNuke(); _nukeRestoreFunc=nil end) end end)
            end)
        end)
    end)
end

local function getInfo(itemFrame,forcePrice,forceAsset)
    local info={name="Donation",price=forcePrice or 0,username="Player",assetId=forceAsset,imageId=nil}
    if not itemFrame then return info end
    pcall(function() info.price=itemFrame:GetAttribute("AssetPrice") or info.price; info.assetId=itemFrame:GetAttribute("AssetId") or info.assetId; local n=itemFrame:GetAttribute("AssetName"); if n and n~="" then info.name=n end; local cn=itemFrame:GetAttribute("CreatorName"); if cn and cn~="" then info.username=cn end end)
    pcall(function() local cid=itemFrame:GetAttribute("CreatorId"); if cid and cid>0 then local ok,name=pcall(function() return Players:GetNameFromUserIdAsync(cid) end); if ok and name then info.username=name end end end)
    if info.username=="Player" then pcall(function() local cur=itemFrame; for _=1,12 do cur=cur.Parent; if not cur then break end; for _,d in pairs(cur:GetDescendants()) do if d:IsA("TextLabel") and d.Text and d.Visible then local m=d.Text:match("@([%w_]+)"); if m and #m>=3 then info.username=m; return end end end end end) end
    if info.assetId then pcall(function() local prod=MarketplaceService:GetProductInfo(info.assetId,Enum.InfoType.GamePass); if prod then if prod.Name and prod.Name~="" then info.name=prod.Name end; if prod.PriceInRobux and prod.PriceInRobux>0 then info.price=prod.PriceInRobux end; if prod.IconImageAssetId and prod.IconImageAssetId>0 then info.imageId=prod.IconImageAssetId end; if prod.Creator and prod.Creator.Name then info.username=prod.Creator.Name end end end) end
    return info
end

local KColors={BgDark=Color3.fromRGB(30,30,35),White=Color3.fromRGB(255,255,255),ButtonBase=Color3.fromRGB(0,70,180),FillColor=Color3.fromRGB(0,110,255),Overlay=Color3.fromRGB(0,0,0)}
local function kAddStroke(p,t,c,tr) local s=Instance.new("UIStroke");s.Color=c;s.Thickness=t;s.Transparency=tr;s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border;s.Parent=p;return s end
local function kFadeGroup(c,tT,ti) TweenService:Create(c,ti,{BackgroundTransparency=tT}):Play(); for _,v in pairs(c:GetDescendants()) do if v:IsA("TextLabel")or v:IsA("TextBox") then TweenService:Create(v,ti,{TextTransparency=tT}):Play() elseif v:IsA("ImageLabel") then TweenService:Create(v,ti,{ImageTransparency=tT}):Play() elseif v:IsA("TextButton") then TweenService:Create(v,ti,{TextTransparency=tT}):Play(); if v.Name=="CloseButton" then TweenService:Create(v,ti,{BackgroundTransparency=1}):Play() else TweenService:Create(v,ti,{BackgroundTransparency=tT}):Play() end elseif v:IsA("Frame") and v.Name=="FillBar" then TweenService:Create(v,ti,{BackgroundTransparency=tT}):Play() elseif v:IsA("UIStroke") then TweenService:Create(v,ti,{Transparency=tT==1 and 1 or 0.6}):Play() end end end
local function kResetVis(f) f.BackgroundTransparency=0; for _,v in pairs(f:GetDescendants()) do if v:IsA("TextLabel")or v:IsA("TextBox") then v.TextTransparency=0 elseif v:IsA("ImageLabel") then v.ImageTransparency=0 elseif v:IsA("TextButton") then v.TextTransparency=0; if v.Name=="CloseButton" then v.BackgroundTransparency=1 else v.BackgroundTransparency=0 end elseif v:IsA("Frame") and v.Name=="FillBar" then v.BackgroundTransparency=0 elseif v:IsA("UIStroke") then v.Transparency=0.6 end end end
local kratoGui=Instance.new("ScreenGui");kratoGui.Name="KratoFakeRobux";kratoGui.ResetOnSpawn=false;kratoGui.IgnoreGuiInset=true;kratoGui.DisplayOrder=10005;kratoGui.Parent=playerGui
local kModalOv=Instance.new("Frame",kratoGui);kModalOv.Name="ModalOv";kModalOv.Size=UDim2.new(1,0,1,0);kModalOv.BackgroundColor3=KColors.Overlay;kModalOv.BackgroundTransparency=1;kModalOv.Visible=false;kModalOv.ZIndex=8
local function toggleKratoOv(show) kModalOv.Visible=true;local t=show and 0.6 or 1;local tw=TweenService:Create(kModalOv,TweenInfo.new(0.25),{BackgroundTransparency=t});tw:Play();if not show then tw.Completed:Connect(function() if kModalOv.BackgroundTransparency>=0.99 then kModalOv.Visible=false end end) end end
local function kCreatePanel(name,w,h,parent) local f=Instance.new("Frame");f.Name=name;f.Size=UDim2.new(0,w,0,h);f.AnchorPoint=Vector2.new(0.5,0.5);f.Position=UDim2.new(0.5,0,0.5,0);f.BackgroundColor3=KColors.BgDark;f.BorderSizePixel=0;f.ZIndex=10;f.Parent=parent;Instance.new("UICorner",f).CornerRadius=UDim.new(0,10);return f end
local kBuyFrame=kCreatePanel("BuyFrame",450,225,kratoGui);kBuyFrame.Visible=false;kAddStroke(kBuyFrame,1.5,Color3.fromRGB(60,60,80),0)
local kBTitle=Instance.new("TextLabel",kBuyFrame);kBTitle.Text="Buy item";kBTitle.Font=Enum.Font.GothamBlack;kBTitle.TextSize=22;kBTitle.TextColor3=KColors.White;kBTitle.BackgroundTransparency=1;kBTitle.Size=UDim2.new(0,150,0,30);kBTitle.Position=UDim2.new(0,20,0,10);kBTitle.TextXAlignment=Enum.TextXAlignment.Left;kBTitle.ZIndex=20
local kHeaderCont=Instance.new("Frame",kBuyFrame);kHeaderCont.BackgroundTransparency=1;kHeaderCont.Size=UDim2.new(0,260,0,30);kHeaderCont.AnchorPoint=Vector2.new(1,0);kHeaderCont.Position=UDim2.new(1,-15,0,10);kHeaderCont.ZIndex=20
local kHLay=Instance.new("UIListLayout",kHeaderCont);kHLay.FillDirection=Enum.FillDirection.Horizontal;kHLay.HorizontalAlignment=Enum.HorizontalAlignment.Right;kHLay.VerticalAlignment=Enum.VerticalAlignment.Center;kHLay.SortOrder=Enum.SortOrder.LayoutOrder;kHLay.Padding=UDim.new(0,8)
local kCloseXBtn=Instance.new("TextButton",kHeaderCont);kCloseXBtn.Name="CloseButton";kCloseXBtn.Text="X";kCloseXBtn.Font=Enum.Font.Gotham;kCloseXBtn.TextSize=24;kCloseXBtn.TextColor3=KColors.White;kCloseXBtn.BackgroundTransparency=1;kCloseXBtn.AutoButtonColor=false;kCloseXBtn.Size=UDim2.new(0,25,0,25);kCloseXBtn.LayoutOrder=3;kCloseXBtn.ZIndex=20
local kRText=Instance.new("TextLabel",kHeaderCont);kRText.Text="0";kRText.Font=Enum.Font.GothamMedium;kRText.TextSize=16;kRText.TextColor3=KColors.White;kRText.BackgroundTransparency=1;kRText.AutomaticSize=Enum.AutomaticSize.X;kRText.Size=UDim2.new(0,0,1,0);kRText.LayoutOrder=2;kRText.ZIndex=20;regBal(kRText)
local kRIcon=Instance.new("ImageLabel",kHeaderCont);kRIcon.Image=ROBUX_THUMB;kRIcon.BackgroundTransparency=1;kRIcon.Size=UDim2.new(0,20,0,20);kRIcon.LayoutOrder=1;kRIcon.ZIndex=20
local kItemImgF=Instance.new("Frame",kBuyFrame);kItemImgF.BackgroundTransparency=1;kItemImgF.Size=UDim2.new(0,75,0,75);kItemImgF.Position=UDim2.new(0,35,0,55);kItemImgF.ZIndex=20
local kItemImg=Instance.new("ImageLabel",kItemImgF);kItemImg.Size=UDim2.fromScale(1,1);kItemImg.BackgroundTransparency=1;kItemImg.Image=ROBUX_THUMB;kItemImg.ZIndex=20;Instance.new("UICorner",kItemImg).CornerRadius=UDim.new(0,8)
local kInfoCont=Instance.new("Frame",kBuyFrame);kInfoCont.BackgroundTransparency=1;kInfoCont.Position=UDim2.new(0,125,0,55);kInfoCont.Size=UDim2.new(1,-145,0,0);kInfoCont.AutomaticSize=Enum.AutomaticSize.Y;kInfoCont.ZIndex=20
local kInfoLay=Instance.new("UIListLayout",kInfoCont);kInfoLay.SortOrder=Enum.SortOrder.LayoutOrder;kInfoLay.Padding=UDim.new(0,5)
local kIName=Instance.new("TextLabel",kInfoCont);kIName.Text="Gamepass";kIName.Font=Enum.Font.GothamBold;kIName.TextSize=20;kIName.TextColor3=KColors.White;kIName.BackgroundTransparency=1;kIName.Size=UDim2.new(1,0,0,0);kIName.AutomaticSize=Enum.AutomaticSize.Y;kIName.TextWrapped=true;kIName.TextXAlignment=Enum.TextXAlignment.Left;kIName.TextYAlignment=Enum.TextYAlignment.Top;kIName.LayoutOrder=1;kIName.ZIndex=20
local kPriceRow=Instance.new("Frame",kInfoCont);kPriceRow.BackgroundTransparency=1;kPriceRow.Size=UDim2.new(1,0,0,24);kPriceRow.LayoutOrder=2;kPriceRow.ZIndex=20
local kPIcon=Instance.new("ImageLabel",kPriceRow);kPIcon.Image=ROBUX_THUMB;kPIcon.BackgroundTransparency=1;kPIcon.ImageColor3=KColors.White;kPIcon.Size=UDim2.new(0,20,0,20);kPIcon.Position=UDim2.new(0,0,0.5,0);kPIcon.AnchorPoint=Vector2.new(0,0.5);kPIcon.ZIndex=20
local kPText=Instance.new("TextLabel",kPriceRow);kPText.Text="0";kPText.Font=Enum.Font.Gotham;kPText.TextSize=18;kPText.TextColor3=KColors.White;kPText.BackgroundTransparency=1;kPText.Size=UDim2.new(1,-25,1,0);kPText.Position=UDim2.new(0,25,0,0);kPText.TextXAlignment=Enum.TextXAlignment.Left;kPText.ZIndex=20
local kBuyBtn=Instance.new("TextButton",kBuyFrame);kBuyBtn.Text="";kBuyBtn.BackgroundColor3=KColors.ButtonBase;kBuyBtn.Size=UDim2.new(0.9,0,0,42);kBuyBtn.Position=UDim2.new(0.05,0,0.73,0);kBuyBtn.ClipsDescendants=true;kBuyBtn.ZIndex=20;kBuyBtn.AutoButtonColor=false;Instance.new("UICorner",kBuyBtn).CornerRadius=UDim.new(0,8)
local kFillBar=Instance.new("Frame",kBuyBtn);kFillBar.Name="FillBar";kFillBar.BackgroundColor3=KColors.FillColor;kFillBar.BorderSizePixel=0;kFillBar.Size=UDim2.new(0,0,1,0);kFillBar.ZIndex=21;Instance.new("UICorner",kFillBar).CornerRadius=UDim.new(0,8)
local kBtnLbl=Instance.new("TextLabel",kBuyBtn);kBtnLbl.Text="Buy";kBtnLbl.Font=Enum.Font.GothamBlack;kBtnLbl.TextSize=20;kBtnLbl.TextColor3=KColors.White;kBtnLbl.BackgroundTransparency=1;kBtnLbl.Size=UDim2.new(1,0,1,0);kBtnLbl.ZIndex=22
local kSuccessFrame=kCreatePanel("SuccessFrame",450,225,kratoGui);kSuccessFrame.Visible=false;kAddStroke(kSuccessFrame,1.5,Color3.fromRGB(60,60,80),0)
local kSTitle=kBTitle:Clone();kSTitle.Text="Purchase completed";kSTitle.Parent=kSuccessFrame
local kSHeaderCont=kHeaderCont:Clone();kSHeaderCont.Parent=kSuccessFrame;local kSX=kSHeaderCont:FindFirstChildWhichIsA("TextButton")
local kSRText=kSHeaderCont:FindFirstChildWhichIsA("TextLabel"); if kSRText then regBal(kSRText) end
local kCheckImg=Instance.new("TextLabel",kSuccessFrame);kCheckImg.Text="✓";kCheckImg.Font=Enum.Font.GothamBold;kCheckImg.TextSize=30;kCheckImg.TextColor3=Color3.fromRGB(240,240,240);kCheckImg.BackgroundTransparency=1;kCheckImg.Size=UDim2.new(0,36,0,36);kCheckImg.AnchorPoint=Vector2.new(0.5,0);kCheckImg.Position=UDim2.new(0.5,0,0.3,0);kCheckImg.TextXAlignment=Enum.TextXAlignment.Center;kCheckImg.TextYAlignment=Enum.TextYAlignment.Center;kCheckImg.ZIndex=20
local kSMsg=Instance.new("TextLabel",kSuccessFrame);kSMsg.Text="You have successfully bought...";kSMsg.Font=Enum.Font.Gotham;kSMsg.TextSize=14;kSMsg.TextColor3=KColors.White;kSMsg.BackgroundTransparency=1;kSMsg.TextWrapped=true;kSMsg.Size=UDim2.new(0.9,0,0,40);kSMsg.AnchorPoint=Vector2.new(0.5,0);kSMsg.Position=UDim2.new(0.5,0,0.53,0);kSMsg.TextXAlignment=Enum.TextXAlignment.Center;kSMsg.ZIndex=20
local kOkBtn=Instance.new("TextButton",kSuccessFrame);kOkBtn.Text="Okay";kOkBtn.Font=Enum.Font.GothamBlack;kOkBtn.TextSize=20;kOkBtn.TextColor3=KColors.White;kOkBtn.BackgroundColor3=KColors.ButtonBase;kOkBtn.Size=UDim2.new(0.9,0,0,42);kOkBtn.Position=UDim2.new(0.05,0,0.73,0);kOkBtn.ZIndex=20;kOkBtn.AutoButtonColor=false;Instance.new("UICorner",kOkBtn).CornerRadius=UDim.new(0,8)
local kFillComplete=false;local kFillTween=nil;local kDeb=false;local kCurrentData=nil
local function kStartFill() kFillComplete=false;kFillBar.Size=UDim2.new(0,0,1,0);kFillBar.Visible=true;local ti=TweenInfo.new(2.25,Enum.EasingStyle.Quad,Enum.EasingDirection.In);kFillTween=TweenService:Create(kFillBar,ti,{Size=UDim2.new(1,0,1,0)});kFillTween.Completed:Connect(function(ps) if ps==Enum.PlaybackState.Completed then kFillComplete=true end end);kFillTween:Play() end
local kratoCloseAll
local function openKratoBuy(data)
    if CFG.isMenuOpen then return end; closeRealPrompts(); kCurrentData=data; CFG.isMenuOpen=true; kDeb=false
    if kItemImg then kItemImg.Image=data.imageId and "rbxassetid://"..tostring(data.imageId) or (data.assetId and "rbxthumb://type=GamePass&id="..tostring(data.assetId).."&w=150&h=150") or ROBUX_THUMB end
    if kIName then kIName.Text=data.name or "Donation" end; if kPText then kPText.Text=fmt(data.price or 0) end
    if kSMsg then kSMsg.Text="You have successfully bought "..(data.name or "Item").."." end
    kBuyFrame.Visible=true; kSuccessFrame.Visible=false; toggleKratoOv(true)
    kResetVis(kBuyFrame); kFadeGroup(kBuyFrame,1,TweenInfo.new(0)); kFadeGroup(kBuyFrame,0,TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out)); kStartFill()
end
kratoCloseAll=function() if kFillTween then kFillTween:Cancel() end; kBuyFrame.Visible=false; kSuccessFrame.Visible=false; toggleKratoOv(false); kDeb=false; CFG.isMenuOpen=false end
if kCloseXBtn then kCloseXBtn.MouseButton1Click:Connect(kratoCloseAll) end
if kSX then kSX.MouseButton1Click:Connect(kratoCloseAll) end
kBuyBtn.MouseButton1Click:Connect(function()
    if kDeb or not kFillComplete then return end; kDeb=true
    local data=kCurrentData
    if data and data.assetId and CFG.purchasedItems[data.assetId] then showNotif({Color=Color3.fromRGB(255,140,0),Icon="rbxassetid://15047371063",Text="Already owned",Duration=3}); kratoCloseAll(); return end
    if data then
        local price=data.price or 0; setBal(CFG.balance-price); updateStandUI(price); updateLeaderboard(price)
        if data.assetId then CFG.purchasedItems[data.assetId]=true end
        if CFG.nukeEnabled and CFG.nukeOnGamepass and price>=NUKE_THRESHOLD then
            task.delay(0.4,function() triggerNuke(data.username,price) end)
        else
            playDonSnd(price)
        end
    end
    local sp=kBuyFrame.Position; local dp=UDim2.new(sp.X.Scale,sp.X.Offset,sp.Y.Scale+0.02,sp.Y.Offset); local fo=TweenInfo.new(0.25,Enum.EasingStyle.Linear)
    TweenService:Create(kBuyFrame,fo,{Position=dp}):Play(); kFadeGroup(kBuyFrame,1,fo); task.wait(0.25); kBuyFrame.Visible=false
    kSuccessFrame.Visible=true; kSuccessFrame.Position=dp; kResetVis(kSuccessFrame); kFadeGroup(kSuccessFrame,1,TweenInfo.new(0))
    local fi=TweenInfo.new(0.25,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    TweenService:Create(kSuccessFrame,fi,{Position=sp}):Play(); kFadeGroup(kSuccessFrame,0,TweenInfo.new(0.25)); kDeb=false
    task.delay(0.3,function() fireNotifs(data and data.username or "?",data and data.price or 0,CFG.notifStyle); spawnCoinRain(data and data.username or "?") end)
end)
kOkBtn.MouseButton1Click:Connect(function()
    if not kSuccessFrame.Visible or kDeb then return end; kDeb=true
    local sp=kSuccessFrame.Position; local dp=UDim2.new(sp.X.Scale,sp.X.Offset,sp.Y.Scale+0.02,sp.Y.Offset); local fo=TweenInfo.new(0.25,Enum.EasingStyle.Linear)
    TweenService:Create(kSuccessFrame,fo,{Position=dp}):Play(); kFadeGroup(kSuccessFrame,1,fo)
    toggleKratoOv(false); task.wait(0.25); kSuccessFrame.Visible=false; kDeb=false; CFG.isMenuOpen=false
end)
UserInputService.InputBegan:Connect(function(inp,gpe) if not gpe and inp.KeyCode==Enum.KeyCode.X then kratoCloseAll() end end)
local kratoPromptObj={open=function(data) openKratoBuy(data) end,hideAll=function() kratoCloseAll() end,destroy=function() end}

local v3BuyScreenGui=nil; local v3SuccessScreenGui=nil; local v3CurrentData=nil; local v3Deb=false
local function v3ShowCompleted(data)
    if v3SuccessScreenGui then v3SuccessScreenGui:Destroy() end
    v3SuccessScreenGui=Instance.new("ScreenGui"); v3SuccessScreenGui.Parent=playerGui; v3SuccessScreenGui.DisplayOrder=10010; v3SuccessScreenGui.ResetOnSpawn=false
    local modal=Instance.new("Frame",v3SuccessScreenGui); modal.Size=UDim2.fromOffset(420,220); modal.Position=UDim2.fromScale(0.5,0.5); modal.AnchorPoint=Vector2.new(0.5,0.5); modal.BackgroundColor3=Color3.fromRGB(31,32,36); modal.BorderSizePixel=0; Instance.new("UICorner",modal).CornerRadius=UDim.new(0,14)
    local ttl=Instance.new("TextLabel",modal); ttl.Text="Purchase completed"; ttl.Font=Enum.Font.GothamBold; ttl.TextSize=18; ttl.TextXAlignment=Enum.TextXAlignment.Left; ttl.Position=UDim2.fromOffset(20,16); ttl.Size=UDim2.new(1,-40,0,24); ttl.TextColor3=Color3.fromRGB(240,240,240); ttl.BackgroundTransparency=1
    local function closeSuccess() v3SuccessScreenGui:Destroy(); CFG.isMenuOpen=false end
    local xBtn=Instance.new("TextButton",modal); xBtn.Position=UDim2.new(1,-36,0,16); xBtn.Size=UDim2.fromOffset(28,28); xBtn.Text="X"; xBtn.Font=Enum.Font.GothamBold; xBtn.TextSize=19; xBtn.BackgroundTransparency=1; xBtn.TextColor3=Color3.fromRGB(200,200,200); xBtn.MouseButton1Click:Connect(closeSuccess)
    local circ=Instance.new("Frame",modal); circ.Size=UDim2.fromOffset(52,52); circ.AnchorPoint=Vector2.new(0.5,0); circ.Position=UDim2.new(0.5,0,0,56); circ.BackgroundTransparency=1; circ.BorderSizePixel=0; Instance.new("UICorner",circ).CornerRadius=UDim.new(1,0)
    local cs=Instance.new("UIStroke",circ); cs.Thickness=3; cs.Color=Color3.fromRGB(200,200,200)
    local chk=Instance.new("TextLabel",circ); chk.Size=UDim2.new(1,0,1,0); chk.BackgroundTransparency=1; chk.Text="✓"; chk.Font=Enum.Font.GothamBold; chk.TextSize=32; chk.TextColor3=Color3.fromRGB(240,240,240); chk.TextXAlignment=Enum.TextXAlignment.Center; chk.TextYAlignment=Enum.TextYAlignment.Center
    local desc=Instance.new("TextLabel",modal); desc.Text="You have successfully bought "..(data and data.name or "Item").."."; desc.Font=Enum.Font.GothamMedium; desc.TextSize=15; desc.TextWrapped=true; desc.Position=UDim2.fromOffset(40,120); desc.Size=UDim2.new(1,-80,0,40); desc.TextColor3=Color3.fromRGB(220,220,220); desc.BackgroundTransparency=1
    local ok=Instance.new("TextButton",modal); ok.Size=UDim2.new(1,-40,0,36); ok.Position=UDim2.fromOffset(20,170); ok.Text="OK"; ok.Font=Enum.Font.GothamBold; ok.TextSize=15; ok.BackgroundColor3=Color3.fromRGB(0,120,255); ok.TextColor3=Color3.new(1,1,1); Instance.new("UICorner",ok).CornerRadius=UDim.new(0,8); ok.MouseButton1Click:Connect(closeSuccess)
    modal.Position=UDim2.fromScale(0.5,0.4); modal:TweenPosition(UDim2.fromScale(0.5,0.5),Enum.EasingDirection.Out,Enum.EasingStyle.Back,0.5,true)
end
local function openV3Buy(data)
    if CFG.isMenuOpen then return end; closeRealPrompts(); v3CurrentData=data; v3Deb=false; CFG.isMenuOpen=true
    if v3BuyScreenGui then v3BuyScreenGui:Destroy() end
    v3BuyScreenGui=Instance.new("ScreenGui"); v3BuyScreenGui.Name="V3PurchaseModal"; v3BuyScreenGui.Parent=playerGui; v3BuyScreenGui.DisplayOrder=10010; v3BuyScreenGui.ResetOnSpawn=false
    local modal=Instance.new("Frame",v3BuyScreenGui); modal.Size=UDim2.fromOffset(420,208); modal.Position=UDim2.fromScale(0.5,0.5); modal.AnchorPoint=Vector2.new(0.5,0.5); modal.BackgroundColor3=Color3.fromRGB(31,32,36); modal.BorderSizePixel=0; Instance.new("UICorner",modal).CornerRadius=UDim.new(0,14)
    local sk=Instance.new("UIStroke",modal); sk.Color=Color3.new(1,1,1); sk.Transparency=0.85
    local ttl=Instance.new("TextLabel",modal); ttl.Position=UDim2.fromOffset(20,16); ttl.Size=UDim2.new(1,-160,0,28); ttl.Text="Buy Item"; ttl.Font=Enum.Font.GothamBold; ttl.TextSize=19; ttl.TextXAlignment=Enum.TextXAlignment.Left; ttl.BackgroundTransparency=1; ttl.TextColor3=Color3.fromRGB(240,240,240)
    local balF=Instance.new("Frame",modal); balF.AnchorPoint=Vector2.new(1,0); balF.Position=UDim2.new(1,-42,0,14); balF.Size=UDim2.fromOffset(0,28); balF.AutomaticSize=Enum.AutomaticSize.X; balF.BackgroundTransparency=1
    local bFLay=Instance.new("UIListLayout",balF); bFLay.FillDirection=Enum.FillDirection.Horizontal; bFLay.VerticalAlignment=Enum.VerticalAlignment.Center; bFLay.Padding=UDim.new(0,4)
    local bRIco=Instance.new("ImageLabel",balF); bRIco.Image=ROBUX_ICON; bRIco.BackgroundTransparency=1; bRIco.Size=UDim2.fromOffset(16,16); bRIco.LayoutOrder=1
    local bRTxt=Instance.new("TextLabel",balF); bRTxt.Text="0"; bRTxt.Font=Enum.Font.GothamMedium; bRTxt.TextSize=14; bRTxt.TextColor3=Color3.fromRGB(220,220,220); bRTxt.BackgroundTransparency=1; bRTxt.AutomaticSize=Enum.AutomaticSize.X; bRTxt.Size=UDim2.new(0,0,1,0); bRTxt.LayoutOrder=2; regBal(bRTxt)
    local xBtn=Instance.new("TextButton",modal); xBtn.Position=UDim2.new(1,-15,0,15); xBtn.AnchorPoint=Vector2.new(1,0); xBtn.Size=UDim2.fromOffset(30,30); xBtn.Text="X"; xBtn.Font=Enum.Font.GothamBold; xBtn.TextSize=18; xBtn.BackgroundTransparency=1; xBtn.TextColor3=Color3.fromRGB(200,200,200); xBtn.MouseButton1Click:Connect(function() v3BuyScreenGui:Destroy(); CFG.isMenuOpen=false end)
    local row=Instance.new("Frame",modal); row.Position=UDim2.fromOffset(20,56); row.Size=UDim2.new(1,-40,0,64); row.BackgroundTransparency=1
    local icon=Instance.new("ImageLabel",row); icon.Size=UDim2.fromOffset(68,68); icon.BackgroundTransparency=1; icon.Image=data.imageId and "rbxassetid://"..tostring(data.imageId) or (data.assetId and "rbxthumb://type=GamePass&id="..tostring(data.assetId).."&w=150&h=150") or ROBUX_THUMB; Instance.new("UICorner",icon).CornerRadius=UDim.new(1,0)
    local tCol=Instance.new("Frame",row); tCol.Position=UDim2.fromOffset(78,0); tCol.Size=UDim2.new(1,-78,1,0); tCol.BackgroundTransparency=1
    local iName=Instance.new("TextLabel",tCol); iName.Position=UDim2.fromOffset(0,8); iName.Size=UDim2.new(1,0,0,24); iName.Text=data.name or "Donation"; iName.Font=Enum.Font.GothamBold; iName.TextSize=17; iName.TextXAlignment=Enum.TextXAlignment.Left; iName.BackgroundTransparency=1; iName.TextColor3=Color3.fromRGB(240,240,240)
    local pRow=Instance.new("Frame",tCol); pRow.Position=UDim2.fromOffset(0,38); pRow.Size=UDim2.fromOffset(120,20); pRow.BackgroundTransparency=1
    local rIco=Instance.new("ImageLabel",pRow); rIco.Size=UDim2.fromOffset(18,18); rIco.Position=UDim2.fromOffset(0,1); rIco.Image=ROBUX_ICON; rIco.BackgroundTransparency=1
    local pLbl=Instance.new("TextLabel",pRow); pLbl.Position=UDim2.fromOffset(20,0); pLbl.Size=UDim2.new(1,-20,1,0); pLbl.Text=fmt(data.price or 0); pLbl.Font=Enum.Font.GothamBold; pLbl.TextSize=15; pLbl.TextXAlignment=Enum.TextXAlignment.Left; pLbl.BackgroundTransparency=1; pLbl.TextColor3=Color3.fromRGB(240,240,240)
    local buyBtn=Instance.new("TextButton",modal); buyBtn.Position=UDim2.fromOffset(20,155); buyBtn.Size=UDim2.new(1,-40,0,36); buyBtn.BackgroundColor3=Color3.fromRGB(0,60,140); buyBtn.AutoButtonColor=false; buyBtn.Text=""; buyBtn.Active=false; Instance.new("UICorner",buyBtn).CornerRadius=UDim.new(0,8)
    local filler=Instance.new("Frame",buyBtn); filler.Size=UDim2.new(0,0,1,0); filler.BackgroundColor3=Color3.fromRGB(0,120,255); filler.BorderSizePixel=0; filler.ZIndex=2; Instance.new("UICorner",filler).CornerRadius=UDim.new(0,8)
    local bLbl=Instance.new("TextLabel",buyBtn); bLbl.Size=UDim2.new(1,0,1,0); bLbl.BackgroundTransparency=1; bLbl.Text="Buy"; bLbl.Font=Enum.Font.GothamBold; bLbl.TextSize=15; bLbl.TextColor3=Color3.new(1,1,1); bLbl.ZIndex=3
    modal.Position=UDim2.fromScale(0.5,0.4); modal:TweenPosition(UDim2.fromScale(0.5,0.5),Enum.EasingDirection.Out,Enum.EasingStyle.Back,0.5,true)
    task.spawn(function() task.wait(0.5); if not filler or not filler.Parent then return end; local tw=TweenService:Create(filler,TweenInfo.new(3.0,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(1,0,1,0)}); tw:Play(); tw.Completed:Wait(); if buyBtn and buyBtn.Parent then buyBtn.Active=true end end)
    buyBtn.MouseButton1Click:Connect(function()
        if v3Deb or not buyBtn.Active then return end; v3Deb=true
        local price=data.price or 0
        if data.assetId and CFG.purchasedItems[data.assetId] then showNotif({Color=Color3.fromRGB(255,140,0),Icon="rbxassetid://15047371063",Text="Already owned",Duration=3}); v3BuyScreenGui:Destroy(); CFG.isMenuOpen=false; return end
        setBal(CFG.balance-price); updateStandUI(price); updateLeaderboard(price)
        if data.assetId then CFG.purchasedItems[data.assetId]=true end
        if CFG.nukeEnabled and CFG.nukeOnGamepass and price>=NUKE_THRESHOLD then
            task.delay(0.4,function() triggerNuke(data.username,price) end)
        else
            playDonSnd(price)
        end
        v3BuyScreenGui:Destroy(); task.wait(0.3); v3ShowCompleted(data)
        task.delay(0.3,function() fireNotifs(data.username or "?",price,CFG.notifStyle); spawnCoinRain(data.username or "?") end)
    end)
end
local v3PromptObj={open=function(data) openV3Buy(data) end,hideAll=function() if v3BuyScreenGui then v3BuyScreenGui:Destroy(); CFG.isMenuOpen=false end; if v3SuccessScreenGui then v3SuccessScreenGui:Destroy() end end,destroy=function() end}

local activePrompt=nil
local function rebuildPrompt() if activePrompt and activePrompt~=kratoPromptObj and activePrompt~=v3PromptObj then pcall(function() activePrompt.destroy() end) end; if CFG.uiStyle=="v3" then activePrompt=v3PromptObj else activePrompt=kratoPromptObj end end
rebuildPrompt()
local function openPrompt(data) if CFG.isMenuOpen then return end; closeRealPrompts(); CFG.currentPurchase=data; activePrompt.open(data) end

local function getButtonId(obj) for name,val in pairs(obj:GetAttributes()) do if (name:lower():find("id")or name:lower():find("asset")) and type(val)=="number" then return val end end; for _,c in ipairs(obj:GetChildren()) do if (c.Name:lower():find("id")or c.Name:lower():find("asset")) and (c:IsA("NumberValue")or c:IsA("IntValue")) then return c.Value end end; if tonumber(obj.Name) then return tonumber(obj.Name) end; local id=obj.Name:match("Item(%d+)"); if id then return tonumber(id) end; if obj.Parent then local pid=obj.Parent.Name:match("Item(%d+)"); if pid then return tonumber(pid) end end; return nil end
local function getUsernameCtx(btn) for _,c in ipairs(btn:GetDescendants()) do if (c:IsA("TextLabel")or c:IsA("TextButton")) and c.Text then local u=c.Text:match("@([%w_]+)"); if u then return u end end end; local cur=btn; for _=1,10 do cur=cur.Parent; if not cur then break end; for _,d in pairs(cur:GetDescendants()) do if d:IsA("TextLabel") and d.Text and d.Visible then local m=d.Text:match("@([%w_]+)"); if m and #m>=3 then return m end end end end; return nil end
local function hookBtn(btn)
    if not (btn:IsA("TextButton")or btn:IsA("ImageButton")) then return end; if btn:FindFirstChild("__FD_Ov") then return end
    local id=getButtonId(btn); if not id then return end
    if getconnections then for _,ev in ipairs({"MouseButton1Click","Activated"}) do pcall(function() for _,conn in ipairs(getconnections(btn[ev])) do if conn.Function then pcall(function() conn:Disable() end) end end end) end end
    pcall(function() local old; old=hookmetamethod(game,"__namecall",newcclosure(function(self,...) local m=getnamecallmethod(); if self==MarketplaceService and (m=="PromptGamePassPurchase"or m=="PromptProductPurchase"or m=="PromptPurchase") then return end; return old(self,...) end)) end)
    local ov=Instance.new("TextButton"); ov.Name="__FD_Ov"; ov.BackgroundTransparency=1; ov.Text=""; ov.Size=UDim2.new(1,0,1,0); ov.ZIndex=(btn.ZIndex or 1)+10; ov.Parent=btn
    ov.MouseButton1Click:Connect(function() local cid=getButtonId(btn) or id; local info=getInfo(btn,0,cid); if info.username=="Player" then local u=getUsernameCtx(btn); if u then info.username=u end end; openPrompt(info) end)
end
local function setupIF(f) if not f or CFG.processedFrames[f] then return end; CFG.processedFrames[f]=true; if f:IsA("TextButton")or f:IsA("ImageButton") then hookBtn(f) else for _,c in ipairs(f:GetDescendants()) do if (c:IsA("TextButton")or c:IsA("ImageButton")) and not c:FindFirstChild("__FD_Ov") then if getButtonId(c) then hookBtn(c) end end end end end
task.spawn(function() task.wait(2); for _,f in pairs(CollectionService:GetTagged("ItemFrame")) do pcall(function() setupIF(f) end) end; for _,obj in ipairs(playerGui:GetDescendants()) do pcall(function() if (obj:IsA("TextButton")or obj:IsA("ImageButton")) and not obj:FindFirstChild("__FD_Ov") then if getButtonId(obj) then hookBtn(obj) end end end) end end)
CollectionService:GetInstanceAddedSignal("ItemFrame"):Connect(function(f) pcall(function() setupIF(f) end) end)
playerGui.DescendantAdded:Connect(function(d) task.delay(0.1,function() if d and d.Parent then hookBtn(d) end end) end)
task.spawn(function() while true do task.wait(4); pcall(function() for _,obj in ipairs(playerGui:GetDescendants()) do if (obj:IsA("TextButton")or obj:IsA("ImageButton")) and not obj:FindFirstChild("__FD_Ov") then if getButtonId(obj) then hookBtn(obj) end end end end) end end)

local mainGui=Instance.new("ScreenGui"); mainGui.Name="FazoxHubGui"; mainGui.Parent=playerGui; mainGui.ResetOnSpawn=false; mainGui.DisplayOrder=9999; mainGui.IgnoreGuiInset=true
local panel=Instance.new("Frame"); panel.Size=UDim2.new(0,300,0,430); panel.Position=UDim2.new(0,16,1,-450); panel.BackgroundColor3=Color3.fromRGB(12,10,20); panel.BorderSizePixel=0; panel.ClipsDescendants=true; panel.Parent=mainGui
Instance.new("UICorner",panel).CornerRadius=UDim.new(0,14)
local pGrad=Instance.new("UIGradient",panel); pGrad.Rotation=145; pGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(28,18,48)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(14,10,26)),ColorSequenceKeypoint.new(1,Color3.fromRGB(8,6,16))})
local pStroke=Instance.new("UIStroke",panel); pStroke.Color=Color3.fromRGB(110,50,200); pStroke.Thickness=1.5; pStroke.Transparency=0.3
task.spawn(function() local t=0; while panel and panel.Parent do t=t+0.02; local r=math.abs(math.sin(t))*0.3; pcall(function() pStroke.Transparency=0.15+r end); task.wait(0.04) end end)
local titleBar=Instance.new("Frame",panel); titleBar.Size=UDim2.new(1,0,0,40); titleBar.BackgroundColor3=Color3.fromRGB(22,12,42); titleBar.BorderSizePixel=0; Instance.new("UICorner",titleBar).CornerRadius=UDim.new(0,14)
local tbPatch=Instance.new("Frame",titleBar); tbPatch.Size=UDim2.new(1,0,0,14); tbPatch.Position=UDim2.new(0,0,1,-14); tbPatch.BackgroundColor3=Color3.fromRGB(22,12,42); tbPatch.BorderSizePixel=0
local tbGrad=Instance.new("UIGradient",titleBar); tbGrad.Rotation=90; tbGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(35,18,65)),ColorSequenceKeypoint.new(1,Color3.fromRGB(18,10,36))})
local titleIcon=Instance.new("TextLabel",titleBar); titleIcon.Size=UDim2.fromOffset(28,28); titleIcon.Position=UDim2.fromOffset(12,6); titleIcon.BackgroundTransparency=1; titleIcon.Text="☢"; titleIcon.Font=Enum.Font.GothamBlack; titleIcon.TextSize=20; titleIcon.TextColor3=Color3.fromRGB(180,80,255)
local titleLbl2=Instance.new("TextLabel",titleBar); titleLbl2.Size=UDim2.new(1,-100,1,0); titleLbl2.Position=UDim2.fromOffset(40,0); titleLbl2.BackgroundTransparency=1; titleLbl2.Text="FAZOX NUKE"; titleLbl2.TextColor3=Color3.fromRGB(220,190,255); titleLbl2.Font=Enum.Font.GothamBlack; titleLbl2.TextSize=14; titleLbl2.TextXAlignment=Enum.TextXAlignment.Left
local vBadge=Instance.new("Frame",titleBar); vBadge.Size=UDim2.fromOffset(56,18); vBadge.Position=UDim2.new(0,130,0.5,-9); vBadge.BackgroundColor3=Color3.fromRGB(90,30,160); vBadge.BorderSizePixel=0; Instance.new("UICorner",vBadge).CornerRadius=UDim.new(1,0)
local vLbl=Instance.new("TextLabel",vBadge); vLbl.Size=UDim2.fromScale(1,1); vLbl.BackgroundTransparency=1; vLbl.Text="V3 CUSTOM"; vLbl.Font=Enum.Font.GothamBold; vLbl.TextSize=7; vLbl.TextColor3=Color3.fromRGB(200,160,255)
do
    local dragging=false; local dragSP; local frameSP
    titleBar.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then dragging=true; dragSP=inp.Position; frameSP=panel.Position end end)
    titleBar.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
    UserInputService.InputChanged:Connect(function(inp) if not dragging then return end; if inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch then local delta=inp.Position-dragSP; panel.Position=UDim2.new(frameSP.X.Scale,frameSP.X.Offset+delta.X,frameSP.Y.Scale,frameSP.Y.Offset+delta.Y) end end)
end
local isMin=false; local fullSz=UDim2.new(0,300,0,430); local miniSz=UDim2.new(0,300,0,40)
local minBtn=Instance.new("TextButton",titleBar); minBtn.Size=UDim2.fromOffset(24,24); minBtn.Position=UDim2.new(1,-52,0.5,-12); minBtn.BackgroundColor3=Color3.fromRGB(60,40,90); minBtn.Text="-"; minBtn.Font=Enum.Font.GothamBold; minBtn.TextSize=16; minBtn.TextColor3=Color3.fromRGB(200,170,255); minBtn.AutoButtonColor=false; Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,6)
local closeHubBtn=Instance.new("TextButton",titleBar); closeHubBtn.Size=UDim2.fromOffset(24,24); closeHubBtn.Position=UDim2.new(1,-26,0.5,-12); closeHubBtn.BackgroundColor3=Color3.fromRGB(180,40,80); closeHubBtn.Text="✕"; closeHubBtn.Font=Enum.Font.GothamBold; closeHubBtn.TextSize=13; closeHubBtn.TextColor3=Color3.new(1,1,1); closeHubBtn.AutoButtonColor=false; Instance.new("UICorner",closeHubBtn).CornerRadius=UDim.new(0,6)
closeHubBtn.MouseButton1Click:Connect(function() destroyOverlay(); setHide(false); mainGui:Destroy() end)
minBtn.MouseButton1Click:Connect(function() isMin=not isMin; TweenService:Create(panel,TweenInfo.new(0.25,Enum.EasingStyle.Quad),{Size=isMin and miniSz or fullSz}):Play(); minBtn.Text=isMin and "+" or "-" end)

local tabY=40; local tabH=28; local tabNames={"Balance","Name","Avatar","Settings"}; local tabBtns={}; local tabConts={}
local tabIcons={"💰","👤","🎭","⚙️"}
local tabBar=Instance.new("Frame",panel); tabBar.Size=UDim2.new(1,0,0,tabH); tabBar.Position=UDim2.new(0,0,0,tabY); tabBar.BackgroundColor3=Color3.fromRGB(16,10,30); tabBar.BorderSizePixel=0
for i,name in ipairs(tabNames) do
    local btn=Instance.new("TextButton",tabBar); btn.Size=UDim2.new(0.25,0,1,0); btn.Position=UDim2.new(0.25*(i-1),0,0,0); btn.BackgroundColor3=i==1 and Color3.fromRGB(55,25,100) or Color3.fromRGB(20,14,36); btn.Text=tabIcons[i].." "..name; btn.Font=Enum.Font.GothamBold; btn.TextSize=9; btn.TextColor3=i==1 and Color3.fromRGB(210,180,255) or Color3.fromRGB(100,85,140); btn.AutoButtonColor=false; btn.BorderSizePixel=0; tabBtns[i]=btn
    local indicator=Instance.new("Frame",btn); indicator.Size=UDim2.new(i==1 and 0.7 or 0,0,0,2); indicator.Position=UDim2.new(0.5,0,1,-2); indicator.AnchorPoint=Vector2.new(0.5,0); indicator.BackgroundColor3=Color3.fromRGB(160,80,255); indicator.BorderSizePixel=0; indicator.Name="Indicator"
    local cont=Instance.new("ScrollingFrame",panel); cont.Size=UDim2.new(1,0,1,-(tabY+tabH)); cont.Position=UDim2.new(0,0,0,tabY+tabH); cont.BackgroundTransparency=1; cont.BorderSizePixel=0; cont.ScrollBarThickness=3; cont.ScrollBarImageColor3=Color3.fromRGB(120,60,200); cont.CanvasSize=UDim2.new(0,0,0,0); cont.AutomaticCanvasSize=Enum.AutomaticSize.Y; cont.Visible=i==1
    local lay=Instance.new("UIListLayout",cont); lay.Padding=UDim.new(0,6); local pad=Instance.new("UIPadding",cont); pad.PaddingLeft=UDim.new(0,10); pad.PaddingRight=UDim.new(0,10); pad.PaddingTop=UDim.new(0,8); pad.PaddingBottom=UDim.new(0,8); tabConts[i]=cont
    btn.MouseButton1Click:Connect(function()
        for j=1,#tabNames do tabConts[j].Visible=j==i; tabBtns[j].BackgroundColor3=j==i and Color3.fromRGB(55,25,100) or Color3.fromRGB(20,14,36); tabBtns[j].TextColor3=j==i and Color3.fromRGB(210,180,255) or Color3.fromRGB(100,85,140); local ind=tabBtns[j]:FindFirstChild("Indicator"); if ind then TweenService:Create(ind,TweenInfo.new(0.2),{Size=UDim2.new(j==i and 0.7 or 0,0,0,2)}):Play() end end
    end)
end

local function mkSection(parent,text) local lbl=Instance.new("TextLabel",parent); lbl.Size=UDim2.new(1,0,0,18); lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=Color3.fromRGB(120,80,180); lbl.Font=Enum.Font.GothamBold; lbl.TextSize=10; lbl.TextXAlignment=Enum.TextXAlignment.Left; return lbl end
local function mkInput(parent,placeholder) local tb=Instance.new("TextBox",parent); tb.Size=UDim2.new(1,0,0,34); tb.BackgroundColor3=Color3.fromRGB(22,16,38); tb.BorderSizePixel=0; tb.PlaceholderText=placeholder or ""; tb.Text=""; tb.Font=Enum.Font.Gotham; tb.TextSize=13; tb.TextColor3=Color3.new(1,1,1); tb.PlaceholderColor3=Color3.fromRGB(90,70,130); tb.ClearTextOnFocus=false; Instance.new("UICorner",tb).CornerRadius=UDim.new(0,8); local pad=Instance.new("UIPadding",tb); pad.PaddingLeft=UDim.new(0,12); pad.PaddingRight=UDim.new(0,12); local s=Instance.new("UIStroke",tb); s.Color=Color3.fromRGB(80,40,140); s.Thickness=1; s.Transparency=0.5; return tb end
local function mkBtn(parent,text,color,h) local b=Instance.new("TextButton",parent); b.Size=UDim2.new(1,0,0,h or 36); b.BackgroundColor3=color or Color3.fromRGB(70,40,130); b.BorderSizePixel=0; b.Text=text; b.Font=Enum.Font.GothamBold; b.TextSize=13; b.TextColor3=Color3.new(1,1,1); b.AutoButtonColor=false; Instance.new("UICorner",b).CornerRadius=UDim.new(0,9); local bs=Instance.new("UIStroke",b); bs.Color=Color3.new(1,1,1); bs.Transparency=0.85; bs.Thickness=1; b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(0.12),{BackgroundTransparency=0.18}):Play() end); b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(0.12),{BackgroundTransparency=0}):Play() end); return b end
local function mkToggle(parent,text,initVal,onChange) local row=Instance.new("Frame",parent); row.Size=UDim2.new(1,0,0,40); row.BackgroundColor3=Color3.fromRGB(18,14,30); row.BorderSizePixel=0; Instance.new("UICorner",row).CornerRadius=UDim.new(0,9); local s=Instance.new("UIStroke",row); s.Color=Color3.fromRGB(70,40,120); s.Transparency=0.6; s.Thickness=1; local lbl=Instance.new("TextLabel",row); lbl.Size=UDim2.new(1,-62,1,0); lbl.Position=UDim2.fromOffset(12,0); lbl.BackgroundTransparency=1; lbl.Text=text; lbl.TextColor3=Color3.fromRGB(195,180,220); lbl.Font=Enum.Font.GothamMedium; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left; local tog=Instance.new("Frame",row); tog.Size=UDim2.fromOffset(38,21); tog.Position=UDim2.new(1,-50,0.5,-10.5); tog.BackgroundColor3=initVal and Color3.fromRGB(120,50,220) or Color3.fromRGB(50,35,80); tog.BorderSizePixel=0; Instance.new("UICorner",tog).CornerRadius=UDim.new(1,0); local knob=Instance.new("Frame",tog); knob.Size=UDim2.fromOffset(17,17); knob.Position=initVal and UDim2.new(1,-19,0.5,-8.5) or UDim2.new(0,2,0.5,-8.5); knob.BackgroundColor3=Color3.new(1,1,1); knob.BorderSizePixel=0; Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0); local val={v=initVal}; local tb2=Instance.new("TextButton",row); tb2.Size=UDim2.new(1,0,1,0); tb2.BackgroundTransparency=1; tb2.Text=""; tb2.MouseButton1Click:Connect(function() val.v=not val.v; TweenService:Create(tog,TweenInfo.new(0.2),{BackgroundColor3=val.v and Color3.fromRGB(120,50,220) or Color3.fromRGB(50,35,80)}):Play(); TweenService:Create(knob,TweenInfo.new(0.18),{Position=val.v and UDim2.new(1,-19,0.5,-8.5) or UDim2.new(0,2,0.5,-8.5)}):Play(); onChange(val.v) end); return row end

local balTab=tabConts[1]
local balCard=Instance.new("Frame",balTab); balCard.Size=UDim2.new(1,0,0,60); balCard.BackgroundColor3=Color3.fromRGB(22,14,40); balCard.BorderSizePixel=0; Instance.new("UICorner",balCard).CornerRadius=UDim.new(0,10); local bcGrad=Instance.new("UIGradient",balCard); bcGrad.Rotation=135; bcGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(35,20,65)),ColorSequenceKeypoint.new(1,Color3.fromRGB(15,10,30))}); local bcStroke=Instance.new("UIStroke",balCard); bcStroke.Color=Color3.fromRGB(100,50,180); bcStroke.Transparency=0.5; bcStroke.Thickness=1; local bIco=Instance.new("ImageLabel",balCard); bIco.Size=UDim2.fromOffset(26,26); bIco.Position=UDim2.fromOffset(12,12); bIco.BackgroundTransparency=1; bIco.Image=ROBUX_ICON; bIco.ImageColor3=Color3.fromRGB(120,255,120); local bLblSub=Instance.new("TextLabel",balCard); bLblSub.Size=UDim2.new(1,-52,0,14); bLblSub.Position=UDim2.fromOffset(44,8); bLblSub.BackgroundTransparency=1; bLblSub.Text="BALANCE"; bLblSub.TextColor3=Color3.fromRGB(110,80,170); bLblSub.Font=Enum.Font.GothamBold; bLblSub.TextSize=9; bLblSub.TextXAlignment=Enum.TextXAlignment.Left; local balNumLbl=Instance.new("TextLabel",balCard); balNumLbl.Size=UDim2.new(1,-52,0,26); balNumLbl.Position=UDim2.fromOffset(44,24); balNumLbl.BackgroundTransparency=1; balNumLbl.Text=fmt(CFG.balance); balNumLbl.TextColor3=Color3.fromRGB(120,255,120); balNumLbl.Font=Enum.Font.GothamBold; balNumLbl.TextSize=18; balNumLbl.TextXAlignment=Enum.TextXAlignment.Left; regBal(balNumLbl)
local balInput=mkInput(balTab,"Balance (e.g. 1000, 100K, 1.5B)")
local setBalBtn=mkBtn(balTab,"💰 Set Balance",Color3.fromRGB(40,130,60)); setBalBtn.MouseButton1Click:Connect(function() local v=parseN(balInput.Text); if not v then return end; setBal(v); playSnd("Success",0.8); balInput.Text="" end)
mkBtn(balTab,"+ 100,000",Color3.fromRGB(35,80,160)).MouseButton1Click:Connect(function() setBal(CFG.balance+100000); playSnd("Click",0.7) end)
mkBtn(balTab,"+ 1,000,000",Color3.fromRGB(30,60,160)).MouseButton1Click:Connect(function() setBal(CFG.balance+1000000); playSnd("Click",0.7) end)
mkBtn(balTab,"☢ Test Nuke",Color3.fromRGB(160,30,80),40).MouseButton1Click:Connect(function() triggerNuke(player.Name,100000) end)

local nameTab=tabConts[2]
local nameInput=mkInput(nameTab,"Custom display name")
mkToggle(nameTab,"Enable custom name",CFG.nameEnabled,function(v) CFG.nameEnabled=v; if player.Character then applyBadges(player.Character) end end)
mkBtn(nameTab,"✓ Apply Name",Color3.fromRGB(65,40,120)).MouseButton1Click:Connect(function() CFG.customName=nameInput.Text or ""; if player.Character then applyBadges(player.Character) end; playSnd("Success",0.8) end)
mkToggle(nameTab,"Developer Badge",CFG.developerBadge,function(v) CFG.developerBadge=v; if player.Character then applyBadges(player.Character) end end)
mkToggle(nameTab,"VIP Badge",CFG.vipBadge,function(v) CFG.vipBadge=v; if player.Character then applyBadges(player.Character) end end)
mkToggle(nameTab,"Show Checkmark ✓",CFG.showCheckmark,function(v) CFG.showCheckmark=v; if player.Character then applyBadges(player.Character) end end)

local avatarTab=tabConts[3]
local uidInput=mkInput(avatarTab,"User ID or username")
mkBtn(avatarTab,"🎭 Apply Avatar",Color3.fromRGB(65,40,120)).MouseButton1Click:Connect(function() local txt=uidInput.Text or ""; local uid=tonumber(txt); if not uid then pcall(function() uid=Players:GetUserIdFromNameAsync(txt) end) end; if not uid then showNotif({Color=Color3.fromRGB(200,60,60),Text="User not found",Duration=2}); return end; task.spawn(function() local ok,msg=spawnOverlay(uid,txt); if ok then showNotif({Color=Color3.fromRGB(0,178,89),Text="Avatar applied!",Duration=2}) else showNotif({Color=Color3.fromRGB(200,60,60),Text="Error: "..(msg or "?"),Duration=3}) end end) end)
mkBtn(avatarTab,"✕ Remove Avatar",Color3.fromRGB(140,35,60)).MouseButton1Click:Connect(function() destroyOverlay(); setHide(false); playSnd("Click",0.7) end)
mkToggle(avatarTab,"Hide own body",CFG.hideOwnBody,function(v) setHide(v) end)

local setTab=tabConts[4]
mkSection(setTab,"GENERAL")
mkToggle(setTab,"Sounds enabled",CFG.enableSounds,function(v) CFG.enableSounds=v end)
mkToggle(setTab,"Nuke enabled",CFG.nukeEnabled,function(v) CFG.nukeEnabled=v end)
mkToggle(setTab,"Update Stand Raised",CFG.updateStandRaised,function(v) CFG.updateStandRaised=v end)
mkToggle(setTab,"Nuke Billboard",CFG.nukeBillboard,function(v) CFG.nukeBillboard=v end)

mkSection(setTab,"NUKE ON GAMEPASS 10K+")
mkToggle(setTab,"Enable nuke on 10k+",CFG.nukeOnGamepass,function(v)
    CFG.nukeOnGamepass=v
    if v then
        showNotif({Color=Color3.fromRGB(200,50,50),Text="☢ Nuke 10k+ enabled",Duration=2})
    else
        showNotif({Color=Color3.fromRGB(60,160,60),Text="✓ Nuke 10k+ disabled",Duration=2})
    end
end)

mkBtn(setTab,"🔄 Restore Nuke",Color3.fromRGB(180,50,50),36).MouseButton1Click:Connect(function() resetNukeNow(); showNotif({Color=Color3.fromRGB(60,200,60),Text="Nuke restored!",Duration=2}) end)

mkSection(setTab,"CUSTOM NAME (BILLBOARD)")
mkToggle(setTab,"Use custom name on billboard",CFG.bbUseCustomName,function(v)
    CFG.bbUseCustomName=v
end)
local bbNameInput=mkInput(setTab,"Your name (e.g. FazoxYT)")
if CFG.bbCustomName and #CFG.bbCustomName>0 then bbNameInput.Text=CFG.bbCustomName end
mkBtn(setTab,"✓ Apply custom name",Color3.fromRGB(70,40,130)).MouseButton1Click:Connect(function()
    local txt=bbNameInput.Text or ""
    if #txt>0 then
        CFG.bbCustomName=txt
        showNotif({Color=Color3.fromRGB(100,60,200),Text="Name updated: "..txt,Duration=2})
        playSnd("Success",0.8)
    end
end)

mkSection(setTab,"ALARM DURATION")
do
    local alarmRow=Instance.new("Frame",setTab); alarmRow.Size=UDim2.new(1,0,0,52); alarmRow.BackgroundColor3=Color3.fromRGB(18,14,30); alarmRow.BorderSizePixel=0; Instance.new("UICorner",alarmRow).CornerRadius=UDim.new(0,9); local s=Instance.new("UIStroke",alarmRow); s.Color=Color3.fromRGB(70,40,120); s.Transparency=0.6; s.Thickness=1
    local aLbl=Instance.new("TextLabel",alarmRow); aLbl.Size=UDim2.new(1,0,0,18); aLbl.Position=UDim2.fromOffset(14,4); aLbl.BackgroundTransparency=1; aLbl.Text="ALARM DURATION (sec)"; aLbl.TextColor3=Color3.fromRGB(110,80,160); aLbl.Font=Enum.Font.GothamBold; aLbl.TextSize=9; aLbl.TextXAlignment=Enum.TextXAlignment.Left
    local aVal=Instance.new("TextLabel",alarmRow); aVal.Size=UDim2.new(1,-90,0,28); aVal.Position=UDim2.fromOffset(14,20); aVal.BackgroundTransparency=1; aVal.Text=tostring(CFG.nukeAlarmDur); aVal.TextColor3=Color3.fromRGB(190,160,240); aVal.Font=Enum.Font.GothamBold; aVal.TextSize=16; aVal.TextXAlignment=Enum.TextXAlignment.Left
    local aMinus=mkBtn(alarmRow,"-",Color3.fromRGB(40,28,70),28); aMinus.Size=UDim2.fromOffset(28,28); aMinus.Position=UDim2.new(1,-64,0.5,-14); aMinus.AutoButtonColor=false
    local aPlus=mkBtn(alarmRow,"+",Color3.fromRGB(40,28,70),28); aPlus.Size=UDim2.fromOffset(28,28); aPlus.Position=UDim2.new(1,-32,0.5,-14); aPlus.AutoButtonColor=false
    aMinus.MouseButton1Click:Connect(function() CFG.nukeAlarmDur=math.max(0,CFG.nukeAlarmDur-1); aVal.Text=tostring(CFG.nukeAlarmDur) end)
    aPlus.MouseButton1Click:Connect(function() CFG.nukeAlarmDur=CFG.nukeAlarmDur+1; aVal.Text=tostring(CFG.nukeAlarmDur) end)
end

mkSection(setTab,"NOTIFICATION STYLE")
do
    local styles={"both","green","pink","none"}
    local styleIdx=1; for i,s in ipairs(styles) do if s==CFG.notifStyle then styleIdx=i; break end end
    local styleRow=Instance.new("Frame",setTab); styleRow.Size=UDim2.new(1,0,0,40); styleRow.BackgroundColor3=Color3.fromRGB(18,14,30); styleRow.BorderSizePixel=0; Instance.new("UICorner",styleRow).CornerRadius=UDim.new(0,9); local sst=Instance.new("UIStroke",styleRow); sst.Color=Color3.fromRGB(70,40,120); sst.Transparency=0.6; sst.Thickness=1
    local sLbl=Instance.new("TextLabel",styleRow); sLbl.Size=UDim2.new(0.4,0,1,0); sLbl.Position=UDim2.fromOffset(12,0); sLbl.BackgroundTransparency=1; sLbl.Text="Style"; sLbl.TextColor3=Color3.fromRGB(195,180,220); sLbl.Font=Enum.Font.GothamMedium; sLbl.TextSize=12; sLbl.TextXAlignment=Enum.TextXAlignment.Left
    local sVal=Instance.new("TextLabel",styleRow); sVal.Size=UDim2.new(0.3,0,1,0); sVal.AnchorPoint=Vector2.new(0.5,0); sVal.Position=UDim2.new(0.6,0,0,0); sVal.BackgroundTransparency=1; sVal.Text=styles[styleIdx]; sVal.TextColor3=Color3.fromRGB(220,180,255); sVal.Font=Enum.Font.GothamBold; sVal.TextSize=12; sVal.TextXAlignment=Enum.TextXAlignment.Center
    local sPrev=mkBtn(styleRow,"◀",Color3.fromRGB(40,28,70),26); sPrev.Size=UDim2.fromOffset(26,26); sPrev.Position=UDim2.new(1,-58,0.5,-13); sPrev.AutoButtonColor=false
    local sNext=mkBtn(styleRow,"▶",Color3.fromRGB(40,28,70),26); sNext.Size=UDim2.fromOffset(26,26); sNext.Position=UDim2.new(1,-28,0.5,-13); sNext.AutoButtonColor=false
    sPrev.MouseButton1Click:Connect(function() styleIdx=styleIdx>1 and styleIdx-1 or #styles; sVal.Text=styles[styleIdx]; CFG.notifStyle=styles[styleIdx] end)
    sNext.MouseButton1Click:Connect(function() styleIdx=styleIdx<#styles and styleIdx+1 or 1; sVal.Text=styles[styleIdx]; CFG.notifStyle=styles[styleIdx] end)
end

mkSection(setTab,"BUY UI STYLE")
do
    local uiStyles={"krato","v3"}
    local uiIdx=1; for i,s in ipairs(uiStyles) do if s==CFG.uiStyle then uiIdx=i; break end end
    local uiRow=Instance.new("Frame",setTab); uiRow.Size=UDim2.new(1,0,0,40); uiRow.BackgroundColor3=Color3.fromRGB(18,14,30); uiRow.BorderSizePixel=0; Instance.new("UICorner",uiRow).CornerRadius=UDim.new(0,9); local ust=Instance.new("UIStroke",uiRow); ust.Color=Color3.fromRGB(70,40,120); ust.Transparency=0.6; ust.Thickness=1
    local uLbl=Instance.new("TextLabel",uiRow); uLbl.Size=UDim2.new(0.4,0,1,0); uLbl.Position=UDim2.fromOffset(12,0); uLbl.BackgroundTransparency=1; uLbl.Text="Theme"; uLbl.TextColor3=Color3.fromRGB(195,180,220); uLbl.Font=Enum.Font.GothamMedium; uLbl.TextSize=12; uLbl.TextXAlignment=Enum.TextXAlignment.Left
    local uVal=Instance.new("TextLabel",uiRow); uVal.Size=UDim2.new(0.3,0,1,0); uVal.AnchorPoint=Vector2.new(0.5,0); uVal.Position=UDim2.new(0.6,0,0,0); uVal.BackgroundTransparency=1; uVal.Text=uiStyles[uiIdx]; uVal.TextColor3=Color3.fromRGB(220,180,255); uVal.Font=Enum.Font.GothamBold; uVal.TextSize=12; uVal.TextXAlignment=Enum.TextXAlignment.Center
    local uPrev=mkBtn(uiRow,"◀",Color3.fromRGB(40,28,70),26); uPrev.Size=UDim2.fromOffset(26,26); uPrev.Position=UDim2.new(1,-58,0.5,-13); uPrev.AutoButtonColor=false
    local uNext=mkBtn(uiRow,"▶",Color3.fromRGB(40,28,70),26); uNext.Size=UDim2.fromOffset(26,26); uNext.Position=UDim2.new(1,-28,0.5,-13); uNext.AutoButtonColor=false
    uPrev.MouseButton1Click:Connect(function() uiIdx=uiIdx>1 and uiIdx-1 or #uiStyles; uVal.Text=uiStyles[uiIdx]; CFG.uiStyle=uiStyles[uiIdx]; rebuildPrompt() end)
    uNext.MouseButton1Click:Connect(function() uiIdx=uiIdx<#uiStyles and uiIdx+1 or 1; uVal.Text=uiStyles[uiIdx]; CFG.uiStyle=uiStyles[uiIdx]; rebuildPrompt() end)
end

startLoad(function()
    showNotif({Color=Color3.fromRGB(80,30,180),Icon=ROBUX_ICON,Text="FAZOX NUKE loaded!",Duration=4})
end)
