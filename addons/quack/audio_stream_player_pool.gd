extends Node
class_name AudioStreamPlayerPool

## fires when the bus layout changes and repopulates
signal reload()

var _mutex: Mutex = Mutex.new()

var pool: Array[AudioStreamPlayerPooling] = []
var busy: Array[AudioStreamPlayerPool] = []

# settings
@export var QuackDefaultPlayerVolume: float = 1.0

var default_pool_size: int = 8
var bus: String

func _init(pool_bus: String = "Master", pool_size: int = default_pool_size) -> void:
	bus = pool_bus
	default_pool_size = pool_size
	
	_build_pool()
	

func _build_pool() -> void:
	_mutex.lock()
	busy.clear()
	pool.clear()
	for i in default_pool_size:
		_grow()
	_mutex.unlock()

func _grow() -> void:
	var player := AudioStreamPlayerPooling.new(false)
	add_child(player)
	_mutex.lock()
	pool.append(player)
	_mutex.unlock()
	player.bus = bus
	player.finished.connect(_finished)

func recycle(player: AudioStreamPlayerPooling) -> void:
	_mutex.lock()
	player.reset()
	if busy.has(player):
		busy.erase(player)
	_mutex.unlock()

func _finished(player: AudioStreamPlayerPooling) -> void:
	recycle(player)
