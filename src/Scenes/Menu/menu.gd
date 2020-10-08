extends Node2D

# -------------------> Variables

#onready var Username = get_node("Username")
#onready var TargetIP = get_node("TargetIP")

# -------------------> Functions

# Starts the game as host
func _on_ButtonHost_pressed() -> void:
	networking.create_server($Username.text)
	tools.info("Switching to team select")
	get_tree().change_scene("res://Scenes/TeamSelect/TeamSelect.tscn")


# Starts the game as client
func _on_ButtonJoin_pressed() -> void:
	networking.create_client($Username.text, $TargetIP.text)
	tools.info("Switching to team select")
	get_tree().change_scene("res://Scenes/TeamSelect/TeamSelect.tscn")
