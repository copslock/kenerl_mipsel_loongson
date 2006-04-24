Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 15:44:24 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:61245 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133730AbWDXOn5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2006 15:43:57 +0100
Received: by mo.po.2iij.net (mo31) id k3OEuw1m056763; Mon, 24 Apr 2006 23:56:58 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox30) id k3OEusYn068338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 24 Apr 2006 23:56:54 +0900 (JST)
Date:	Mon, 24 Apr 2006 23:56:50 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] vr41xx: defconfig update
Message-Id: <20060424235650.1afed6e0.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060424101129.GE3194@linux-mips.org>
References: <20060416231216.1accadac.yoichi_yuasa@tripeaks.co.jp>
	<20060424101129.GE3194@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

On Mon, 24 Apr 2006 11:11:29 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Sun, Apr 16, 2006 at 11:12:16PM +0900, Yoichi Yuasa wrote:
> 
> > This patch updates defconfig for VR41xx machines.
> > Please apply.
> 
> Seems this patch no longer applies cleanly.  Can you respin the patch?

OK, take 2.
I add a few updates to the patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/capcella_defconfig mips/arch/mips/configs/capcella_defconfig
--- mips-orig/arch/mips/configs/capcella_defconfig	2006-04-24 22:47:47.736798500 +0900
+++ mips/arch/mips/configs/capcella_defconfig	2006-04-24 23:11:14.625735500 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc1
-# Fri Jan 27 15:39:54 2006
+# Linux kernel version: 2.6.17-rc2
+# Mon Apr 24 23:06:31 2006
 #
 CONFIG_MIPS=y
 
@@ -72,6 +72,8 @@ CONFIG_ZAO_CAPCELLA=y
 CONFIG_PCI_VR41XX=y
 # CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
@@ -91,7 +93,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_MIPS64_R2 is not set
 # CONFIG_CPU_R3000 is not set
 # CONFIG_CPU_TX39XX is not set
-# CONFIG_CPU_VR41XX is not set
+CONFIG_CPU_VR41XX=y
 # CONFIG_CPU_R4300 is not set
 # CONFIG_CPU_R4X00 is not set
 # CONFIG_CPU_TX49XX is not set
@@ -104,18 +106,22 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+CONFIG_SYS_HAS_CPU_VR41XX=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
 #
 # Kernel type
 #
-# CONFIG_32BIT is not set
+CONFIG_32BIT=y
 # CONFIG_64BIT is not set
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_MIPS_MT is not set
-CONFIG_CPU_HAS_LLSC=y
+# CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -136,7 +142,6 @@ CONFIG_PREEMPT_NONE=y
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -152,6 +157,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -165,10 +171,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -180,7 +182,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
@@ -188,6 +189,9 @@ CONFIG_KMOD=y
 #
 # Block layer
 #
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -207,7 +211,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
-CONFIG_PCI_LEGACY_PROC=y
 CONFIG_MMU=y
 
 #
@@ -225,6 +228,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
 
 #
 # Networking
@@ -234,6 +238,7 @@ CONFIG_NET=y
 #
 # Networking options
 #
+# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
@@ -256,12 +261,15 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
-CONFIG_INET_TUNNEL=m
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_BIC=y
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -273,6 +281,11 @@ CONFIG_TCP_CONG_BIC=y
 # SCTP Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
@@ -282,11 +295,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
-# CONFIG_TIPC is not set
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
@@ -303,10 +311,7 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
+# CONFIG_IEEE80211 is not set
 
 #
 # Device Drivers
@@ -349,10 +354,12 @@ CONFIG_CONNECTOR=m
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
-# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -579,6 +586,11 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -602,6 +614,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # Ftape, the floppy tape device driver
 #
 # CONFIG_DRM is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -637,10 +650,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -671,6 +680,7 @@ CONFIG_DUMMY_CONSOLE=y
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_USB is not set
 
 #
@@ -688,13 +698,48 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 # CONFIG_INFINIBAND is not set
 
 #
-# SN Devices
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
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
 #
+# CONFIG_RTC_DRV_M48T86 is not set
+CONFIG_RTC_DRV_VR41XX=y
+# CONFIG_RTC_DRV_TEST is not set
 
 #
 # File systems
@@ -713,7 +758,7 @@ CONFIG_EXT2_FS=y
 CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=y
+# CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 
@@ -736,10 +781,9 @@ CONFIG_FUSE_FS=m
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_RELAYFS_FS=m
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -806,44 +850,20 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_FS is not set
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="mem=32M console=ttyVR0,38400"
 
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
@@ -853,8 +873,6 @@ CONFIG_CRYPTO_CRC32C=m
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
--- mips-orig/arch/mips/configs/e55_defconfig	2006-04-24 22:47:47.788801750 +0900
+++ mips/arch/mips/configs/e55_defconfig	2006-04-24 23:14:32.990132500 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc1
-# Fri Jan 27 15:40:04 2006
+# Linux kernel version: 2.6.17-rc2
+# Mon Apr 24 23:11:22 2006
 #
 CONFIG_MIPS=y
 
@@ -70,6 +70,8 @@ CONFIG_CASIO_E55=y
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
@@ -89,7 +91,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_MIPS64_R2 is not set
 # CONFIG_CPU_R3000 is not set
 # CONFIG_CPU_TX39XX is not set
-# CONFIG_CPU_VR41XX is not set
+CONFIG_CPU_VR41XX=y
 # CONFIG_CPU_R4300 is not set
 # CONFIG_CPU_R4X00 is not set
 # CONFIG_CPU_TX49XX is not set
@@ -102,18 +104,22 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+CONFIG_SYS_HAS_CPU_VR41XX=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
 #
 # Kernel type
 #
-# CONFIG_32BIT is not set
+CONFIG_32BIT=y
 # CONFIG_64BIT is not set
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_MIPS_MT is not set
-CONFIG_CPU_HAS_LLSC=y
+# CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -134,7 +140,6 @@ CONFIG_PREEMPT_NONE=y
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -145,11 +150,10 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
-# CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -163,10 +167,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -178,7 +178,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
@@ -186,6 +185,9 @@ CONFIG_KMOD=y
 #
 # Block layer
 #
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -220,85 +222,12 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
 
 #
 # Networking
 #
-CONFIG_NET=y
-
-#
-# Networking options
-#
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
-CONFIG_INET_TUNNEL=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
-# CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
-# CONFIG_IPV6 is not set
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
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
-# CONFIG_TIPC is not set
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
+# CONFIG_NET is not set
 
 #
 # Device Drivers
@@ -314,7 +243,6 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Connector - unified userspace <-> kernelspace linker
 #
-CONFIG_CONNECTOR=m
 
 #
 # Memory Technology Devices (MTD)
@@ -336,11 +264,11 @@ CONFIG_CONNECTOR=m
 #
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -399,81 +327,8 @@ CONFIG_IDE_GENERIC=y
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
@@ -509,11 +364,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
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
@@ -532,6 +383,10 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -566,6 +421,7 @@ CONFIG_WATCHDOG=y
 #
 # Ftape, the floppy tape device driver
 #
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -601,10 +457,6 @@ CONFIG_WATCHDOG=y
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -612,7 +464,6 @@ CONFIG_WATCHDOG=y
 #
 # Digital Video Broadcasting Devices
 #
-# CONFIG_DVB is not set
 
 #
 # Graphics support
@@ -636,6 +487,7 @@ CONFIG_DUMMY_CONSOLE=y
 #
 # CONFIG_USB_ARCH_HAS_HCD is not set
 # CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -652,14 +504,32 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 
 #
-# SN Devices
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
 #
 
 #
+# Real Time Clock
+#
+# CONFIG_RTC_CLASS is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -670,13 +540,12 @@ CONFIG_EXT2_FS=y
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
 
@@ -699,10 +568,9 @@ CONFIG_FUSE_FS=m
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_RELAYFS_FS=m
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -723,29 +591,6 @@ CONFIG_RELAYFS_FS=m
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
@@ -768,44 +613,20 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_FS is not set
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="console=ttyVR0,19200 mem=8M"
 
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
@@ -815,8 +636,6 @@ CONFIG_CRYPTO_CRC32C=m
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
--- mips-orig/arch/mips/configs/tb0226_defconfig	2006-04-24 22:47:47.808803000 +0900
+++ mips/arch/mips/configs/tb0226_defconfig	2006-04-24 23:37:47.001252750 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc1
-# Fri Jan 27 15:40:34 2006
+# Linux kernel version: 2.6.17-rc2
+# Mon Apr 24 23:32:47 2006
 #
 CONFIG_MIPS=y
 
