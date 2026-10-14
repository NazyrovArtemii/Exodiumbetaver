-- EXODIUM HUB
local P,R,T,U,W,L=game:GetService("Players"),game:GetService("RunService"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("Workspace"),game:GetService("Lighting")
local LP=P.LocalPlayer
local pg=LP:WaitForChild("PlayerGui")
if pg:FindFirstChild("ExodiumSelect")then pg.ExodiumSelect:Destroy()end
if pg:FindFirstChild("ExodiumHub")then pg.ExodiumHub:Destroy()end
local function pc(f)pcall(f)end
local AIM_SPEED=100
local SHOT_DELAY=0.5

-- ОКНО ВЫБОРА
local vsg=Instance.new("ScreenGui",pg)
vsg.Name="ExodiumSelect"vsg.ResetOnSpawn=false vsg.IgnoreGuiInset=true vsg.DisplayOrder=1000
local VM=Instance.new("Frame",vsg)
VM.Size=UDim2.new(0,260,0,180)
VM.Position=UDim2.new(0.5,-130,0.5,-90)
VM.BackgroundColor3=Color3.fromRGB(12,10,20)
VM.BorderSizePixel=0
VM.Active=true
Instance.new("UICorner",VM).CornerRadius=UDim.new(0,14)
local VMS=Instance.new("UIStroke",VM)
VMS.Color=Color3.fromRGB(160,80,255)
VMS.Thickness=2
VMS.Transparency=0.1
local VE=Instance.new("TextLabel",VM)
VE.Size=UDim2.new(0,32,0,36)
VE.Position=UDim2.new(0,14,0,0)
VE.BackgroundTransparency=1
VE.Text="E"
VE.TextColor3=Color3.fromRGB(200,120,255)
VE.Font=Enum.Font.GothamBlack
VE.TextSize=24
VE.TextXAlignment=Enum.TextXAlignment.Left
local VName=Instance.new("TextLabel",VM)
VName.Size=UDim2.new(0,160,0,36)
VName.Position=UDim2.new(0,40,0,0)
VName.BackgroundTransparency=1
VName.Text="XODIUM HUB"
VName.TextColor3=Color3.fromRGB(220,180,255)
VName.Font=Enum.Font.GothamBlack
VName.TextSize=13
VName.TextXAlignment=Enum.TextXAlignment.Left
local VHint=Instance.new("TextLabel",VM)
VHint.Size=UDim2.new(1,-30,0,20)
VHint.Position=UDim2.new(0,15,0,42)
VHint.BackgroundTransparency=1
VHint.Text="Выберите версию:"
VHint.TextColor3=Color3.fromRGB(160,140,200)
VHint.Font=Enum.Font.Gotham
VHint.TextSize=11
VHint.TextXAlignment=Enum.TextXAlignment.Left
local VExtBtn=Instance.new("TextButton",VM)
VExtBtn.Size=UDim2.new(1,-30,0,42)
VExtBtn.Position=UDim2.new(0,15,0,70)
VExtBtn.BackgroundColor3=Color3.fromRGB(20,25,40)
VExtBtn.TextColor3=Color3.fromRGB(0,200,255)
VExtBtn.Font=Enum.Font.GothamBold
VExtBtn.TextSize=12
VExtBtn.Text="EXTERNAL"
VExtBtn.BorderSizePixel=0
VExtBtn.AutoButtonColor=false
Instance.new("UICorner",VExtBtn).CornerRadius=UDim.new(0,8)
local VExtS=Instance.new("UIStroke",VExtBtn)
VExtS.Color=Color3.fromRGB(0,200,255)
VExtS.Thickness=1.5
local VIntBtn=Instance.new("TextButton",VM)
VIntBtn.Size=UDim2.new(1,-30,0,42)
VIntBtn.Position=UDim2.new(0,15,0,120)
VIntBtn.BackgroundColor3=Color3.fromRGB(25,18,40)
VIntBtn.TextColor3=Color3.fromRGB(255,0,200)
VIntBtn.Font=Enum.Font.GothamBold
VIntBtn.TextSize=12
VIntBtn.Text="INTERNAL"
VIntBtn.BorderSizePixel=0
VIntBtn.AutoButtonColor=false
Instance.new("UICorner",VIntBtn).CornerRadius=UDim.new(0,8)
local VIntS=Instance.new("UIStroke",VIntBtn)
VIntS.Color=Color3.fromRGB(255,0,200)
VIntS.Thickness=1.5
VExtBtn.MouseEnter:Connect(function()T:Create(VExtBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(35,45,70)}):Play()end)
VExtBtn.MouseLeave:Connect(function()T:Create(VExtBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(20,25,40)}):Play()end)
VIntBtn.MouseEnter:Connect(function()T:Create(VIntBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(50,25,80)}):Play()end)
VIntBtn.MouseLeave:Connect(function()T:Create(VIntBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(25,18,40)}):Play()end)

