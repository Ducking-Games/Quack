extends Panel

@onready var vucontainer: HBoxContainer = get_node("vbox/VUContainer/hbox")
@onready var volcontainer: HBoxContainer = get_node("vbox/VolContainer/hbox")

@onready var vumeter: PackedScene = preload("res://vu_meter.tscn")
@onready var vcontrol: PackedScene = preload("res://volume_control.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var def_bus: String = QuackSound.get_default_bus()
	var busses: Array[String] = QuackSound.get_busses()
	
	for bus in busses:	
		build_vu_meter(bus)
		build_volume_control(bus)
	
	pass # Replace with function body.

func build_vu_meter(bus_name: String) -> VuMeter:
	var meter: VBoxContainer = vumeter.instantiate()
	vucontainer.add_child(meter)
	var m: VuMeter = meter as VuMeter
	m.init(bus_name)
	return meter

func build_volume_control(bus_name: String) -> VolumeControl:
	var cont: VBoxContainer = vcontrol.instantiate()
	volcontainer.add_child(cont)
	var c: VolumeControl = cont as VolumeControl
	c.init(bus_name)
	return cont

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_a_sound() -> void:
	var res: AudioStream = preload("res://samples/button_enter.wav")
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.stream = res
	add_child(player)
	player.play()
	pass

func play_a_music() -> void:
	var res: AudioStream = preload("res://samples/CyberDuck.mp3")
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.stream = res
	player.bus = "Master"
	add_child(player)
	player.play()

func quit() -> void:
	get_tree().quit()
