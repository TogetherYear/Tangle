extends Node

func LoadResourceAsync(path: String, callback: Callable, process: Callable = func(_percent: float): pass ) -> void:
    var loadingProgress: Array[float] = []
    if !ResourceLoader.exists(path): return
    ResourceLoader.load_threaded_request(path)
    while true:
        var status = ResourceLoader.load_threaded_get_status(path, loadingProgress)
        if status == ResourceLoader.THREAD_LOAD_LOADED:
            var resource := ResourceLoader.load_threaded_get(path)
            callback.call(resource)
            break
        elif status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
            process.call(loadingProgress[0])
        elif status == ResourceLoader.THREAD_LOAD_FAILED:
            break
        await get_tree().process_frame
    
func LoadResource(path: String) -> Resource:
    if !ResourceLoader.exists(path): return null
    var resource := ResourceLoader.load(path)
    return resource

func SaveResource(resource: Resource):
    for prop in resource.get_property_list():
        # 条件1：是脚本变量且被导出
        if !(prop["usage"] & PROPERTY_USAGE_SCRIPT_VARIABLE):
            continue
            
        # 条件2：类型是Resource或其子类
        var value = resource.get(prop["name"])
        if !(value is Resource):
            continue
        ResourceSaver.save(value, value.resource_path)
    ResourceSaver.save(resource, resource.resource_path)

func LoadJsonToDictionary(fileName: String):
    if !FileAccess.file_exists(fileName):
        return {}
    var file := FileAccess.open(fileName, FileAccess.READ)
    var data = JSON.parse_string(file.get_as_text())
    file.close()
    if data == null || !(data is Dictionary):
        return {}
    return data
