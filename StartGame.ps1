param(
    [string]$GamePath, # 游戏路径
    [string]$ModNamespace # 模组命名空间
)

# 设置输出编码为UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 获取时间戳
$timestamp = Get-Date -Format "yyyy-MM-dd_HH.mm.ss"

# 各种路径
$GamePath = [System.IO.Path]::GetFullPath($GamePath) # 游戏路径
$bepInExPath = [System.IO.Path]::Combine($GamePath, "BepInEx")

# 各种文件
$bepInExLog = [System.IO.Path]::Combine($bepInExPath, "LogOutput.log") # BepInEx 日志
$GameExecutable = [System.IO.Path]::Combine($GamePath, "CasualtiesUnknown.exe") # 游戏文件
$ModDll = [System.IO.Path]::Combine($PSScriptRoot, "bin/Debug/net472", "$ModNamespace.dll")

# 日志目标路径
$logDestination = [System.IO.Path]::Combine($PSScriptRoot, "logs", "$timestamp.log") # 日志目标路径

# 检查游戏路径是否有效
if (-not (Test-Path $GamePath -PathType Container)) {
    Write-Error "Game path invalid or not a directory: $GamePath"
    exit 1
}

# 确保目标目录存在
$logsFolder = [System.IO.Path]::Combine($PSScriptRoot, "logs")
if (-not (Test-Path $logsFolder)) {
    New-Item -ItemType Directory -Path $logsFolder -Force
}

# 封装输出函数
function Write-ColoredMessage {
    param (
        [string]$Message,
        [System.ConsoleColor]$Color
    )
    Write-Host $Message -ForegroundColor $Color
}

# 定义日志复制函数
function Copy-BepInExLog {
    if (Test-Path $bepInExLog) {
        try {
            Write-ColoredMessage "Copying BepInEx logs to ""$logDestination""." Cyan
            Copy-Item $bepInExLog $logDestination -Force
        }
        catch {
            Write-Warning "Failed to copy BepInEx logs: $_"
        }
    }
}

# 间隔输出
function Interval {
    Write-Host "----------------------------------------"
}

# 清空 BepInEx 日志文件
if (Test-Path $bepInExLog) {
    Clear-Content $bepInExLog
    Write-ColoredMessage "Cleared previous BepInEx logs." Cyan
}

# 输出启动信息
Write-ColoredMessage "Game path: $GamePath" Yellow
Write-ColoredMessage "Mod namespace: $ModNamespace" Yellow 

# 复制dll文件到游戏目录
try {
    Write-ColoredMessage "Copying Mod dll file to ""$bepInExPath\plugins\$ModNamespace.dll""." Cyan
    Copy-Item $ModDll "$GamePath\BepInEx\plugins" -Force
} 
catch {
    Write-Error "Failed to copy Mod dll file: $_"
    exit 1
}

# 启动游戏进程并重定向输出
try {
    $gameProcess = Start-Process -FilePath $GameExecutable `
        -WorkingDirectory (Split-Path $GameExecutable -Parent) `
        -PassThru -NoNewWindow

    Write-ColoredMessage "Game process started, PID: $($gameProcess.Id)" Yellow
    Interval

    # 定期轮询日志
    $lastReadPosition = 0
    while (!$gameProcess.HasExited) {
        if (Test-Path $bepInExLog) {
            $content = Get-Content $bepInExLog -ReadCount 0
            for ($i = $lastReadPosition; $i -lt $content.Count; $i++) {
                Write-ColoredMessage $content[$i] Magenta
            }
            $lastReadPosition = $content.Count
        }
        Start-Sleep -Milliseconds 500 # 每 500ms 检查一次
    }
    
    # 等待游戏进程退出
    Interval
    Write-ColoredMessage "Game process exited." Red
}

catch {
    Write-Error "Failed to start the game process: $_"
    exit 1
}

finally {
    # 如果游戏进程仍在运行，则终止它
    if ($gameProcess -and !$gameProcess.HasExited) {
        Interval
        Write-ColoredMessage "Terminating game process..." Red
        $gameProcess.Kill()
    }
    Copy-BepInExLog
}