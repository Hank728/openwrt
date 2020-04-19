include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-domainlist
PKG_VERSION:=1.0.1
PKG_RELEASE:=2

PKG_MAINTAINER:=panda-mute <wxuzju@gmail.com>
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-domainlist
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI support for domainlist
	DEPENDS:=+dnsmasq-full +curl +@BUSYBOX_CONFIG_BASE64
	PKGARCH:=all
	MAINTAINER:=panda-mute
endef

define Package/luci-app-domainlist/description
	This package contains LuCI configuration pages for domainlist.
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/files/luci/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-domainlist/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-domainlist ]; then
		( . /etc/uci-defaults/luci-domainlist ) && \
		rm -f /etc/uci-defaults/luci-domainlist
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
fi
exit 0
endef

define Package/luci-app-domainlist/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/root/usr/sbin/gfwlist2dnsmasq.sh $(1)/usr/sbin/gfwlist
	$(INSTALL_BIN) ./files/root/usr/sbin/generate_dnsmasq_chinalist.sh $(1)/usr/sbin/chinalist

	$(INSTALL_DIR) $(1)/usr/share/domainlist
	$(INSTALL_BIN) ./files/root/usr/share/domainlist/domainlistupdate $(1)/usr/share/domainlist/
	$(INSTALL_DATA) ./files/root/usr/share/domainlist/user-gfwlist.txt $(1)/usr/share/domainlist/
	$(INSTALL_DATA) ./files/root/usr/share/domainlist/user-chinalist.txt $(1)/usr/share/domainlist/
	$(INSTALL_DATA) ./files/root/usr/share/domainlist/user-exclude.txt $(1)/usr/share/domainlist/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/root/etc/config/domainlist $(1)/etc/config/domainlist
	$(INSTALL_DIR) $(1)/etc/domainlist
	$(INSTALL_DATA) ./files/root/etc/domainlist/gfwlist.conf $(1)/etc/domainlist/gfwlist.conf
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/root/etc/init.d/domainlist $(1)/etc/init.d/domainlist

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/root/etc/uci-defaults/luci-domainlist $(1)/etc/uci-defaults/luci-domainlist

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/domainlist.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/domainlist.zh-cn.lmo
	$(INSTALL_DATA) ./files/luci/model/domainlist.lua $(1)/usr/lib/lua/luci/model/cbi/domainlist.lua
	$(INSTALL_DATA) ./files/luci/controller/domainlist.lua $(1)/usr/lib/lua/luci/controller/domainlist.lua
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./files/root/usr/share/rpcd/acl.d/luci-app-domainlist.json $(1)/usr/share/rpcd/acl.d/luci-app-domainlist.json
endef

$(eval $(call BuildPackage,luci-app-domainlist))
