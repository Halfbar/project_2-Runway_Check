extends Node2D

@export var crowd_layers: Array[Node2D]
#@export var bg_music_game_scene: AudioStream

func _ready() -> void:
	GameManager.create_new_requirement()
	SignalBus.new_requirement.connect(crowd_reaction)
	#SoundManager.stop_sounds()
	#SoundManager.play_music(bg_music_game_scene)

func crowd_reaction(_ignore):
	var timer: float = 0.0
	var duration: float = 2.0

	while timer < duration:
		make_random_people_jump(1)
		var delay = randf_range(0.1, 0.5)
		await get_tree().create_timer(delay).timeout
		timer += delay

func make_random_people_jump(_ignore):
	var layer = crowd_layers.pick_random()
	var people = layer.get_children()
	if people.is_empty():
		return
	var amount = randi_range(1, 3)
	people.shuffle()
	for i in range(min(amount, people.size())):
		people[i].jump()
