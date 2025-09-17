class_name Game

extends Node2D

func _process(_delta):
    if ImGui.Button("Speaker"):
        Dialogic.start("PlayerSpeakerTimeline")
    if ImGui.Button("Bubble"):
        var layout = Dialogic.Styles.change_style("Bubble", true, true)
        layout.register_character("res://Dialogic/Characters/PlayerBubble.dch", $Marker2D)
        Dialogic.start("PlayerBubbleTimeline")
    if ImGui.Button("OpenDoor"):
        SoundManager.PlayAudio(SoundManager.AudioType.DoorOpen, 0.0, 0.05, 2, -1.0, SoundManager.AudioGrade.Door)
    if ImGui.Button("CloseDoor"):
        SoundManager.PlayAudio(SoundManager.AudioType.DoorClose, 0.0, -0.25, 1.5, -1.0, SoundManager.AudioGrade.Door)
