#!/bin/sh

cp config.template .config

echo "Update feeds"
LUCI="feeds/luci"
if [ -d "$LUCI" ]; then
	cd feeds/luci/
	git checkout applications
	cd -
fi

PACKAGE="feeds/packages"
if [ -d "$PACKAGE" ]; then
	cd feeds/packages/
	git checkout net/
	git checkout libs/
	rm -rf net/samba4/files/samba.hotplug
	rm -rf net/samba4/files/samba.sh
	rm -rf net/samba4/samba4-libs/
	cd -
fi

./scripts/feeds update -a

echo "Patch luci"
cd feeds/luci/
cd -

echo "Patch mypackages"
cd feeds/packages/
patch -p1 < ../../packages.patch
patch -p1 < ../../samba4.patch
cd -

echo "Install feeds"
./scripts/feeds install -a
./scripts/feeds uninstall luci-app-shadowsocks-libev
./scripts/feeds uninstall dnscrypt-proxy2
