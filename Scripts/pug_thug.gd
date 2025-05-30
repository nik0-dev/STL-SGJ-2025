extends Node2D
	
func _ready() -> void:
	Console.add_command("pug_thug_take_damage", take_damage)

func take_damage():
	Node2DFX.play_position_shake(self, 20.0, 20, 0.01)
	Node2DFX.play_modulate_flash(self, Color.RED, 0.1, 0.15)
