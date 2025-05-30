extends Node2D

const BASIC_CARD : PackedScene = preload("res://Objects/obj_template_card.tscn")
const ATTACK_CARD : PackedScene = preload("res://Objects/obj_card_basic_attack.tscn") 

@export var matching_array : Node2D 
@export var enemy_healthbar : ProgressBar
@export var player_healthbar : ProgressBar 

var cards : Array[Card] = []

func _ready() -> void:
	for child in matching_array.get_children():
		var card : Card = ATTACK_CARD.instantiate()
		child.add_child(card)
		cards.append(card)
		card.deactivate_button()
		
	await get_tree().create_timer(1.0).timeout
	
	for card in cards:
		card.flip()
		await get_tree().create_timer(0.02).timeout
		card.activate_button()
		card.activatable = true
	
	BattleManager.player_healthbar = player_healthbar
	BattleManager.player_healthbar.max_value = BattleManager.player_health.max_health
	BattleManager.player_healthbar.value = BattleManager.player_health.health
	
	BattleManager.enemy_healthbar = enemy_healthbar
	BattleManager.enemy_healthbar.max_value = BattleManager.enemy_health.max_health
	BattleManager.enemy_healthbar.value = BattleManager.enemy_health.health
