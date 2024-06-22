extends Node2D
class_name LevelManager

@export var characters: Array[Constants.Character]

@onready var portaits_container: PortaitsContainer = $UI/PortaitsContainer
@onready var player: Player = $Player
@onready var respawn_point: Marker2D = $RespawnPoint
@onready var totem_spawner: TotemSpawner = $TotemSpawner
@onready var totem_spawn_point: Marker2D = $Player/TotemSpawnPoint
@onready var mechanics: Node2D = $Mechanics
@onready var traps: Node2D = $Traps

var lives: int = 0

func _ready() -> void:
	init_UI()
	spawn_player()

func init_UI() -> void:
	portaits_container.create_secondary_portraits(characters.size())
	update_UI()

func update_UI() -> void:
	portaits_container.update(characters, lives)

func spawn_player() -> void:
	var character = characters[lives]
	var spawn_position = respawn_point.position
	player.spawn(character, spawn_position)

func spawn_totem(spawn_position: Vector2) -> void:
	var callable = totem_spawner.spawn_totem \
		.bind(characters[lives - 1], spawn_position)
	get_tree().process_frame.connect(callable, CONNECT_ONE_SHOT)

func next_character() -> void:
	lives += 1
	if lives >= characters.size():
		reset_level()
		return
	var totem_spawn_position: Vector2 = totem_spawn_point.global_position
	spawn_player()
	call_deferred("spawn_totem", totem_spawn_position)
	update_UI()

func reset_level() -> void:
	totem_spawner.clear_totem()
	lives = 0
	update_UI()
	spawn_player()
	reset_mechanics()
	reset_traps()

func reset_mechanics() -> void:
	for mechanic in mechanics.get_children():
		mechanic.reset()

func reset_traps() -> void:
	for trap in traps.get_children():
		trap.reset()

func _on_player_died() -> void:
	var death_wait_time: float = player.health.recovery_timer.wait_time
	get_tree().create_timer(death_wait_time).timeout.connect(next_character)
