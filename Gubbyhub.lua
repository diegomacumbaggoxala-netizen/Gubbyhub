--[[ AFTON HUB | Bacon Afton e Luna ]]
warn("[Afton Hub] Iniciado")
local Players=game:GetService("Players") local RunService=game:GetService("RunService") local Workspace=game:GetService("Workspace") local Lighting=game:GetService("Lighting") local Camera=Workspace.CurrentCamera local LP=Players.LocalPlayer
local function getParent() if type(gethui)=="function" then local ok,h=pcall(gethui) if ok and typeof(h)=="Instance" then return h end end local ok,cg=pcall(function() return game:GetService("CoreGui") end) if ok and cg then return cg end return LP:WaitForChild("PlayerGui") end
pcall(function() local p=getParent() local o=p:FindFirstChild("AftonHub") if o then o:Destroy() end end)
local MAX_N=30 local MAX_L=1000 local CAP=500
local St={Aim=false, Npc=false, Fov=false, Esp=false, Spd=false, Lim=false, FR=120, SV=16, FovC=nil, EspO={}, LianaMode=false}
local Th={BG=Color3.fromRGB(40,15,65), Off=Color3.fromRGB(110,40,170), On=Color3.fromRGB(40,180,80), Str=Color3.fromRGB(150,60,220), Txt=Color3.fromRGB(200,140,255), Hd=Color3.fromRGB(110,40,170)}
local gui=Instance.new("ScreenGui") gui.Name="AftonHub" gui.ResetOnSpawn=false gui.IgnoreGuiInset=true gui.Parent=getParent()
local main=Instance.new("Frame",gui) main.Size=UDim2.new(0,240,0,360) main.Position=UDim2.new(0,20,0,20) main.BackgroundColor3=Th.BG main.BorderSizePixel=0 main.Active=true main.Draggable=true Instance.new("UICorner",main).CornerRadius=UDim.new(0,10)
local str=Instance.new("UIStroke",main) str.Color=Th.Str str.Thickness=1.5
local hd=Instance.new("Frame",main) hd.Size=UDim2.new(1,0,0,34) hd.BackgroundColor3=Th.Hd hd.BorderSizePixel=0 Instance.new("UICorner",hd).CornerRadius=UDim.new(0,10)
local hf=Instance.new("Frame",hd) hf.Size=UDim2.new(1,0,0.5,0) hf.Position=UDim2.new(0,0,0.5,0) hf.BackgroundColor3=Th.Hd hf.BorderSizePixel=0
local title=Instance.new("TextLabel",hd) title.Size=UDim2.new(1,-70,1,0) title.Position=UDim2.new(0,10,0,0) title.BackgroundTransparency=1 title.Text="AFTON HUB" title.TextColor3=Th.Txt title.Font=Enum.Font.GothamBold title.TextSize=18 title.TextXAlignment=Enum.TextXAlignment.Left title.ZIndex=2
local minBtn=Instance.new("TextButton",hd) minBtn.Size=UDim2.new(0,28,0,28) minBtn.Position=UDim2.new(1,-64,0,3) minBtn.BackgroundColor3=Th.Off minBtn.Text="—" minBtn.TextColor3=Color3.new(1,1,1) minBtn.Font=Enum.Font.GothamBold minBtn.TextSize=18 minBtn.BorderSizePixel=0 minBtn.ZIndex=2 Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,6)
local clsBtn=Instance.new("TextButton",hd) clsBtn.Size=UDim2.new(0,28,0,28) clsBtn.Position=UDim2.new(1,-32,0,3) clsBtn.BackgroundColor3=Color3.fromRGB(200,50,50) clsBtn.Text="X" clsBtn.TextColor3=Color3.new(1,1,1) clsBtn.Font=Enum.Font.GothamBold clsBtn.TextSize=18 clsBtn.BorderSizePixel=0 clsBtn.ZIndex=2 Instance.new("UICorner",clsBtn).CornerRadius=UDim.new(0,6)
local tCon=Instance.new("Frame",main) tCon.Size=UDim2.new(1,-20,0,30) tCon.Position=UDim2.new(0,10,0,40) tCon.BackgroundTransparency=1
local function mkTab(t,x) local b=Instance.new("TextButton",tCon) b.Size=UDim2.new(0.33,-5,1,0) b.Position=UDim2.new(0,x,0,0) b.BackgroundColor3=Th.BG b.TextColor3=Th.Txt b.Font=Enum.Font.GothamBold b.TextSize=11 b.Text=t b.BorderSizePixel=0 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6) return b end
local tb1=mkTab("MAIN PVP",0) local tb2=mkTab("TOOLS",80) local tb3=mkTab("MISC",160)
local frm={} for i=1,3 do local f=Instance.new("Frame",main) f.Size=UDim2.new(1,-20,0,260) f.Position=UDim2.new(0,10,0,80) f.BackgroundTransparency=1 f.Visible=(i==1) frm[i]=f end
local function selTab(i) for j=1,3 do frm[j].Visible=(j==i) end local tbs={tb1,tb2,tb3} for j,t in ipairs(tbs) do t.BackgroundColor3=(j==i) and Th.Hd or Th.BG t.TextColor3=(j==i) and Color3.new(1,1,1) or Th.Txt end end
tb1.MouseButton1Click:Connect(function() selTab(1) end) tb2.MouseButton1Click:Connect(function() selTab(2) end) tb3.MouseButton1Click:Connect(function() selTab(3) end)
local function mkBtn(p,t,y) local b=Instance.new("TextButton",p) b.Size=UDim2.new(1,0,0,32) b.Position=UDim2.new(0,0,0,y) b.BackgroundColor3=Th.Off b.TextColor3=Color3.new(1,1,1) b.Font=Enum.Font.GothamBold b.TextSize=13 b.Text=t b.BorderSizePixel=0 Instance.new("UICorner",b).CornerRadius=UDim.new(0,8) return b end
local function mkSm(p,t,x,y) local b=Instance.new("TextButton",p) b.Size=UDim2.new(0,34,0,26) b.Position=UDim2.new(0,x,0,y) b.BackgroundColor3=Th.Off b.TextColor3=Color3.new(1,1,1) b.Font=Enum.Font.GothamBold b.TextSize=15 b.Text=t b.BorderSizePixel=0 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6) return b end
local bAim=mkBtn(frm[1],"AIMBOT OFF",0) local bNpc=mkBtn(frm[1],"AIMBOT NPC OFF",38) local bEsp=mkBtn(frm[1],"ESP OFF",76) local bFov=mkBtn(frm[1],"FOV OFF",114)
local lFov=Instance.new("TextLabel",frm[1]) lFov.Size=UDim2.new(1,0,0,20) lFov.Position=UDim2.new(0,0,0,152) lFov.BackgroundTransparency=1 lFov.Text="FOV: 120" lFov.TextColor3=Th.Txt lFov.Font=Enum.Font.Gotham lFov.TextSize=12 lFov.TextXAlignment=Enum.TextXAlignment.Left
local bMin=mkSm(frm[1],"-",0,174) local bPlu=mkSm(frm[1],"+",42,174)
local bSpd=mkBtn(frm[2],"SPEED OFF",0) local bLim=mkBtn(frm[2],"LIMIT BREAK OFF",38) local bLag=mkBtn(frm[2],"ANTI-LAG OFF",76) local bMom=mkBtn(frm[2],"CARTA PARA LIANA 💜",114) bMom.Visible=false
local lSpd=Instance.new("TextLabel",frm[2]) lSpd.Size=UDim2.new(1,0,0,20) lSpd.Position=UDim2.new(0,0,0,152) lSpd.BackgroundTransparency=1 lSpd.Text="Speed: 16 / 30" lSpd.TextColor3=Th.Txt lSpd.Font=Enum.Font.Gotham lSpd.TextSize=12 lSpd.TextXAlignment=Enum.TextXAlignment.Left
local sMin=mkSm(frm[2],"-",0,174) local sPlu=mkSm(frm[2],"+",42,174)
local bRed=mkBtn(frm[3],"🔴 TEMA VERMELHO",0) local bPur=mkBtn(frm[3],"🟣 TEMA ROXO",38) local bYel=mkBtn(frm[3],"🟡 TEMA AMARELO",76)
local cInp=Instance.new("TextBox",frm[3]) cInp.Size=UDim2.new(1,0,0,32) cInp.Position=UDim2.new(0,0,0,120) cInp.BackgroundColor3=Th.BG cInp.TextColor3=Th.Txt cInp.Font=Enum.Font.GothamBold cInp.TextSize=13 cInp.PlaceholderText="[ Escreva o código ]" cInp.PlaceholderColor3=Th.Txt cInp.BorderSizePixel=0 Instance.new("UICorner",cInp).CornerRadius=UDim.new(0,8)
local cBtn=mkBtn(frm[3],"APLICAR CÓDIGO",158) cBtn.BackgroundColor3=Th.On cBtn.TextColor3=Color3.new(0,0,0)
local mini=Instance.new("TextButton",gui) mini.Size=UDim2.new(0,46,0,46) mini.Position=UDim2.new(0,20,0,20) mini.BackgroundColor3
