extends Node2D


const CARD_POOL : Array[PackedScene] = [
	preload("res://Objects/obj_card_basic_attack.tscn"),
	preload("res://Objects/obj_card_basic_heal.tscn")
]

@export var matching_array : Node2D 
@export var enemy_healthbar : ProgressBar
@export var player_healthbar : ProgressBar 

var cards : Array[Card] = []

func _ready() -> void:
	BattleManager.player_healthbar = player_healthbar
	BattleManager.player_healthbar.max_value = BattleManager.player_health.max_health
	BattleManager.player_healthbar.value = BattleManager.player_health.health
	
	BattleManager.enemy_healthbar = enemy_healthbar
	BattleManager.enemy_healthbar.max_value = BattleManager.enemy_health.max_health
	BattleManager.enemy_healthbar.value = BattleManager.enemy_health.health
		
	BattleManager.turn = Data.BattlerType.Player
	BattleManager.turn_changed.connect(func(turn):
		match turn:
			Data.BattlerType.Enemy:
				if cards.size() > 0:
					var card : Card = cards.pick_random()
					card.ownership = Data.BattlerType.Enemy
					card.flip()
					BattleManager.progress_turn()
				
	)
	
	refresh_cards()
	

func refresh_cards(): 
	for child in matching_array.get_children():
		var card : Card = CARD_POOL.pick_random().instantiate()
		child.add_child(card)
		cards.append(card)
		card.deactivate_button()
		card.activated.connect(cards.erase.bind(card))
		
	await get_tree().create_timer(1.0).timeout
	
	for card in cards:
		card.flip()
		await get_tree().create_timer(0.02).timeout
		card.activate_button()
		card.activatable = true

func _process(delta: float) -> void:
	if cards.size() == 0:
		refresh_cards()
		
