--[[
	Made by: GiantDefender427

	Devforum Post: https://devforum.roblox.com/t/movementhandler-crouch-sprint-slide-prone/1539379
]]

-- Service dependencies
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")

-- MovementHandler
local MovementHandler = {}

-- Reourses
MovementHandler.ReplicatedStorageDirectory = game.ReplicatedStorage:WaitForChild("MovementHandler")
MovementHandler.AnimationFolder = MovementHandler.ReplicatedStorageDirectory:WaitForChild("Animations")
MovementHandler.MovementState = MovementHandler.ReplicatedStorageDirectory:WaitForChild("MovementState")
MovementHandler.HumanoidState = MovementHandler.ReplicatedStorageDirectory:WaitForChild("HumanoidState")

-- Local player
MovementHandler.Player = nil
MovementHandler.Character = nil
MovementHandler.Humanoid = nil
MovementHandler.Animator = nil

-- Camera offset tweens
MovementHandler.CameraOffsetTweens = {}
MovementHandler.CameraOffsetTweens.Default = nil
MovementHandler.CameraOffsetTweens.Crouch = nil
MovementHandler.CameraOffsetTweens.Prone = nil
MovementHandler.CameraOffsetTweens.Slide = nil

-- Event connections
MovementHandler.onCharacterAddedConnection = nil
MovementHandler.onHumanoidStateChangeddConnection = nil
MovementHandler.onHumanoidRunningConnection = nil
MovementHandler.onHumanoidJumpingConnection = nil

-- States
MovementHandler.States = {}
MovementHandler.States.Sprinting = false
MovementHandler.States.Crouching = false
MovementHandler.States.Proning = false
MovementHandler.States.Sliding = false

-- Configurations
MovementHandler.Enabled = false
MovementHandler.Configurations = {}
MovementHandler.Configurations.WalkSpeed = 16
MovementHandler.Configurations.SprintSpeed = 30
MovementHandler.Configurations.CrouchSpeed = 6
MovementHandler.Configurations.ProneSpeed = 4
MovementHandler.Configurations.SprintEnabled = true
MovementHandler.Configurations.SlideEnabled = true
MovementHandler.Configurations.CrouchEnabled = true
MovementHandler.Configurations.ProneEnabled = true

-- Animations
MovementHandler.Animations = {}
MovementHandler.Animations.CrouchIdle = MovementHandler.AnimationFolder.CrouchIdle
MovementHandler.Animations.CrouchWalk = MovementHandler.AnimationFolder.CrouchWalk
MovementHandler.Animations.ProneIdle = MovementHandler.AnimationFolder.ProneIdle
MovementHandler.Animations.ProneWalk = MovementHandler.AnimationFolder.ProneWalk
MovementHandler.Animations.Slide = MovementHandler.AnimationFolder.Slide

-- Animation tracks
MovementHandler.AnimationTracks = {}
MovementHandler.AnimationTracks.CrouchIdle = nil
MovementHandler.AnimationTracks.CrouchWalk = nil
MovementHandler.AnimationTracks.ProneIdle = nil
MovementHandler.AnimationTracks.ProneWalk = nil
MovementHandler.AnimationTracks.Slide = nil

-- Lerp
function MovementHandler:Lerp(a, b, t)
	return a * (1 - t) + (b * t)
end

-- Assemble the profile for functionality
function MovementHandler:Initiate()
	-- Saftey measures incase character has already loaded
	self.Character = self.Player.Character
	self:GetPlayerInput()
	self.onCharacterAddedConnection = self.Player.CharacterAdded:Connect(function(Model)
		self:onCharacterAdded(Model)
	end)
end

-- On character added
function MovementHandler:onCharacterAdded(Model)
	self.Humanoid = Model:WaitForChild("Humanoid")
	self.Character = Model
	self.Animator = self.Humanoid:FindFirstChildOfClass("Animator")
	self:LoadAnimationTracks()
	self.onHumanoidStateChangedConnection = self.Humanoid.StateChanged:Connect(function(OldState, NewState)
		self:onHumanoidStateChanged(OldState, NewState)
	end)
	self.onHumanoidRunningConnection = self.Humanoid.Running:Connect(function(Speed)
		self:onHumanoidRunning(Speed)
	end)
	self.onHumanoidJumpingConnection = self.Humanoid.Jumping:Connect(function(Jumping)
		self:onHumanoidJumping(Jumping)
	end)
	self:ResetCameraOffsetTweens()
