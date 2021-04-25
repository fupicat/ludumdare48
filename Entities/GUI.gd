extends CanvasLayer

const MAX_ACCEL = 20

onready var level = get_parent()

var held = false
var updown = false
var multiply = 1
var restart = 0
var dead_mode = false
var can_control = true

func _ready():
    for butt in $Hints.get_children():
        if butt is Area2D:
            butt.visible = true
    $Label.hide()

func _input(event):
    if not can_control:
        if event.is_action_pressed("click"):
            level.next()
        return
    if event.is_action_released("click"):
        held = false

    if event is InputEventMouseMotion and held:
        if updown:
            level.slider_value = min(abs(event.relative.x), MAX_ACCEL) * sign(event.relative.x) / 10 * multiply
        else:
            level.slider_value = min(abs(event.relative.y), MAX_ACCEL) * sign(event.relative.y) / 10 * multiply

func die():
    dead_mode = true
    $Hints/Anim.play("Restart")

func win():
    can_control = false
    $Hints/Anim.play("Win")

func _on_LeftRight_input_event(_viewport, event, _shape_idx):
    if not can_control:
        return
    restart = 0
    $Hints/Restart/Label.text = "Restart"
    if event.is_action_pressed("click"):
        held = true
        updown = false
        level.slider_value = 0
        multiply = sign($Sprite.get_local_mouse_position().x)

func _on_UpDown_input_event(_viewport, event, _shape_idx):
    if not can_control:
        return
    restart = 0
    $Hints/Restart/Label.text = "Restart"
    if event.is_action_pressed("click"):
        held = true
        updown = true
        level.slider_value = 0
        multiply = -sign($Sprite.get_local_mouse_position().y)

func _on_Restart_input_event(_viewport, event, _shape_idx):
    if not can_control:
        return
    if event.is_action_pressed("click"):
        restart += 1
        if restart == 1:
            $Hints/Restart/Label.text = "Press again to restart"
        if restart == 2:
            var _err = get_tree().reload_current_scene()
