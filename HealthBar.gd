extends Control

onready var health_bar = $TextureProgress  # Bu node'u bulacak

func _ready():
	if health_bar:  # Null kontrolü
		health_bar.max_value = 100
		health_bar.value = 100
	else:
		print("HATA: TextureProgress bulunamadı!")

func update_health(new_health):
	if health_bar:
		health_bar.value = new_health
