extends Control

var fill_max: float
var fill_amount: float

func _ready():
	# Initialize fill_max based on the initial width of the ColorRect
	fill_max = $ColorRect.size.x

# Update the health bar based on health and max_health values
func update_healthbar(health, max_health):
	# Calculate the fill amount based on health and max_health
	fill_amount = (float(health) / max_health) * fill_max
	
	# Update the width of the ColorRect to represent the fill amount
	$ColorRect.size.x = fill_amount
