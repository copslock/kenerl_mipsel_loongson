Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 14:54:40 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:37957 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039408AbYFPNyY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2008 14:54:24 +0100
Received: by mo.po.2iij.net (mo31) id m5GDsJF0047803; Mon, 16 Jun 2008 22:54:19 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox303) id m5GDsFrP002874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Jun 2008 22:54:16 +0900
Date:	Mon, 16 Jun 2008 22:54:16 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] update TANBAC boards defconfig
Message-Id: <20080616225416.f4c6be4b.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Update TANBAC boards defconfig.
These boards need cca setup on CMDLINE.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/configs/tb0219_defconfig linux/arch/mips/configs/tb0219_defconfig
--- linux-orig/arch/mips/configs/tb0219_defconfig	2008-05-12 09:42:20.695216083 +0900
+++ linux/arch/mips/configs/tb0219_defconfig	2008-05-12 11:55:12.291345850 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc2
-# Wed Aug  8 16:11:47 2007
+# Linux kernel version: 2.6.26-rc1
+# Mon May 12 11:54:51 2008
 #
 CONFIG_MIPS=y
 
@@ -10,9 +10,11 @@ CONFIG_MIPS=y
 #
 # CONFIG_MACH_ALCHEMY is not set
 # CONFIG_BASLER_EXCITE is not set
+# CONFIG_BCM47XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
 # CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_ATLAS is not set
 # CONFIG_MIPS_MALTA is not set
@@ -26,6 +28,7 @@ CONFIG_MACH_VR41XX=y
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
 # CONFIG_SGI_IP32 is not set
 # CONFIG_SIBYTE_CRHINE is not set
 # CONFIG_SIBYTE_CARMEL is not set
@@ -53,12 +56,17 @@ CONFIG_PCI_VR41XX=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CMOS_UPDATE=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K=y
+CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_HOTPLUG_CPU is not set
@@ -113,6 +121,7 @@ CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -120,10 +129,16 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
@@ -156,23 +171,29 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+# CONFIG_GROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
@@ -185,10 +206,19 @@ CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+# CONFIG_HAVE_DMA_ATTRS is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
@@ -212,18 +242,17 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI_LEGACY=y
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
 
@@ -237,6 +266,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
 
 #
@@ -278,6 +308,7 @@ CONFIG_INET_TUNNEL=m
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -285,15 +316,10 @@ CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 CONFIG_NETWORK_SECMARK=y
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
-# CONFIG_SCTP_HMAC_NONE is not set
-# CONFIG_SCTP_HMAC_SHA1 is not set
-# CONFIG_SCTP_HMAC_MD5 is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -306,10 +332,6 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -317,6 +339,7 @@ CONFIG_NETWORK_SECMARK=y
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -339,6 +362,7 @@ CONFIG_FIB_RULES=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
@@ -360,10 +384,11 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+CONFIG_BLK_DEV_XIP=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
@@ -375,10 +400,6 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
 
 #
@@ -394,6 +415,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
 CONFIG_PHYLIB=m
 
@@ -409,7 +431,8 @@ CONFIG_VITESSE_PHY=m
 CONFIG_SMSC_PHY=m
 # CONFIG_BROADCOM_PHY is not set
 # CONFIG_ICPLUS_PHY is not set
-# CONFIG_FIXED_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_AX88796 is not set
@@ -420,6 +443,10 @@ CONFIG_MII=y
 # CONFIG_DM9000 is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
@@ -427,7 +454,6 @@ CONFIG_NET_PCI=y
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
 # CONFIG_TC35815 is not set
-# CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
@@ -439,6 +465,7 @@ CONFIG_8139TOO_PIO=y
 # CONFIG_8139TOO_TUNE_TWISTER is not set
 # CONFIG_8139TOO_8129 is not set
 # CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -451,6 +478,10 @@ CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_E1000E_ENABLED is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -472,6 +503,7 @@ CONFIG_VIA_VELOCITY=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # USB Network Adapters
