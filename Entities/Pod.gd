extends RigidBody2D

var vida = 100

onready var planet = get_node("../Planet")
onready var sprite = get_node("Sprite")
onready var sfx = get_node("SFX")

var prev_vel = Vector2(0, 0)

# Antes de tudo atualiza a GUI pra ficar certa.
func _ready():
    gui_update()

func _physics_process(delta):
    # Deixa a gravidade maior quanto mais perto estiver do centro do planeta.
    gravity_scale = 2000 / position.distance_to(planet.position)
    
    # Muda a rotação do sprite pra rotação negativa do rigidbody, pra que o sprite não rotacione junto.
    sprite.rotation = -rotation
    
    # Se a distância entre a velocidade anterior e atual do body for grande, e a mudança de direção for maior que 45 graus, significa que o corpo quicou.
    if prev_vel.distance_to(linear_velocity) > 80 and abs(prev_vel.angle_to(linear_velocity)) > deg2rad(45):
        
        # Toca o som de impacto com pitch aleatório e volume baseado na velocidade.
        sfx.pitch_scale = rand_range(0.8, 1.2)
        sfx.volume_db = linear2db(prev_vel.distance_to(linear_velocity) / 400)
        sfx.play()
        
        # Diminui um valor da vida, baseado na velocidade do body, e morre se a vida for menor que 0.
        vida -= prev_vel.distance_to(linear_velocity) / 100
        if vida < 0:
            get_tree().reload_current_scene()
        
        # Por fim atualiza a GUI
        gui_update()
    
    # Guarda a velocidade atual do body nesse variável para, no próximo frame, podermos saber qual era a velocidade dele no frame anterior, e fazer os cálculos necessários.
    prev_vel = linear_velocity

func gui_update():
    $GUI/Vida.value = vida
