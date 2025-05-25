static func get_opponent(player: Constants.BattlerType) -> Constants.BattlerType:
	match player:
		Constants.BattlerType.None: return Constants.BattlerType.None
		Constants.BattlerType.Player: return Constants.BattlerType.Enemy
		Constants.BattlerType.Enemy: return Constants.BattlerType.Player
		_: return Constants.BattlerType.None

static func flip_card(card: Card):
	match card.side:
		Constants.CardSide.Front: 
			card.animation_player.play("flip_to_back")
			card.side = Constants.CardSide.Back
		Constants.CardSide.Back:
			card.animation_player.play("flip_to_front")
			card.side = Constants.CardSide.Front
