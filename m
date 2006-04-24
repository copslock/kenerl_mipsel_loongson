Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 16:12:17 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:22024 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133747AbWDXPLy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2006 16:11:54 +0100
Received: by mo.po.2iij.net (mo30) id k3OFOsEm060847; Tue, 25 Apr 2006 00:24:54 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox31) id k3OFOofl062879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Apr 2006 00:24:51 +0900 (JST)
Date:	Tue, 25 Apr 2006 00:24:48 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	ralf@linux-mips.org
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] vr41xx: defconfig update
Message-Id: <20060425002448.0a2cb655.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060424235650.1afed6e0.yoichi_yuasa@tripeaks.co.jp>
References: <20060416231216.1accadac.yoichi_yuasa@tripeaks.co.jp>
	<20060424101129.GE3194@linux-mips.org>
	<20060424235650.1afed6e0.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 24 Apr 2006 23:56:50 +0900
Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:

> Hello Ralf,
> 
> On Mon, 24 Apr 2006 11:11:29 +0100
> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > On Sun, Apr 16, 2006 at 11:12:16PM +0900, Yoichi Yuasa wrote:
> > 
> > > This patch updates defconfig for VR41xx machines.
> > > Please apply.
> > 
> > Seems this patch no longer applies cleanly.  Can you respin the patch?
> 
> OK, take 2.
> I add a few updates to the patch.

The take2 was too late for your defconfigs update.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/capcella_defconfig mips/arch/mips/configs/capcella_defconfig
--- mips-orig/arch/mips/configs/capcella_defconfig	2006-04-25 00:00:54.837896750 +0900
+++ mips/arch/mips/configs/capcella_defconfig	2006-04-25 00:08:14.765769000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.17-rc2
-# Mon Apr 24 14:50:56 2006
+# Tue Apr 25 00:08:06 2006
 #
 CONFIG_MIPS=y
 
@@ -156,7 +156,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_RELAY=y
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -310,13 +310,7 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_IEEE80211 is not set
 
 #
 # Device Drivers
@@ -359,10 +353,12 @@ CONFIG_CONNECTOR=m
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
-# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -589,7 +585,10 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
@@ -614,7 +613,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # Ftape, the floppy tape device driver
 #
 # CONFIG_DRM is not set
-# CONFIG_GPIO_VR41XX is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -722,7 +721,24 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 #
 # Real Time Clock
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+
+#
+# RTC drivers
+#
+# CONFIG_RTC_DRV_M48T86 is not set
+CONFIG_RTC_DRV_VR41XX=y
+# CONFIG_RTC_DRV_TEST is not set
 
 #
 # File systems
@@ -741,7 +757,7 @@ CONFIG_EXT2_FS=y
 CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=y
+# CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 
@@ -764,7 +780,7 @@ CONFIG_FUSE_FS=m
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -840,38 +856,13 @@ CONFIG_CMDLINE="mem=32M console=ttyVR0,3
 #
 # Security options
 #
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
 # Cryptographic options
 #
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=m
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO is not set
 
 #
 # Hardware crypto devices
@@ -881,8 +872,6 @@ CONFIG_CRYPTO_CRC32C=m
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
-CONFIG_CRC16=m
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
+# CONFIG_LIBCRC32C is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/e55_defconfig mips/arch/mips/configs/e55_defconfig
--- mips-orig/arch/mips/configs/e55_defconfig	2006-04-25 00:00:54.845893250 +0900
+++ mips/arch/mips/configs/e55_defconfig	2006-04-25 00:08:34.927029000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.17-rc2
-# Mon Apr 24 14:51:02 2006
+# Tue Apr 25 00:08:20 2006
 #
 CONFIG_MIPS=y
 
@@ -149,12 +149,10 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
-# CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_RELAY=y
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -228,88 +226,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Networking
 #
-CONFIG_NET=y
-
-#
-# Networking options
-#
-# CONFIG_NETDEBUG is not set
-CONFIG_PACKET=y
-CONFIG_PACKET_MMAP=y
-CONFIG_UNIX=y
-CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_FIB_HASH=y
-# CONFIG_IP_PNP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_ARPD is not set
-# CONFIG_SYN_COOKIES is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_XFRM_TUNNEL is not set
-# CONFIG_INET_TUNNEL is not set
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
-# CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
-# CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
-# CONFIG_NETFILTER is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
-# CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
-# CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
-# CONFIG_TIPC is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-
-#
-# Network testing
-#
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_NET is not set
 
 #
 # Device Drivers
