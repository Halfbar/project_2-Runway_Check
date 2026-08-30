extends Node2D

@onready var courtains_sprite: AnimatedSprite2D = $courtains_sprite

#@export var animation_sfx: AudioStream

func _on_courtains_area_2d_area_entered(area: Area2D) -> void:
	#SoundManager.play_sound(animation_sfx,"SFX",true)
	courtains_sprite.play("open")


func _on_courtains_area_2d_area_exited(area: Area2D) -> void:
	#SoundManager.play_sound(animation_sfx,"SFX",true)
	courtains_sprite.play("close")
