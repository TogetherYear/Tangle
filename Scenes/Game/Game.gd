class_name Game

extends Node2D

func _process(_delta):
    if ImGui.Button("Speaker"):
        Dialogic.start("PlayerSpeakerTimeline")
    if ImGui.Button("Bubble"):
        var layout = Dialogic.Styles.change_style("Bubble", true, true)
        layout.register_character("res://Dialogic/Characters/PlayerBubble.dch", $Marker2D)
        Dialogic.start("PlayerBubbleTimeline")
