class_name Card extends Object

var data: CardBase
var process_events: Dictionary[Constants.BattleEvents, Callable]
var ownership: Constants.BattlerType = Constants.BattlerType.None

func add_tag(tag: String): 
	data.tags.append(tag)

func remove_tag(tag: String): 
	data.tags.append(tag)

static func has_tag(card: Card, tag: String) -> bool: 
	return card.data.tags.has(tag)
