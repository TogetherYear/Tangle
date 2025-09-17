extends Node

## 动作音效 索引使用AudioType
@export var audio_list: Array[AudioStream]

## 音效类型
enum AudioType {
    DoorOpen,
    DoorClose,
}

## 音效等级
enum AudioGrade {
    None,
    Door
}

## 初始化对象池大小
@export var pool_size = 10

var pool: Array[AudioStreamPlayer] = []

## 等级字典
var grade_dic: Dictionary = {}

var tween: Tween

func _enter_tree() -> void:
    FillPool()

func FillPool():
    for i in pool_size:
        var player = AudioStreamPlayer.new()
        add_child(player)
        pool.append(player)

func PlayAudio(soundType: AudioType, volume: float = 0.0, from: float = 0.0, pitch_scale: float = 1.0, duration: float = -1.0, grade: AudioGrade = AudioGrade.None):
    if from < 0.0:
        await get_tree().create_timer(abs(from)).timeout
        PlayAudio(soundType, volume, 0.0, pitch_scale, duration, grade)
    else:
        if grade != AudioGrade.None:
            StopAudio(grade)
        var player = GetFreePlayer()
        player.stream = audio_list[soundType]
        player.volume_db = volume
        player.pitch_scale = pitch_scale
        player.play(from)

        if duration > 0:
            get_tree().create_timer(duration).timeout.connect(
                func():
                    if player.playing:
                        player.stop()
            )

        if grade != AudioGrade.None:
            if grade_dic.has(grade):
                grade_dic[grade].push_back(player)
            else:
                grade_dic[grade] = []
                grade_dic[grade].push_back(player)
    

func StopAudio(grade: AudioGrade):
    if grade_dic.has(grade):
        for player in grade_dic[grade]:
            player.stop()
        grade_dic[grade] = []

func GetFreePlayer():
    for player in pool:
        if !player.playing:
            return player
    var newPlayer = AudioStreamPlayer.new()
    add_child(newPlayer)
    pool.append(newPlayer)
    return newPlayer
