extends Control

var stage = 0

func _input(event):
    if event.is_action_pressed("click"):
        stage += 1
        if $Anim2.has_animation(str(stage)):
            $SFX.play()
            $Anim2.play(str(stage))

func done():
    var _err = get_tree().change_scene("res://Levels/Level1.tscn")

func _on_VideoPlayer_finished():
    $Instructions/Title2/VideoPlayer.play()
