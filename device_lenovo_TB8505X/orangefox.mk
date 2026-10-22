#
# OrangeFox build variables for TB-8505X.
# Included from BoardConfig.mk. The same values are also exported from
# vendorsetup.sh, so they apply whichever way your fox_12.1 checkout reads them.
#

OF_MAINTAINER := Unofficial
FOX_BUILD_TYPE := Unofficial
FOX_VARIANT := default
FOX_TARGET_DEVICES := TB8505X,TB-8505X,akita_row_call
TARGET_DEVICE_ALT := TB-8505X,akita_row_call

# Screen: 800x1280 panel. OrangeFox expects height scaled to 1080 width:
# 1280 * 1080 / 800 = 1728
OF_SCREEN_H := 1728
OF_STATUS_H := 80
OF_STATUS_INDENT_LEFT := 48
OF_STATUS_INDENT_RIGHT := 48
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 1
OF_ALLOW_DISABLE_NAVBAR := 0

# No flashlight or notification LED on this tablet
OF_FLASHLIGHT_ENABLE := 0
OF_USE_GREEN_LED := 0

# Partitions / AVB
FOX_RECOVERY_SYSTEM_PARTITION := /dev/block/platform/bootdevice/by-name/system
FOX_RECOVERY_VENDOR_PARTITION := /dev/block/platform/bootdevice/by-name/vendor
FOX_RECOVERY_BOOT_PARTITION := /dev/block/platform/bootdevice/by-name/boot
OF_PATCH_AVB20 := 1
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
OF_ENABLE_LPTOOLS := 0

# Not a Xiaomi device
OF_DISABLE_MIUI_SPECIFIC_FEATURES := 1
OF_NO_MIUI_PATCH_WARNING := 1
OF_TWRP_COMPATIBILITY_MODE := 1

# Backups
OF_SKIP_MULTIUSER_FOLDERS_BACKUP := 1
OF_QUICK_BACKUP_LIST := /boot;/vendor_image;/system_image;

# Size reduction - must fit in the 32 MB recovery partition (gzip only)
FOX_DRASTIC_SIZE_REDUCTION := 1
FOX_REMOVE_AAPT := 1
FOX_REMOVE_BASH := 1
FOX_REMOVE_ZIP_BINARY := 1
FOX_USE_NANO_EDITOR := 0
FOX_USE_TAR_BINARY := 0
FOX_USE_SED_BINARY := 0
FOX_USE_XZ_UTILS := 0
FOX_ENABLE_APP_MANAGER := 0
FOX_DELETE_AROMAFM := 1
