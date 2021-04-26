extends Node

signal faded

var music : AudioStreamPlayer
const FADE = preload("res://Entities/Fade.tscn")

var fader

var restart_count = 0
var started_music = false

func _input(event):
    var _err
    if event.is_action_pressed("1"):
        _err = get_tree().change_scene("res://Levels/Level1.tscn")
    if event.is_action_pressed("2"):
        _err = get_tree().change_scene("res://Levels/Level2.tscn")
    if event.is_action_pressed("3"):
        _err = get_tree().change_scene("res://Levels/Level3.tscn")
    if event.is_action_pressed("4"):
        _err = get_tree().change_scene("res://Levels/Level4.tscn")
    if event.is_action_pressed("5"):
        _err = get_tree().change_scene("res://Levels/Level5.tscn")
    if event.is_action_pressed("6"):
        _err = get_tree().change_scene("res://Levels/Level6.tscn")

func start_music():
    if not started_music:
        started_music = true
        music = AudioStreamPlayer.new()
        add_child(music)
        music.stream = load("res://Music/WackyWobblingsIntro.ogg")
        music.play()
        yield(music, "finished")
        if started_music:
            music.stream = load("res://Music/WackyWobblings.ogg")
            music.play()

func stop_music():
    music.stop()
    started_music = false

func fade(inout : String):
    if not fader:
        fader = FADE.instance()
        add_child(fader)
    fader.get_node("Anim").play(inout)
    yield(fader.get_node("Anim"), "animation_finished")
    if inout == "In":
        fader.queue_free()
        fader = null
    emit_signal("faded")
