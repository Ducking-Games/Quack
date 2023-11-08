# Quack
 A godot audio engine developed for [unannounced game]

# A note
This plugin is under active development and is not ready for consumption.

# Addon Properties
Some configuration is surfaced in the project settings under Quack/

* `quack/defaults/default_player_bus`
    * The default bus for new players to be assigned on creation
* `quack/defaults/default_player_pool_size`
* `quack/defaults/default_player_volume`
* `quack/defaults/default_ignored_busses`
    * Busses to not create audio pools for
    * If a provided bus does not exist it will be logged and skipped
    * Comma-delimited string (ex. `Master,SFX`)


