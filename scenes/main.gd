extends Node

const minimum_portrait_size = Vector2(128,224)
const minimum_landscape_size = Vector2(224,160)

@onready var WINDOW_ID := get_window().get_window_id()

var zoom_factor := 4

var fullscreen:=true :
    set(value):
        if value==fullscreen: return
        fullscreen=value
        _resize()

func _ready():
    if not OS.has_feature("template"):
        print("Development mode")
        fullscreen=false
    else:
        _resize()

func _resize():
    var SCREEN := get_window().current_screen
    force_not_fullscreen()
    var window_size:Vector2=DisplayServer.screen_get_size(SCREEN) if fullscreen else ((DisplayServer.screen_get_usable_rect(SCREEN).size*0.8) as Vector2i)
    # size adjustment is needed for fullscreen on Windows in order to prevent switch to Fullscreen mode here...
    DisplayServer.window_set_size(window_size+(Vector2(1,1) if fullscreen else Vector2.ZERO),WINDOW_ID)
    var is_landscape = window_size.aspect()>1
    var min_size = minimum_landscape_size if is_landscape else minimum_portrait_size
    var calculated_ratio = window_size / min_size
    var zoom = min(calculated_ratio.x,calculated_ratio.y)/zoom_factor
    get_parent().set("content_scale_size",(window_size/zoom))
    %Badges.custom_minimum_size=(window_size/zoom)-Vector2(1,1) # size adjustment because of division rounding errors
    force_center_of_screen(SCREEN)
    reset_window_mode()

## because of Windows implementation that forces fullscreen mode if actually fullscreen
func force_not_fullscreen():
    get_window().position=Vector2(-1,-1)
    DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP,false,WINDOW_ID)
    DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

## because of Windows implementation that forces fullscreen mode if actually fullscreen
func force_center_of_screen(p_screen:int):
    DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
    DisplayServer.window_set_current_screen(p_screen,WINDOW_ID)
    get_window().move_to_center()

## because of Windows implementation that forces fullscreen mode if actually fullscreen
func reset_window_mode():
    DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
    DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP,fullscreen,WINDOW_ID)


func _input(event: InputEvent) -> void:
    if event is InputEventKey:
        if not OS.has_feature("template"):
            if event.is_action_pressed(&"ui_fullscreen"):
                fullscreen = not fullscreen
            if event.is_action_pressed(&"ui_change_screen"):
                DisplayServer.window_set_current_screen((get_window().current_screen+1)%DisplayServer.get_screen_count(),WINDOW_ID)
                _resize()
