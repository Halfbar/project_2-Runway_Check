extends Node2D
@onready var projector: Node2D = $light/projector
@onready var projector_2: Node2D = $light/projector2
@onready var projector_3: Node2D = $light/projector3
@onready var eval_effect: GPUParticles2D = $eval_effect

@export var rose_texture: Texture2D
@export var tomato_texture: Texture2D

#@export var turn_light_on: AudioStream
#@export var eval_player_good_crowd: AudioStream
#@export var eval_player_good: AudioStream
#@export var eval_player_bad_crowd: AudioStream
#@export var eval_player_bad: AudioStream
#@export var eval_player_ready: AudioStream

func _on_runway_end_area_2d_area_entered(area: Area2D) -> void:
	print("player entered runway_end")
	GameManager.player_checked = true
	if GameManager.evaluate_player() == true:
		#SoundManager.play_sound(eval_player_ready,"SFX")
		await get_tree().create_timer(3).timeout
		GameManager.score += GameManager.score_add
		eval_effect.texture = rose_texture
		eval_effect.restart()
		#SoundManager.play_sound(eval_player_good,"SFX")
		#SoundManager.play_sound(eval_player_good_crowd,"SFX",false,true)
		eval_effect.emitting = true
		start_new_round()
	else:
		#SoundManager.play_sound(eval_player_ready,"SFX")
		await get_tree().create_timer(3).timeout
		GameManager.score -= GameManager.score_minus
		eval_effect.texture = tomato_texture
		eval_effect.restart()
		#SoundManager.play_sound(eval_player_bad,"SFX",false,true)
		#SoundManager.play_sound(eval_player_bad_crowd,"SFX",false,true)
		eval_effect.emitting = true
		start_new_round()

func start_new_round():
	turn_lights()
	GameManager.create_new_requirement()
	GameManager.player_checked = false
	GameManager.player_min_x = GameManager.player_base_min

func _on_runway_all_area_2d_area_entered(area: Area2D) -> void:
	if !GameManager.player_checked:
		turn_lights()
		GameManager.player_min_x = GameManager.runway_min

# Maybe there is a better way to do that. 
# But this is good enough. Deadline awaits!
# In other project better use for loop
func turn_lights():
	await get_tree().create_timer(0.2).timeout
	#SoundManager.play_sound(turn_light_on,"SFX")
	projector.visible = !projector.visible
	await get_tree().create_timer(0.2).timeout
	#SoundManager.play_sound(turn_light_on,"SFX")
	projector_2.visible = !projector_2.visible
	await get_tree().create_timer(0.2).timeout
	#SoundManager.play_sound(turn_light_on,"SFX")
	projector_3.visible = !projector_3.visible