@@ -480,14 +512,12 @@ CONFIG_VIA_VELOCITY=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -506,7 +536,6 @@ CONFIG_INPUT=y
 #
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
@@ -533,7 +562,9 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_DEVKMEM is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
@@ -552,52 +583,62 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 CONFIG_GPIO_TB0219=y
-# CONFIG_DRM is not set
 CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
+
+#
+# Multimedia drivers
+#
 # CONFIG_DAB is not set
 
 #
 # Graphics support
 #
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-# CONFIG_VGASTATE is not set
-# CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
 
 #
 # Console display driver support
@@ -616,6 +657,7 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=m
 # CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
 # Miscellaneous USB options
@@ -624,15 +666,18 @@ CONFIG_USB_DEVICEFS=y
 CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
 # CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
 
 #
 # USB Host Controller Drivers
 #
+# CONFIG_USB_C67X00_HCD is not set
 CONFIG_USB_EHCI_HCD=m
-# CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 # CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
 CONFIG_USB_OHCI_HCD=m
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
@@ -665,10 +710,6 @@ CONFIG_USB_MON=y
 #
 # USB port drivers
 #
-
-#
-# USB Serial Converter support
-#
 # CONFIG_USB_SERIAL is not set
 
 #
@@ -694,17 +735,11 @@ CONFIG_USB_MON=y
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
-
-#
-# USB DSL modem support
-#
-
-#
-# USB Gadget Support
-#
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
@@ -729,9 +764,10 @@ CONFIG_RTC_INTF_DEV=y
 # Platform RTC drivers
 #
 # CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
-# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
@@ -740,23 +776,6 @@ CONFIG_RTC_INTF_DEV=y
 # on-CPU RTC drivers
 #
 CONFIG_RTC_DRV_VR41XX=y
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
-
-#
-# Userspace I/O
-#
 # CONFIG_UIO is not set
 
 #
@@ -771,20 +790,16 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-CONFIG_ROMFS_FS=m
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 # CONFIG_FUSE_FS is not set
@@ -813,7 +828,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -828,24 +842,21 @@ CONFIG_RAMFS=y
 # CONFIG_EFS_FS is not set
 CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+CONFIG_ROMFS_FS=m
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
 # CONFIG_NFSD_V3_ACL is not set
 # CONFIG_NFSD_V4 is not set
-CONFIG_NFSD_TCP=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
@@ -866,47 +877,38 @@ CONFIG_SUNRPC=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
 
 #
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE="mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
+# CONFIG_SAMPLES is not set
+CONFIG_CMDLINE="cca=3 mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
 
 #
 # Security options
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 # CONFIG_CRYPTO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/configs/tb0226_defconfig linux/arch/mips/configs/tb0226_defconfig
--- linux-orig/arch/mips/configs/tb0226_defconfig	2008-05-12 09:42:20.695216083 +0900
+++ linux/arch/mips/configs/tb0226_defconfig	2008-05-12 11:54:24.792639052 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc2
-# Thu Aug  9 11:16:55 2007
+# Linux kernel version: 2.6.26-rc1
+# Mon May 12 11:53:54 2008
 #
 CONFIG_MIPS=y
 
@@ -10,9 +10,11 @@ CONFIG_MIPS=y
 #
 # CONFIG_MACH_ALCHEMY is not set
 # CONFIG_BASLER_EXCITE is not set
+# CONFIG_BCM47XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
 # CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_ATLAS is not set
 # CONFIG_MIPS_MALTA is not set
@@ -26,6 +28,7 @@ CONFIG_MACH_VR41XX=y
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
 # CONFIG_SGI_IP32 is not set
 # CONFIG_SIBYTE_CRHINE is not set
 # CONFIG_SIBYTE_CARMEL is not set
@@ -53,12 +56,17 @@ CONFIG_PCI_VR41XX=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CMOS_UPDATE=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K=y
+CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_HOTPLUG_CPU is not set
@@ -113,6 +121,7 @@ CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -120,10 +129,16 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
@@ -156,23 +171,29 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+# CONFIG_GROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
@@ -185,10 +206,19 @@ CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+# CONFIG_HAVE_DMA_ATTRS is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
@@ -212,18 +242,17 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI_LEGACY=y
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
 
@@ -237,6 +266,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
 
 #
