extends Control

@onready var settings: Control = $panels/settings
@onready var btns: Control = $btns

#@export var bg_music_main_menu: AudioStream

#func _ready() -> void:
	#SoundManager.stop_sounds()
	#SoundManager.play_music(bg_music_main_menu)

func _on_exit_btn_pressed() -> void:
	get_tree().quit()


func _on_settings_btn_pressed() -> void:
	btns.visible = false
	settings.visible = true


func _on_exit_settings_btn_pressed() -> void:
	btns.visible = true
	settings.visible = false


func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_objects/game_scene/game_scene.tscn")
