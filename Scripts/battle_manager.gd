extends Node

signal event_triggered(event: EventType)

var player := HealthComponent.new()
var enemy := HealthComponent.new()
var player_bar : ProgressBar
var enemy_bar : ProgressBar

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

func global_bm_event_list():
	for event in EventType.keys():
		Console.log_msg(event, Color.LIGHT_PINK)
		
func _ready() -> void:
	Console.add_command(
		"bm_emit_event", 
		global_bm_emit_event, 
		{"eventName": TYPE_STRING}, 
		"emulates an event emission from the battle manager singleton"
	)
	
	Console.add_command(
		"bm_event_list",
		global_bm_event_list,
		{},
		"prints the event name keys"
	)
	
	Console.add_command(
		"damage_component",
		func(name, amt):
			damage_health_component(str_to_ownership_target(name), int(amt)),
		{"name": TYPE_STRING, "amt": TYPE_INT}
	)
	
	player.max_health = 20
	player.health = player.max_health
	
	enemy.max_health = 10
	enemy.health = enemy.max_health
	
	player.health_changed.connect(func(amt): 
		Console.log_msg("Player Health Is Now: " + str(amt), Color.YELLOW)
		if player_bar != null:
			player_bar.value = amt
	)
	enemy.health_changed.connect(func(amt): 
		Console.log_msg("Enemy Health Is Now: " + str(amt), Color.YELLOW)
		if enemy_bar.value != null:
			enemy_bar.value = amt
	)

func get_targets(card: Card) -> Array[HealthComponent]:
	if card.ownership == Data.BattlerType.None: return []
	
	var self_target = get_ownership_target(card.ownership)
	var enemy_target = get_ownership_target(get_opponent(card.ownership))
	
	match card.data.target_type:
		Data.TargetType.None: return []
		Data.TargetType.Self: return [self_target]
		Data.TargetType.Enemy: return [enemy_target]
		Data.TargetType.All: return [self_target, enemy_target]
	return []
		
func get_ownership_target(ownership: Data.BattlerType) -> HealthComponent:
	match ownership:
		Data.BattlerType.None: return null
		Data.BattlerType.Player: return player
		Data.BattlerType.Enemy: return enemy
	return null

func get_opponent(player: Data.BattlerType) -> Data.BattlerType:
	match player:
		Data.BattlerType.None: return Data.BattlerType.None
		Data.BattlerType.Player: return Data.BattlerType.Enemy
		Data.BattlerType.Enemy: return Data.BattlerType.Player
		_: return Data.BattlerType.None

func damage_health_component(component: HealthComponent, amt: int):
	if component != null:
		component.take_damage(amt)

func str_to_ownership_target(str: String) -> HealthComponent:
	if Data.BattlerType.keys().has(str):
		return get_ownership_target(Data.BattlerType[str])
	return null
	
