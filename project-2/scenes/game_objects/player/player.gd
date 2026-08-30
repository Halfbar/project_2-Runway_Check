# Used node2d to simplify project creating. 
# Do not use Node2d for player in other cases

extends Node2D

@onready var player_hat: Sprite2D = $player_body/player_hat
@onready var player_top: Sprite2D = $player_body/player_top
@onready var player_bottom: AnimatedSprite2D = $player_body/player_bottom
@onready var player_walk: AudioStreamPlayer = $player_walk

@export var speed: float = 200.0

var direction: float 

var player_current_head_index: int = 0
var player_current_top_index: int = 0

func _ready() -> void:
	GameManager.player = self
	SignalBus.player_cloth_changed.connect(_on_player_cloth_changed)
	#TODO call change_clothes() when textures will be ready
	change_clothes()

func _process(delta: float) -> void:
	direction = Input.get_axis("move_left","move_right")
	position.x += direction * speed * delta
	position.x = clamp(position.x,GameManager.player_min_x,GameManager.player_max_x)
	if direction != 0:
		player_bottom.play("walk")
		if not player_walk.playing:
			player_walk.pitch_scale = randf_range(0.8, 1.2)
			player_walk.play()
	else:
		player_bottom.play("idle")
		player_walk.stop()

	if direction < 0:
		player_bottom.flip_h = false
	elif direction > 0:
		player_bottom.flip_h = true

func _on_player_cloth_changed(slot, value):
	match slot:
		"head":
			player_current_head_index = posmod(player_current_head_index + value, GameManager.all_heads.size())
		"top":
			player_current_top_index = posmod(player_current_top_index + value, GameManager.all_tops.size())
		_:
			return
	change_clothes()

func change_clothes():
	player_hat.texture = GameManager.all_heads[player_current_head_index].texture
	player_top.texture = GameManager.all_tops[player_current_top_index].texture

func get_player_cloths_in_slot(slot: String) -> Cloth_Data:
	match slot:
		"head":
			return GameManager.all_heads[player_current_head_index]
		"top":
			return GameManager.all_tops[player_current_top_index]
	return null