@@ -277,6 +307,7 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -284,15 +315,10 @@ CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 CONFIG_NETWORK_SECMARK=y
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
-# CONFIG_SCTP_HMAC_NONE is not set
-# CONFIG_SCTP_HMAC_SHA1 is not set
-# CONFIG_SCTP_HMAC_MD5 is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -305,10 +331,6 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -316,6 +338,7 @@ CONFIG_NETWORK_SECMARK=y
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -338,6 +361,7 @@ CONFIG_FIB_RULES=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
@@ -359,10 +383,11 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+CONFIG_BLK_DEV_XIP=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
@@ -402,18 +427,13 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 CONFIG_SCSI_SAS_ATTRS=m
 CONFIG_SCSI_SAS_LIBSAS=m
+CONFIG_SCSI_SAS_HOST_SMP=y
 # CONFIG_SCSI_SAS_LIBSAS_DEBUG is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
-# CONFIG_FUSION_SPI is not set
-# CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -428,6 +448,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
@@ -440,6 +461,10 @@ CONFIG_MII=y
 # CONFIG_DM9000 is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
@@ -447,7 +472,6 @@ CONFIG_NET_PCI=y
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
 # CONFIG_TC35815 is not set
-# CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 CONFIG_E100=y
 # CONFIG_FEALNX is not set
@@ -455,6 +479,7 @@ CONFIG_E100=y
 # CONFIG_NE2K_PCI is not set
 # CONFIG_8139CP is not set
 # CONFIG_8139TOO is not set
+# CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -470,6 +495,7 @@ CONFIG_E100=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # USB Network Adapters
@@ -478,7 +504,6 @@ CONFIG_USB_CATC=m
 CONFIG_USB_KAWETH=m
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
-# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
@@ -486,7 +511,6 @@ CONFIG_USB_RTL8150=m
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 # CONFIG_NET_FC is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -505,7 +529,6 @@ CONFIG_INPUT=y
 #
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
@@ -532,7 +555,9 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_DEVKMEM is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
@@ -551,52 +576,62 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_GPIO_TB0219 is not set
-# CONFIG_DRM is not set
 CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
+
+#
+# Multimedia drivers
+#
 # CONFIG_DAB is not set
 
 #
 # Graphics support
 #
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-# CONFIG_VGASTATE is not set
-# CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
 
 #
 # Console display driver support
@@ -615,6 +650,7 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
 # Miscellaneous USB options
@@ -623,15 +659,18 @@ CONFIG_USB_DEVICEFS=y
 CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
 # CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
 
 #
 # USB Host Controller Drivers
 #
+# CONFIG_USB_C67X00_HCD is not set
 CONFIG_USB_EHCI_HCD=y
-# CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 # CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
@@ -657,13 +696,16 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
 # CONFIG_USB_STORAGE_DPCM is not set
 # CONFIG_USB_STORAGE_USBAT is not set
 # CONFIG_USB_STORAGE_SDDR09 is not set
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
@@ -676,10 +718,6 @@ CONFIG_USB_STORAGE=y
 #
 # USB port drivers
 #
-
-#
-# USB Serial Converter support
-#
 # CONFIG_USB_SERIAL is not set
 
 #
@@ -705,17 +743,11 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
-
-#
-# USB DSL modem support
-#
-
-#
-# USB Gadget Support
-#
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
@@ -740,9 +772,10 @@ CONFIG_RTC_INTF_DEV=y
 # Platform RTC drivers
 #
 # CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
-# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
@@ -751,23 +784,6 @@ CONFIG_RTC_INTF_DEV=y
 # on-CPU RTC drivers
 #
 CONFIG_RTC_DRV_VR41XX=y
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
-
-#
-# Userspace I/O
-#
 # CONFIG_UIO is not set
 
 #
@@ -782,14 +798,11 @@ CONFIG_EXT2_FS=y
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-CONFIG_ROMFS_FS=m
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 # CONFIG_FUSE_FS is not set
@@ -818,7 +831,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -833,24 +845,21 @@ CONFIG_RAMFS=y
 # CONFIG_EFS_FS is not set
 CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+CONFIG_ROMFS_FS=m
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 # CONFIG_NFSD_V3_ACL is not set
 # CONFIG_NFSD_V4 is not set