@@ -325,7 +242,6 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Connector - unified userspace <-> kernelspace linker
 #
-CONFIG_CONNECTOR=m
 
 #
 # Memory Technology Devices (MTD)
@@ -347,11 +263,11 @@ CONFIG_CONNECTOR=m
 #
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM=m
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -410,81 +326,8 @@ CONFIG_IDE_GENERIC=y
 #
 
 #
-# Network device support
-#
-CONFIG_NETDEVICES=y
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
-
-#
-# ARCnet devices
-#
-# CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
-CONFIG_PHYLIB=m
-
-#
-# MII PHY device drivers
-#
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
-
-#
-# Ethernet (10 or 100Mbit)
-#
-CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_NET_VENDOR_SMC is not set
-# CONFIG_DM9000 is not set
-# CONFIG_NET_VENDOR_RACAL is not set
-# CONFIG_AT1700 is not set
-# CONFIG_DEPCA is not set
-# CONFIG_HP100 is not set
-# CONFIG_NET_ISA is not set
-# CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
-# CONFIG_TR is not set
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
-#
-# CONFIG_WAN is not set
-# CONFIG_PPP is not set
-# CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
-# CONFIG_NETCONSOLE is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-
-#
 # ISDN subsystem
 #
-# CONFIG_ISDN is not set
 
 #
 # Telephony Support
@@ -520,11 +363,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -543,7 +382,10 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -578,7 +420,7 @@ CONFIG_WATCHDOG=y
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_GPIO_VR41XX is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -621,7 +463,6 @@ CONFIG_WATCHDOG=y
 #
 # Digital Video Broadcasting Devices
 #
-# CONFIG_DVB is not set
 
 #
 # Graphics support
@@ -698,13 +539,12 @@ CONFIG_EXT2_FS=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=y
+# CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 
@@ -727,7 +567,7 @@ CONFIG_FUSE_FS=m
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -750,29 +590,6 @@ CONFIG_RAMFS=y
 # CONFIG_UFS_FS is not set
 
 #
-# Network File Systems
-#
-CONFIG_NFS_FS=m
-# CONFIG_NFS_V3 is not set
-# CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
-CONFIG_LOCKD=m
-CONFIG_EXPORTFS=m
-CONFIG_NFS_COMMON=y
-CONFIG_SUNRPC=m
-# CONFIG_RPCSEC_GSS_KRB5 is not set
-# CONFIG_RPCSEC_GSS_SPKM3 is not set
-# CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
-# CONFIG_NCP_FS is not set
-# CONFIG_CODA_FS is not set
-# CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
-
-#
 # Partition Types
 #
 # CONFIG_PARTITION_ADVANCED is not set
@@ -802,38 +619,13 @@ CONFIG_CMDLINE="console=ttyVR0,19200 mem
 #
 # Security options
 #
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
 # Cryptographic options
 #
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=m
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO is not set
 
 #
 # Hardware crypto devices
@@ -843,8 +635,6 @@ CONFIG_CRYPTO_CRC32C=m
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
-CONFIG_CRC16=m
-CONFIG_CRC32=m
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
+# CONFIG_CRC16 is not set
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/tb0226_defconfig mips/arch/mips/configs/tb0226_defconfig
--- mips-orig/arch/mips/configs/tb0226_defconfig	2006-04-25 00:00:55.037809250 +0900
+++ mips/arch/mips/configs/tb0226_defconfig	2006-04-25 00:08:53.016159500 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.17-rc2
-# Mon Apr 24 14:51:18 2006
+# Tue Apr 25 00:08:41 2006
 #
 CONFIG_MIPS=y
 
@@ -68,7 +68,7 @@ CONFIG_MACH_VR41XX=y
 # CONFIG_NEC_CMBVR4133 is not set
 CONFIG_TANBAC_TB022X=y
 CONFIG_TANBAC_TB0226=y
-CONFIG_TANBAC_TB0287=y
+# CONFIG_TANBAC_TB0287 is not set
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_PCI_VR41XX=y
@@ -158,7 +158,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_RELAY=y
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -316,13 +316,7 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_IEEE80211 is not set
 
 #
 # Device Drivers
