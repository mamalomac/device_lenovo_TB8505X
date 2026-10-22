#
# OrangeFox build environment for Lenovo Tab M8 HD LTE (TB-8505X)
# Sourced automatically by build/envsetup.sh.
# Mirrors orangefox.mk so the values are seen whichever way fox_12.1 reads them.
#

FDEVICE="TB8505X"

fox_get_target_device() {
    local chkdev=$(echo "$BASH_SOURCE" | grep -w \"$FDEVICE\")
    if [ -n "$chkdev" ]; then
        FOX_BUILD_DEVICE="$FDEVICE"
    else
        chkdev=$(set | grep BASH_ARGV | grep -w \"$FDEVICE\")
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
    fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export ALLOW_MISSING_DEPENDENCIES=true
    export LC_ALL="C"

    # Set your name here
    export OF_MAINTAINER="Unofficial"
    export FOX_BUILD_TYPE="Unofficial"
    export FOX_VARIANT="default"
    export FOX_TARGET_DEVICES="TB8505X,TB-8505X,akita_row_call"
    export TARGET_DEVICE_ALT="TB-8505X,akita_row_call"

    # Screen (800x1280 -> 1728 at 1080 width)
    export OF_SCREEN_H=1728
    export OF_STATUS_H=80
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_HIDE_NOTCH=1
    export OF_CLOCK_POS=1
    export OF_ALLOW_DISABLE_NAVBAR=0
    export OF_FLASHLIGHT_ENABLE=0
    export OF_USE_GREEN_LED=0

    # Partitions / AVB
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/platform/bootdevice/by-name/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/platform/bootdevice/by-name/vendor"
    export FOX_RECOVERY_BOOT_PARTITION="/dev/block/platform/bootdevice/by-name/boot"
    export OF_PATCH_AVB20=1
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    export OF_ENABLE_LPTOOLS=0
    export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
    export OF_NO_MIUI_PATCH_WARNING=1
    export OF_TWRP_COMPATIBILITY_MODE=1

    # Backups
    export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
    export OF_QUICK_BACKUP_LIST="/boot;/vendor_image;/system_image;"

    # Size reduction (32 MB partition, gzip-only kernel)
    export FOX_DRASTIC_SIZE_REDUCTION=1
    export FOX_REMOVE_AAPT=1
    export FOX_REMOVE_BASH=1
    export FOX_REMOVE_ZIP_BINARY=1
    export FOX_USE_NANO_EDITOR=0
    export FOX_USE_TAR_BINARY=0
    export FOX_USE_SED_BINARY=0
    export FOX_USE_XZ_UTILS=0
    export FOX_ENABLE_APP_MANAGER=0
    export FOX_DELETE_AROMAFM=1
fi
