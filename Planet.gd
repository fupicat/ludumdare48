extends KinematicBody2D

var rot = 0

onready var pod = get_node("../Pod")
onready var level = owner

func _physics_process(delta):
    # Guarda a rotação do frame anterior
    var prev_rot = rot
    
    # Diz pra que direção vai rodar
    rot = owner.slider_value
    
    # Faz rotação suave
    rotate(lerp(prev_rot, rot, 0.2) * delta)
