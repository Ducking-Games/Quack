extends Node

const settings_defaults = "quack/defaults/"




func _init() -> void:
	Engine.register_singleton("QuackSound", self)

func get_default(Name: String) -> Variant:
	return ProjectSettings.get_setting("%s%s" % [settings_defaults, Name])

func get_default_bus() -> String:
	var ret = get_default("default_player_bus")
	if ret == null:
		return "Master"
	return ret

func get_default_pool_size() -> int:
	return get_default("default_player_pool_size")

func get_default_player_volume() -> float:
	return get_default("default_player_volume")

func get_busses() -> Array[String]:
	var busses: Array[String] = []
	for bus_idx in AudioServer.bus_count:
		var bus = AudioServer.get_bus_name(bus_idx)
		busses.append(bus)
	return busses

'''
signal refresh()

var _aspMutex: Mutex = Mutex.new()
var AudioStreamPool: Array[AudioStreamPlayerPool] = []
var AudioStreamPoolIndices: Array[String]

const QuackSettings = preload("res://addons/quack/quack_settings.gd")
var settings: QuackSettings = QuackSettings.new()

var busses: Array[String] = []

func _init() -> void:
	Engine.register_singleton("QuackSound", self)

func _ready() -> void:
	
	_reload()

func _enter_tree() -> void:
	_reload()

func _refresh_busses() -> void:
	busses.clear()
	for bus_idx in AudioServer.bus_count:
		var bus = AudioServer.get_bus_name(bus_idx)
		busses.append(bus)

func _reload() -> void:
	print_rich("[color=orange][Quack] Reloading...")
	_refresh_busses()
	refresh.emit()
	
'''
