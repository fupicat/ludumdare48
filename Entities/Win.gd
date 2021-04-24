extends Area2D

# Se encostar no jogador, passa para o próximo nível.
func _on_Win_body_entered(body):
    if body.is_in_group("player"):
        $"../..".next()
