extends CanvasLayer

const MAX_ACCEL = 20

onready var level = get_parent()

var held = false
var updown = false
var multiply = 1

func _input(event):
    if event.is_action_released("click"):
        held = false

    if event is InputEventMouseMotion and held:
        if updown:
            level.slider_value = min(abs(event.relative.x), MAX_ACCEL) * sign(event.relative.x) / 10 * multiply
        else:
            level.slider_value = min(abs(event.relative.y), MAX_ACCEL) * sign(event.relative.y) / 10 * multiply

func _on_LeftRight_input_event(_viewport, event, _shape_idx):
    if event.is_action_pressed("click"):
        held = true
        updown = false
        level.slider_value = 0
        multiply = sign($Sprite.get_local_mouse_position().x)

func _on_UpDown_input_event(_viewport, event, _shape_idx):
    if event.is_action_pressed("click"):
        held = true
        updown = true
        level.slider_value = 0
        multiply = -sign($Sprite.get_local_mouse_position().y)
