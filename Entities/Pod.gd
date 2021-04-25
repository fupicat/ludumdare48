extends RigidBody2D

const BROKEN1 = preload("res://Entities/Pod/Broken1.png")
const BROKEN2 = preload("res://Entities/Pod/Broken2.png")
const BROKEN3 = preload("res://Entities/Pod/Broken3.png")

var vida = 100

onready var level = $".."
onready var planet = $"../Planet"
onready var sprite = $Sprite
onready var sfx = $SFX

var prev_vel = Vector2(0, 0)

# Antes de tudo atualiza a GUI pra ficar certa.
func _ready():
    gui_update()

# warning-ignore:unused_argument
func _physics_process(delta):
    # Deixa a gravidade maior quanto mais perto estiver do centro do planeta.
    gravity_scale = 2000 / position.distance_to(planet.position)
    
    # Muda a rotação do sprite pra rotação negativa do rigidbody,
    # pra que o sprite não rotacione junto.
    sprite.rotation = -rotation
    
    # Se a distância entre a velocidade anterior e atual do body for grande, e
    # a mudança de direção for maior que 45 graus significa que o corpo quicou.
    if (prev_vel.distance_to(linear_velocity) > 80) and (
            abs(prev_vel.angle_to(linear_velocity)) > deg2rad(45)):
        
        # Toca o som de impacto com pitch aleatório e volume baseado na
        # velocidade.
        sfx.pitch_scale = rand_range(0.8, 1.2)
        sfx.volume_db = range_lerp(linear2db(
                prev_vel.distance_to(linear_velocity) / 400),
                -13, 7, -13, -1)
        sfx.play()
        
        # Faz camera shake de acordo com a intensidade da colisão.
        level.camera_shake(prev_vel.distance_to(linear_velocity) / 100)
        
        # Diminui um valor da vida, baseado na velocidade do body,
        # e morre se a vida for menor que 0.
        vida -= prev_vel.distance_to(linear_velocity) / 100
        if vida < 0:
            # warning-ignore:return_value_discarded
            get_tree().reload_current_scene()
        if vida < 75:
            $Sprite/Pod/Broken.texture = BROKEN1
        if vida < 50:
            $Sprite/Pod/Broken.texture = BROKEN2
        if vida < 25:
            $Sprite/Pod/Broken.texture = BROKEN3
        
        # Por fim atualiza a GUI
        gui_update()
    
    # Guarda a velocidade atual do body nesse variável para, no próximo frame,
    # podermos saber qual era a velocidade dele no frame anterior, e fazer os
    # cálculos necessários.
    prev_vel = linear_velocity
    
    if abs(position.x) > 2000 or abs(position.y) > 2000:
        # warning-ignore:return_value_discarded
        get_tree().reload_current_scene()

func gui_update():
    $Sprite/Vida.value = vida
