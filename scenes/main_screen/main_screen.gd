extends Control


const STYLE_BADGES_PANEL = preload("uid://dye6djqpxqfq0")
static var STYLE_BADGES_PANEL_CONTAINER = StyleBoxEmpty.new()

var view_zoom:float = 1.0

func _ready() -> void:
    pass
    %Panel.set(&"theme_override_styles/panel",STYLE_BADGES_PANEL)
    %TitleScreen.set(&"theme_override_styles/panel",STYLE_BADGES_PANEL_CONTAINER)



func _on_quit_btn_pressed() -> void:
    get_tree().quit() # Replace with function body.


func _on_screen_management_screen_parameters_changed(new_window_size:  Vector2i,new_zoom:  float,) -> void:
    view_zoom = new_zoom
    custom_minimum_size=(new_window_size/new_zoom)-Vector2(1,1) # size adjustment because of division rounding errors

func _on_item_rect_changed() -> void:
    %TitleScreen.adapt_to_screen(get_window().size,view_zoom)
