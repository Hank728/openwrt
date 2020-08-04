#
# Copyright (C) 2008-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy-v2
PKG_VERSION:=2.0.44
PKG_RELEASE:=1
PKG_MAINTAINER:=Maintainer Name <email@gmail.com>
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE:=dnscrypt-proxy-linux_$(ARCH)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/jedisct1/dnscrypt-proxy/releases/download/$(PKG_VERSION)/
PKG_HASH:=35abf486ad90ca0d6433a46dbff7da0df0c1fcfbfb95716c7e2d89d86eed68b6
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

PKG_INSTALL:=1

RSTRIP:=true

include $(INCLUDE_DIR)/package.mk

define Package/dnscrypt-proxy-v2
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=A tool for securing communication between a client and a DNS resolver
  URL:=https://github.com/jedisct1/dnscrypt-proxy
  USERID:=nobody=65534:nogroup=65534
endef

define Package/dnscrypt-proxy-v2/description
  A flexible DNS proxy, with support for modern encrypted DNS protocols such as DNSCrypt v2
  and DNS-over-HTTP/2.
endef

define Package/dnscrypt-proxy-v2/conffiles
/etc/dnscrypt-proxy/dnscrypt-proxy.toml
/etc/config/dnscrypt-proxy
endef

define Build/Prepare
	gzip -dc "$(DL_DIR)/$(PKG_SOURCE)" | tar -C $(PKG_BUILD_DIR)/ -xf -
endef

define Build/Compile
	upx --lzma $(PKG_BUILD_DIR)/linux-$(ARCH)/dnscrypt-proxy >/dev/null 2>&1
endef

define Build/Install
	mkdir -p \
		$(PKG_INSTALL_DIR)/etc/config \
		$(PKG_INSTALL_DIR)/etc/dnscrypt-proxy \
		$(PKG_INSTALL_DIR)/etc/init.d \
		$(PKG_INSTALL_DIR)/usr/sbin
endef

define Package/dnscrypt-proxy-v2/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN) ./files/dnscrypt-proxy-v2.conf $(1)/etc/config/dnscrypt-proxy
	$(INSTALL_DIR) $(1)/etc/dnscrypt-proxy
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/linux-$(ARCH)/example-dnscrypt-proxy.toml \
        $(1)/etc/dnscrypt-proxy/dnscrypt-proxy.toml
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/dnscrypt-proxy-v2.init $(1)/etc/init.d/dnscrypt-proxy
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/linux-$(ARCH)/dnscrypt-proxy $(1)/usr/sbin/dnscrypt-proxy
endef

$(eval $(call BuildPackage,dnscrypt-proxy-v2))