@@ -68,12 +68,14 @@ CONFIG_MACH_VR41XX=y
 # CONFIG_NEC_CMBVR4133 is not set
 CONFIG_TANBAC_TB022X=y
 CONFIG_TANBAC_TB0226=y
-CONFIG_TANBAC_TB0287=y
+# CONFIG_TANBAC_TB0287 is not set
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_PCI_VR41XX=y
 # CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
@@ -93,7 +95,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_MIPS64_R2 is not set
 # CONFIG_CPU_R3000 is not set
 # CONFIG_CPU_TX39XX is not set
-# CONFIG_CPU_VR41XX is not set
+CONFIG_CPU_VR41XX=y
 # CONFIG_CPU_R4300 is not set
 # CONFIG_CPU_R4X00 is not set
 # CONFIG_CPU_TX49XX is not set
@@ -106,18 +108,22 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+CONFIG_SYS_HAS_CPU_VR41XX=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
 #
 # Kernel type
 #
-# CONFIG_32BIT is not set
+CONFIG_32BIT=y
 # CONFIG_64BIT is not set
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_MIPS_MT is not set
-CONFIG_CPU_HAS_LLSC=y
+# CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -138,7 +144,6 @@ CONFIG_PREEMPT_NONE=y
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -154,6 +159,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -167,10 +173,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -182,7 +184,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
@@ -190,6 +191,9 @@ CONFIG_KMOD=y
 #
 # Block layer
 #
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -209,7 +213,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
-# CONFIG_PCI_LEGACY_PROC is not set
 CONFIG_MMU=y
 
 #
@@ -227,6 +230,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
 
 #
 # Networking
@@ -236,11 +240,10 @@ CONFIG_NET=y
 #
 # Networking options
 #
+# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
-CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -264,12 +267,15 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
-CONFIG_INET_TUNNEL=m
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_BIC=y
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -281,6 +287,11 @@ CONFIG_TCP_CONG_BIC=y
 # SCTP Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
@@ -290,11 +301,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
-# CONFIG_TIPC is not set
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
@@ -311,10 +317,7 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
+# CONFIG_IEEE80211 is not set
 
 #
 # Device Drivers
@@ -359,11 +362,12 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_UB is not set
-CONFIG_BLK_DEV_RAM=m
+CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -398,14 +402,14 @@ CONFIG_SCSI_MULTI_LUN=y
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
@@ -425,7 +429,6 @@ CONFIG_ISCSI_TCP=m
 # CONFIG_SCSI_INIA100 is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
-# CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
 # CONFIG_SCSI_LPFC is not set
@@ -508,8 +511,8 @@ CONFIG_NET_PCI=y
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
@@ -626,6 +629,11 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -686,10 +694,6 @@ CONFIG_GPIO_VR41XX=y
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -698,6 +702,7 @@ CONFIG_GPIO_VR41XX=y
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
@@ -720,6 +725,7 @@ CONFIG_DUMMY_CONSOLE=y
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
 
@@ -757,7 +763,7 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 #
 # may also be needed; see USB_STORAGE Help for more information
 #
-CONFIG_USB_STORAGE=m
+CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
@@ -784,9 +790,7 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_ACECAD is not set
 # CONFIG_USB_KBTAB is not set
 # CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_MTOUCH is not set
-# CONFIG_USB_ITMTOUCH is not set
-# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_TOUCHSCREEN is not set
 # CONFIG_USB_YEALINK is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
@@ -801,15 +805,6 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_MICROTEK is not set
 
 #
-# USB Multimedia devices
-#
-# CONFIG_USB_DABUSB is not set
-
-#
-# Video4Linux support is needed for USB Multimedia device support
-#
-
-#
 # USB Network Adapters
 #
 # CONFIG_USB_CATC is not set
@@ -817,7 +812,7 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
 # CONFIG_USB_USBNET is not set
-CONFIG_USB_MON=y
+# CONFIG_USB_MON is not set
 
 #
 # USB port drivers
@@ -861,13 +856,48 @@ CONFIG_USB_MON=y
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 # CONFIG_INFINIBAND is not set
 
 #
-# SN Devices
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
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
 #
+# CONFIG_RTC_DRV_M48T86 is not set
+CONFIG_RTC_DRV_VR41XX=y
+# CONFIG_RTC_DRV_TEST is not set
 
 #
 # File systems
