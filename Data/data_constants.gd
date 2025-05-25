class_name Constants

enum TargetType {
	None,
	Self,
	Enemy,
	All
}

enum BattlerType {
	None,
	Player,
	Enemy
}

enum BattleEvents {
	BattleStart,
	CardsReplenished,
	CardsDepleted,
	TurnStart,
	CardEffectActivated,
	CardPlayed,
	TurnEnd,
	Healed,
	Defending,
	CardResolved,
	DamageDealt,
	DamageTaken,
	BattleComplete
}

enum CardSide {
	Front,
	Back
}
