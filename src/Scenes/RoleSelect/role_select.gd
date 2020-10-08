extends Node2D

# -------------------> Functions

# Sets the team select scene up
func _ready() -> void:
	# Connect signals
	networking.connect("player_update", self, "_update_level")


# Updates the team select scene
func _update_level() -> void:
	# Gather all taken roles
	var roles = []
	for teammate in globals.team_red.values() if globals.player.team == "red" else globals.team_blue.values():
		roles += teammate.roles

	# Hide buttons accordingly
	$ButtonCaptain.disabled = true if roles.has("captain") else false
	$ButtonFirstMate.disabled = true if roles.has("firstmate") else false
	$ButtonEngineer.disabled = true if roles.has("engineer") else false
	$ButtonRadio.disabled = true if roles.has("radio") else false


# Sets roles to captain
func _on_ButtonCaptain_pressed() -> void:
	networking.rpc("set_player_roles", globals.player.id, ["captain"])
	tools.info("Switching to lobby")
	get_tree().change_scene("res://Scenes/Lobby/Lobby.tscn")


# Sets roles to first mate
func _on_ButtonFirstMate_pressed() -> void:
	networking.rpc("set_player_roles", globals.player.id, ["firstmate"])
	tools.info("Switching to lobby")
	get_tree().change_scene("res://Scenes/Lobby/Lobby.tscn")


# Sets roles to engineer
func _on_ButtonEngineer_pressed() -> void:
	networking.rpc("set_player_roles", globals.player.id, ["engineer"])
	tools.info("Switching to lobby")
	get_tree().change_scene("res://Scenes/Lobby/Lobby.tscn")


# Sets roles to radio operator
func _on_ButtonRadio_pressed() -> void:
	networking.rpc("set_player_roles", globals.player.id, ["radio"])
	tools.info("Switching to lobby")
	get_tree().change_scene("res://Scenes/Lobby/Lobby.tscn")