@@ -912,7 +942,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_RELAYFS_FS=m
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -953,9 +982,7 @@ CONFIG_NFS_COMMON=y
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
@@ -971,46 +998,7 @@ CONFIG_MSDOS_PARTITION=y
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
@@ -1024,44 +1012,20 @@ CONFIG_NLS_ISO8859_1=m
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_FS is not set
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="mem=32M console=ttyVR0,115200"
 
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
@@ -1070,9 +1034,8 @@ CONFIG_CRYPTO_CRC32C=m
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
--- mips-orig/arch/mips/configs/tb0229_defconfig	2006-04-24 22:47:47.808803000 +0900
+++ mips/arch/mips/configs/tb0229_defconfig	2006-04-24 23:41:52.812615000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc1
-# Fri Jan 27 15:40:35 2006
+# Linux kernel version: 2.6.17-rc2
+# Mon Apr 24 23:38:38 2006
 #
 CONFIG_MIPS=y
 
@@ -68,12 +68,14 @@ CONFIG_MACH_VR41XX=y
 # CONFIG_NEC_CMBVR4133 is not set
 CONFIG_TANBAC_TB022X=y
 # CONFIG_TANBAC_TB0226 is not set
-CONFIG_TANBAC_TB0287=y
+# CONFIG_TANBAC_TB0287 is not set
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_PCI_VR41XX=y
 # CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
@@ -93,7 +95,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_MIPS64_R2 is not set
 # CONFIG_CPU_R3000 is not set
 # CONFIG_CPU_TX39XX is not set
-# CONFIG_CPU_VR41XX is not set
+CONFIG_CPU_VR41XX=y
 # CONFIG_CPU_R4300 is not set
 # CONFIG_CPU_R4X00 is not set
 # CONFIG_CPU_TX49XX is not set
@@ -106,18 +108,22 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+CONFIG_SYS_HAS_CPU_VR41XX=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
 #
 # Kernel type
 #
-# CONFIG_32BIT is not set
+CONFIG_32BIT=y
 # CONFIG_64BIT is not set
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_MIPS_MT is not set
-CONFIG_CPU_HAS_LLSC=y
+# CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -138,7 +144,6 @@ CONFIG_PREEMPT_NONE=y
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -154,6 +159,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -167,10 +173,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -182,7 +184,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
@@ -190,6 +191,9 @@ CONFIG_KMOD=y
 #
 # Block layer
 #
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -209,7 +213,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
-# CONFIG_PCI_LEGACY_PROC is not set
 CONFIG_MMU=y
 
 #
@@ -227,6 +230,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
 
 #
 # Networking
@@ -236,11 +240,10 @@ CONFIG_NET=y
 #
 # Networking options
 #
+# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
-CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -265,12 +268,15 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 CONFIG_INET_TUNNEL=m
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_BIC=y
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -282,6 +288,11 @@ CONFIG_TCP_CONG_BIC=y
 # SCTP Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
@@ -291,11 +302,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
-# CONFIG_TIPC is not set
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
@@ -312,10 +318,7 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
+# CONFIG_IEEE80211 is not set
 
 #
 # Device Drivers
@@ -326,12 +329,12 @@ CONFIG_IEEE80211_CRYPT_CCMP=m
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
@@ -364,10 +367,8 @@ CONFIG_BLK_DEV_RAM=y
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
@@ -444,30 +445,7 @@ CONFIG_MII=y
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
@@ -484,7 +462,6 @@ CONFIG_R8169=y
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
 # CONFIG_SK98LIN is not set
-# CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 
@@ -511,19 +488,8 @@ CONFIG_R8169=y
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
@@ -584,6 +550,11 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -608,6 +579,7 @@ CONFIG_TANBAC_TB0219=y
 # Ftape, the floppy tape device driver
 #
 # CONFIG_DRM is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -643,10 +615,6 @@ CONFIG_TANBAC_TB0219=y
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -655,6 +623,7 @@ CONFIG_TANBAC_TB0219=y
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
@@ -677,6 +646,7 @@ CONFIG_DUMMY_CONSOLE=y
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=m
 # CONFIG_USB_DEBUG is not set
 
@@ -732,9 +702,7 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_ACECAD is not set
 # CONFIG_USB_KBTAB is not set
 # CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_MTOUCH is not set
-# CONFIG_USB_ITMTOUCH is not set
-# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_TOUCHSCREEN is not set
 # CONFIG_USB_YEALINK is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
@@ -748,15 +716,6 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_MDC800 is not set
 
 #