@@ -367,12 +361,12 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_UB is not set
-CONFIG_BLK_DEV_RAM=m
+CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -407,14 +401,14 @@ CONFIG_SCSI_MULTI_LUN=y
 # SCSI Transport Attributes
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
-CONFIG_SCSI_FC_ATTRS=y
-CONFIG_SCSI_ISCSI_ATTRS=m
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
 
 #
 # SCSI low-level drivers
 #
-CONFIG_ISCSI_TCP=m
+# CONFIG_ISCSI_TCP is not set
 # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
 # CONFIG_SCSI_3W_9XXX is not set
 # CONFIG_SCSI_ACARD is not set
@@ -516,8 +510,8 @@ CONFIG_NET_PCI=y
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
 # CONFIG_DGRS is not set
-CONFIG_EEPRO100=y
-# CONFIG_E100 is not set
+# CONFIG_EEPRO100 is not set
+CONFIG_E100=y
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
@@ -634,7 +628,10 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
@@ -765,7 +762,7 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 #
 # may also be needed; see USB_STORAGE Help for more information
 #
-CONFIG_USB_STORAGE=m
+CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
@@ -814,7 +811,7 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
 # CONFIG_USB_USBNET is not set
-CONFIG_USB_MON=y
+# CONFIG_USB_MON is not set
 
 #
 # USB port drivers
@@ -882,7 +879,24 @@ CONFIG_USB_MON=y
 #
 # Real Time Clock
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+
+#
+# RTC drivers
+#
+# CONFIG_RTC_DRV_M48T86 is not set
+CONFIG_RTC_DRV_VR41XX=y
+# CONFIG_RTC_DRV_TEST is not set
 
 #
 # File systems
@@ -967,9 +981,7 @@ CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-CONFIG_SMB_NLS_DEFAULT=y
-CONFIG_SMB_NLS_REMOTE="cp932"
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -985,46 +997,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Native Language Support
 #
-CONFIG_NLS=y
-CONFIG_NLS_DEFAULT="iso8859-1"
-CONFIG_NLS_CODEPAGE_437=m
-# CONFIG_NLS_CODEPAGE_737 is not set
-# CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
-# CONFIG_NLS_CODEPAGE_852 is not set
-# CONFIG_NLS_CODEPAGE_855 is not set
-# CONFIG_NLS_CODEPAGE_857 is not set
-# CONFIG_NLS_CODEPAGE_860 is not set
-# CONFIG_NLS_CODEPAGE_861 is not set
-# CONFIG_NLS_CODEPAGE_862 is not set
-# CONFIG_NLS_CODEPAGE_863 is not set
-# CONFIG_NLS_CODEPAGE_864 is not set
-# CONFIG_NLS_CODEPAGE_865 is not set
-# CONFIG_NLS_CODEPAGE_866 is not set
-# CONFIG_NLS_CODEPAGE_869 is not set
-# CONFIG_NLS_CODEPAGE_936 is not set
-# CONFIG_NLS_CODEPAGE_950 is not set
-CONFIG_NLS_CODEPAGE_932=m
-# CONFIG_NLS_CODEPAGE_949 is not set
-# CONFIG_NLS_CODEPAGE_874 is not set
-# CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
-# CONFIG_NLS_CODEPAGE_1251 is not set
-# CONFIG_NLS_ASCII is not set
-CONFIG_NLS_ISO8859_1=m
-# CONFIG_NLS_ISO8859_2 is not set
-# CONFIG_NLS_ISO8859_3 is not set
-# CONFIG_NLS_ISO8859_4 is not set
-# CONFIG_NLS_ISO8859_5 is not set
-# CONFIG_NLS_ISO8859_6 is not set
-# CONFIG_NLS_ISO8859_7 is not set
-# CONFIG_NLS_ISO8859_9 is not set
-# CONFIG_NLS_ISO8859_13 is not set
-# CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
-# CONFIG_NLS_KOI8_R is not set
-# CONFIG_NLS_KOI8_U is not set
-# CONFIG_NLS_UTF8 is not set
+# CONFIG_NLS is not set
 
 #
 # Profiling support
@@ -1045,38 +1018,13 @@ CONFIG_CMDLINE="mem=32M console=ttyVR0,1
 #
 # Security options
 #
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
 # Cryptographic options
 #
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=m
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO is not set
 
 #
 # Hardware crypto devices
