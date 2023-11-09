extends VBoxContainer
class_name VuMeter

var default: bool = false
var bus: String
var bus_idx: int
var bus_channel_count: int

@onready var meter: ProgressBar = get_node("meter")
@onready var volume: Label = get_node("meter/volume")
@onready var label: Label = get_node("name")

func init(bus_name: String) -> void:
	bus = bus_name
	bus_idx = AudioServer.get_bus_index(bus)
	bus_channel_count = AudioServer.get_bus_channels(bus_idx)
	print_rich("[color=green][Quack] Setting up bus: %s [%d] (%d channels)" % [bus, bus_idx, bus_channel_count])
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var avg: float
	for chan in bus_channel_count:
		avg += AudioServer.get_bus_peak_volume_left_db(bus_idx, chan)
	
	avg /= bus_channel_count
	
	meter.value = avg
	label.text = "*%s" % [bus] if default else "%s" % [bus]
	volume.text = "%3.0fdB" % avg
	
	pass
