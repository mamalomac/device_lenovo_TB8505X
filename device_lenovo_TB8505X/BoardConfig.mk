#
# OrangeFox / TWRP device tree for Lenovo Tab M8 HD LTE (TB-8505X)
# Platform: MediaTek MT6761 (Helio A22), stock Android 10, header v2, non-A/B,
# no dynamic partitions.
#
# All addresses, sizes and the kernel/dtb/dtbo below were taken from the stock
# recovery.img of TB-8505X_S301129_230914_BMP (security patch 2023-08-05).
#

DEVICE_PATH := device/lenovo/TB8505X

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_USES_64_BIT_BINDER := true

# Bootloader / platform
TARGET_BOOTLOADER_BOARD_NAME := akita_row_call
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := mt6761
BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_HARDWARE := true

# Kernel (prebuilt from stock recovery: Linux 4.9.190, clang 9)
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=user
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x11a88000
BOARD_KERNEL_SECOND_OFFSET := 0x00e88000
BOARD_KERNEL_TAGS_OFFSET := 0x07808000
BOARD_DTB_OFFSET := 0x07808000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_IMAGE_NAME := Image.gz
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
BOARD_INCLUDE_RECOVERY_DTBO := true

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

# IMPORTANT: the stock kernel only supports GZIP initramfs
# (CONFIG_RD_LZMA / RD_XZ / RD_LZ4 are all disabled). Do NOT enable LZMA.
BOARD_RAMDISK_USE_LZMA := false

# Partitions (sizes from MT6761_Android_scatter.txt)
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 4085252096
BOARD_VENDORIMAGE_PARTITION_SIZE := 838860800
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2952790016

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true
# Stock kernel has no F2FS support
TARGET_COPY_OUT_VENDOR := vendor

# Android 10 system image uses the system-as-root layout
BOARD_SUPPRESS_SECURE_ERASE := true

# Recovery
BOARD_USES_RECOVERY_AS_BOOT := false
TARGET_NO_RECOVERY := false
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# AVB: recovery is a chained partition in vbmeta (rollback location 1).
# The image gets signed with the AOSP test key; with the patched vbmeta
# (flags=3) the bootloader skips verification anyway.
BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Security patch level (high value avoids anti-rollback complaints)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2023-08-05
PLATFORM_VERSION := 16.1.0

# SELinux
SELINUX_IGNORE_NEVERALLOWS := true

# Encryption
# Stock uses FDE (forcefdeorfbe, key in /metadata) with the Microtrust TEE.
# Decryption needs the vendor keymaster/TEE blobs, which are NOT in this tree,
# so crypto is left OFF: if /data is encrypted, use "Format Data" in recovery.
# TW_INCLUDE_CRYPTO := true
# TW_INCLUDE_FBE_METADATA_DECRYPT := true

# TWRP configuration
TW_THEME := portrait_hdpi
TARGET_SCREEN_WIDTH := 800
TARGET_SCREEN_HEIGHT := 1280
TW_DEFAULT_LANGUAGE := en
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 120
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone0/temp"
TW_USE_TOOLBOX := true
TW_INCLUDE_NTFS_3G := false
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_LIBRESETPROP := true
TW_DEVICE_VERSION := TB-8505X
TARGET_USES_MKE2FS := true
RECOVERY_SDCARD_ON_DATA := true

# Size savers - recovery partition is only 32 MB and the kernel alone is ~10 MB
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_APEX := true
TW_EXCLUDE_PYTHON := true
TW_EXCLUDE_NANO := true
TW_EXCLUDE_BASH := true
TW_EXCLUDE_LPDUMP := true
TW_EXCLUDE_LPTOOLS := true
TW_EXCLUDE_TZDATA := true

# Debug
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true

# OrangeFox build variables
-include $(DEVICE_PATH)/orangefox.mk
