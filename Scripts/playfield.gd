extends Node2D

const BASIC_CARD : PackedScene = preload("res://Objects/obj_template_card.tscn")

@export var matching_array : Node 

func _ready() -> void:
	for child in matching_array.get_children():
		var card = BASIC_CARD.instantiate()
		child.add_child(card)
		await get_tree().create_timer(0.02).timeout
		card.side = Data.CardSide.Back
