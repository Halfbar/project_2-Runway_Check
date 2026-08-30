extends Control

@onready var panels: Control = $panels
@onready var settings: Control = $panels/settings
@onready var btns: Panel = $btns

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		SignalBus.game_paused.emit() # goes to user_interface.gd
		get_tree().paused = !get_tree().paused


func _on_continue_btn_pressed() -> void:
	visible = false
	get_tree().paused = !get_tree().paused


func _on_settings_btn_pressed() -> void:
	settings.visible = true
	settings.mouse_filter = Control.MOUSE_FILTER_STOP
	btns.visible = false
	btns.mouse_filter = Control.MOUSE_FILTER_IGNORE
	

func _on_exit_btn_pressed() -> void:
	get_tree().paused = !get_tree().paused
	get_tree().change_scene_to_file("res://scenes/other/main_menu/main_menu.tscn")

func close_panels():
	var childs = panels.get_children()
	for child in childs:
		child.visible = false
		child.mouse_filter = Control.MOUSE_FILTER_IGNORE
	btns.visible = true
	btns.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_game_btn_pressed() -> void:
	close_panels()
