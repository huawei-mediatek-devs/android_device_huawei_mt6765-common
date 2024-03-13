#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/huawei/mt6761-common

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a73

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Android Verified Boot (AVB)
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# Boot
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_HAS_RAMDISK := false
BOARD_CUSTOM_BOOTIMG_MK := hardware/huawei/mkbootimg.mk

BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 product.type=normal androidboot.selinux=permissive unmovable_isolate1=2:256M,3:288M,4:320M unmovable_isolate2=2:40M,3:44M,4:48M
BOARD_KERNEL_CMDLINE += androidboot.super_partition=system
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x11a88000 --second_offset 0x00e88000 --tags_offset 0x07808000 --header_version 1

# Build System
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Filesystems
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

TARGET_KERNEL_CONFIG := merge_full_k61v1_64_mex_a32_defconfig
TARGET_KERNEL_SOURCE := kernel/huawei/mt6761

TARGET_KERNEL_CLANG_VERSION := r416183b
TARGET_KERNEL_CLANG_PATH := $(abspath .)/prebuilts/clang/kernel/$(HOST_PREBUILT_TAG)/clang-$(TARGET_KERNEL_CLANG_VERSION)
TARGET_KERNEL_LLVM_BINUTILS := false
TARGET_KERNEL_ADDITIONAL_FLAGS := HOSTCFLAGS="-fuse-ld=lld -Wno-unused-command-line-argument"

# Partitions - dynamic
BOARD_SUPER_PARTITION_BLOCK_DEVICES := \
    cust \
    eng_system \
    eng_vendor \
    odm \
    product \
    preas \
    preavs \
    system \
    vendor

BOARD_SUPER_PARTITION_CUST_DEVICE_SIZE := 92274688
BOARD_SUPER_PARTITION_ENG_SYSTEM_DEVICE_SIZE := 15728640
BOARD_SUPER_PARTITION_ENG_VENDOR_DEVICE_SIZE := 12582912
BOARD_SUPER_PARTITION_ODM_DEVICE_SIZE := 67108864
BOARD_SUPER_PARTITION_PRODUCT_DEVICE_SIZE := 436207616
BOARD_SUPER_PARTITION_PREAS_DEVICE_SIZE := 696254464
BOARD_SUPER_PARTITION_PREAVS_DEVICE_SIZE := 33554432
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 1207959552
BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE := 167772160

BOARD_SUPER_PARTITION_SIZE := \
    $(shell expr $(BOARD_SUPER_PARTITION_CUST_DEVICE_SIZE) \
                 + $(BOARD_SUPER_PARTITION_ENG_SYSTEM_DEVICE_SIZE) \
                 + $(BOARD_SUPER_PARTITION_ENG_VENDOR_DEVICE_SIZE) \
                 + $(BOARD_SUPER_PARTITION_ODM_DEVICE_SIZE) \
                 + $(BOARD_SUPER_PARTITION_PRODUCT_DEVICE_SIZE) \
                 + $(BOARD_SUPER_PARTITION_PREAS_DEVICE_SIZE) \
                 + $(BOARD_SUPER_PARTITION_PREAVS_DEVICE_SIZE) \
                 + $(BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE) \
                 + $(BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE))

BOARD_SUPER_PARTITION_GROUPS := huawei_dynamic_partitions
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_HUAWEI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor
BOARD_HUAWEI_DYNAMIC_PARTITIONS_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) - 4194304 )

ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_EXTFS_INODE_COUNT := -1
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 314572800
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := -1
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 40000000
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 20000000
endif
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 57671680

# Partitions
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor

# Platform
BOARD_HAS_MTK_HARDWARE := true
TARGET_BOARD_PLATFORM := mt6761

# Properties
TARGET_VENDOR_PROP += $(COMMON_PATH)/vendor.prop

# Recovery
BOARD_USES_FULL_RECOVERY_IMAGE := true
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/rootdir/etc/fstab.mt6761
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_huawei

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := hardware/huawei/releasetools

# SEPolicy
BOARD_VENDOR_SEPOLICY_DIRS += $(COMMON_PATH)/sepolicy/vendor

# Vintf
DEVICE_MANIFEST_FILE := $(COMMON_PATH)/manifest.xml

# VNDK
PRODUCT_USE_VNDK_OVERRIDE := true

# Inherit the proprietary files
include vendor/huawei/mt6761-common/BoardConfigVendor.mk
