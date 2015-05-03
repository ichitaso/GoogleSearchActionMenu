GO_EASY_ON_ME := 1
PACKAGE_VERSION = 1.0-1
ARCHS = armv6 armv7 arm64
THEOS_DEVICE_IP = 192.168.0.7

TWEAK_NAME = GoogleSearch
GoogleSearch_FILES = GoogleSearchActionMenu.m
GoogleSearch_FRAMEWORKS = Foundation UIKit CoreGraphics
GoogleSearch_INSTALL_PATH = /Library/ActionMenu/Plugins

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

before-package::
	sudo chown -R root:wheel $(THEOS_STAGING_DIR)
	sudo chmod -R 755 $(THEOS_STAGING_DIR)

after-install::
	install.exec "killall -9 SpringBoard"
	make clean
	sudo rm -rf _
	rm -rf .obj
	rm -rf obj
#	rm -rf .theos
#	rm -rf *.deb