local function buildMenu(mode)
	vsg:Destroy()
	local isInt=(mode=="internal")
	local mc=isInt and Color3.fromRGB(255,0,200) or Color3.fromRGB(0,200,255)
	local tt=isInt and "XODIUM INT" or "XODIUM EXT"
	local vt=isInt and "INTERNAL" or "EXTERNAL"
	local sg=Instance.new("ScreenGui",pg)
	sg.Name="ExodiumHub"sg.ResetOnSpawn=false sg.IgnoreGuiInset=true sg.DisplayOrder=100
	local M=Instance.new("Frame",sg)
	M.Size=UDim2.new(0,270,0,340)M.Position=UDim2.new(0,15,1,-355)
	M.BackgroundColor3=Color3.fromRGB(12,10,20)M.BorderSizePixel=0 M.Active=true M.ClipsDescendants=true
	Instance.new("UICorner",M).CornerRadius=UDim.new(0,14)
	local mst=Instance.new("UIStroke",M)mst.Color=mc mst.Thickness=2 mst.Transparency=0.1
	local Tp=Instance.new("Frame",M)Tp.Size=UDim2.new(1,0,0,3)Tp.BackgroundColor3=mc Tp.BorderSizePixel=0
	local TG=Instance.new("UIGradient",Tp)TG.Color=ColorSequence.new(mc,Color3.fromRGB(160,80,255),mc)
	local E=Instance.new("TextLabel",M)E.Size=UDim2.new(0,32,0,36)E.Position=UDim2.new(0,14,0,0)E.BackgroundTransparency=1 E.Text="E"E.TextColor3=mc E.Font=Enum.Font.GothamBlack E.TextSize=24 E.TextXAlignment=Enum.TextXAlignment.Left
	local Nm=Instance.new("TextLabel",M)Nm.Size=UDim2.new(0,140,0,36)Nm.Position=UDim2.new(0,40,0,0)Nm.BackgroundTransparency=1 Nm.Text=tt Nm.TextColor3=Color3.fromRGB(220,180,255)Nm.Font=Enum.Font.GothamBlack Nm.TextSize=12 Nm.TextXAlignment=Enum.TextXAlignment.Left
	local Vr=Instance.new("TextLabel",M)Vr.Size=UDim2.new(0,80,0,11)Vr.Position=UDim2.new(0,40,0,24)Vr.BackgroundTransparency=1 Vr.Text=vt Vr.TextColor3=mc Vr.Font=Enum.Font.GothamBold Vr.TextSize=7 Vr.TextXAlignment=Enum.TextXAlignment.Left
	local dB=Instance.new("TextButton",M)dB.Size=UDim2.new(1,-80,0,36)dB.Position=UDim2.new(0,0,0,0)dB.BackgroundTransparency=1 dB.Text=""
	local Mb=Instance.new("TextButton",M)Mb.Size=UDim2.new(0,22,0,22)Mb.Position=UDim2.new(1,-54,0,7)Mb.BackgroundColor3=Color3.fromRGB(25,20,35)Mb.Text="−"Mb.TextColor3=Color3.fromRGB(200,160,255)Mb.Font=Enum.Font.GothamBold Mb.TextSize=14 Mb.BorderSizePixel=0 Mb.AutoButtonColor=false Mb.ZIndex=5
