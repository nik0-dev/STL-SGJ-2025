class_name CardBase extends Resource

@export_group("General")
@export var name: String = ""
@export_multiline var description: String = ""
@export var image: Texture2D = null
@export var color: Color = Color.WHITE
@export var tags: Array[String]
@export var flavor_text: String

@export_group("Battle")
@export var target_type: Constants.TargetType = Constants.TargetType.None
@export var process_on_event: Dictionary[BattleManager.EventType, bool]
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
