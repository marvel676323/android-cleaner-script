clear
echo "\033[41m                       ks姚雷                        \033[0m"
echo "\033[41m                fsnsjzna146780056497                 \033[0m"
echo "\033[41m                  (一键过春秋检测)                   \033[0m"
echo "\033[41m                嫌这里慢可以自行编辑                 \033[0m"
echo "\033[41m                      研究制作                       \033[0m"
echo "\033[41m                       不加密                        \033[0m"
echo "\033[41m          如果遗漏或者被检测到的一些特征文件         \033[0m"
echo "\033[41m                  可以自己手动添加一下               \033[0m"
echo "\033[41m                     rm -rf (路径)                   \033[0m"
sleep 3
#!/bin/bash
PS3='请选择一个操作: '
options=("一键过Luna" "单过Luna敏感文件" "一键过春秋" "退出")
select opt in "${options[@]}"
do
case $opt in
"一键过Luna")
clear
echo "\033[41m                    一键过luna检测                  \033[0m"
echo "\033[41m              其他脚本的大合自己加了几个指令        \033[0m"
sleep 3
clear

# 原第一段Base64加密内容解密后的逻辑
#!/system/bin/sh
echo "正在执行Luna检测绕过核心逻辑..."
# 1. 删除常见检测工具残留文件
rm -rf /storage/emulated/0/Android/data/me.garfieldhan.holmes
rm -rf /storage/emulated/0/Android/data/com.zhenxi.hunter
rm -rf /storage/emulated/0/Android/data/icu.nullptr.nativetest
rm -rf /storage/emulated/0/Android/data/com.byyoung.setting
rm -rf /storage/emulated/0/Android/data/bin.mt.plus

# 2. 临时关闭Android数据隔离属性（避免检测到应用数据异常）
resetprop --delete persist.sys.vold_app_data_isolation_enabled
resetprop --delete persist.zygote.app_data_isolation

# 3. 清理持久化属性文件中的隔离配置（防止重启后恢复）
TARGET_FILE="/data/property/persistent_properties"
[ -f "$TARGET_FILE" ] && sed -i '/persist\.sys\.vold_app_data_isolation_enabled/d; /persist\.zygote\.app_data_isolation/d' "$TARGET_FILE"

# 4. 清理Shizuku等工具残留（常见检测目标）
rm -rf /data/local/tmp/shizuku
rm -rf /data/local/tmp/shizuku_starter
rm -rf /storage/emulated/0/Android/data/moe.shizuku.privileged.api
echo "Luna核心绕过逻辑执行完成"

sleep 1
clear

# 原第二段Base64加密内容解密后的逻辑
#!/system/bin/sh
echo "正在执行深度清理与系统配置调整..."
# 1. 清理更多检测工具目录（覆盖各类检测器、修改工具）
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.mahoshojo
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.mahoshojo
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.mahoshojo
rm -rf /storage/emulated/0/Android/obb/icu.nullptr.applistdetector
rm -rf /storage/emulated/0/Android/data/icu.nullptr.applistdetector
rm -rf /storage/emulated/0/Android/obb/com.byxiaorun.detector
rm -rf /storage/emulated/0/Android/data/com.byxiaorun.detector
rm -rf /storage/emulated/0/Android/obb/io.github.huskydg.memorydetector
rm -rf /storage/emulated/0/Android/data/io.github.huskydg.memorydetector
rm -rf /storage/emulated/0/Android/obb/com.OrangeEnvironment.Detector
rm -rf /storage/emulated/0/Android/data/com.OrangeEnvironment.Detector
rm -rf /storage/emulated/0/Android/obb/com.Longze.detector.pro2
rm -rf /storage/emulated/0/Android/data/com.Longze.detector.pro2
rm -rf /storage/emulated/0/Android/obb/rikka.safetynetchecker
rm -rf /storage/emulated/0/Android/data/rikka.safetynetchecker

# 2. 清理Xposed/修改工具残留
rm -rf /storage/emulated/0/Download/WechatXposed
rm -rf /storage/emulated/0/WechatXposed
rm -rf /data/local/tmp

# 3. 空目录清理（避免检测到异常空文件夹）
TARGET_PATHS=("/storage/emulated/0/Android/data" "/storage/emulated/0/Android/media" "/storage/emulated/0/Android/obb")
EXCLUDE_DIRS=("com.android.providers.downloads" "com.termux")
for path in "${TARGET_PATHS[@]}"; do
  [ -d "$path" ] && find "$path" -mindepth 1 -maxdepth 1 -type d | while read dir; do
    dir_name=$(basename "$dir")
    if ! echo " ${EXCLUDE_DIRS[*]} " | grep -q " $dir_name "; then
      [ -z "$(ls -A "$dir")" ] && rm -rf "$dir" && echo "删除空目录：$dir"
    fi
  done