@@ -1085,9 +1033,8 @@ CONFIG_CRYPTO_CRC32C=m
 #
 # Library routines
 #
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
-CONFIG_CRC32=m
-CONFIG_LIBCRC32C=m
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC32 is not set
+# CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/tb0229_defconfig mips/arch/mips/configs/tb0229_defconfig
--- mips-orig/arch/mips/configs/tb0229_defconfig	2006-04-25 00:00:55.037809250 +0900
+++ mips/arch/mips/configs/tb0229_defconfig	2006-04-25 00:09:09.925216250 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.17-rc2
-# Mon Apr 24 14:51:18 2006
+# Tue Apr 25 00:08:59 2006
 #
 CONFIG_MIPS=y
 
@@ -68,7 +68,7 @@ CONFIG_MACH_VR41XX=y
 # CONFIG_NEC_CMBVR4133 is not set
 CONFIG_TANBAC_TB022X=y
 # CONFIG_TANBAC_TB0226 is not set
-CONFIG_TANBAC_TB0287=y
+# CONFIG_TANBAC_TB0287 is not set
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_PCI_VR41XX=y
@@ -158,7 +158,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_RELAY=y
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -317,13 +317,7 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_IEEE80211 is not set
 
 #
 # Device Drivers
@@ -334,12 +328,12 @@ CONFIG_WIRELESS_EXT=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+# CONFIG_FW_LOADER is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
 #
-CONFIG_CONNECTOR=m
+# CONFIG_CONNECTOR is not set
 
 #
 # Memory Technology Devices (MTD)
@@ -372,10 +366,8 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -452,30 +444,7 @@ CONFIG_MII=y
 #
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
-CONFIG_NET_PCI=y
-# CONFIG_PCNET32 is not set
-# CONFIG_AMD8111_ETH is not set
-# CONFIG_ADAPTEC_STARFIRE is not set
-# CONFIG_B44 is not set
-# CONFIG_FORCEDETH is not set
-# CONFIG_DGRS is not set
-CONFIG_EEPRO100=y
-# CONFIG_E100 is not set
-# CONFIG_FEALNX is not set
-# CONFIG_NATSEMI is not set
-# CONFIG_NE2K_PCI is not set
-# CONFIG_8139CP is not set
-CONFIG_8139TOO=y
-CONFIG_8139TOO_PIO=y
-# CONFIG_8139TOO_TUNE_TWISTER is not set
-# CONFIG_8139TOO_8129 is not set
-# CONFIG_8139_OLD_RX_RESET is not set
-# CONFIG_SIS900 is not set
-# CONFIG_EPIC100 is not set
-# CONFIG_SUNDANCE is not set
-# CONFIG_TLAN is not set
-# CONFIG_VIA_RHINE is not set
-# CONFIG_LAN_SAA9730 is not set
+# CONFIG_NET_PCI is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -492,7 +461,6 @@ CONFIG_R8169=y
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
 # CONFIG_SK98LIN is not set
-# CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 
@@ -519,19 +487,8 @@ CONFIG_R8169=y
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPP_MPPE=m
-CONFIG_PPPOE=m
-CONFIG_SLIP=m
-CONFIG_SLIP_COMPRESSED=y
-CONFIG_SLIP_SMART=y
-CONFIG_SLIP_MODE_SLIP6=y
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -592,7 +549,10 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
@@ -618,7 +578,7 @@ CONFIG_TANBAC_TB0219=y
 # Ftape, the floppy tape device driver
 #
 # CONFIG_DRM is not set
-# CONFIG_GPIO_VR41XX is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -830,7 +790,24 @@ CONFIG_USB_MON=y
 #
 # Real Time Clock
 #
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+
+#
+# RTC drivers
+#
+# CONFIG_RTC_DRV_M48T86 is not set
+CONFIG_RTC_DRV_VR41XX=y
+# CONFIG_RTC_DRV_TEST is not set
 
 #
 # File systems
@@ -838,32 +815,16 @@ CONFIG_USB_MON=y
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
-CONFIG_EXT3_FS=m
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-CONFIG_EXT3_FS_SECURITY=y
-CONFIG_JBD=m
-# CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
+# CONFIG_EXT3_FS is not set
 # CONFIG_REISERFS_FS is not set
-CONFIG_JFS_FS=m
-# CONFIG_JFS_POSIX_ACL is not set
-# CONFIG_JFS_SECURITY is not set
-# CONFIG_JFS_DEBUG is not set
-# CONFIG_JFS_STATISTICS is not set
+# CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
-CONFIG_XFS_FS=y
-CONFIG_XFS_EXPORT=y
-CONFIG_XFS_QUOTA=y
-# CONFIG_XFS_SECURITY is not set
-CONFIG_XFS_POSIX_ACL=y
-# CONFIG_XFS_RT is not set
+# CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=m
 CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
