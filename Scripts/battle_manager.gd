extends Node

signal event_triggered(event: EventType)

enum EventType {
	BattleStart,
	CardsReplenished,
	CardsDepleted,
	TurnStart,
	CardEffectActivated,
	CardPlayed,
	TurnEnd,
	Healed,
	Defending,
	CardResolved,
	DamageDealt,
	DamageTaken,
	BattleComplete
}

### writes hello to the console
func global_bm_emit_event(eventName: String):
	if EventType.keys().has(eventName):
		event_triggered.emit(EventType.get(eventName))

func _ready() -> void:
	Console.add_command(
		"global_bm_emit_event", 
		global_bm_emit_event, 
		{"eventName": TYPE_STRING}, 
		"hii"
	)
	
static func get_opponent(player: Constants.BattlerType) -> Constants.BattlerType:
	match player:
		Constants.BattlerType.None: return Constants.BattlerType.None
		Constants.BattlerType.Player: return Constants.BattlerType.Enemy
		Constants.BattlerType.Enemy: return Constants.BattlerType.Player
		_: return Constants.BattlerType.None
