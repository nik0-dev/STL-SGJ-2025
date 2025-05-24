extends Node2D

# Follow cursor
func _process(delta):
	
	# Hide mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# Follow invisible cursor
	# position.x = get_global_mouse_position().x
	# position.y = get_global_mouse_position().y
	
