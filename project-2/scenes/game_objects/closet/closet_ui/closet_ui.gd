extends Control

@onready var head_texture: TextureRect = $closet_ui_panel/closet_ui_margin_container/vbox_container/head_container/head_texture
@onready var upper_body_texture: TextureRect = $closet_ui_panel/closet_ui_margin_container/vbox_container/upper_body_container/upper_body_texture
@onready var head_label: Label = $closet_ui_panel/closet_ui_margin_container/vbox_container/head_label
@onready var upper_body_label: Label = $closet_ui_panel/closet_ui_margin_container/vbox_container/upper_body_label

func _ready() -> void:
	SignalBus.player_cloth_changed.connect(_on_player_cloth_changed)
	update_visual()

func _on_player_cloth_changed(_slot, _value):
	update_visual()

func _on_prev_head_btn_pressed() -> void:
	SignalBus.player_cloth_changed.emit("head", -1) #goes to player.gd

func _on_next_head_btn_pressed() -> void:
	SignalBus.player_cloth_changed.emit("head", +1) #goes to player.gd


func _on_prev_upper_body_btn_pressed() -> void:
	SignalBus.player_cloth_changed.emit("top", -1) #goes to player.gd


func _on_next_upper_body_btn_pressed() -> void:
	SignalBus.player_cloth_changed.emit("top", +1) #goes to player.gd

func update_visual():
	head_texture.texture = GameManager.player.get_player_cloths_in_slot("head").texture
	head_label.text = GameManager.player.get_player_cloths_in_slot("head").display_name
	upper_body_texture.texture = GameManager.player.get_player_cloths_in_slot("top").texture
	upper_body_label.text = GameManager.player.get_player_cloths_in_slot("top").display_name

func _on_closet_ui_confirm_btn_pressed() -> void:
	SignalBus.ui_panels_closed.emit() # goes to user_interface.gd
