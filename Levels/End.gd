extends Control

func _ready():
    Global.fade("In")
    Global.stop_music()
    $Oopsies/Deaths.text = str(Global.restart_count)
