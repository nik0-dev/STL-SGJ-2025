class_name CardMetadata extends Resource

@export_group("General")
@export var image: Texture2D = null
@export var color: Color = Color.WHITE
@export var tags: Array[String]

@export_group("Battle")
@export var target_type: Data.TargetType = Data.TargetType.None
@export var permanent: bool = false
