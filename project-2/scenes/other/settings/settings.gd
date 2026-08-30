extends Control

@onready var master_slider: HSlider = $TabContainer/Volume/margin_container/vbox_container/master_container/master_slider
@onready var music_slider: HSlider = $TabContainer/Volume/margin_container/vbox_container/music_container/music_slider
@onready var sfx_slider: HSlider = $TabContainer/Volume/margin_container/vbox_container/sfx_container/sfx_slider

func _ready() -> void:
	master_slider.value = ConfigFileGlobal.master_volume
	sfx_slider.value = ConfigFileGlobal.sfx_volume
	music_slider.value = ConfigFileGlobal.music_volume

func set_bus_volume(bus_name: String, volume_percent: float):
	var db = linear_to_db(volume_percent)
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, db)


func _on_master_slider_value_changed(value: float) -> void:
	ConfigFileGlobal.master_volume = value
	config_file_save()


func _on_music_slider_value_changed(value: float) -> void:
	ConfigFileGlobal.music_volume = value
	config_file_save()


func _on_sfx_slider_value_changed(value: float) -> void:
	ConfigFileGlobal.sfx_volume = value
	config_file_save()

func config_file_save():
	ConfigFileGlobal.save_settings()
	ConfigFileGlobal.apply_settings()
