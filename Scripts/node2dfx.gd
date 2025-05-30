extends Node 

func play_modulate_flash(node: Node2D, color: Color, duration_in: float, duration_out: float):
	var tween = get_tree().create_tween()
	var original_modulate = node.modulate
	tween.tween_property(node, "modulate", color, duration_in)
	tween.tween_property(node, "modulate", original_modulate, duration_out)

func play_position_shake(node: Node2D, intensity: float, shake_points: int, tweening_val: float):
	var original_position = node.position
	var tween = get_tree().create_tween()
	for i in range(0, shake_points):
		var rand_x = randf() * intensity
		var rand_y = randf() * intensity
		var new_pos = node.position + Vector2(rand_x, rand_y)
		tween.tween_property(node, "position", new_pos, tweening_val)
	await tween.finished
	node.position = original_position
