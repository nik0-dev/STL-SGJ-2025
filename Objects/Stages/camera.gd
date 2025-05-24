extends Camera2D

# Load the cursor from the tree
@onready var cursor = $"../ObjPlayer"

func _ready():
	pass
	

func _process(delta):
	
	# Match cursor position
	position.x = cursor.global_position.x/9
	position.y = cursor.global_position.y/9
