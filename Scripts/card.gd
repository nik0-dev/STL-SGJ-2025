class_name Card extends Node2D

var data: CardBase:
	set(value):
		image_placeholder.text = value.name
		if value.image != null:
			image.texture = value.image
		
var process_events: Dictionary[BattleManager.EventType, Callable]
var ownership: Constants.BattlerType = Constants.BattlerType.None
var side: Constants.CardSide = Constants.CardSide.Front

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var button: Button = $Container/Button
@onready var image_placeholder: Label = $Container/CardContents/Front/ImageHolder/ImagePlaceholder
@onready var image: TextureRect = $Container/CardContents/Front/ImageHolder/Image

func _ready() -> void:
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
			Constants.CardSide.Front: 
				animation_player.play("flip_to_back")
				side = Constants.CardSide.Back
			Constants.CardSide.Back:
				animation_player.play("flip_to_front")
				side = Constants.CardSide.Front

func add_tag(tag: String): 
	data.tags.append(tag)

func remove_tag(tag: String): 
	data.tags.append(tag)

static func has_tag(card: Card, tag: String) -> bool: 
	return card.data.tags.has(tag)
