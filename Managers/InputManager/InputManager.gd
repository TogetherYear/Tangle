extends Node

enum Platform {
    PC
}

@export var inputMappings: Array[GUIDEMappingContext] = []

@export var currentPlatform: Platform = Platform.PC

func _ready() -> void:
    GUIDE.enable_mapping_context(inputMappings[currentPlatform], true)
