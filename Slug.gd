extends CharacterBody2D
class_name Slug

var speed = -60.0
@export var score = 50

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false

func _ready():
	$hitbox.connect("body_entered", Callable(self, "_on_hitbox_entered"))
	$AnimationPlayer.play("Walk")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !$RayCast2D.is_colliding() and is_on_floor():
		flip()
	
	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		$AnimationPlayer.play("die")
		

func die():
	GameManager.score += 200
	queue_free()

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1)
