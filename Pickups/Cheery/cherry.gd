extends Area2D
class_name Cherry

@export var coins = 1
@export var score = 50

var audio_stream_player

func _ready():
	audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player) 

func spawn_feedback():
	var scene_to_spawn = preload("res://Pickups/Feedback/feedback.tscn")
	var new_scene_instance = scene_to_spawn.instantiate()
	get_tree().current_scene.add_child(new_scene_instance)  # Add the instance as a child of the current scene
	new_scene_instance.global_position = global_position


func _on_body_entered(body):
	GameManager.gain_coins(coins)
	GameManager.score += 50
	spawn_feedback()
	queue_free()



