extends HBoxContainer

@onready var play_btn: Button = get_node("play")
@onready var bus_name: OptionButton = get_node("bus")

@export var text: String
@export var file: AudioStream
var bus: String

var player: AudioStreamPlayerPooling


func _update(bus_idx: int) -> void:
	bus = bus_name.get_item_text(bus_idx)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_btn.text = text
	var busses: Array[String] = QuackSound.get_busses()
	
	for bussy in busses:	
		bus_name.add_item(bussy)
	
	bus_name.item_selected.connect(_update)
	
	bus_name.select(0)
	pass # Replace with function body.
	
	player = AudioStreamPlayerPooling.new(false)
	add_child(player)
	player.stream = file
	

func play() -> void:
	if player.playing:
		player.stop()
	else:
		player.bus = bus
		player.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
