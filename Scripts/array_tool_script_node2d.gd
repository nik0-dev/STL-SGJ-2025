@tool extends Node

@export var instance_node: Node2D = null
@export var offset := Vector2i(0,0)
@export var dimensions := Vector2i(0,0)
@export var spacing: int = 0

@export_category("")
@export_tool_button("Generate Array", "ItemList")
var array_tool_button_generate = array_tool_button_generate_impl
@export_tool_button("Destroy Children", "Skeleton3D")
var array_tool_button_destroy = array_tool_button_destroy_impl

func array_tool_button_destroy_impl():
	for child in get_children(): child.queue_free()
	
func array_tool_button_generate_impl():
	for child in get_children(): child.queue_free()
	
	for x in range(0, dimensions.x):
		for y in range(0, dimensions.y):
			var new_in : Node2D = instance_node.duplicate()
			add_child(new_in)
			new_in.owner = get_tree().edited_scene_root
			new_in.name = new_in.get_class() + " - " + str(Vector2i(x,y))
			var new_x = offset.x + (x * spacing)
			var new_y = offset.x + (y * spacing)
			new_in.position = Vector2(new_x, new_y)
			