-# USB Multimedia devices
-#
-# CONFIG_USB_DABUSB is not set
-
-#
-# Video4Linux support is needed for USB Multimedia device support
-#
-
-#
 # USB Network Adapters
 #
 # CONFIG_USB_CATC is not set
@@ -808,13 +767,48 @@ CONFIG_USB_MON=y
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 # CONFIG_INFINIBAND is not set
 
 #
-# SN Devices
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
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
 #
+# CONFIG_RTC_DRV_M48T86 is not set
+CONFIG_RTC_DRV_VR41XX=y
+# CONFIG_RTC_DRV_TEST is not set
 
 #
 # File systems
@@ -822,32 +816,16 @@ CONFIG_USB_MON=y
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
@@ -856,20 +834,14 @@ CONFIG_FUSE_FS=m
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
@@ -881,7 +853,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_RELAYFS_FS=m
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -922,9 +893,7 @@ CONFIG_NFS_COMMON=y
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
@@ -940,46 +909,7 @@ CONFIG_MSDOS_PARTITION=y
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
@@ -993,44 +923,20 @@ CONFIG_NLS_ISO8859_1=m
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_FS is not set
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
 
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
@@ -1039,9 +945,8 @@ CONFIG_CRYPTO_CRC32C=m
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
--- mips-orig/arch/mips/configs/tb0287_defconfig	2006-04-24 22:47:47.808803000 +0900
+++ mips/arch/mips/configs/tb0287_defconfig	2006-04-24 22:56:17.968686000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16
-# Wed Mar 22 11:07:34 2006
+# Linux kernel version: 2.6.17-rc2
+# Mon Apr 24 22:52:57 2006
 #
 CONFIG_MIPS=y
 
@@ -74,7 +74,10 @@ CONFIG_TANBAC_TB0287=y
 CONFIG_PCI_VR41XX=y
 # CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
@@ -107,7 +110,6 @@ CONFIG_CPU_VR41XX=y
 # CONFIG_CPU_SB1 is not set
 CONFIG_SYS_HAS_CPU_VR41XX=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
-CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
@@ -157,6 +159,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -170,10 +173,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -185,7 +184,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
@@ -194,6 +192,8 @@ CONFIG_KMOD=y
 # Block layer
 #
 # CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -213,7 +213,6 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
-# CONFIG_PCI_LEGACY_PROC is not set
 CONFIG_MMU=y
 
 #
@@ -245,8 +244,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
-CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -271,6 +268,7 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 CONFIG_INET_TUNNEL=m
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
@@ -288,6 +286,8 @@ CONFIG_TCP_CONG_HTCP=m
 # CONFIG_TCP_CONG_VEGAS is not set
 # CONFIG_TCP_CONG_SCALABLE is not set
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -493,7 +493,6 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_INIA100 is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
-# CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
 # CONFIG_SCSI_LPFC is not set
@@ -714,7 +713,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_WATCHDOG is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
-# CONFIG_RTC_VR41XX is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
@@ -760,10 +758,6 @@ CONFIG_GPIO_VR41XX=y
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -772,17 +766,53 @@ CONFIG_GPIO_VR41XX=y
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
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
@@ -794,6 +824,7 @@ CONFIG_DUMMY_CONSOLE=y
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=m
 # CONFIG_USB_DEBUG is not set
 
@@ -863,9 +894,7 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_ACECAD is not set
 # CONFIG_USB_KBTAB is not set
 # CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_MTOUCH is not set
-# CONFIG_USB_ITMTOUCH is not set
-# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_TOUCHSCREEN is not set
 # CONFIG_USB_YEALINK is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
@@ -880,15 +909,6 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_MICROTEK is not set
 
 #
-# USB Multimedia devices
-#
-# CONFIG_USB_DABUSB is not set
-
-#
-# Video4Linux support is needed for USB Multimedia device support
-#
-
-#
 # USB Network Adapters
 #
 # CONFIG_USB_CATC is not set
@@ -939,6 +959,19 @@ CONFIG_USB_MON=y
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 # CONFIG_INFINIBAND is not set
@@ -948,6 +981,11 @@ CONFIG_USB_MON=y
 #
 
 #
