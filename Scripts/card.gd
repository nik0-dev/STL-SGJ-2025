class_name Card extends Node2D

const FLIP_SOUND : AudioStream = preload("res://Audio/card_flip.ogg")

signal activated

var data: CardMetadata:
	set(value):
		if value.image != null:
			image.texture = value.image
		if has_node("Container/CardVisual"):
			var panel : Panel = get_node("Container/CardVisual")
			var sb : StyleBoxFlat = panel.get_theme_stylebox("panel")
			sb.bg_color = value.color
		data = value
	get:
		return data
		
var process_events: Dictionary[BattleManager.EventType, Callable]
@export var ownership: Data.BattlerType = Data.BattlerType.None
var side: Data.CardSide = Data.CardSide.Front:
	set(value):
		if side != value:
			flip()
			side = value
	get:
		return side

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var button: Button = $Container/Button
@onready var image_placeholder: Label = $Container/CardContents/Front/ImageHolder/ImagePlaceholder
@onready var image: TextureRect = $Container/CardContents/Front/ImageHolder/Image

var activatable : bool = false

func deactivate_button():
	button.disabled = true
	
func activate_button():
	button.disabled = false
	

func _ready() -> void:
	image.visible = false if data != null && data.image == null else true

	BattleManager.event_triggered.connect(
		func(event: BattleManager.EventType):
			if process_events.has(event):
				process_events[event].call()
	)
	
	button.pressed.connect(func():
		ownership = Data.BattlerType.Player
		deactivate_button()
		flip()
		await animation_player.animation_finished
		BattleManager.progress_turn()
	
	)
	
func _process(delta: float) -> void:
	button.disabled = BattleManager.turn == Data.BattlerType.Enemy

func flip():
	if !animation_player.is_playing():
		AudioManager.play_audio_random_pitch(FLIP_SOUND, 0.95, 1.25)
		match side:
			Data.CardSide.Front: 
				animation_player.play("flip_to_back")
				side = Data.CardSide.Back
			Data.CardSide.Back:
				animation_player.play("flip_to_front")
				side = Data.CardSide.Front
				if activatable && ownership != Data.BattlerType.None:
					activated.emit()
					var tween = get_tree().create_tween()
					var m = modulate
					m.a = 0
					tween.tween_property(self, "modulate", m, 1.0)
					await tween.finished
					tween.kill()
					queue_free()

func add_tag(tag: String): 
	data.tags.append(tag)

func remove_tag(tag: String): 
	data.tags.append(tag)

static func has_tag(card: Card, tag: String) -> bool: 
	return card.data.tags.has(tag)
