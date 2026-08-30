extends Node

const SAVE_PATH = "user://settings.cfg"

var master_volume := 1.0
var sfx_volume := 1.0
var music_volume := 1.0

func _ready():
	load_settings()
	apply_settings()
	
func save_settings():

	var config = ConfigFile.new()

	config.set_value("audio","master",master_volume)
	config.set_value("audio","sfx",sfx_volume)
	config.set_value("audio","music",music_volume)
	config.save(SAVE_PATH)

func load_settings():

	var config = ConfigFile.new()
	
	if config.load(SAVE_PATH) != OK:
		save_settings()
		return
	
	master_volume = config.get_value("audio","master",1.0)
	sfx_volume = config.get_value("audio","sfx",1.0)
	music_volume = config.get_value("audio","music",1.0)

func apply_settings():

	set_bus("Master", master_volume)
	set_bus("SFX", sfx_volume)
	set_bus("Music", music_volume)
	
func set_bus(bus:String,value:float):

	var index = AudioServer.get_bus_index(bus)
	AudioServer.set_bus_volume_db(index,linear_to_db(value))
