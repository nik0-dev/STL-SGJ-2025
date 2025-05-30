class_name Data

enum BattlerType {
	None,
	Player,
	Enemy
}

enum CardSide {
	Front,
	Back
}

enum TargetType {
	None,
	Self,
	Enemy,
	All
}

const HEALTH_GREEN : Color = Color(0.0, 1.0, 0.584)
const HEALTH_YELLOW : Color = Color(0.869, 0.871, 0.452)
const HEALTH_RED : Color = Color(0.87, 0.452, 0.452)
