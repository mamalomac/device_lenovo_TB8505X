#
# Lenovo Tab M8 HD LTE (TB-8505X)
#

LOCAL_PATH := device/lenovo/TB8505X

# Launched with Android 9 (ro.product.first_api_level=28)
PRODUCT_SHIPPING_API_LEVEL := 28

# Non-A/B, no dynamic partitions
AB_OTA_UPDATER := false
PRODUCT_USE_DYNAMIC_PARTITIONS := false

# Tablet characteristics
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Recovery init scripts live in recovery/root/ and are copied automatically.
# Both names are provided because ro.hardware may report mt6761 or mt8766.

# Props from stock
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=240 \
    ro.build.characteristics=tablet
