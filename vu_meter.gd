extends VBoxContainer
class_name VuMeter

var default: bool = false
var bus: String
var bus_idx: int
var bus_channel_count: int

@onready var l_meter: ProgressBar = get_node("HBoxContainer/meter_l")
@onready var r_meter: ProgressBar = get_node("HBoxContainer/meter_r")
@onready var volume_slider: VSlider = get_node("HBoxContainer/VSlider")
@onready var db_label: Label = get_node("volume")
@onready var label: Label = get_node("name")

func init(bus_name: String) -> void:
	bus = bus_name
	bus_idx = AudioServer.get_bus_index(bus)
	bus_channel_count = AudioServer.get_bus_channels(bus_idx)
	print_rich("[color=green][Quack] Setting up bus: %s [%d] (%d channels)" % [bus, bus_idx, bus_channel_count])
	pass

func update(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(value))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	volume_slider.value_changed.connect(update)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var lavg: float
	for chan in bus_channel_count:
		lavg += AudioServer.get_bus_peak_volume_left_db(bus_idx, chan)
	
	var ravg: float
	for chan in bus_channel_count:
		ravg += AudioServer.get_bus_peak_volume_right_db(bus_idx, chan)
	
	lavg /= bus_channel_count
	lavg /= db_to_linear(AudioServer.get_bus_volume_db(bus_idx))
	ravg /= bus_channel_count
	ravg /= db_to_linear(AudioServer.get_bus_volume_db(bus_idx))
	
	l_meter.value = lavg
	r_meter.value = ravg
	label.text = "*%s" % [bus] if default else "%s" % [bus]
	db_label.text = "%3.0fdB" % ((lavg+ravg)/2)
	
	pass
