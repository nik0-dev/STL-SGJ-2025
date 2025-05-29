extends Node2D

const BASIC_CARD : PackedScene = preload("res://Objects/obj_template_card.tscn")

@export var matching_array : Node2D 
@export var enemy_healthbar : ProgressBar
@export var player_healthbar : ProgressBar 

func _ready() -> void:
	for child in matching_array.get_children():
		var card = BASIC_CARD.instantiate()
		child.add_child(card)
		await get_tree().create_timer(0.02).timeout
		card.side = Data.CardSide.Back
		
	BattleManager.player_healthbar = player_healthbar
	BattleManager.player_healthbar.max_value = BattleManager.player_health.max_health
	BattleManager.player_healthbar.value = BattleManager.player_health.health
	
	BattleManager.enemy_healthbar = enemy_healthbar
	BattleManager.enemy_healthbar.max_value = BattleManager.enemy_health.max_health
	BattleManager.enemy_healthbar.value = BattleManager.enemy_health.health