end

-- Load animations
function MovementHandler:LoadAnimationTracks()
	self.AnimationTracks.CrouchIdle = self.Animator:LoadAnimation(self.Animations.CrouchIdle)
	self.AnimationTracks.CrouchWalk = self.Animator:LoadAnimation(self.Animations.CrouchWalk)
	self.AnimationTracks.ProneIdle = self.Animator:LoadAnimation(self.Animations.ProneIdle)
	self.AnimationTracks.ProneWalk = self.Animator:LoadAnimation(self.Animations.ProneWalk)
	self.AnimationTracks.Slide = self.Animator:LoadAnimation(self.Animations.Slide)
end

-- Reset camera offset tweens
function MovementHandler:ResetCameraOffsetTweens()
	self.CameraOffsetTweens.Default = TweenService:Create(self.Humanoid, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {CameraOffset = Vector3.new(0, 0, 0)})
	self.CameraOffsetTweens.Crouch = TweenService:Create(self.Humanoid, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {CameraOffset = Vector3.new(0, -1, 0)})
	self.CameraOffsetTweens.Prone = TweenService:Create(self.Humanoid, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {CameraOffset = Vector3.new(0, -3, 0)})
	self.CameraOffsetTweens.Slide = TweenService:Create(self.Humanoid, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {CameraOffset = Vector3.new(0, -2, 0)})
end

-- Humanoid events
function MovementHandler:onHumanoidStateChanged(_, NewState)
	-- Data to be used by external scripts
	self.HumanoidState.Value = tostring(NewState)
end

function MovementHandler:onHumanoidRunning(Speed)
	if Speed == 0 then
		self.AnimationTracks.CrouchWalk:Stop()
		self.AnimationTracks.ProneWalk:Stop()
	else
		if self.States.Crouching then
			-- Play animation only if it isnt playing, to avoid restart of animation
			if not self.AnimationTracks.CrouchWalk.IsPlaying then
				self.AnimationTracks.CrouchWalk:Play()
			end
			-- Adjust the speed of animation to match Character WalkSpeed
			self.AnimationTracks.CrouchWalk:AdjustSpeed(Speed / self.AnimationTracks.CrouchWalk.Length)
		end
		if self.States.Proning then
			-- Play animation only if it isnt playing, to avoid restart of animation
			if not self.AnimationTracks.ProneWalk.IsPlaying then
				self.AnimationTracks.ProneWalk:Play()
			end
			-- Adjust the speed of animation to match Character WalkSpeed
			self.AnimationTracks.ProneWalk:AdjustSpeed(Speed / self.AnimationTracks.ProneWalk.Length)
		end
	end
end

function MovementHandler:onHumanoidJumping(Jumping)
	if Jumping then
		if self.States.Crouching then
			self:StopCrouching()
		end
		if self.States.Proning then
			self:StopProning()
		end
	end
end

-- Sprint
function MovementHandler:StartSprinting()
	if not self.Configurations.SprintEnabled then return end
	if self.States.Crouching then
		self:StopCrouching()
	end
	if self.States.Proning then
		self:StopCrouching()
	end
	if not self.States.Sliding then
		-- Player is sliding, don't overwrite the MovementState
		self.MovementState.Value = "Sprinting"
	end
	self.States.Sprinting = true
	self.Humanoid.WalkSpeed = self.Configurations.SprintSpeed
end

function MovementHandler:StopSprinting()
	self.States.Sprinting = false
	self.Humanoid.WalkSpeed = self.Configurations.WalkSpeed
	if not self.States.Sliding then
		-- Player is sliding, don't overwrite the MovementState
		self.MovementState.Value = ""
	end
end

-- Crouch
function MovementHandler:StartCrouching()
	if not self.Configurations.CrouchEnabled then return end
	self.MovementState.Value = "Crouching"
	self.States.Crouching = true
	self.AnimationTracks.CrouchIdle:Play()
	self.CameraOffsetTweens.Crouch:Play()
	self.Humanoid.WalkSpeed = self.Configurations.CrouchSpeed
end

function MovementHandler:StopCrouching()
	self.Humanoid.WalkSpeed = self.Configurations.WalkSpeed
	self.MovementState.Value = ""
	self.States.Crouching = false
	self.AnimationTracks.CrouchIdle:Stop()
	self.AnimationTracks.CrouchWalk:Stop()
	self.CameraOffsetTweens.Default:Play()
end

