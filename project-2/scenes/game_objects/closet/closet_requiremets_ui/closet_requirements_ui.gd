extends Control

@onready var reuirements_label_box: VBoxContainer = $Panel/MarginContainer/reuirements_label_box

var slot_names = {
	"head": "Head",
	"top": "Top",
}

func _ready() -> void:
	SignalBus.new_requirement.connect(_on_new_requirements)
	
func _on_new_requirements(requirements_array: Array[Requirement_Data]):
	var labels = reuirements_label_box.get_children()
	
	for label in labels:
		label.hide()
	
	for i in requirements_array.size():
		var requirement = requirements_array[i]
		var label: Label = labels[i]
		
		label.text = create_requirement_text(requirement)
		label.show()

func create_requirement_text(requirement: Requirement_Data) -> String:
	var slot_name = slot_names[requirement.slot]
	match requirement.property:
		"color":
			return "%s must contain %s" % [slot_name, requirement.value]
		"display_name":
			return "Put on: %s" % requirement.value
	return ""
