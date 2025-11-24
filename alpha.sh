#!/bin/bash

# Remove old local_manifests
rm -rf .repo/local_manifests/
rm -rf device/xiaomi/onyx
rm -rf vendor/xiaomi/onyx
rm -rf device/xiaomi/onyx-kernel
rm -rf hardware/xiaomi
rm -rf packages/apps/XiaomiDolby

# Local TimeZone
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

# ROM source repo
repo init -u https://github.com/alphadroid-project/manifest -b alpha-16.1 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone Trees
git clone https://github.com/alphadroidonyx/android_device_xiaomi_onyx.git device/xiaomi/onyx
git clone https://github.com/alphadroidonyx/proprietary_vendor_xiaomi_onyx.git vendor/xiaomi/onyx
git clone https://github.com/alphadroidonyx/android_device_xiaomi_onyx-kernel.git device/xiaomi/onyx-kernel
git clone https://github.com/alphadroidonyx/android_hardware_xiaomi.git hardware/xiaomi
git clone https://github.com/alphadroidonyx/android_packages_apps_XiaomiDolby.git packages/apps/XiaomiDolby

# Sync the repositories
/opt/crave/resync.sh
echo "============================"

# Export
export BUILD_USERNAME=Sachin
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch alpha_onyx-userdebug
echo "============="

# Make clean install
make installclean
echo "============="

# Build ROM
make bacon
