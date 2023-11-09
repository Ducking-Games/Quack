extends VBoxContainer
class_name VolumeControl

@onready var label: Label = get_node("name")
@onready var slider: VSlider = get_node("slider")

var bus: String

func init(bus_name: String) -> void:
	bus = bus_name

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = bus
	slider.value_changed.connect(update_bus_volume)
	pass # Replace with function body.

func update_bus_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear_to_db(value))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
