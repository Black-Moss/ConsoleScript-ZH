基于[05126619z/ScavTemplate](https://github.com/05126619z/ScavTemplate).

[English Guide](README.md)
 
# BlackMossTemplate

一个用于开发 `Casualties Unknown` 的模组模板。

# 如何使用？
__这个指南适用于 JetBrains Rider，我不喜欢 Visual Studio，所以不会写 Visual Studio 的指南。__

*也许 Visual Studio 也能做到，但是我不会。*

1. 克隆[这个模板](https://github.com/new?template_name=BlackMossTemplate)。
2. 获取游戏的 dll 文件：
   1. 右键单击 `依赖项`。
   2. 选择 `引用...`，然后是 `添加自...`.
   3. 去到你游戏的目录(就像 `E:/CasualtiesUnknownDemo/CasualtiesUnknown_Data/Managed` 这样)。
   4. 选择所有 `.dll` 文件
3. 把 `BlackMossTemplate` 重命名为你的模组名称。
4. 把下列文件中的 `BlackMossTemplate` 换成你的模组名称：
    1.  `vars.targets`
    2.  `Plugin.cs`
    3.  `BlackMossTemplate.csproj`
5. 把 `vars.targets` 里的 `<BaseGamePath>E:/CasualtiesUnknownDemo</BaseGamePath>` 替换成你游戏的目录。就像 `<BaseGamePath>E:/CasualtiesUnknownDemo</BaseGamePath>` 这样。
6. 构建项目测试能不能运行，如果不能，重新尝试一遍 2、3、4、5 的步骤。
7. 成功运行之后，把 [Pulgin.cs](Plugin.cs) 中的以下内容替换成对应的内容：
   1. `namespace BlackMossTemplate` 改成你的命名空间，和你的模组名称一样就行。
   2. `blackmoss.template` 换成你的GUID，格式是`你的名字.模组名称`。___兼容大小写和下划线，但是更推荐全小写无下划线。___
   3. `BlackMossTemplate` 换成你的模组名称。
   4. `0.0.0` 版本你自行填写，`114514.1919.810` 都是可以的。
   5. `_harmony` 常量的内容和你的 GUID 是一样的。
   6. `Logger.LogInfo("Here's Black Moss!");` 这个你随便写 ~~（被骂在日志里拉屎不关我事）~~。

# 关于配置
使用 Rider 的配置功能可以更方便地开发。

1. 点击构建旁边的 `添加配置`。
2. 点击 `编辑配置...` 再到 `添加新...`。
3. 选择 `原生可执行文件`。
4. 把 `未命名` 改成 `Start`*(其实你可以改成任何名字)*。
5. `可执行文件路径` 这里填你的游戏目录下的 `CasualtiesUnknown.exe`。
6. 按 `确定`。
7. 点击那个绿色箭头按钮。
8. 享受你的开发之旅！
