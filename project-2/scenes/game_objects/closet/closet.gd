extends Node2D

@onready var closet_area_2d: Area2D = $closet_area2d
@onready var closet_sprite_2d: AnimatedSprite2D = $closet_sprite2d
@onready var e_png: Sprite2D = $e_png

#@export var open_up_closet_ui: AudioStream
#@export var animation_sfx: AudioStream

func _on_area_2d_area_entered(area: Area2D) -> void:
	#SoundManager.play_sound(animation_sfx,"SFX",true)
	e_png.visible = !e_png.visible
	closet_sprite_2d.play("close")

# TODO add a checking if player in the zone of closet or not
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use") and closet_area_2d.get_overlapping_areas():
		#SoundManager.play_sound(open_up_closet_ui,"SFX",true)
		SignalBus.open_closet_ui.emit() #goes to user_interface.cd
		get_tree().paused = !get_tree().paused


func _on_closet_area_2d_area_exited(area: Area2D) -> void:
		#SoundManager.play_sound(animation_sfx,"SFX",true)
		e_png.visible = !e_png.visible
		closet_sprite_2d.play("open")
