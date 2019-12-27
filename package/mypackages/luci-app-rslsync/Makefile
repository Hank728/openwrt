include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-rslsync
PKG_VERSION:=2.6.4
PKG_RELEASE:=1

PKG_MAINTAINER:=paradislover <wxu1986@gmail.com>
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

RSTRIP:=true

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/Default
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI support for rslsync
	DEPENDS:=+libopenssl +libc +librt +libpthread
endef

Package/$(PKG_NAME) = $(call Package/$(PKG_NAME)/Default,ARM)
Package/$(PKG_NAME)-armhf = $(call Package/$(PKG_NAME)/Default,ARMHF)

define Package/$(PKG_NAME)/description
	This package contains LuCI configuration pages for rslsync.
endef

Package/$(PKG_NAME)-armhf/description = $(Package/$(PKG_NAME)/description)

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/files/luci/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/extra_provides
	echo "libc.so.6"; \
	echo "libcrypt.so.1"; \
	echo "libdl.so.2"; \
	echo "libm.so.6"; \
	echo "libpthread.so.0"; \
	echo "librt.so.1";
endef

Package/$(PKG_NAME)-armhf/extra_provides = $(Package/$(PKG_NAME)/extra_provides)

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/luci-rslsync ) && rm -f /etc/uci-defaults/luci-rslsync
	rm -f /tmp/luci-indexcache
fi
exit 0
endef

Package/$(PKG_NAME)-armhf/postinst = $(Package/$(PKG_NAME)/postinst)

define Install/luci
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/luci-rslsync $(1)/etc/uci-defaults/luci-rslsync

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n

	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rslsync.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/rslsync.zh-cn.lmo
	$(INSTALL_DATA) ./files/luci/model/rslsync.lua $(1)/usr/lib/lua/luci/model/cbi/rslsync.lua
	$(INSTALL_DATA) ./files/luci/controller/rslsync.lua $(1)/usr/lib/lua/luci/controller/rslsync.lua
endef

define Install/lib
	$(INSTALL_DIR) $(1)/lib
	$(INSTALL_DIR) $(1)/usr/lib
ifdef CONFIG_USE_MUSL
ifeq ($(findstring armhf,$(2)),armhf)
	$(LN) libc.so $(1)/lib/ld-linux-armhf.so.3
else
	$(LN) libc.so $(1)/lib/ld-linux.so.3
endif
	$(LN) libcrypto.so.1.0.0 $(1)/usr/lib/libcrypt.so.1
endif
endef

define Package/$(PKG_NAME)/install
	$(call Install/luci,$(1))
	$(call Install/lib,$(1))
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
ifeq ($(ARCH),arm)
	$(INSTALL_BIN) ./files/bin/ARM/rslsync $(1)/usr/bin/rslsync
	$(INSTALL_BIN) ./files/etc/init.d/rslsync $(1)/etc/init.d/rslsync
endif
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/etc/config/rslsync $(1)/etc/config/rslsync
	$(INSTALL_DIR) $(1)/etc/hotplug.d/block
	$(INSTALL_BIN) ./files/hotplug.sh $(1)/etc/hotplug.d/block/30-rslsync
endef

define Package/$(PKG_NAME)-armhf/install
	$(call Install/luci,$(1))
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
ifeq ($(ARCH),arm)
ifeq ($(if $(findstring -mfloat-abi=soft,$(TARGET_CFLAGS)),soft),soft)
	@echo "arm"
	$(call Install/lib,$(1))
#	$(INSTALL_BIN) ./files/bin/ARM/rslsync $(1)/usr/bin/rslsync
	$(INSTALL_BIN) ./files/etc/init.d/rslsync $(1)/etc/init.d/rslsync
endif
ifeq ($(if $(findstring -mfloat-abi=hard,$(TARGET_CFLAGS)),hard),hard)
	@echo "armhf"
	$(call Install/lib,$(1),armhf)
#ifdef CONFIG_USE_MUSL
#	$(INSTALL_BIN) ./files/bin/ARMHF/2.4.5/rslsync $(1)/usr/bin/rslsync
#else
#	$(INSTALL_BIN) ./files/bin/ARMHF/$(PKG_VERSION)/rslsync $(1)/usr/bin/rslsync
#endif
	$(INSTALL_BIN) ./files/etc/init.d/rslsync.armhf $(1)/etc/init.d/rslsync
endif
endif
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/etc/config/rslsync $(1)/etc/config/rslsync
	$(INSTALL_DIR) $(1)/etc/hotplug.d/block
	$(INSTALL_BIN) ./files/hotplug.sh $(1)/etc/hotplug.d/block/30-rslsync
endef

#$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-armhf))
