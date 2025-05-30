extends ProgressBar

func _ready() -> void:
	set_color(value)
	
	value_changed.connect(func(new_value):
		set_color(new_value)
	)

func set_color(progress_value: float):
	var weight = inverse_lerp(min_value, max_value, progress_value)  
	var tween = get_tree().create_tween()
	
	if weight > 0.5:
		tween.tween_property(self, "modulate", Data.HEALTH_GREEN, 0.5)
	elif weight <= 0.5 && weight > 0.25:
		tween.tween_property(self, "modulate", Data.HEALTH_YELLOW, 0.5)
	else:
		tween.tween_property(self, "modulate", Data.HEALTH_RED, 0.5)
	
	await tween.finished
	tween.kill()
