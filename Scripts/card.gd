class_name Card extends Node2D

const FLIP_SOUND : AudioStream = preload("res://Audio/card_flip.ogg")

var data: CardMetadata:
	set(value):
		if value.image != null:
			image.texture = value.image
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

func _ready() -> void:
	side = Data.CardSide.Back
	image.visible = false if data != null && data.image == null else true
	button.pressed.connect(flip)
	
	BattleManager.event_triggered.connect(
		func(event: BattleManager.EventType):
			if process_events.has(event):
				process_events[event].call()
	)

func flip():
	if !animation_player.is_playing():
		match side:
			Data.CardSide.Front: 
				animation_player.play("flip_to_back")
				side = Data.CardSide.Back
			Data.CardSide.Back:
				animation_player.play("flip_to_front")
				side = Data.CardSide.Front
		AudioManager.play_audio_random_pitch(FLIP_SOUND, 0.85, 1.2)

func add_tag(tag: String): 
	data.tags.append(tag)

func remove_tag(tag: String): 
	data.tags.append(tag)

static func has_tag(card: Card, tag: String) -> bool: 
	return card.data.tags.has(tag)
