class_name HealthComponent extends Node

signal damage_taken(int)
signal healed(int)
signal health_changed(int)
signal health_depleted

@export var max_health : int = 0
var health: int:
	set(value): 
		health = clamp(value, 0, max_health)
		health_changed.emit(health)
		if health <= 0: health_depleted.emit()
	
func _ready() -> void:
	health = max_health

func take_damage(amt: int):
	health -= amt
	damage_taken.emit(amt)

func heal(amt: int): 
	health += amt
	healed.emit(amt)