done

# 4. 小文件目录清理（删除20KB以下非保护目录）
SIZE_LIMIT=20
PROTECT_PATTERNS=("com.android.*" "com.google.*" "android" "*.nomedia" "*.obb")
for dir in "${TARGET_PATHS[@]}"; do
  [ -d "$dir" ] && find "$dir" -mindepth 1 -maxdepth 1 -type d | while read dir_path; do
    name=$(basename "$dir_path")
    protect=0
    for pattern in "${PROTECT_PATTERNS[@]}"; do
      case "$name" in $pattern) protect=1; break ;; esac
    done
    [ $protect -eq 0 ] && {
      dir_size=$(du -sk "$dir_path" | awk '{print $1}')
      [ "$dir_size" -lt "$SIZE_LIMIT" ] && rm -rf "$dir_path" && echo "删除小目录（${dir_size}KB）：$name"
    }
  done
done

# 5. 恢复临时关闭的系统服务（确保系统正常运行）
start zygote
start zygote64
start vold
echo "深度清理与系统配置调整完成"

sleep 1
clear
#!/system/bin/sh
# 多目录小文件清理脚本（Android特化版）
TARGET_DIRS=(
    "/storage/emulated/0/Android/data"
    "/storage/emulated/0/Android/media" 
    "/storage/emulated/0/Android/obb"
)
SIZE_LIMIT=20  # 单位KB
PROTECTED_PATTERNS=(
    "com.android.*" 
    "com.google.*"
    "android"
    "*.nomedia"       # 媒体库控制文件
    "*.obb"           # 游戏数据包
)
function clean_small_dirs() {
    local target_dir="$1"
    
    echo "\n🔍 扫描目录：$target_dir"
    [ ! -d "$target_dir" ] && {
        echo "⚠️ 目录不存在，跳过"
        return
    }
    find "$target_dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null \
        | while read dir; do
        
        dir_name=$(basename "$dir")
        
        # 保护规则检查
        for pattern in "${PROTECTED_PATTERNS[@]}"; do
            case "$dir_name" in
                $pattern)
                    echo "🛡️ 受保护: $dir_name"
                    continue 2
                    ;;
            esac
        done
        # 精确计算目录大小
        dir_size=$(du -sk "$dir" 2>/dev/null | awk '{print $1}')
        
        # 大小判断
        if [ -n "$dir_size" ] && [ "$dir_size" -lt $SIZE_LIMIT ]; then
            echo "🗑️ 删除 ${dir_size}KB: $dir_name"
            rm -rf "$dir" 2>/dev/null
        fi
    done
}
# 主流程
echo "⚠️ 需要ROOT权限"
for dir in "${TARGET_DIRS[@]}"; do
    clean_small_dirs "$dir"
done
echo "\n✅ 多目录清理完成"
echo "注：.nomedia/.obb后缀目录已自动保护"
sleep 1
clear
# 定义目标文件路径
TARGET_FILE="/data/property/persistent_properties"
# 检查文件是否存在
if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: Target file $TARGET_FILE 🤔未找到文件/🤔not found file"
    exit 1
