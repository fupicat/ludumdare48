extends Area2D

var prev_hidden = true
var hidden = true
var stuck = false
onready var gui = $"../.."

func _ready():
    # warning-ignore:return_value_discarded
    connect("mouse_entered", self, "fade_in")
    # warning-ignore:return_value_discarded
    connect("mouse_exited", self, "fade_out")

func _process(_delta):
    if stuck and not gui.held and prev_hidden != hidden and not gui.dead_mode:
        stuck = false
        if hidden:
            $Anim.play("Out")
        else:
            $Anim.play("In")

func fade_in():
    hidden = false
    stuck = true
    if not gui.held and not gui.dead_mode:
        prev_hidden = hidden
        stuck = false
        $Anim.play("In")

func fade_out():
    hidden = true
    stuck = true
    if not gui.held and not gui.dead_mode:
        prev_hidden = hidden
        stuck = false
        $Anim.play("Out")
