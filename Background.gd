extends Node2D

export var scroll_speed = 10  # Kaydırma hızı
onready var background1 = $Background
onready var background2 = $Background2
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
	# Null kontrolü ekleyelim
	if !background1 or !background2:
		print("HATA: Background node'ları bulunamadı!")
		return
		
	if !background1.texture or !background2.texture:
		print("HATA: Background texture'ları yüklenmemiş!")
		return
	
	# Debug bilgisi
	print("Background boyutu:", background1.texture.get_size())
	
	# Arka planları ayarla
	var bg_size = background1.texture.get_size()
	var scale_factor = Vector2(
		screen_size.x / bg_size.x,
		screen_size.y / bg_size.y
	)
	
	background1.scale = scale_factor
	background2.scale = scale_factor
	
	# İlk pozisyonları ayarla
	background1.position = screen_size / 2
	background2.position = Vector2(
		screen_size.x / 2,
		-screen_size.y / 2
	)

func _process(delta):
	if !background1 or !background2:
		return
		
	# Her iki arka planı da kaydır
	background1.position.y += scroll_speed * delta
	background2.position.y += scroll_speed * delta
	
	# Ekran dışına çıkan arka planı yukarı taşı
	if background1.position.y - screen_size.y/2 > screen_size.y:
		background1.position.y = background2.position.y - screen_size.y
		
	if background2.position.y - screen_size.y/2 > screen_size.y:
		background2.position.y = background1.position.y - screen_size.y
