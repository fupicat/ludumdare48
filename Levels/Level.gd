extends Node2D
class_name Level

export var next : String # Variável que você pode mudar no inspetor.

# Muda para a cena com o nome escolhido no inspetor.
func next():
    get_tree().change_scene("res://Levels/" + next + ".tscn")
