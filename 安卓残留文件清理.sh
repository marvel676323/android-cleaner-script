#!/bin/bash
PS3='请选择一个操作: '
options=("一键过Luna" "单过Luna敏感文件" "一键过春秋" "退出")
select opt in "${options[@]}"; do
case $opt in
"一键过Luna")
clear
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
    [ ! -d "$target_dir" ] && { return; }
    find "$target_dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null \
        | while read dir; do
        dir_name=$(basename "$dir")
        for pattern in "${PROTECTED_PATTERNS[@]}"; do
            case "$dir_name" in $pattern) continue 2 ;; esac
        done
        dir_size=$(du -sk "$dir" 2>/dev/null | awk '{print $1}')
        if [ -n "$dir_size" ] && [ "$dir_size" -lt $SIZE_LIMIT ]; then
            rm -rf "$dir" 2>/dev/null
        fi
    done
}
# 主流程
for dir in "${TARGET_DIRS[@]}"; do
    clean_small_dirs "$dir"
done

# 定义目标文件路径
TARGET_FILE="/data/property/persistent_properties"
# 检查文件是否存在
if [ -f "$TARGET_FILE" ]; then
    # 临时删除数据隔离prop属性
    resetprop --delete persist.sys.vold_app_data_isolation_enabled 2>/dev/null
    resetprop --delete persist.zygote.app_data_isolation 2>/dev/null
    # 清理持久性属性文件
    sed -i '/persist\.sys\.vold_app_data_isolation_enabled/d; /persist\.zygote\.app_data_isolation/d' "$TARGET_FILE" 2>/dev/null
fi

# 敏感文件清理
rm -rf /storage/emulated/0/Android/data/me.garfieldhan.holmes 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.zhenxi.hunter 2>/dev/null
rm -rf /storage/emulated/0/Android/data/icu.nullptr.nativetest 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.byyoung.setting 2>/dev/null
rm -rf /data/property/persistent_properties 2>/dev/null
rm -rf /storage/emulated/0/Android/data/bin.mt.plus 2>/dev/null
rm -rf /data/property/ 2>/dev/null
rm -rf /data/local/tmp/byyang/ 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.omarea.vtools 2>/dev/null
rm -rf /data/local/tmp/shizuku 2>/dev/null
rm -rf /data/local/tmp/shizuku_starter 2>/dev/null
rm -rf /storage/emulated/0/Android/data/moe.shizuku.privileged.api 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/icu.nullptr.applistdetector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/icu.nullptr.applistdetector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/icu.nullptr.applistdetector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/com.byxiaorun.detector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.byxiaorun.detector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/com.byxiaorun.detector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.huskydg.memorydetector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.huskydg.memorydetector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.huskydg.memorydetector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/com.OrangeEnvironment.Detector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.OrangeEnvironment.Detector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/com.OrangeEnvironment.Detector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/com.Longze.detector.pro2 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.Longze.detector.pro2 2>/dev/null
rm -rf /storage/emulated/0/Android/media/com.Longze.detector.pro2 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/rikka.safetynetchecker 2>/dev/null
rm -rf /storage/emulated/0/Android/data/rikka.safetynetchecker 2>/dev/null
rm -rf /storage/emulated/0/Android/media/rikka.safetynetchecker 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.keyattestation 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.keyattestation 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.keyattestation 2>/dev/null
rm -rf /storage/emulated/0/Download/WechatXposed 2>/dev/null
rm -rf /storage/emulated/0/WechatXposed 2>/dev/null
rm -rf /data/local/tmp 2>/dev/null
mkdir /data/local/tmp 2>/dev/null

