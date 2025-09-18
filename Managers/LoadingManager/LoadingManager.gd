extends Node

@export var loading: ColorRect

@export var animationPlayer: AnimationPlayer

var isLoading = false

func EnterForce():
    loading.material.set("shader_parameter/progress", 0.0)

func LeaveForce():
    loading.material.set("shader_parameter/progress", 1.0)

## 进入loading [br]
## center: 加载动画的中心位置 0 - 1 范围内 [br]
func Enter(center: Vector2, invert: bool = false, callback: Callable = func(): pass ):
    isLoading = true
    loading.material.set("shader_parameter/center_point", center)
    loading.material.set("shader_parameter/is_active", invert)
    animationPlayer.play("Enter")
    await animationPlayer.animation_finished
    callback.call()

func Leave(center: Vector2, callback: Callable = func(): pass ):
    loading.material.set("shader_parameter/center_point", center)
    animationPlayer.play("Leave")
    await animationPlayer.animation_finished
    isLoading = false
    callback.call()
