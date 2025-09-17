extends Node

signal Quit

func _ready() -> void:
    SetImGuiConfig()

func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
        OnQuit()

func OnQuit():
    Quit.emit()
    get_tree().quit()

func SetSetting():
    get_tree().auto_accept_quit = false

func SetImGuiConfig():
    var io = ImGui.GetIO()
    io.ConfigFlags |= ImGui.ConfigFlags_DockingEnable
