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

ENT.MIDIKeys = {
    [36] = { Sound = "a1"  }, -- C
    [37] = { Sound = "b1"  },
    [38] = { Sound = "a2"  },
    [39] = { Sound = "b2"  },
    [40] = { Sound = "a3"  },
    [41] = { Sound = "a4"  },
    [42] = { Sound = "b3"  },
    [43] = { Sound = "a5"  },
    [44] = { Sound = "b4"  },
    [45] = { Sound = "a6"  },
    [46] = { Sound = "b5"  },
    [47] = { Sound = "a7"  },
    [48] = { Sound = "a8"  }, -- c
    [49] = { Sound = "b6"  },
    [50] = { Sound = "a9"  },
    [51] = { Sound = "b7"  },
    [52] = { Sound = "a10" },
    [53] = { Sound = "a11" },
    [54] = { Sound = "b8"  },
    [55] = { Sound = "a12" },
    [56] = { Sound = "b9"  },
    [57] = { Sound = "a13" },
    [58] = { Sound = "b10" },
    [59] = { Sound = "a14" },
    [60] = { Sound = "a15" }, -- c'
    [61] = { Sound = "b11" },
    [62] = { Sound = "a16" },
    [63] = { Sound = "b12" },
    [64] = { Sound = "a17" },
    [65] = { Sound = "a18" },
    [66] = { Sound = "b13" },
    [67] = { Sound = "a19" },
    [68] = { Sound = "b14" },
    [69] = { Sound = "a20" },
    [70] = { Sound = "b15" },
    [71] = { Sound = "a21" },
    [72] = { Sound = "a22" }, -- c''
    [73] = { Sound = "b16" },
    [74] = { Sound = "a23" },
    [75] = { Sound = "b17" },
    [76] = { Sound = "a24" },
    [77] = { Sound = "a25" },
    [78] = { Sound = "b18" },
    [79] = { Sound = "a26" },
    [80] = { Sound = "b19" },
    [81] = { Sound = "a27" },
    [82] = { Sound = "b20" },
    [83] = { Sound = "a28" },
    [84] = { Sound = "a29" }, -- c'''
    [85] = { Sound = "b21" },
    [86] = { Sound = "a30" },
    [87] = { Sound = "b22" },
    [88] = { Sound = "a31" },
    [89] = { Sound = "a32" },
    [90] = { Sound = "b23" },
    [91] = { Sound = "a33" },
    [92] = { Sound = "b24" },
    [93] = { Sound = "a34" },
    [94] = { Sound = "b25" },
    [95] = { Sound = "a35" },
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
