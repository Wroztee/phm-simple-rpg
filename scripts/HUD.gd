extends CanvasLayer


func _ready():
	update_health()
	update_coins()

func update_health():
	$Control/HealthBar.value = PlayerState.health
	
func update_coins():
	$Control/Coins.text = str(PlayerState.coins)
	
func show_hud():
	$Control.show()
	
func hide_hud():
	$Control.hide()
