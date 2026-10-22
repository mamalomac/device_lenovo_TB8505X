LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),TB8505X)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
