extends Node

signal event_triggered(event: EventType)

var player_health := HealthComponent.new()
var enemy_health := HealthComponent.new()

var enemy_sprite : Node2D
var player_sprite : Node2D

var player_healthbar : ProgressBar
var enemy_healthbar : ProgressBar

var turn : Data.BattlerType = Data.BattlerType.None

signal turn_changed(turn: Data.BattlerType)

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
		func(v_name, amt):
			damage_health_component(str_to_ownership_target(v_name), int(amt)),
		{"name": TYPE_STRING, "amt": TYPE_INT}
	)
	
	Console.add_command(
		"turn",
		func():
			Console.log_msg(Data.BattlerType.keys()[turn], Color.YELLOW)
	)
	
	Console.add_command(
		"change_turn",
		func(key):
			if Data.BattlerType.has(key):
				turn = Data.BattlerType[key],
		{"name": TYPE_STRING}
	)
	
	player_health.max_health = 20
	player_health.health = player_health.max_health
	
	enemy_health.max_health = 10
	enemy_health.health = enemy_health.max_health
	
	player_health.health_changed.connect(func(amt): 
		Console.log_msg("Player Health Is Now: " + str(amt), Color.YELLOW)
		if player_healthbar != null:
			player_healthbar.value = amt
	)
	enemy_health.health_changed.connect(func(amt): 
		Console.log_msg("Enemy Health Is Now: " + str(amt), Color.YELLOW)
		if enemy_healthbar.value != null:
			enemy_healthbar.value = amt
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
		Data.BattlerType.Player: return player_health
		Data.BattlerType.Enemy: return enemy_health
	return null

func get_opponent(v_player: Data.BattlerType) -> Data.BattlerType:
	match v_player:
		Data.BattlerType.None: return Data.BattlerType.None
		Data.BattlerType.Player: return Data.BattlerType.Enemy
		Data.BattlerType.Enemy: return Data.BattlerType.Player
		_: return Data.BattlerType.None

func damage_health_component(component: HealthComponent, amt: int):
	if component != null:
		component.take_damage(amt)

func heal_health_component(component: HealthComponent, amt: int):
	if component != null:
		component.heal(amt)

func str_to_ownership_target(v_str: String) -> HealthComponent:
	if Data.BattlerType.keys().has(v_str):
		return get_ownership_target(Data.BattlerType[v_str])
	return null

func progress_turn(): 
	turn = get_opponent(turn)
	turn_changed.emit(turn)