-# CONFIG_NFSD_TCP is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
@@ -871,47 +880,38 @@ CONFIG_SUNRPC=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
 
 #
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE="mem=32M console=ttyVR0,115200"
+# CONFIG_SAMPLES is not set
+CONFIG_CMDLINE="cca=3 mem=32M console=ttyVR0,115200"
 
 #
 # Security options
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 # CONFIG_CRYPTO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=m
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/configs/tb0287_defconfig linux/arch/mips/configs/tb0287_defconfig
--- linux-orig/arch/mips/configs/tb0287_defconfig	2008-05-12 09:42:20.695216083 +0900
+++ linux/arch/mips/configs/tb0287_defconfig	2008-05-12 11:56:05.510378627 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc2
-# Thu Aug  9 14:03:54 2007
+# Linux kernel version: 2.6.26-rc1
+# Mon May 12 11:55:55 2008
 #
 CONFIG_MIPS=y
 
@@ -10,9 +10,11 @@ CONFIG_MIPS=y
 #
 # CONFIG_MACH_ALCHEMY is not set
 # CONFIG_BASLER_EXCITE is not set
+# CONFIG_BCM47XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
 # CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_ATLAS is not set
 # CONFIG_MIPS_MALTA is not set
@@ -26,6 +28,7 @@ CONFIG_MACH_VR41XX=y
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
 # CONFIG_SGI_IP32 is not set
 # CONFIG_SIBYTE_CRHINE is not set
 # CONFIG_SIBYTE_CARMEL is not set
@@ -53,12 +56,17 @@ CONFIG_PCI_VR41XX=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CMOS_UPDATE=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K=y
+CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_HOTPLUG_CPU is not set
@@ -113,6 +121,7 @@ CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -120,10 +129,16 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
@@ -156,12 +171,15 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+# CONFIG_GROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
@@ -173,6 +191,8 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
@@ -185,10 +205,19 @@ CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+# CONFIG_HAVE_DMA_ATTRS is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
@@ -212,18 +241,17 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_CLASSIC_RCU=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI_LEGACY=y
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
 
@@ -237,6 +265,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
 
 #
@@ -278,6 +307,7 @@ CONFIG_INET_TUNNEL=m
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 CONFIG_TCP_CONG_ADVANCED=y
@@ -302,8 +332,6 @@ CONFIG_DEFAULT_BIC=y
 CONFIG_DEFAULT_TCP_CONG="bic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 CONFIG_NETWORK_SECMARK=y
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
@@ -320,10 +348,6 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -331,6 +355,7 @@ CONFIG_NETWORK_SECMARK=y
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -353,6 +378,7 @@ CONFIG_FIB_RULES=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
@@ -374,10 +400,11 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+CONFIG_BLK_DEV_XIP=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
@@ -416,10 +443,14 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
+CONFIG_SATA_PMP=y
 # CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SIL24 is not set
+CONFIG_ATA_SFF=y
 # CONFIG_SATA_SVW is not set
 # CONFIG_ATA_PIIX is not set
 # CONFIG_SATA_MV is not set
@@ -429,7 +460,6 @@ CONFIG_ATA=y
 # CONFIG_SATA_PROMISE is not set
 # CONFIG_SATA_SX4 is not set
 # CONFIG_SATA_SIL is not set
-# CONFIG_SATA_SIL24 is not set
 # CONFIG_SATA_SIS is not set
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
@@ -458,7 +488,9 @@ CONFIG_ATA=y
 # CONFIG_PATA_MPIIX is not set
 # CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
 # CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
 # CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_OPTIDMA is not set
 # CONFIG_PATA_PDC_OLD is not set
@@ -472,15 +504,9 @@ CONFIG_PATA_SIL680=y
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
+# CONFIG_PATA_SCH is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
-# CONFIG_FUSION_SPI is not set
-# CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -520,6 +546,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
@@ -532,6 +559,10 @@ CONFIG_MII=y
 # CONFIG_DM9000 is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
@@ -539,7 +570,6 @@ CONFIG_NET_PCI=y
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
 # CONFIG_TC35815 is not set
-# CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
@@ -551,6 +581,7 @@ CONFIG_8139TOO_PIO=y
 # CONFIG_8139TOO_TUNE_TWISTER is not set
 # CONFIG_8139TOO_8129 is not set
 # CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -563,6 +594,10 @@ CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
+# CONFIG_E1000E_ENABLED is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -584,6 +619,7 @@ CONFIG_VIA_VELOCITY=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # USB Network Adapters
@@ -592,7 +628,6 @@ CONFIG_VIA_VELOCITY=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
@@ -600,7 +635,6 @@ CONFIG_VIA_VELOCITY=y
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 # CONFIG_NET_FC is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -622,7 +656,6 @@ CONFIG_INPUT_MOUSEDEV_PSAUX=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
@@ -649,7 +682,9 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_DEVKMEM is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
@@ -668,49 +703,53 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_GPIO_TB0219 is not set
-# CONFIG_DRM is not set
 CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
 #
 CONFIG_MFD_SM501=y
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
-# CONFIG_DAB is not set
 
 #
-# Graphics support
+# Multimedia drivers
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_DAB is not set
 
 #
-# Display device support
+# Graphics support
 #
-# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
@@ -719,9 +758,11 @@ CONFIG_FB=y
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
 # CONFIG_FB_SYS_FILLRECT is not set
 # CONFIG_FB_SYS_COPYAREA is not set
 # CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
 # CONFIG_FB_SYS_FOPS is not set
 CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
@@ -757,7 +798,14 @@ CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_ARK is not set
 # CONFIG_FB_PM3 is not set
 CONFIG_FB_SM501=y
+# CONFIG_FB_COBALT is not set
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
 # Console display driver support
@@ -787,6 +835,7 @@ CONFIG_FONT_8x16=y
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
 
 #
 # USB Input Devices
@@ -807,6 +856,7 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=m
 # CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
 # Miscellaneous USB options
@@ -815,15 +865,18 @@ CONFIG_USB=m
 CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
 # CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
 
 #
 # USB Host Controller Drivers
 #
+# CONFIG_USB_C67X00_HCD is not set
 CONFIG_USB_EHCI_HCD=m
-# CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 # CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
 CONFIG_USB_OHCI_HCD=m
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
@@ -849,13 +902,16 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
 # CONFIG_USB_STORAGE_DPCM is not set
 # CONFIG_USB_STORAGE_USBAT is not set
 # CONFIG_USB_STORAGE_SDDR09 is not set
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
@@ -868,10 +924,6 @@ CONFIG_USB_MON=y
 #
 # USB port drivers
 #
-
-#
-# USB Serial Converter support
-#
 # CONFIG_USB_SERIAL is not set
 
 #
@@ -896,36 +948,14 @@ CONFIG_USB_MON=y
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
-
-#
-# USB DSL modem support
-#
-
-#
-# USB Gadget Support
-#
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
+CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
-
-#
-# Userspace I/O
-#
 # CONFIG_UIO is not set
 
 #
@@ -940,25 +970,21 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
-# CONFIG_XFS_SECURITY is not set
 CONFIG_XFS_POSIX_ACL=y
 # CONFIG_XFS_RT is not set
-# CONFIG_GFS2_FS is not set
+# CONFIG_XFS_DEBUG is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-CONFIG_ROMFS_FS=m
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_QUOTACTL=y
-CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 # CONFIG_FUSE_FS is not set
@@ -987,7 +1013,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -1002,24 +1027,21 @@ CONFIG_RAMFS=y
 # CONFIG_EFS_FS is not set
 CONFIG_CRAMFS=m
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+CONFIG_ROMFS_FS=m
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 # CONFIG_NFSD_V3_ACL is not set
 # CONFIG_NFSD_V4 is not set
-CONFIG_NFSD_TCP=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
@@ -1040,47 +1062,38 @@ CONFIG_SUNRPC=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
 
 #
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE="mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
+# CONFIG_SAMPLES is not set
+CONFIG_CMDLINE="cca=3 mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
 
 #
 # Security options
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 # CONFIG_CRYPTO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
