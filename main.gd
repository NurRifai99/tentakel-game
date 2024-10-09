extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop() # Replace with function body.

func new_game() -> void:
	score = 0
	$player.start($startposition.position)
	$starttimer.start()

func _on_scoretimer_timeout() -> void:
	score += 1 # Replace with function body.

func _on_starttimer_timeout() -> void:
	$mobtimer.start()
	$scoretimer.start() # Replace with function body.

func _on_mobtimer_timeout() -> void:
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $mobpath/mobspawnlocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob) # Replace with function body.
