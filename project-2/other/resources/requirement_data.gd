extends Resource

class_name Requirement_Data

@export var slot: String
@export var property: String
@export var value: Variant

func check_requirements(requirement: Requirement_Data) -> bool:
	var current_clothing = GameManager.player.get_player_cloths_in_slot(requirement.slot)
	return requirement.value in current_clothing.color
