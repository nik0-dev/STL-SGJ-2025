static func get_opponent(player: Constants.BattlerType) -> Constants.BattlerType:
	match player:
		Constants.BattlerType.None: return Constants.BattlerType.None
		Constants.BattlerType.Player: return Constants.BattlerType.Enemy
		Constants.BattlerType.Enemy: return Constants.BattlerType.Player
		_: return Constants.BattlerType.None
