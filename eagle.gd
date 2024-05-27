extends CharacterBody2D
class_name Eagle
# Variables for horizontal and vertical speed
var speed = -60.0
var vertical_speed = 20.0
var vertical_direction = 1
@export var score = 200

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false

func _ready():
	$AnimationPlayer.play("Attack")
	# Create and configure the timer to change vertical direction
	var direction_change_timer = Timer.new()
	direction_change_timer.wait_time = 1.0
	direction_change_timer.connect("timeout", Callable(self, "_on_DirectionChangeTimeout"))
	add_child(direction_change_timer)
	direction_change_timer.start()
	
	# Connect the body_entered signal of the Area2D to a function
	$hitbox.connect("body_entered", Callable(self, "_on_hitbox_entered"))

func _physics_process(delta):
	# Horizontal movement
	velocity.x = speed
	
	# Vertical movement
	if not is_on_floor():
		velocity.y += vertical_speed * vertical_direction * delta

	move_and_slide()
	
	
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

# Function to change the vertical direction periodically
func _on_DirectionChangeTimeout():
	vertical_direction *= -1  # Change direction

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		$AnimationPlayer.play("die")
		

func die():
	queue_free()
	GameManager.score += 200

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1)