-CONFIG_QUOTACTL=y
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
@@ -872,20 +833,14 @@ CONFIG_FUSE_FS=m
 #
 # CD-ROM/DVD Filesystems
 #
-CONFIG_ISO9660_FS=y
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_ZISOFS_FS=y
+# CONFIG_ISO9660_FS is not set
 # CONFIG_UDF_FS is not set
 
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_FAT_DEFAULT_CODEPAGE=437
-CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
 # CONFIG_NTFS_FS is not set
 
 #
@@ -937,9 +892,7 @@ CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=m
-CONFIG_SMB_NLS_DEFAULT=y
-CONFIG_SMB_NLS_REMOTE="cp932"
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -955,46 +908,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Native Language Support
 #
-CONFIG_NLS=y
-CONFIG_NLS_DEFAULT="iso8859-1"
-CONFIG_NLS_CODEPAGE_437=m
-# CONFIG_NLS_CODEPAGE_737 is not set
-# CONFIG_NLS_CODEPAGE_775 is not set
-# CONFIG_NLS_CODEPAGE_850 is not set
-# CONFIG_NLS_CODEPAGE_852 is not set
-# CONFIG_NLS_CODEPAGE_855 is not set
-# CONFIG_NLS_CODEPAGE_857 is not set
-# CONFIG_NLS_CODEPAGE_860 is not set
-# CONFIG_NLS_CODEPAGE_861 is not set
-# CONFIG_NLS_CODEPAGE_862 is not set
-# CONFIG_NLS_CODEPAGE_863 is not set
-# CONFIG_NLS_CODEPAGE_864 is not set
-# CONFIG_NLS_CODEPAGE_865 is not set
-# CONFIG_NLS_CODEPAGE_866 is not set
-# CONFIG_NLS_CODEPAGE_869 is not set
-# CONFIG_NLS_CODEPAGE_936 is not set
-# CONFIG_NLS_CODEPAGE_950 is not set
-CONFIG_NLS_CODEPAGE_932=m
-# CONFIG_NLS_CODEPAGE_949 is not set
-# CONFIG_NLS_CODEPAGE_874 is not set
-# CONFIG_NLS_ISO8859_8 is not set
-# CONFIG_NLS_CODEPAGE_1250 is not set
-# CONFIG_NLS_CODEPAGE_1251 is not set
-# CONFIG_NLS_ASCII is not set
-CONFIG_NLS_ISO8859_1=m
-# CONFIG_NLS_ISO8859_2 is not set
-# CONFIG_NLS_ISO8859_3 is not set
-# CONFIG_NLS_ISO8859_4 is not set
-# CONFIG_NLS_ISO8859_5 is not set
-# CONFIG_NLS_ISO8859_6 is not set
-# CONFIG_NLS_ISO8859_7 is not set
-# CONFIG_NLS_ISO8859_9 is not set
-# CONFIG_NLS_ISO8859_13 is not set
-# CONFIG_NLS_ISO8859_14 is not set
-# CONFIG_NLS_ISO8859_15 is not set
-# CONFIG_NLS_KOI8_R is not set
-# CONFIG_NLS_KOI8_U is not set
-# CONFIG_NLS_UTF8 is not set
+# CONFIG_NLS is not set
 
 #
 # Profiling support
@@ -1015,38 +929,13 @@ CONFIG_CMDLINE="mem=64M console=ttyVR0,1
 #
 # Security options
 #
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
 # Cryptographic options
 #
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=m
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO is not set
 
 #
 # Hardware crypto devices
@@ -1055,9 +944,8 @@ CONFIG_CRYPTO_CRC32C=m
 #
 # Library routines
 #
-CONFIG_CRC_CCITT=m
-CONFIG_CRC16=m
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=y
-CONFIG_ZLIB_DEFLATE=m
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=m
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/tb0287_defconfig mips/arch/mips/configs/tb0287_defconfig
--- mips-orig/arch/mips/configs/tb0287_defconfig	2006-04-25 00:00:55.037809250 +0900
+++ mips/arch/mips/configs/tb0287_defconfig	2006-04-25 00:09:27.054286750 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.17-rc2
-# Mon Apr 24 14:51:19 2006
+# Tue Apr 25 00:09:17 2006
 #
 CONFIG_MIPS=y
 
