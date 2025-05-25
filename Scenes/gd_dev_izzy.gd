extends Node2D

@onready var template_card: Card = $TemplateCard
@onready var component: HealthComponent = $Node

func _ready() -> void:
	template_card.data = preload("res://Data/data_dev_card.tres")
	
	print("max health: " + str(component.max_health))
	
	component.health_changed.connect(func(amt):
		print("health changed to: " + str(amt))
	)
	
	component.damage_taken.connect(func(amt):
		print("damage taken: " + str(amt))	
	)
	
	component.healed.connect(func(amt):
		print("healed: " + str(amt))
	)
	
	component.health_depleted.connect(func():
		print("you died!")
	)
	
	component.take_damage(3)
	component.heal(3)
	component.take_damage(4)
	component.health = 30
	component.health = -10
