extends Control


const STYLE_BADGES_PANEL = preload("uid://dye6djqpxqfq0")
static var STYLE_BADGES_PANEL_CONTAINER = StyleBoxEmpty.new()

var view_zoom:Vector2 :
    set(value):
        view_zoom = value
        %Camera2D.zoom = value


func _ready() -> void:
    %Panel.set(&"theme_override_styles/panel",STYLE_BADGES_PANEL)
    %PanelContainer.set(&"theme_override_styles/panel",STYLE_BADGES_PANEL_CONTAINER)
