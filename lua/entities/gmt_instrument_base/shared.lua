ENT.Base		= "base_anim"
ENT.Type		= "anim"
ENT.PrintName	= "Instrument Base"

ENT.Model		= Model( "models/fishy/furniture/piano.mdl" )
ENT.ChairModel	= Model( "models/fishy/furniture/piano_seat.mdl" )
ENT.MaxKeys		= 4 // how many keys can be played at once

ENT.SoundDir	= "GModTower/lobby/piano/note_"
ENT.SoundExt 	= ".wav"

INSTNET_USE		= 1
INSTNET_HEAR	= 2
INSTNET_PLAY	= 3

INST_LATENCY    = 0.35

//ENT.Keys = {}
ENT.ControlKeys = { 
	[KEY_TAB] =	function( inst, bPressed )
		if ( !bPressed ) then return end
		RunConsoleCommand( "instrument_leave", inst:EntIndex() )
	end,
				
	[KEY_SPACE] = function( inst, bPressed ) 
		if ( !bPressed ) then return end
		inst:ToggleSheetMusic()
	end,
	
	[KEY_LEFT] = function( inst, bPressed )
		if ( !bPressed ) then return end
		inst:SheetMusicBack()
	end,
	[KEY_RIGHT] = function( inst, bPressed )
		if ( !bPressed ) then return end
		inst:SheetMusicForward()
	end,
	
	[KEY_LCONTROL] = function( inst, bPressed )
		if ( !bPressed ) then return end
		inst:CtrlMod() 
	end,
	[KEY_RCONTROL] = function( inst, bPressed )
		if ( !bPressed ) then return end
		inst:CtrlMod() 
	end,
	
	[KEY_LSHIFT] = function( inst, bPressed )
		inst:ShiftMod()
	end,
}

function ENT:GetSound( snd )

	if ( snd == nil || snd == "" ) then
		return nil
	end
	
	return self.SoundDir .. snd .. self.SoundExt
end

if SERVER then
	function ENT:Intiailize()
		self:PrecacheSounds()
	end

	function ENT:PrecacheSounds()

		if !self.Keys then return end

		for _, keyData in pairs( self.Keys ) do
			util.PrecacheSound( self:GetSound( keyData.Sound ) )
		end

	end
end

hook.Add( "PhysgunPickup", "NoPickupInsturmentChair", function( ply, ent )

	local inst = ent:GetOwner()

	if IsValid( inst ) && inst.Base == "gmt_instrument_base" then
		return false
	end

end )

// Returns the approximate "fitted" number based on linear regression.
function math.Fit( val, valMin, valMax, outMin, outMax )
	return ( val - valMin ) * ( outMax - outMin ) / ( valMax - valMin ) + outMin
end	