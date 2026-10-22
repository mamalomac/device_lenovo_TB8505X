#
# Product makefile for OrangeFox (fox_12.1) / TWRP 12.1
# lunch twrp_TB8505X-eng
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit some common TWRP stuff
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from TB8505X device
$(call inherit-product, device/lenovo/TB8505X/device.mk)

PRODUCT_DEVICE := TB8505X
PRODUCT_NAME := twrp_TB8505X
PRODUCT_BRAND := Lenovo
PRODUCT_MODEL := Lenovo TB-8505X
PRODUCT_MANUFACTURER := LENOVO
PRODUCT_RELEASE_NAME := Lenovo Tab M8 HD LTE

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_akita_row_call-user 10 QP1A.190711.020 TB-8505X_U release-keys" \
    TARGET_DEVICE=TB-8505X
