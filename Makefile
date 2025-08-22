TARGET := iphone:clang:latest:7.0
THEOS_PACKAGE_SCHEME = rootless
INSTALL_TARGET_PROCESSES = VSCO
THEOS_DEVICE_IP = 192.168.1.119
THEOS_DEVICE_USER = root
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VscoPlus

VscoPlus_FILES = Tweak.x \
                 src/Utils/Helpers.m \
				 src/Utils/StyleUtils.m \
                 src/UIElements/Toast.m \
                 src/UIElements/FloatingButton.m \
                 src/UIElements/MenuView.xm \
                 src/Hooks/AdBlockerHook.x \
                 src/Hooks/ImageDetailHook.x \

VscoPlus_CFLAGS = -fobjc-arc -I.

include $(THEOS_MAKE_PATH)/tweak.mk