-- Prone
function MovementHandler:StartProning()
	if not self.Configurations.ProneEnabled then return end
	self.MovementState.Value = "Proning"
	self.States.Proning = true
	self.AnimationTracks.ProneIdle:Play()
	self.CameraOffsetTweens.Prone:Play()
	self.Humanoid.WalkSpeed = self.Configurations.ProneSpeed
end

function MovementHandler:StopProning()
	self.Humanoid.WalkSpeed = self.Configurations.WalkSpeed
	self.MovementState.Value = ""
	self.States.Proning = false
	self.AnimationTracks.ProneIdle:Stop()
	self.AnimationTracks.ProneWalk:Stop()
	self.CameraOffsetTweens.Default:Play()
end

-- Slide
function MovementHandler:StartSliding()
	if not self.Configurations.SlideEnabled then return end
	local HumanoidRootPart = self.Character.HumanoidRootPart
	local JumpPower = self.Humanoid.JumpPower
	local JumpHeight = self.Humanoid.JumpHeight
	local num = 0
	self.MovementState.Value = "Slide"
	self.States.Sliding = true
	self.AnimationTracks.Slide:Play()
	self.CameraOffsetTweens.Slide:Play()
	self.Humanoid.JumpPower = 0
	self.Humanoid.JumpHeight = 0
	-- Slide the character
	while math.abs(num - 5) > 0.01 do
		num = self:Lerp(num, 5, 0.1)
		local rec = num / 10
		HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -rec)
		RunService.RenderStepped:Wait()
	end
	self.Humanoid.JumpPower = JumpPower
	self.Humanoid.JumpHeight = JumpHeight
	self.MovementState.Value = ""
	self.States.Sliding = false
	self.AnimationTracks.Slide:Stop()
	self.CameraOffsetTweens.Default:Play()
	if self.States.Sprinting then
		-- Sprinting state is still true, start sprinting
		self:StartSprinting()
	end
end

-- Player input
function MovementHandler:ProcessInput(_, InputState, InputObject)
	if not self.Enabled then return end
	if InputObject.KeyCode == Enum.KeyCode.LeftShift then
		if InputState == Enum.UserInputState.Begin then
			self:StartSprinting()
		else
			self:StopSprinting()
		end
	end
	if InputObject.KeyCode == Enum.KeyCode.C and InputState == Enum.UserInputState.Begin and self.States.Sliding == false then
		if self.States.Sprinting then
			-- Tried to crouch but player is sprinting
			self:StartSliding()
		else
			if self.States.Crouching then
				self:StopCrouching()
				self:StartProning()
			else
				self:StopProning()
				self:StartCrouching()
			end
		end
	end
end

function MovementHandler:GetPlayerInput()
	local function PlayerInput(ActionName, InputState, InputObject)
		self:ProcessInput(ActionName, InputState, InputObject)
	end
	ContextActionService:BindAction("Sprint", PlayerInput, true, Enum.KeyCode.LeftShift)
	ContextActionService:BindAction("Crouch", PlayerInput, true, Enum.KeyCode.C)
	ContextActionService:SetTitle("Crouch", "Crouch")
	ContextActionService:SetTitle("Sprint", "Sprint")
	ContextActionService:SetPosition(("Crouch"), UDim2.new(1, -160, 1, -60))
	ContextActionService:SetPosition(("Sprint"), UDim2.new(1, -90, 1, -150))
end

-- Destructor
function MovementHandler:Destroy()
	self.Enabled = false
	for i,_ in pairs(self.States) do
		self.States[i] = false
	end
	self:StopProning()
	self:StopCrouching()
	self:StopSprinting()
	self.onCharacterAddedConnection:Disconnect()
	self.onHumanoidStateChangedConnection:Disconnect()
	self.onHumanoidRunningConnection:Disconnect()
	self.onHumanoidJumpingConnection:Disconnect()
	ContextActionService:UnbindAction("Sprint")
	ContextActionService:UnbindAction("Crouch")
	for i,_ in pairs(self) do
		self[i] = nil
	end
	for i,_ in pairs(getmetatable(self)) do
		getmetatable(self)[i] = nil
	end
end

-- Constructor
local MovementHandlerModule = {}
function MovementHandlerModule:New(ProfileInfo)
	ProfileInfo = ProfileInfo or {}
	setmetatable(ProfileInfo, MovementHandler)
	MovementHandler.__index = MovementHandler
	return ProfileInfo
end

return MovementHandlerModule
