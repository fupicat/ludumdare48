extends Node

var music : AudioStreamPlayer

func _ready():
    music = AudioStreamPlayer.new()
    add_child(music)
    music.stream = load("res://Music/WackyWobblingsIntro.ogg")
    music.play()
    yield(music, "finished")
    music.stream = load("res://Music/WackyWobblings.ogg")
    music.play()