@@ -770,13 +770,48 @@ CONFIG_GPIO_VR41XX=y
 #
 # Graphics support
 #
-# CONFIG_FB is not set
+CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_MACMODES is not set
+CONFIG_FB_FIRMWARE_EDID=y
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_NVIDIA is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_ATY is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+CONFIG_FB_SMIVGX=y
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+
+#
+# Logo configuration
+#
+# CONFIG_LOGO is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -1075,8 +1110,7 @@ CONFIG_CMDLINE="mem=64M console=ttyVR0,1
 #
 # Security options
 #
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/workpad_defconfig mips/arch/mips/configs/workpad_defconfig
--- mips-orig/arch/mips/configs/workpad_defconfig	2006-04-25 00:00:55.037809250 +0900
+++ mips/arch/mips/configs/workpad_defconfig	2006-04-25 00:09:42.283238500 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.17-rc2
-# Mon Apr 24 14:51:19 2006
+# Tue Apr 25 00:09:33 2006
 #
 CONFIG_MIPS=y
 
@@ -154,7 +154,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_RELAY=y
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -224,7 +224,7 @@ CONFIG_PCMCIA_IOCTL=y
 # CONFIG_I82365 is not set
 # CONFIG_TCIC is not set
 CONFIG_PCMCIA_PROBE=y
-# CONFIG_PCMCIA_VRC4171 is not set
+CONFIG_PCMCIA_VRC4171=y
 
 #
 # PCI Hotplug Support
@@ -315,12 +315,7 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
+# CONFIG_IEEE80211 is not set
 CONFIG_WIRELESS_EXT=y
 
 #
@@ -360,10 +355,12 @@ CONFIG_CONNECTOR=m
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM=m
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -481,7 +478,38 @@ CONFIG_MII=m
 #
 # Wireless LAN (non-hamradio)
 #
-# CONFIG_NET_RADIO is not set
+CONFIG_NET_RADIO=y
+# CONFIG_NET_WIRELESS_RTNETLINK is not set
+
+#
+# Obsolete Wireless cards support (pre-802.11)
+#
+# CONFIG_STRIP is not set
+# CONFIG_ARLAN is not set
+# CONFIG_WAVELAN is not set
+# CONFIG_PCMCIA_WAVELAN is not set
+# CONFIG_PCMCIA_NETWAVE is not set
+
+#
+# Wireless 802.11 Frequency Hopping cards support
+#
+# CONFIG_PCMCIA_RAYCS is not set
+
+#
+# Wireless 802.11b ISA/PCI cards support
+#
+CONFIG_HERMES=m
+# CONFIG_ATMEL is not set
+
+#
+# Wireless 802.11b Pcmcia/Cardbus cards support
+#
+CONFIG_PCMCIA_HERMES=m
+# CONFIG_PCMCIA_SPECTRUM is not set
+# CONFIG_AIRO_CS is not set
+# CONFIG_PCMCIA_WL3501 is not set
+# CONFIG_HOSTAP is not set
+CONFIG_NET_WIRELESS=y
 
 #
 # PCMCIA network device support
@@ -525,10 +553,7 @@ CONFIG_INPUT=y
 #
 # Userland interfaces
 #
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
@@ -546,11 +571,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -569,7 +590,10 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -582,20 +606,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # Watchdog Cards
 #
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
-
-#
-# Watchdog Device Drivers
-#
-# CONFIG_SOFT_WATCHDOG is not set
-
-#
-# ISA-based Watchdog Cards
-#
-# CONFIG_PCWATCHDOG is not set
-# CONFIG_MIXCOMWD is not set
-# CONFIG_WDT is not set
+# CONFIG_WATCHDOG is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
@@ -740,7 +751,7 @@ CONFIG_FS_POSIX_ACL=y
 CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=y
+# CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 
@@ -763,7 +774,7 @@ CONFIG_FUSE_FS=m
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -838,38 +849,13 @@ CONFIG_CMDLINE="console=ttyVR0,19200 mem
 #
 # Security options
 #
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
 # Cryptographic options
 #
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=m
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO is not set
 
 #
 # Hardware crypto devices
@@ -879,8 +865,6 @@ CONFIG_CRYPTO_CRC32C=m
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
-CONFIG_CRC16=m
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
+# CONFIG_LIBCRC32C is not set
