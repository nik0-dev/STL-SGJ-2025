extends Node2D

@onready var template_card: Card = $TemplateCard

func _ready() -> void:
	template_card.data = preload("res://Data/data_dev_card.tres")
