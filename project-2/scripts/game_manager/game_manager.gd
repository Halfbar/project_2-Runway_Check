extends Node

@export var all_heads: Array[Cloth_Data]
@export var all_tops: Array[Cloth_Data]

# Game scene boundaries. 
# Normally they should be physic colliders
# Buuut I don`t need physic colliders in this project =0
var runway_min: float = 150.0 
var player_base_min: float = -120.0

var score: int = 0
var score_add: int = 10
var score_minus: int = 20
var player: Node2D

@export var player_min_x: float = -120.0
@export var player_max_x: float = 300.0

var current_requirements: Array[Requirement_Data]
var player_checked: bool = false

func create_new_requirement():
	var number_of_requirements = randi_range(1, 2)
	var available_slots = ["head", "top"]
	available_slots.shuffle()
	current_requirements.clear()
	for i in range(number_of_requirements):
		var slot = available_slots[i]
		var clothing_list
		match slot:
			"head":
				clothing_list = all_heads
			"top":
				clothing_list = all_tops
		var clothing = clothing_list.pick_random()
		var property = "color"
		var value = clothing.color.pick_random()
				
		var new_requirement = Requirement_Data.new()
		new_requirement.slot = slot
		new_requirement.property = property
		new_requirement.value = value
		
		current_requirements.append(new_requirement)
	SignalBus.new_requirement.emit(current_requirements) #goes to closet_requirements.gd

func evaluate_player() -> bool:
	if check_player_clothing():
		return true
	else:
		return false

func check_player_clothing() -> bool:
	for requirement in current_requirements:
		if !requirement.check_requirements(requirement):
			return false
	return true
