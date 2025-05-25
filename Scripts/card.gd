class_name Card extends Node2D

var data: CardBase
var process_events: Dictionary[Constants.BattleEvents, Callable]
var ownership: Constants.BattlerType = Constants.BattlerType.None
var side: Constants.CardSide = Constants.CardSide.Front
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var button: Button = $Container/Button

func _ready() -> void:
	button.pressed.connect(flip)
	
func flip():
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
