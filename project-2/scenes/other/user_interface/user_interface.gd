extends CanvasLayer

@onready var closet_ui: Control = $ui_in_game/closet_ui
@onready var pause: Control = $ui_other/pause
@onready var score_label: Label = $ui_in_game/score_label

func _ready() -> void:
	SignalBus.open_closet_ui.connect(_on_open_closet_ui)
	SignalBus.game_paused.connect(_on_game_paused)
	SignalBus.ui_panels_closed.connect(_on_ui_panels_closed)
	SignalBus.new_requirement.connect(_on_new_requirement)
	hide_panels()

func _on_new_requirement(_ignore):
	score_label.text = "Score: " + str(GameManager.score)

func _on_ui_panels_closed():
	hide_panels()

func hide_panels():
	get_tree().paused = false
	closet_ui.hide()
	pause.hide()
	
	closet_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
	pause.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _on_open_closet_ui():
	closet_ui.visible = !closet_ui.visible
	closet_ui.mouse_filter = Control.MOUSE_FILTER_STOP

func _on_game_paused():
	pause.visible = !pause.visible
