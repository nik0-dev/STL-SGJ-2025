extends Node2D

const BASIC_CARD : PackedScene = preload("res://Objects/obj_template_card.tscn")

@export var matching_array : Node 
@onready var enemy_health: ProgressBar = $EnemyHealth
@onready var player_health: ProgressBar = $PlayerHealth

func _ready() -> void:
	for child in matching_array.get_children():
		var card = BASIC_CARD.instantiate()
		child.add_child(card)
		await get_tree().create_timer(0.02).timeout
		card.side = Data.CardSide.Back
		
	BattleManager.player_bar = player_health
	BattleManager.player_bar.max_value = BattleManager.player.max_health
	BattleManager.player_bar.value = BattleManager.player.health
	
	BattleManager.enemy_bar = enemy_health
	BattleManager.enemy_bar.max_value = BattleManager.enemy.max_health
	BattleManager.enemy_bar.value = BattleManager.enemy.health
