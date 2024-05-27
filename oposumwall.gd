extends CharacterBody2D

@export var speed: float = 200.0 # Default speed value

func _process(delta):
	velocity.x = speed
	move_and_slide()

func _on_player_detector_body_entered(body):
	if body.name == "player":
		die()

func die():
	queue_free() # This will remove the node from the scene
