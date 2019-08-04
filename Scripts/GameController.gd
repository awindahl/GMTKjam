extends Node

var score = 0
var level = 1
var hasSave = false
var player

var enemy = []
var coinSpawner = []

const filepath = "res://save/game_data.sve"
func _ready():
	_load()

func _save():
	var file = File.new()
	file.open_encrypted_with_pass(filepath, File.WRITE, "test")
	var dict = { "0" : score, "1" : level}
	file.store_line(to_json(dict));
	file.close()

func _load():
	var file = File.new();
	if not file.file_exists(filepath) : return
	hasSave = true
	file.open_encrypted_with_pass(filepath, File.READ, "test")
	var save = parse_json(file.get_line())
	score = save["0"]
	level = save["1"]
	file.close()

func deleteSave():
	var dir = Directory.new()
	dir.remove(filepath)
	hasSave = false
