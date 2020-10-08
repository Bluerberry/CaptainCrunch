extends Node

# -------------------> Classes

class Player:
	var id = 1
	var username: String
	var team = "spectator"
	var roles = []

# -------------------> Variables

var player = Player.new()
var players = {}
var team_red = {}
var team_blue = {}
var spectators = {}
