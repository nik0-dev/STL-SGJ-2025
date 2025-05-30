extends Card

const DAMAGE_VALUE : int = 1

func _ready() -> void:
	data = preload("res://Data/basic_attack.tres")
	ownership = Data.BattlerType.Player
	activated.connect(activate)
	super._ready()

func activate():
	var targets = BattleManager.get_targets(self)
	for target in targets:
		BattleManager.damage_health_component(target, DAMAGE_VALUE)