# ROOT工具集：空目录清理/小文件清理/指定路径删除
TARGET_PATHS=(
    "/data/media/0/Android/data"
    "/data/media/0/Android/media"
    "/data/media/0/Android/obb"
)
EXCLUDE_DIRS=("com.termux" "com.android.providers.downloads")
CLEAN_LOG="/data/local/tmp/clean_empty.log"
clean_empty_dirs() {
    echo -e "\n=== 空目录清理开始 $(date) ===" >> "$CLEAN_LOG" 2>/dev/null
    for path in "${TARGET_PATHS[@]}"; do
        [ ! -d "$path" ] && continue
        find "$path" -mindepth 1 -maxdepth 1 -type d | while IFS= read -r dir; do
            local dir_name=${dir##*/}
            if echo " ${EXCLUDE_DIRS[*]} " | grep -qE "\<${dir_name}\>"; then
                echo "[保护] $dir_name" >> "$CLEAN_LOG" 2>/dev/null
                continue
            fi
            [ -z "$(ls -A "$dir" 2>/dev/null)" ] && {
                rm -rf -- "$dir" 2>/dev/null
            }
        done
    done
}
SMALL_TARGET_DIRS=(
    "/storage/emulated/0/Android/data"
    "/storage/emulated/0/Android/media"
    "/storage/emulated/0/Android/obb"
)
SIZE_LIMIT=20
PROTECT_PATTERNS=("com.android.*" "com.google.*" "android" "*.nomedia" "*.obb")
clean_small_dirs() {
    for dir in "${SMALL_TARGET_DIRS[@]}"; do
        [ ! -d "$dir" ] && continue
        find "$dir" -mindepth 1 -maxdepth 1 -type d | while IFS= read -r dir_path; do
            local name=${dir_path##*/}
            for pattern in "${PROTECT_PATTERNS[@]}"; do
                case "$name" in $pattern) continue 2 ;; esac
            done
            local size=$(du -sk "$dir_path" 2>/dev/null | cut -f1)
            [ "$size" -lt "$SIZE_LIMIT" ] 2>/dev/null && rm -rf -- "$dir_path" 2>/dev/null
        done
    done
}
DELETE_PATHS=(
    "/data/nh/" "/data/nh5/" "/data/nh6/" "/data/nh2/" "/data/nh3/" "/data/nh4/"
    "/data/nh.ko" "/data/gamepad_driver.so" "/sdcard/elgg/" "/data/BingPUBG/" "/data/BingHPJY/"
    "/data/jz/" "/data/jz.sh" "/data/system/liboxmem.so" "/data/local/tmp/gamepad_driver.so"
    "/system/lib/hid/gamepad_driver.so" "/data/.gamepad_driver_installed" "/data/system/liborangeinit.so"
    "/data/system/xydriver.ko" "/data/BingPUBG/guns.cfg" "/data/BingHPJY/pz.cfg" "/dev/Bing/"
    "/data/单发枪配置.txt" "/data/local/tmp/单发枪配置.txt" "/data/A内核.ini" "/data/物资.txt"
    "/data/HPX/" "/data/HPY/" "/data/system/HPX/" "/data/system/HPY/" "/storage/emulated/0/落叶配置/"
    "/storage/emulated/0/BY物资/" "/storage/emulated/0/落叶配置/落叶配置.txt" "/storage/emulated/0/BY物资/BY物资.txt"
    "/storage/emulated/elgg/" "/storage/emulated/0/Download/WechatXposed/" "/storage/emulated/legacy/Android/data/com.apocalua.run/"
)
delete_specified_paths() {
    for path in "${DELETE_PATHS[@]}"; do
        [ -e "$path" ] && rm -rf -- "$path" 2>/dev/null
    done
}
clean_empty_dirs
clean_small_dirs
delete_specified_paths

# 生成随机Android ID
MATRIX="0123456789qwertyuiopasdfghjklzxcvbnm"
LENGTH="16"
PASS=""
n=1
while [ $n -le $LENGTH ]; do
    PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
    let n+=1
done
settings put secure android_id "$PASS" 2>/dev/null
echo "$PASS"

break
;;
"单过Luna敏感文件")
clear
rm -rf /storage/emulated/0/Android/data/me.garfieldhan.holmes 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.zhenxi.hunter 2>/dev/null
rm -rf /storage/emulated/0/Android/data/icu.nullptr.nativetest 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.byyoung.setting 2>/dev/null
rm -rf /data/property/persistent_properties 2>/dev/null
rm -rf /storage/emulated/0/Android/data/bin.mt.plus 2>/dev/null
rm -rf /data/property/ 2>/dev/null
rm -rf /data/local/tmp/byyang/ 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.omarea.vtools 2>/dev/null
rm -rf /data/local/tmp/shizuku 2>/dev/null
rm -rf /data/local/tmp/shizuku_starter 2>/dev/null
rm -rf /storage/emulated/0/Android/data/moe.shizuku.privileged.api 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/icu.nullptr.applistdetector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/icu.nullptr.applistdetector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/icu.nullptr.applistdetector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/com.byxiaorun.detector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.byxiaorun.detector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/com.byxiaorun.detector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.huskydg.memorydetector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.huskydg.memorydetector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.huskydg.memorydetector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/com.OrangeEnvironment.Detector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.OrangeEnvironment.Detector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/com.OrangeEnvironment.Detector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/com.Longze.detector.pro2 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.Longze.detector.pro2 2>/dev/null
rm -rf /storage/emulated/0/Android/media/com.Longze.detector.pro2 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/rikka.safetynetchecker 2>/dev/null
rm -rf /storage/emulated/0/Android/data/rikka.safetynetchecker 2>/dev/null
rm -rf /storage/emulated/0/Android/media/rikka.safetynetchecker 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.keyattestation 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.keyattestation 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.keyattestation 2>/dev/null
rm -rf /storage/emulated/0/Download/WechatXposed 2>/dev/null
rm -rf /storage/emulated/0/WechatXposed 2>/dev/null
rm -rf /data/local/tmp 2>/dev/null
mkdir /data/local/tmp 2>/dev/null
break
;;
"一键过春秋")
clear
rm -rf /storage/emulated/0/Android/data/me.garfieldhan.holmes 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.zhenxi.hunter 2>/dev/null
rm -rf /storage/emulated/0/Android/data/icu.nullptr.nativetest 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.byyoung.setting 2>/dev/null
rm -rf /data/property/ 2>/dev/null
rm -rf /storage/emulated/0/Android/media/org.telegram.messenger.web 2>/dev/null
rm -rf /storage/emulated/0/Android/data/bin.mt.plus 2>/dev/null
rm -rf /storage/emulated/0/MT2 2>/dev/null
rm -rf /storage/emulated/0/Android/data/bin.mt.plus.canary 2>/dev/null
rm -rf /data/property/persistent_properties 2>/dev/null
rm -rf /data/local/tmp/byyang/ 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.omarea.vtools 2>/dev/null
rm -rf /data/local/tmp/shizuku 2>/dev/null
rm -rf /data/local/tmp/shizuku_starter 2>/dev/null
rm -rf /storage/emulated/0/Android/data/moe.shizuku.privileged.api 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/icu.nullptr.applistdetector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/icu.nullptr.applistdetector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/icu.nullptr.applistdetector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/com.byxiaorun.detector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.byxiaorun.detector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/com.byxiaorun.detector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.huskydg.memorydetector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.huskydg.memorydetector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.huskydg.memorydetector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/com.OrangeEnvironment.Detector 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.OrangeEnvironment.Detector 2>/dev/null
rm -rf /storage/emulated/0/Android/media/com.OrangeEnvironment.Detector 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.mahoshojo 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/com.Longze.detector.pro2 2>/dev/null
rm -rf /storage/emulated/0/Android/data/com.Longze.detector.pro2 2>/dev/null
rm -rf /storage/emulated/0/Android/media/com.Longze.detector.pro2 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/rikka.safetynetchecker 2>/dev/null
rm -rf /storage/emulated/0/Android/data/rikka.safetynetchecker 2>/dev/null
rm -rf /storage/emulated/0/Android/media/rikka.safetynetchecker 2>/dev/null
rm -rf /storage/emulated/0/Android/obb/io.github.vvb2060.keyattestation 2>/dev/null
rm -rf /storage/emulated/0/Android/data/io.github.vvb2060.keyattestation 2>/dev/null
rm -rf /storage/emulated/0/Android/media/io.github.vvb2060.keyattestation 2>/dev/null
rm -rf /storage/emulated/0/Download/WechatXposed 2>/dev/null
rm -rf /storage/emulated/0/WechatXposed 2>/dev/null
rm -rf /data/user/0/com.juom 2>/dev/null
rm -rf /storage/emulated/0/Android/data/org.telegram.messenger.web 2>/dev/null
rm -rf /data/system/graphicsstats 2>/dev/null
rm -rf /data/system/package_cache 2>/dev/null
# 检查并创建tmp目录
[ ! -d "/data/local/tmp" ] && mkdir /data/local/tmp 2>/dev/null
;;
"退出")
break
;;
*) echo "无效的选项";;
esac
done