+# Real Time Clock
+#
+# CONFIG_RTC_CLASS is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -1001,7 +1039,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -1067,14 +1104,14 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_FS is not set
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
 
 #
 # Security options
 #
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/workpad_defconfig mips/arch/mips/configs/workpad_defconfig
--- mips-orig/arch/mips/configs/workpad_defconfig	2006-04-24 22:47:47.808803000 +0900
+++ mips/arch/mips/configs/workpad_defconfig	2006-04-24 23:46:53.779424250 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc1
-# Fri Jan 27 15:40:36 2006
+# Linux kernel version: 2.6.17-rc2
+# Mon Apr 24 23:42:15 2006
 #
 CONFIG_MIPS=y
 
@@ -70,6 +70,8 @@ CONFIG_IBM_WORKPAD=y
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
@@ -89,7 +91,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_MIPS64_R2 is not set
 # CONFIG_CPU_R3000 is not set
 # CONFIG_CPU_TX39XX is not set
-# CONFIG_CPU_VR41XX is not set
+CONFIG_CPU_VR41XX=y
 # CONFIG_CPU_R4300 is not set
 # CONFIG_CPU_R4X00 is not set
 # CONFIG_CPU_TX49XX is not set
@@ -102,18 +104,22 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+CONFIG_SYS_HAS_CPU_VR41XX=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
 #
 # Kernel type
 #
-# CONFIG_32BIT is not set
+CONFIG_32BIT=y
 # CONFIG_64BIT is not set
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_MIPS_MT is not set
-CONFIG_CPU_HAS_LLSC=y
+# CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -134,7 +140,6 @@ CONFIG_PREEMPT_NONE=y
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -150,6 +155,7 @@ CONFIG_SYSVIPC=y
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EMBEDDED=y
@@ -163,10 +169,6 @@ CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
 CONFIG_SLAB=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -178,7 +180,6 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
@@ -186,6 +187,9 @@ CONFIG_KMOD=y
 #
 # Block layer
 #
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -221,6 +225,7 @@ CONFIG_PCMCIA_IOCTL=y
 # CONFIG_I82365 is not set
 # CONFIG_TCIC is not set
 CONFIG_PCMCIA_PROBE=y
+CONFIG_PCMCIA_VRC4171=y
 
 #
 # PCI Hotplug Support
@@ -231,6 +236,7 @@ CONFIG_PCMCIA_PROBE=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
 
 #
 # Networking
@@ -240,6 +246,7 @@ CONFIG_NET=y
 #
 # Networking options
 #
+# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
@@ -259,12 +266,15 @@ CONFIG_IP_FIB_HASH=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
-CONFIG_INET_TUNNEL=m
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_BIC=y
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -276,6 +286,11 @@ CONFIG_TCP_CONG_BIC=y
 # SCTP Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
@@ -285,11 +300,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
-# CONFIG_TIPC is not set
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
@@ -306,10 +316,8 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=m
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=m
-CONFIG_IEEE80211_CRYPT_CCMP=m
+# CONFIG_IEEE80211 is not set
+CONFIG_WIRELESS_EXT=y
 
 #
 # Device Drivers
@@ -348,10 +356,12 @@ CONFIG_CONNECTOR=m
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -469,7 +479,38 @@ CONFIG_MII=m
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
@@ -513,10 +554,7 @@ CONFIG_INPUT=y
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
@@ -534,11 +572,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
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
@@ -557,6 +591,10 @@ CONFIG_HW_CONSOLE=y
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -569,20 +607,7 @@ CONFIG_LEGACY_PTY_COUNT=256
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
@@ -598,6 +623,7 @@ CONFIG_WATCHDOG=y
 # CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_GPIO_VR41XX is not set
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -633,10 +659,6 @@ CONFIG_WATCHDOG=y
 #
 
 #
-# Multimedia Capabilities Port drivers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -668,6 +690,7 @@ CONFIG_DUMMY_CONSOLE=y
 #
 # CONFIG_USB_ARCH_HAS_HCD is not set
 # CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -684,12 +707,30 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_MMC is not set
 
 #
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 
 #
-# SN Devices
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
 #
+# CONFIG_RTC_CLASS is not set
 
 #
 # File systems
@@ -711,7 +752,7 @@ CONFIG_FS_POSIX_ACL=y
 CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=y
+# CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 
@@ -734,10 +775,9 @@ CONFIG_FUSE_FS=m
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_RELAYFS_FS=m
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -803,44 +843,20 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_FS is not set
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="console=ttyVR0,19200 mem=16M"
 
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
@@ -850,8 +866,6 @@ CONFIG_CRYPTO_CRC32C=m
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
