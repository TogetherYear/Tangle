extends Node

class ScreenPositionResult:
    var position: Vector2
    var canvasPosition: Vector2
    var isOnScreen: bool

    func _init(_position: Vector2, _canvasPosition: Vector2, _isOnScreen: bool):
        self.position = _position
        self.canvasPosition = _canvasPosition
        self.isOnScreen = _isOnScreen

## 获取Node2D节点的屏幕位置
func GetScreenPosition(node: Node2D) -> ScreenPositionResult:
    var viewport := get_viewport()
    var canvasPosition := viewport.canvas_transform * node.global_position
    var viewportSize := viewport.get_visible_rect().size
    
    var normalized := Vector2(
        canvasPosition.x / viewportSize.x,
        canvasPosition.y / viewportSize.y
    )

    return ScreenPositionResult.new(normalized, canvasPosition, (normalized.x >= 0.0 && normalized.x <= 1.0 &&
                        normalized.y >= 0.0 && normalized.y <= 1.0))

## 获取渲染尺寸
func GetRenderSize():
    return get_viewport().get_visible_rect().size

## 将世界位置转换为瓦片整数位置
func TransformPositionTile(atPosition: Vector2) -> Vector2i:
    return Vector2i(floor(atPosition.x / 16) * 16, floor(atPosition.y / 16) * 16)

func GetDirectionFromPosition(atPosition: Vector2, targetPosition: Vector2):
    # 获取A到B的方向向量
    var aToB: Vector2 = (targetPosition - atPosition).normalized()
    
    # 获取A的向前向量
    var aForward: Vector2 = Vector2(0, 1)
    
    # 计算夹角（弧度）
    var angleRad: float = aToB.angle_to(aForward)
    
    # 使用阈值判断方向
    if abs(angleRad) < PI / 8: # 22.5度阈值
        # 向后
        return 0
    elif abs(angleRad) > 7 * PI / 8: # 157.5度阈值
        #向前
        return -1
    else:
        # 水平
        return 1
