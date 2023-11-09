extends AudioStreamPlayer
class_name AudioStreamPlayerPooling

"""
An AudioStreamPlayerPooling is an AudioStreamPlayer modified for use in an AudioStreamPlayerPool which maintains
a pool of "hot" players ready to go at all times.


"""

## Whether or not this pooling player will persist when it's stream is finished
@export var persistent: bool


func _init(persist: bool) -> void:
	persistent = persist

func reset() -> void:
	stream = null
	bus = QuackSound.settings.DefaultPlayerBus
	volume_db = linear_to_db(QuackSound.settings.DefaultPlayerVolume)
	
func acquire(Stream: AudioStream, Bus: String) -> void:
	stream = Stream
	bus = Bus
