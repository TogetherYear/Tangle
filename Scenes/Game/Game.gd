class_name Game

extends Node2D

@export var moveAction: GUIDEAction

@export var jumpAction: GUIDEAction

func _process(_delta):
    ImGui.Begin("Debug")
    if ImGui.Button("Speaker"):
        Dialogic.start("PlayerSpeakerTimeline")
    if ImGui.Button("Bubble"):
        var layout = Dialogic.Styles.change_style("Bubble", true, true)
        layout.register_character("res://Dialogic/Characters/PlayerBubble.dch", $Marker2D)
        Dialogic.start("PlayerBubbleTimeline")
    if ImGui.Button("OpenDoor"):
        SoundManager.PlayAudio(SoundManager.AudioType.ChestOpen, -10.0, 0.09, 1, -1.0, SoundManager.AudioGrade.Chest)
    if ImGui.Button("CloseDoor"):
        SoundManager.PlayAudio(SoundManager.AudioType.ChestClose, -10.0, 0.0, 1, -1.0, SoundManager.AudioGrade.Chest)
    ImGui.End()

    if !moveAction.value_axis_2d.is_zero_approx():
        print(moveAction.value_axis_2d)
    
    if jumpAction.is_triggered():
        print("Jump")
