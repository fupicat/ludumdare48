extends Node2D
class_name Level

const DECELERATION = 0.05

onready var pod = $Pod
onready var planet = $Planet

var cam : Camera2D
var tween : Tween
var shake_intensity = 0
var gui
var slider_value = 0
var dead = false

# Tudo isso só cria uma câmera com as opções certas e põe ela como filha do
# planeta, só pra eu não ter que adicionar uma câmera em todo nível.
func _ready():
    cam = Camera2D.new()
    cam.zoom = Vector2(2, 2)
    cam.smoothing_enabled = true
    add_child(cam)
    cam.make_current()
    
    tween = Tween.new()
    add_child(tween)
    
    gui = load("res://Entities/GUI.tscn").instance()
    add_child(gui)

# warning-ignore:unused_argument
func _physics_process(delta):
    # Se a nave estiver perto do centro do planeta, coloca a câmera no meio do
    # planeta e da nave. Se estiver longe, coloca a câmera só na nave.
    if not dead:
        if pod.position.distance_to(planet.position) < 1000:
            cam.global_position = lerp(planet.position, pod.position, 0.5)
        else:
            cam.global_position = pod.position
    
    cam.offset = Vector2(0, 0)
    if shake_intensity > 0:
        cam.offset = Vector2(rand_range(-shake_intensity, shake_intensity),
                rand_range(-shake_intensity, shake_intensity))
    
    # Desacelera o slider
    slider_value = lerp(slider_value, 0, DECELERATION)

# Muda para o próximo nível automaticamente
func next():
    var next = filename.replace(".tscn", "")
    next = str(int(next[-1]) + 1)
    # warning-ignore:return_value_discarded
    get_tree().change_scene("res://Levels/Level" + next + ".tscn")

func death():
    var explosion = load("res://Entities/Explosion.tscn").instance()
    add_child(explosion)
    explosion.position = pod.position
    explosion.emitting = true
    explosion.get_node("Explosion").emitting = true
    pod.queue_free()
    dead = true
    gui.die()

func win():
    gui.win()
    pod.win()

func camera_shake(intensity):
    # warning-ignore:return_value_discarded
    tween.interpolate_property(self, "shake_intensity",
            intensity, 0, 0.5, Tween.TRANS_QUART, Tween.EASE_OUT)
    # warning-ignore:return_value_discarded
    tween.start()
