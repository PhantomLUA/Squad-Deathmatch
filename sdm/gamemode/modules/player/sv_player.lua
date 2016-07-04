util.AddNetworkString("KillNotification")
function GM:PlayerInitialSpawn(ply)
	if (ply:GetPData("playerLvl") == nil)then
		ply:SetNWInt("playerLvl", 1)
	else
		ply:SetNWInt("playerLvl", tonumber(ply:GetPData("playerLvl")))

		if (ply:GetPData("playerXp") == nil)then
			ply:SetNWInt("playerXp", 0)
		else
			ply:SetNWInt("playerXp", tonumber(ply:GetPData("playerXp")))
			end
		end
	end

local DefaultRunSpeed		= 240
local DefaultWalkSpeed		= 150
local DefaultJumpPower		= 250

local DisableLevel			= 10

local StaminaDrainSpeed 	= 0.5
local StaminaRestoreSpeed 	= 0.1
if (SERVER) then

	-- PlayerSpawn
	function StaminaStart( ply )
		timer.Destroy( "StaminaTimer" )
		ply:SetRunSpeed( DefaultRunSpeed )
		ply:SetNWInt( "Stamina", 50 )

		StaminaRestore( ply )
	end
	hook.Add( "PlayerSpawn", "StaminaStart", StaminaStart )

	-- KeyPress
	function StaminaPress( ply, key )
		if key == IN_SPEED or ply:KeyDown(IN_SPEED) then
			if ply:InVehicle() then return end
			if ply:GetMoveType() == MOVETYPE_NOCLIP then return end
			if ply:GetMoveType() ==  MOVETYPE_LADDER then return end
			if ply:GetNWInt( "Stamina" ) >= DisableLevel then
				ply:SetRunSpeed( DefaultRunSpeed )
				timer.Destroy( "StaminaTimer" )
				timer.Create( "StaminaTimer", StaminaDrainSpeed, 0, function( )
					if ply:GetNWInt( "Stamina" ) <= 0 then
						ply:SetRunSpeed( DefaultWalkSpeed )
						timer.Destroy( "StaminaTimer" )
						return false
					end
					local vel = ply:GetVelocity()
					if vel.x >= DefaultWalkSpeed or vel.x <= -DefaultWalkSpeed or vel.y >= DefaultWalkSpeed or vel.y <= -DefaultWalkSpeed then
						ply:SetNWInt( "Stamina", ply:GetNWInt( "Stamina" ) - 1 )
					end
				end)
			else
				ply:SetRunSpeed( DefaultWalkSpeed )
				timer.Destroy( "StaminaTimer" )
			end
		end
		if key == IN_JUMP or ply:KeyDown(IN_JUMP) then
			if ply:GetNWInt( "Stamina" ) >= DisableLevel then
				ply:SetJumpPower( DefaultJumpPower )
				ply:SetNWInt( "Stamina", ply:GetNWInt( "Stamina" ) - 1 )
			else
				ply:SetJumpPower( 0 )
			end
		end
	end
	hook.Add( "KeyPress", "StaminaPress", StaminaPress )

	-- KeyRelease
	function StaminaRelease( ply, key )
		if key == IN_SPEED and !ply:KeyDown(IN_SPEED) then
			timer.Destroy( "StaminaTimer" )
			StaminaRestore( ply )
		end
	end
	hook.Add( "KeyRelease", "StaminaRelease", StaminaRelease )

	-- StaminaRestore
	function StaminaRestore( ply )
		timer.Create( "StaminaGain", StaminaRestoreSpeed, 0, function( )
			if ply:GetNWInt( "Stamina" ) >= 100 or (key == IN_SPEED and ply:KeyDown(IN_SPEED)) then
				return false
			else
				ply:SetNWInt( "Stamina", ply:GetNWInt( "Stamina" ) + 1 )
			end
		end)
	end

end

function GM:PlayerSpawn(ply)
	ply:SetGravity(0.9)
	ply:SetMaxHealth(100)
	ply:SetRunSpeed(250)
	ply:SetWalkSpeed(150)
	ply:Give("ryry_mosin")
	ply:SetModel("models/player/urban.mdl")
	if ply:IsAdmin() or ply:IsSuperAdmin() then ply:Give("gmod_tool") end
	ply:Give("cw_g4p_usp40")
	ply:Flashlight( false )
	ply:AllowFlashlight( true )
	ply:SetupHands()
end

function GM:OnNPCKilled(npc,attacker,inflictor)
	net.Start("KillNotification")
	net.Send(attacker)
end

function GM:PlayerDeath(victim, inflictor, attacker)

	attacker:SetNWInt("playerXP", attacker:GetNWInt("playerXP") + 350)

	checkForLevel(attacker)

	if(attacker == victim) then return end
		net.Start("KillNotification")
		net.Send(attacker)
end

function GM:PlayerCanHearPlayersVoice( listener, talker )
	return ( listener:GetPos():Distance( talker:GetPos() ) <= 500 )
end


function GM:PlayerGiveSWEP( ply, class, swep )
	if (ply:IsAdmin() or ply:IsSuperAdmin()) then
		return true
	else
		return false
	end
end


function checkForLevel(ply)
	local xpToLvl = (ply:GetNWInt("playerLvl")* 100) * 3
	local curXp = ply:GetNWInt("playerXp")
	local curLvl = ply:GetNWInt("playerLvl")

	if (curXp >= xpToLvl) then
		curXp = curXp - xpToLvl

		ply:SetNWInt("playerXp", curXp)
		ply:SetNWInt("playerLvl", curLvl + 1)
	end
end
