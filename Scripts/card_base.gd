class_name CardBase extends Resource

@export_group("General")
@export var name: String = ""
@export_multiline var description: String = ""
@export var image: Texture2D = Texture2D.new()
@export var color: Color = Color.WHITE

@export_group("Duration")
# consumes card after it is activated
@export var one_time_activation: bool = true
# unlimited activations
# ignores 'self.one_time_activation'
# ignores 'self.allowed_activations'
@export var permanent: bool = false
# if 'self.one_time_use' is false this variable is used
# if 'self.permanent' is true this is ignored
# an "activation" could be considered any effect that goes into play
@export var allowed_activations: int = 0
# lifetime allows cards to be held for a round duration
@export var use_lifetime: bool = false
# ignored if 'self.use_lifetime' is true
@export var lifetime: int = 0

@export_group("Effects")
@export var activate_on_turn_start: bool = false
@export var activate_on_match: bool = false
@export var activate_on_play: bool = true
@export var activate_on_defend: bool = false
@export var activate_on_attack: bool = false
@export var activate_on_resolve: bool = false
@export var activate_on_turn_end: bool = false

var fx_turn_start: Callable = func(): pass
var fx_on_match: Callable = func(): pass
var fx_on_play: Callable = func(): pass
var fx_on_defend: Callable = func(): pass
var fx_on_attack: Callable = func(): pass
var fx_on_resolve: Callable = func(): pass
var fx_on_turn_end: Callable = func(): pass
