extends Node2D

var Enemy = preload("res://Enemy.tscn")
onready var spawn_point = $SpawnPoint
func _ready():
	# Timer oluştur ve düzenli spawn için ayarla
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "spawn_enemy")
	timer.start(2.0)  # Her 2 saniyede bir düşman oluştur
	
	# İlk düşmanı hemen oluştur
	spawn_enemy()

func spawn_enemy():
	var enemy = Enemy.instance()
	
	# Spawn noktasından rastgele ±100 pixel sapma ile spawn et
	var random_offset = Vector2(
		rand_range(-100, 100),
		0
	)
	enemy.position = spawn_point.position + random_offset
	
	add_child(enemy)
