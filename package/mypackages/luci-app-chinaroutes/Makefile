include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-chnroute
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=panda-mute <wxuzju@gmail.com>
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-chnroute
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI support for chnroute
	DEPENDS:=+wget
	PKGARCH:=all
	MAINTAINER:=panda-mute
endef

define Package/luci-app-chnroute/description
	This package contains LuCI configuration pages for chnroute.
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/files/luci/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-chnroute/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-chnroute ]; then
		( . /etc/uci-defaults/luci-chnroute ) && \
		rm -f /etc/uci-defaults/luci-chnroute
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
fi
exit 0
endef

define Package/luci-app-chnroute/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/root/usr/sbin/chnroute $(1)/usr/sbin/chnroute

	$(INSTALL_DIR) $(1)/etc/
	$(INSTALL_DATA) ./files/root/etc/chnroute.list $(1)/etc/chnroute.list
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/root/etc/config/chnroute $(1)/etc/config/chnroute
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/root/etc/init.d/chnroute $(1)/etc/init.d/chnroute

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/root/etc/uci-defaults/luci-chnroute $(1)/etc/uci-defaults/luci-chnroute

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/chnroute.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/chnroute.zh-cn.lmo
	$(INSTALL_DATA) ./files/luci/model/chnroute.lua $(1)/usr/lib/lua/luci/model/cbi/chnroute.lua
	$(INSTALL_DATA) ./files/luci/controller/chnroute.lua $(1)/usr/lib/lua/luci/controller/chnroute.lua
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./files/root/usr/share/rpcd/acl.d/luci-app-chinaroutes.json $(1)/usr/share/rpcd/acl.d/luci-app-chinaroutes.json
endef

$(eval $(call BuildPackage,luci-app-chnroute))
