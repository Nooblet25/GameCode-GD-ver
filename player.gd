extends CharacterBody2D
class_name Player

@export var SPEED: float = 110.0
@export var JUMP_VELOCITY: float = -300.0

@onready var animated_sprite_2d = $AnimatedSprite2D

var max_health = 3
var health = 0
var can_take_damage = true

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	GameManager.damage_taken = 0
	health = max_health
	GameManager.player = self

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_axis = Input.get_axis("ui_left", "ui_right")
	if input_axis:
		velocity.x = input_axis * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animations(input_axis)
	
	if position.y >= 600:
		die()



func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = input_axis < 0
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
	if not is_on_floor():
		animated_sprite_2d.play("jump")

func take_damage(damage_amount : int):
	if can_take_damage:
		iframe()
		
		GameManager.damage_taken += 1
		
		health -= damage_amount
		
		get_node("Healthbar").update_healthbar(health, max_health)
		
		if health <= 0:
			die()
	

func iframe():
	can_take_damage = false
	await get_tree(). create_timer(1).timeout
	can_take_damage = true

func die():
	GameManager.respawn_player()