fi
# 临时删除数据隔离prop属性的命令
resetprop --delete persist.sys.vold_app_data_isolation_enabled
resetprop --delete persist.zygote.app_data_isolation
# 从一个会临时生成持久性属性的目标文件中删除因使用隐藏应用列表导致出现的数据隔离的持久性属性
# 配合以上resetprop临时删除命令既可做到无风险地彻底清理prop持久性属性痕迹
sed -i '/persist\.sys\.vold_app_data_isolation_enabled/d; /persist\.zygote\.app_data_isolation/d' "$TARGET_FILE"
sleep 1
clear
rm -rf /storage/emulated/0/Android/data/me.garfieldhan.holmes
echo "\033[41mHolmes 文件已清除\033[0m"
sleep 0.5
rm -rf /storage/emulated/0/Android/data/com.zhenxi.hunter
echo "\033[41mHunter 文件已清除\033[0m"
sleep 0.5
rm -rf /storage/emulated/0/Android/data/icu.nullptr.nativetest
echo "\033[41mNative Test 文件已清除\033[0m"
sleep 0.5
rm -rf /storage/emulated/0/Android/data/com.byyoung.setting
rm -rf /data/property/persistent_properties
echo "\033[41m爱玩机工具箱 文件已清除\033[0m"
sleep 0.5
rm -rf /storage/emulated/0/Android/data/bin.mt.plus
echo "\033[41mMT管理器 杂质已清理\033[0m"
sleep 0.5
rm -rf /storage/emulated/0/Android/data/com.byyoung.setting
rm -rf /data/property/
echo "\033[41m隐藏应用列表 文件已清理 \033[0m"
rm -rf /data/local/tmp/byyang/
rm -rf /storage/emulated/0/Android/data/com.omarea.vtools
rm -rf /data/local/tmp/shizuku
rm -rf /data/local/tmp/shizuku_starter
rm -rf /storage/emulated/0/Android/data/moe.shizuku.privileged.api
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.mahoshojo
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.mahoshojo
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.mahoshojo
rm -rf /storage/emulated/0/Android/obb/icu.nullptr.applistdetector
rm -rf /storage/emulated/0/Android/data/icu.nullptr.applistdetector
rm -rf /storage/emulated/0/Android/media/icu.nullptr.applistdetector
rm -rf /storage/emulated/0/Android/obb/com.byxiaorun.detector
rm -rf /storage/emulated/0/Android/data/com.byxiaorun.detector
rm -rf /storage/emulated/0/Android/media/com.byxiaorun.detector
rm -rf /storage/emulated/0/Android/obb/io.github.huskydg.memorydetector
rm -rf /storage/emulated/0/Android/data/io.github.huskydg.memorydetector
rm -rf /storage/emulated/0/Android/media/io.github.huskydg.memorydetector
rm -rf /storage/emulated/0/Android/obb/com.OrangeEnvironment.Detector
rm -rf /storage/emulated/0/Android/data/com.OrangeEnvironment.Detector
rm -rf /storage/emulated/0/Android/media/com.OrangeEnvironment.Detector
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.mahoshojo
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.mahoshojo
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.mahoshojo
rm -rf /storage/emulated/0/Android/obb/com.Longze.detector.pro2
rm -rf /storage/emulated/0/Android/data/com.Longze.detector.pro2
rm -rf /storage/emulated/0/Android/media/com.Longze.detector.pro2
rm -rf /storage/emulated/0/Android/obb/rikka.safetynetchecker
rm -rf /storage/emulated/0/Android/data/rikka.safetynetchecker
rm -rf /storage/emulated/0/Android/media/rikka.safetynetchecker
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.keyattestation
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.keyattestation
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.keyattestation
rm -rf /storage/emulated/0/Download/WechatXposed
rm -rf /storage/emulated/0/WechatXposed
rm -rf /data/local/tmp
echo "\033[41m一堆杂项清理\033[0m"
sleep 1
mkdir /data/local/tmp
#!/system/bin/sh
# ROOT工具集：空目录清理/小文件清理/指定路径删除（兼容版）
# 适用于Android系统（ash/busybox sh等POSIX环境）
# ======================================
# 一、空目录清理模块（修复ash不兼容问题）
# ======================================
TARGET_PATHS=(
    "/data/media/0/Android/data"
    "/data/media/0/Android/media"
    "/data/media/0/Android/obb"
)
EXCLUDE_DIRS=("com.termux" "com.android.providers.downloads")
CLEAN_LOG="/data/local/tmp/clean_empty.log"
clean_empty_dirs() {
    echo -e "\n=== 空目录清理开始 $(date) ===" >> "$CLEAN_LOG"
    for path in "${TARGET_PATHS[@]}"; do
        echo "▌ 处理路径: $path" >> "$CLEAN_LOG"
        find "$path" -mindepth 1 -maxdepth 1 -type d | while IFS= read -r dir; do
            local dir_name=${dir##*/}
            # 替换Bash的=~为POSIX兼容的grep精确匹配（添加单词边界）
            if echo " ${EXCLUDE_DIRS[*]} " | grep -qE "\<${dir_name}\>"; then
                echo "[保护] $dir_name" >> "$CLEAN_LOG"
                continue
            fi
            [[ -z "$(ls -A "$dir")" ]] && {
                echo "[删除] $dir_name" >> "$CLEAN_LOG"
                rm -rf -- "$dir"
            }
        done
    done
    echo "空目录清理日志：$CLEAN_LOG"
}
# ======================================
# 二、小文件目录清理模块（无需修改，原case语法兼容）
# ======================================
SMALL_TARGET_DIRS=(
    "/storage/emulated/0/Android/data"
    "/storage/emulated/0/Android/media"
    "/storage/emulated/0/Android/obb"
)
SIZE_LIMIT=20  # KB
PROTECT_PATTERNS=("com.android.*" "com.google.*" "android" "*.nomedia" "*.obb")
clean_small_dirs() {
    echo -e "\n=== 小文件目录清理开始 $(date) ==="
    for dir in "${SMALL_TARGET_DIRS[@]}"; do
        [ ! -d "$dir" ] && {
            echo "⚠️ 目录不存在: $dir"
            continue
        }
        echo "🔍 扫描目录: $dir"
        find "$dir" -mindepth 1 -maxdepth 1 -type d | while IFS= read -r dir_path; do
            local name=${dir_path##*/}
            # 保护规则匹配（case语法完全兼容POSIX）
            for pattern in "${PROTECT_PAT
