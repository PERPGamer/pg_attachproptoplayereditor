Config = {}
Config.Controls = {
	RaiseX = {control = 174, name = 'INPUT_CELLPHONE_LEFT'}, -- https://docs.fivem.net/docs/game-references/controls/
	LowerX = {control = 175, name = 'INPUT_CELLPHONE_RIGHT'},
	RaiseY = {control = 15, name = 'INPUT_WEAPON_WHEEL_PREV'},
	LowerY = {control = 14, name = 'INPUT_WEAPON_WHEEL_NEXT'},
	RaiseZ = {control = 173, name = 'INPUT_CELLPHONE_DOWN'},
	LowerZ = {control = 172, name = 'INPUT_CELLPHONE_UP'},
	
	RaiseRX = {control = 312, name = 'INPUT_REPLAY_CYCLEMARKERLEFT'},
	LowerRX = {control = 313, name = 'INPUT_REPLAY_CYCLEMARKERRIGHT'},
	RaiseRY = {control = 314, name = 'INPUT_REPLAY_FOVINCREASE'},
	LowerRY = {control = 315, name = 'INPUT_REPLAY_FOVDECREASE'},
	RaiseRZ = {control = 83, name = 'INPUT_VEH_NEXT_RADIO_TRACK'},
	LowerRZ = {control = 84, name = 'INPUT_VEH_PREV_RADIO_TRACK'},
	
	Increment = {control = 127, name = 'INPUT_VEH_SUB_PITCH_UP_ONLY'},
	Decrement = {control = 128, name = 'INPUT_VEH_SUB_PITCH_DOWN_ONLY'},
	Cancel = {control = 202, name = 'INPUT_FRONTEND_CANCEL'}
}
Config.ErrorModelText = '~r~Error:~s~ This model does not exist.'
Config.HelpText = 'X: ~'..Config.Controls.RaiseX.name..'~ ~'..Config.Controls.LowerX.name..'~~n~Y: ~'..Config.Controls.RaiseY.name..'~ ~'..Config.Controls.LowerY.name..'~~n~Z: ~'..Config.Controls.RaiseZ.name..'~ ~'..Config.Controls.LowerZ.name..'~~n~RX: ~'..Config.Controls.RaiseRX.name..'~ ~'..Config.Controls.LowerRX.name..'~~n~RY: ~'..Config.Controls.RaiseRY.name..'~ ~'..Config.Controls.LowerRY.name..'~~n~RZ: ~'..Config.Controls.RaiseRZ.name..'~ ~'..Config.Controls.LowerRZ.name..'~~n~Increment/Decrement: ~'..Config.Controls.Increment.name..'~ ~'..Config.Controls.Decrement.name..'~~n~Cancel ~'..Config.Controls.Cancel.name..'~'