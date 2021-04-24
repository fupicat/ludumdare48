extends KinematicBody2D

var speed = 0.6
var rot = 0
var cam : Camera2D

onready var pod = get_node("../Pod")

# Tudo isso só cria uma câmera com as opções certas e põe ela como filha do planeta, só pra eu não ter que adicionar uma câmera em todo nível.
func _ready():
    cam = Camera2D.new()
    cam.zoom = Vector2(2, 2)
    cam.smoothing_enabled = true
    add_child(cam)
    cam.make_current()

func _physics_process(delta):
    # Guarda a rotação do frame anterior
    var prev_rot = rot
    
    # Diz pra que direção vai rodar
    rot = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    rot *= speed
    
    # Faz rotação suave
    rotate(lerp(prev_rot, rot, 0.2) * delta)
    
    # Se a nave estiver perto do centro do planeta, coloca a câmera no meio do planeta e da nave. Se estiver longe, coloca a câmera só na nave.
    if pod.position.distance_to(position) < 1000:
        cam.global_position = lerp(position, pod.position, 0.5)
    else:
        cam.global_position = pod.position
