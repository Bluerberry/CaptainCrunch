extends Node2D

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
