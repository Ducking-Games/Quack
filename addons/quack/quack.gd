@tool
extends EditorPlugin

var settings_path = "quack/"
var settings_general_path = "%sgeneral/" % [settings_path]
var settings_defaults_path = "%sdefaults/" % [settings_path]

var setting_default_player_bus = {
		"name": "%sdefault_player_bus" % [settings_defaults_path],
		"default": "Master",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "busses"
}

var setting_default_player_pool_size = {
	"name": "%sdefault_player_pool_size" % [settings_defaults_path],
	"default": 8,
	"type": TYPE_INT,
	"hint": PROPERTY_HINT_RANGE,
	"hint_string": "0,8,or_more"
}

var setting_default_player_volume = {
	"name": "%sdefault_player_volume" % [settings_defaults_path],
	"default": 1.0,
	"type": TYPE_FLOAT,
	"hint": PROPERTY_HINT_RANGE,
	"hint_string": "0.0, 1.0"
}

var setting_default_ignore_busses = {
	"name": "%sdefault_ignored_busses" % [settings_defaults_path],
	"default": "",
	"type": TYPE_STRING,
}

var setting_remove_settings_on_unload = {
	"name": "%sremove_settings_on_unload" % [settings_general_path],
	"default": true,
	"type": TYPE_BOOL,
}

var settings: Array[Dictionary] = [
	setting_default_player_bus,
	setting_default_player_pool_size,
	setting_default_player_volume,
	setting_remove_settings_on_unload
]

func _get_busses() -> String:
	var busses: String = ""
	for bus_idx in AudioServer.bus_count:
		var bus = AudioServer.get_bus_name(bus_idx)
		if len(busses) < 1:
			busses = bus
		else:
			busses = "%s,%s" % [busses, bus]
	return busses

func _build_settings() -> void:
	for setting in settings:
		var name: String = setting.get("name")
		ProjectSettings.set_setting(name, setting.get("default"))
		ProjectSettings.set_as_basic(name, true)
		ProjectSettings.add_property_info(setting)
		ProjectSettings.set_initial_value(name, setting.get("default"))

func _refresh_busses() -> void:
	setting_default_player_bus["hint_string"] = _get_busses()
	ProjectSettings.add_property_info(setting_default_player_bus)

func _enter_tree() -> void:
	# Settings setup
	_build_settings()
	_refresh_busses()
	
	add_autoload_singleton("QuackSound", "res://addons/quack/quacksound.tscn")
	AudioServer.bus_layout_changed.connect(_refresh_busses)
	
	
func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_autoload_singleton("QuackSound")

	var clean_settings: bool = ProjectSettings.get_setting(setting_remove_settings_on_unload.get("name"))
	if clean_settings:
		for setting in settings:
			if ProjectSettings.has_setting(setting.get("name")):
				ProjectSettings.clear(setting.get("name"))