Instance.new("UICorner",Mb).CornerRadius=UDim.new(0,6)
	local Xb=Instance.new("TextButton",M)Xb.Size=UDim2.new(0,22,0,22)Xb.Position=UDim2.new(1,-28,0,7)Xb.BackgroundColor3=Color3.fromRGB(50,20,30)Xb.Text="✕"Xb.TextColor3=Color3.fromRGB(255,120,140)Xb.Font=Enum.Font.GothamBold Xb.TextSize=12 Xb.BorderSizePixel=0 Xb.AutoButtonColor=false Xb.ZIndex=5
Instance.new("UICorner",Xb).CornerRadius=UDim.new(0,6)
	local Dv=Instance.new("Frame",M)Dv.Size=UDim2.new(1,-20,0,1)Dv.Position=UDim2.new(0,10,0,40)Dv.BackgroundColor3=Color3.fromRGB(60,40,90)Dv.BorderSizePixel=0
	local Ts=Instance.new("ScrollingFrame",M)Ts.Size=UDim2.new(1,-20,0,30)Ts.Position=UDim2.new(0,10,0,44)Ts.BackgroundTransparency=1 Ts.BorderSizePixel=0 Ts.ScrollBarThickness=0 Ts.CanvasSize=UDim2.new(0,0,0,0)Ts.AutomaticCanvasSize=Enum.AutomaticSize.X Ts.ScrollingDirection=Enum.ScrollingDirection.X Ts.ElasticBehavior=Enum.ElasticBehavior.Never
	local TL=Instance.new("UIListLayout",Ts)TL.FillDirection=Enum.FillDirection.Horizontal TL.Padding=UDim.new(0,3)TL.SortOrder=Enum.SortOrder.LayoutOrder
	local CH=Instance.new("Frame",M)CH.Size=UDim2.new(1,-20,1,-82)CH.Position=UDim2.new(0,10,0,78)CH.BackgroundTransparency=1 CH.ClipsDescendants=true
	local dr=false
	local ds,sp
	dB.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true ds=i.Position sp=M.Position end end)
	U.InputChanged:Connect(function(i)if dr and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-ds M.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)end end)
	U.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
	local mn=false
	Mb.MouseButton1Click:Connect(function()
		mn=not mn
		if mn then
			T:Create(M,TweenInfo.new(0.25),{Size=UDim2.new(0,270,0,40)}):Play()
			Mb.Text="+"Ts.Visible=false CH.Visible=false Dv.Visible=false
		else
			T:Create(M,TweenInfo.new(0.25),{Size=UDim2.new(0,270,0,340)}):Play()
			Mb.Text="−"task.wait(0.15)
			Ts.Visible=true CH.Visible=true Dv.Visible=true
		end
	end)
	Xb.MouseButton1Click:Connect(function()sg:Destroy()end)
	local tabContents={}
	local tabBtns={}
	local function makeTab(name,ord)
		local btn=Instance.new("TextButton",Ts)
		btn.Size=UDim2.new(0,60,0,26)btn.BackgroundColor3=Color3.fromRGB(22,18,32)btn.TextColor3=Color3.fromRGB(150,130,180)
		btn.Font=Enum.Font.GothamBold btn.TextSize=8 btn.Text=name btn.BorderSizePixel=0 btn.AutoButtonColor=false btn.LayoutOrder=ord
		Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)
		local st=Instance.new("UIStroke",btn)st.Color=Color3.fromRGB(60,45,85)st.Thickness=1 st.Transparency=0.5
		local content=Instance.new("ScrollingFrame",CH)
		content.Size=UDim2.new(1,0,1,0)content.Position=UDim2.new(0,0,0,0)
		content.BackgroundTransparency=1 content.BorderSizePixel=0
		content.ScrollBarThickness=2 content.ScrollBarImageColor3=mc
		content.CanvasSize=UDim2.new(0,0,0,0)content.AutomaticCanvasSize=Enum.AutomaticSize.Y content.Visible=false
		Instance.new("UIPadding",content).PaddingBottom=UDim.new(0,50)
		local ll=Instance.new("UIListLayout",content)ll.Padding=UDim.new(0,4)ll.SortOrder=Enum.SortOrder.LayoutOrder
		table.insert(tabBtns,btn)
		table.insert(tabContents,content)
		btn.MouseButton1Click:Connect(function()
			for i=1,#tabContents do
				tabContents[i].Visible=(i==ord)
				if i==ord then
					tabBtns[i].BackgroundColor3=Color3.fromRGB(50,25,80)
					tabBtns[i].TextColor3=mc
				else
					tabBtns[i].BackgroundColor3=Color3.fromRGB(22,18,32)
					tabBtns[i].TextColor3=Color3.fromRGB(150,130,180)
				end
			end
		end)
		return content
	end
	local function mkToggle(txt,ord,on,off,parent)
		local b=Instance.new("TextButton",parent)
		b.Size=UDim2.new(1,0,0,26)b.BackgroundColor3=Color3.fromRGB(22,18,32)b.TextColor3=Color3.fromRGB(210,200,230)
		b.Font=Enum.Font.Gotham b.TextSize=10 b.Text="○ "..txt b.BorderSizePixel=0 b.AutoButtonColor=false b.LayoutOrder=ord
		Instance.new("UICorner",b).CornerRadius=UDim.new(0,7)
		local st=Instance.new("UIStroke",b)st.Color=Color3.fromRGB(60,45,85)st.Thickness=1 st.Transparency=0.5
		local s=false
		local function up()
			if s then
				b.BackgroundColor3=Color3.fromRGB(50,25,80)b.TextColor3=mc
				st.Color=mc st.Transparency=0 b.Text="● "..txt
			else
				b.BackgroundColor3=Color3.fromRGB(22,18,32)b.TextColor3=Color3.fromRGB(210,200,230)
				st.Color=Color3.fromRGB(60,45,85)st.Transparency=0.5 b.Text="○ "..txt
			end
		end
		b.MouseButton1Click:Connect(function()s=not s if s then pc(on)else pc(off)end up()end)
	end
	local function mkBtn(txt,ord,act,parent)
		local b=Instance.new("TextButton",parent)
		b.Size=UDim2.new(1,0,0,26)b.BackgroundColor3=Color3.fromRGB(22,18,32)b.TextColor3=Color3.fromRGB(210,200,230)
		b.Font=Enum.Font.Gotham b.TextSize=10 b.Text="◈ "..txt b.BorderSizePixel=0 b.AutoButtonColor=false b.LayoutOrder=ord
		Instance.new("UICorner",b).CornerRadius=UDim.new(0,7)
		local st=Instance.new("UIStroke",b)st.Color=Color3.fromRGB(60,45,85)st.Thickness=1 st.Transparency=0.5
		b.MouseButton1Click:Connect(function()pc(act)end)
	end
	local function mkSec(txt,ord,c,parent)
		local l=Instance.new("TextLabel",parent)
		l.Size=UDim2.new(1,0,0,16)l.BackgroundTransparency=1 l.Text="▬ "..txt
		l.TextColor3=c l.Font=Enum.Font.GothamBold l.TextSize=9 l.TextXAlignment=Enum.TextXAlignment.Left l.LayoutOrder=ord
	end
	local function getRole(pl)
		if pl.Backpack:FindFirstChild("Knife") or (pl.Character and pl.Character:FindFirstChild("Knife")) then return "Murderer" end
		if pl.Backpack:FindFirstChild("Gun") or (pl.Character and pl.Character:FindFirstChild("Gun")) then return "Sheriff" end
		return "Innocent"
	end
	local function getMur()
		for _,pl in ipairs(P:GetPlayers())do
			if pl~=LP and getRole(pl)=="Murderer" then return pl end
		end
	end
	local eA=false
	local eC={}
	local eD={}
	local function applyESP(pl)
		if pl==LP then return end
		local function ap(char)
			if not eA or not char then return end
			local hl=char:FindFirstChild("ExESP")
			if not hl then
				hl=Instance.new("Highlight",char)
				hl.Name="ExESP"
				hl.OutlineTransparency=1
				hl.FillTransparency=0.5
				hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
			end
			local r=getRole(pl)
			if r=="Murderer" then hl.FillColor=Color3.fromRGB(255,0,0)
			elseif r=="Sheriff" then hl.FillColor=Color3.fromRGB(0,0,255)
			else hl.FillColor=Color3.fromRGB(0,255,0) end
			eD[pl]=hl
		end
		if pl.Character then ap(pl.Character)end
		table.insert(eC,pl.CharacterAdded:Connect(function(c)task.wait(0.5)if eA then ap(c)end end))
	end
	local function sEsp()
		if eA then return end
		eA=true
		for _,pl in ipairs(P:GetPlayers())do applyESP(pl)end
		table.insert(eC,P.PlayerAdded:Connect(applyESP))
		table.insert(eC,R.Heartbeat:Connect(function()
			if not eA then return end
			for pl,hl in pairs(eD)do
				if hl and hl.Parent and pl.Character then
					local r=getRole(pl)
					if r=="Murderer" then hl.FillColor=Color3.fromRGB(255,0,0)
					elseif r=="Sheriff" then hl.FillColor=Color3.fromRGB(0,0,255)
					else hl.FillColor=Color3.fromRGB(0,255,0) end
				end
			end
		end))
	end
	local function eEsp()
		eA=false
		for _,hl in pairs(eD)do if hl and hl.Parent then hl:Destroy()end end
		eD={}
		for _,cn in ipairs(eC)do cn:Disconnect()end
		eC={}
	end
	local aaA=false
	local aaC
	local function sAA()
		if aaA then return end
		aaA=true
		aaC=R.Heartbeat:Connect(function()
			local r=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
			if r then r.CFrame=r.CFrame*CFrame.Angles(0,math.rad(AIM_SPEED),0)end
		end)
	end
	local function eAA()aaA=false if aaC then aaC:Disconnect()aaC=nil end end
	local abA=false
	local abC
	local function sAB()
		if abA then return end
		abA=true
		abC=R.RenderStepped:Connect(function()
			local cm=W.CurrentCamera
			if not cm then return end
			local m=getMur()
			if not m or not m.Character then return end
			local h=m.Character:FindFirstChild("Head")
			local myC=LP.Character
			local myH=myC and myC:FindFirstChild("Head")
			if not h or not myH then return end
			local p=RaycastParams.new()
			p.FilterType=Enum.RaycastFilterType.Exclude
			p.FilterDescendantsInstances={myC,m.Character}
			local res=W:Raycast(myH.Position,h.Position-myH.Position,p)
			if res then return end
			cm.CFrame=CFrame.new(cm.CFrame.Position,h.Position)
		end)
	end
	local function eAB()abA=false if abC then abC:Disconnect()abC=nil end end
	local atA=false
	local atC
	local function sAT()
		if atA then return end
		atA=true
		atC=R.Heartbeat:Connect(function()
			local c=LP.Character
			local r=c and c:FindFirstChild("HumanoidRootPart")
			if not r then return end
			for _,o in ipairs(W:GetDescendants())do
				if o:IsA("Tool")then
					local n=o.Name:lower()
					if n=="gun" or n=="revolver" or n=="pistol" then
						local hd=o:FindFirstChild("Handle")
						if hd and hd.Parent then
							local par=o.Parent
							if par and not par:IsA("Backpack") and not par:FindFirstChildOfClass("Humanoid") then
								r.CFrame=CFrame.new(hd.Position+Vector3.new(0,3,0))
								break
							end
						end
					end
				end
			end
		end)
	end
	local function eAT()atA=false if atC then atC:Disconnect()atC=nil end end
	local amA=false
	local amC
	local function sAM()
		if amA then return end
		amA=true
		amC=R.Heartbeat:Connect(function()
			local m=getMur()
			local mr=m and m.Character and m.Character:FindFirstChild("HumanoidRootPart")
			local myR=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
			if mr and myR then myR.CFrame=CFrame.new(mr.Position+Vector3.new(0,0,3))end
		end)
	end
	local function eAM()amA=false if amC then amC:Disconnect()amC=nil end end
	local shA=false
	local shG=nil
	local lastS=0
	local function makeShot()
		if shG then shG:Destroy()end
		shG=Instance.new("ScreenGui",pg)
		shG.Name="ExodiumShot"shG.ResetOnSpawn=false shG.IgnoreGuiInset=true shG.DisplayOrder=200
		local b=Instance.new("TextButton",shG)
		b.Size=UDim2.new(0,60,0,60)b.Position=UDim2.new(0.85,0,0.7,0)
		b.BackgroundColor3=Color3.fromRGB(20,15,30)b.BorderSizePixel=0 b.Text=""b.AutoButtonColor=false
		Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
		local sk=Instance.new("UIStroke",b)sk.Color=mc sk.Thickness=2 sk.Transparency=0.2
		local ic=Instance.new("TextLabel",b)ic.Size=UDim2.new(1,0,1,0)ic.BackgroundTransparency=1 ic.Text="🔫"ic.TextScaled=true ic.Font=Enum.Font.GothamBold
		local dg=false
		local ds2,sp2
		b.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=true ds2=i.Position sp2=b.Position end end)
		U.InputChanged:Connect(function(i)if dg and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-ds2 if math.abs(d.X)>5 or math.abs(d.Y)>5 then b.Position=UDim2.new(sp2.X.Scale,sp2.X.Offset+d.X,sp2.Y.Scale,sp2.Y.Offset+d.Y)end end end)
		U.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end end)
		b.MouseButton1Click:Connect(function()
			if not shA then return end
			local nw=tick()
			if nw-lastS<SHOT_DELAY then return end
			lastS=nw
			T:Create(b,TweenInfo.new(0.1),{BackgroundColor3=mc}):Play()
			task.wait(0.15)
			T:Create(b,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(20,15,30)}):Play()
			local myC=LP.Character
			if not myC then return end
			local g=myC:FindFirstChild("Gun")
			if not g then local bp=LP:FindFirstChild("Backpack")if bp then g=bp:FindFirstChild("Gun")end end
			if g then pc(function()g:Activate()end)end
		end)
	end
	local function sShot()if shA then return end shA=true makeShot()end
	local function eShot()shA=false if shG then shG:Destroy()shG=nil end end
	local bhA=false
	local bhC
	local function sBH()
		if bhA then return end
		bhA=true
		bhC=R.Heartbeat:Connect(function()
			local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
			if h and h.FloorMaterial~=Enum.Material.Air then h:ChangeState(Enum.HumanoidStateType.Jumping)end
		end)
	end
	local function eBH()bhA=false if bhC then bhC:Disconnect()bhC=nil end end
	local spA=false
	local function sSp()
		if spA then return end spA=true
		local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
		if h then h.WalkSpeed=60 end
	end
	local function eSp()
		spA=false
		local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
		if h then h.WalkSpeed=16 end
	end
	local jpA=false
	local function sJp()
		if jpA then return end jpA=true
		local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
		if h then h.UseJumpPower=true h.JumpPower=120 end
	end
	local function eJp()
		jpA=false
		local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
		if h then h.JumpPower=50 end
	end
	local ncA=false
	local ncC
	local function sNc()
		if ncA then return end ncA=true
		ncC=R.Stepped:Connect(function()
			local c=LP.Character
			if c then for _,o in ipairs(c:GetDescendants())do if o:IsA("BasePart")then o.CanCollide=false end end end
		end)
	end
	local function eNc()ncA=false if ncC then ncC:Disconnect()ncC=nil end end
	local flA=false
	local flBV,flBG
	local function sFl()
		if flA then return end
		flA=true
		local r=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
		if not r then return end
		flBV=Instance.new("BodyVelocity",r)flBV.MaxForce=Vector3.new(1e5,1e5,1e5)flBV.Velocity=Vector3.zero
		flBG=Instance.new("BodyGyro",r)flBG.MaxTorque=Vector3.new(1e5,1e5,1e5)flBG.P=1000 flBG.D=50
	end
	local function eFl()
		flA=false
		if flBV then flBV:Destroy()flBV=nil end
		if flBG then flBG:Destroy()flBG=nil end
	end
	R.RenderStepped:Connect(function()
		if not flA or not flBV or not flBG then return end
		local cm=W.CurrentCamera
		if not cm then return end
		local d=Vector3.zero
		if U:IsKeyDown(Enum.KeyCode.W)then d=d+cm.CFrame.LookVector end
		if U:IsKeyDown(Enum.KeyCode.S)then d=d-cm.CFrame.LookVector end
		if U:IsKeyDown(Enum.KeyCode.A)then d=d-cm.CFrame.RightVector end
		if U:IsKeyDown(Enum.KeyCode.D)then d=d+cm.CFrame.RightVector end
		if U:IsKeyDown(Enum.KeyCode.Space)then d=d+Vector3.new(0,1,0)end
		if U:IsKeyDown(Enum.KeyCode.LeftControl)then d=d-Vector3.new(0,1,0)end
		flBV.Velocity=d.Magnitude>0 and d.Unit*150 or Vector3.zero
		flBG.CFrame=cm.CFrame
	end)
	local ijA=false
	local ijC
	local function sIJ()
		if ijA then return end ijA=true
		ijC=U.JumpRequest:Connect(function()
			local h=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
			if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end
		end)
	end
	local function eIJ()ijA=false if ijC then ijC:Disconnect()ijC=nil end end
	local glA=false
	local glH
	local function sGl()
		if glA then return end glA=true
		local c=LP.Character
		if not c then return end
		glH=Instance.new("Highlight",c)glH.FillColor=mc glH.OutlineTransparency=1 glH.FillTransparency=0.7 glH.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
	end
	local function eGl()glA=false if glH then glH:Destroy()glH=nil end end
	local fbA=false
	local function sFb()
		if fbA then return end fbA=true
		pc(function()L.GlobalShadows=false L.FogEnd=1e6 L.FogStart=1e6 end)
	end
	local function eFb()fbA=false pc(function()L.GlobalShadows=true L.FogEnd=500 end)end
	local nsA=false
	local nsC
	local function sNs()
		if nsA then return end nsA=true
		nsC=R.Stepped:Connect(function()
			local c=LP.Character
			if c then for _,o in ipairs(c:GetDescendants())do if o:IsA("BasePart")then o.Transparency=1 end end end
		end)
	end
	local function eNs()
		nsA=false
		if nsC then nsC:Disconnect()nsC=nil end
		local c=LP.Character
		if c then for _,o in ipairs(c:GetDescendants())do if o:IsA("BasePart")then o.Transparency=0 end end end
	end
	local sdA=false
	local sdD={}
	local function sSd()
		if sdA then return end sdA=true
		pc(function()L.GlobalShadows=false end)
		for _,o in ipairs(W:GetDescendants())do if o:IsA("BasePart")and o.CastShadow then sdD[o]=true o.CastShadow=false end end
	end
	local function eSd()
		sdA=false
		pc(function()L.GlobalShadows=true end)
		for o in pairs(sdD)do if o.Parent then o.CastShadow=true end end
		sdD={}
	end
	local pdA=false
	local pdD={}
	local function sPd()
		if pdA then return end pdA=true
		for _,o in ipairs(W:GetDescendants())do
			if o:IsA("ParticleEmitter")then pdD[o]={r=o.Rate}o.Rate=0
			elseif o:IsA("Trail")or o:IsA("Beam")then pdD[o]={e=o.Enabled}o.Enabled=false end
		end
	end
	local function ePd()
		pdA=false
		for o,d in pairs(pdD)do
			if o.Parent then
				if d.r then o.Rate=d.r end
				if d.e~=nil then o.Enabled=d.e end
			end
		end
		pdD={}
	end
	local function sTp()
		local c=LP.Character
		local r=c and c:FindFirstChild("HumanoidRootPart")
		if r then r.CFrame=r.CFrame+Vector3.new(0,50,0)end
	end
	local T1=makeTab("MM2",1)
	mkSec("MM2",0,mc,T1)
	mkToggle("MM2 ESP (роли)",1,sEsp,eEsp,T1)
	mkToggle("Anti-Aim 100",2,sAA,eAA,T1)
	mkToggle("AutoShot",3,sShot,eShot,T1)
	mkToggle("Aimbot на Murderer",4,sAB,eAB,T1)
	mkToggle("Auto TP к пистолету",5,sAT,eAT,T1)
	mkToggle("Auto TP к убийце",6,sAM,eAM,T1)
	local T2=makeTab("ДВИЖЕНИЕ",2)
	mkSec("ДВИЖЕНИЕ",0,mc,T2)
	mkToggle("Скорость x4",1,sSp,eSp,T2)
	mkToggle("Высокий прыжок",2,sJp,eJp,T2)
	mkToggle("Noclip",3,sNc,eNc,T2)
	mkToggle("Fly",4,sFl,eFl,T2)
	mkToggle("BunnyHop",5,sBH,eBH,T2)
	mkToggle("Беск. прыжок",6,sIJ,eIJ,T2)
	mkBtn("Телепорт вверх",7,sTp,T2)
	local T3=makeTab("ВИЗУАЛЫ",3)
	mkSec("ВИЗУАЛЫ",0,mc,T3)
	mkToggle("Свечение себя",1,sGl,eGl,T3)
	mkToggle("Fullbright",2,sFb,eFb,T3)
	mkToggle("Невидимость",3,sNs,eNs,T3)
	local T4=makeTab("ФПС",4)
	mkSec("ФПС",0,mc,T4)
	mkToggle("Тени OFF",1,sSd,eSd,T4)
	mkToggle("Частицы OFF",2,sPd,ePd,T4)
	local T5=makeTab("РАЗНОЕ",5)
	mkSec("РАЗНОЕ",0,mc,T5)
	mkBtn("Респавн",1,function()
		local c=LP.Character
		if c then
			local h=c:FindFirstChildOfClass("Humanoid")
			if h then h.Health=0 end
		end
	end,T5)
	mkBtn("Rejoin",2,function()
		pc(function()game:GetService("TeleportService"):Teleport(game.PlaceId)end)
	end,T5)
	mkBtn("Копировать позицию",3,function()
		local c=LP.Character
		local r=c and c:FindFirstChild("HumanoidRootPart")
		if r then
			pc(function()setclipboard(tostring(r.Position))end)
		end
	end,T5)
	for i=1,#tabContents do
		tabContents[i].Visible=(i==1)
		if i==1 then
			tabBtns[i].BackgroundColor3=Color3.fromRGB(50,25,80)
			tabBtns[i].TextColor3=mc
		end
	end
end

VExtBtn.MouseButton1Click:Connect(function()buildMenu("external")end)
VIntBtn.MouseButton1Click:Connect(function()buildMenu("internal")end)
print("✅ EXODIUM HUB загружено")
