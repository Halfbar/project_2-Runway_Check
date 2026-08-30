extends Sprite2D

var start_position: Vector2

func _ready() -> void:
	start_position = position

func jump():
	var tween = create_tween()

	tween.tween_property(
		self,
		"position:y",
		start_position.y - 15,
		0.15
	)

	tween.tween_property(
		self,
		"position:y",
		start_position.y,
		0.15
	)
