Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2008 16:31:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:39132 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20026572AbYGJPbl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Jul 2008 16:31:41 +0100
Received: from localhost (p7221-ipad210funabasi.chiba.ocn.ne.jp [58.88.126.221])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 15708AABB; Fri, 11 Jul 2008 00:31:36 +0900 (JST)
Date:	Fri, 11 Jul 2008 00:33:21 +0900 (JST)
Message-Id: <20080711.003321.48796009.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 3/3] update txx9 defconfigs
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/configs/jmr3927_defconfig   |  180 ++++++++++++++++++++-----------
 arch/mips/configs/rbhma4200_defconfig |  153 +++++++++++++++----------
 arch/mips/configs/rbhma4500_defconfig |  196 ++++++++++++++++++++++-----------
 3 files changed, 340 insertions(+), 189 deletions(-)

diff --git a/arch/mips/configs/jmr3927_defconfig b/arch/mips/configs/jmr3927_defconfig
index 92000a3..ab16e67 100644
--- a/arch/mips/configs/jmr3927_defconfig
+++ b/arch/mips/configs/jmr3927_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc1
-# Thu Aug  2 23:07:36 2007
+# Linux kernel version: 2.6.26-rc9
+# Fri Jul 11 00:25:19 2008
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
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SIM is not set
@@ -24,6 +26,7 @@ CONFIG_MIPS=y
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
 # CONFIG_SGI_IP32 is not set
 # CONFIG_SIBYTE_CRHINE is not set
 # CONFIG_SIBYTE_CARMEL is not set
@@ -38,18 +41,27 @@ CONFIG_TOSHIBA_JMR3927=y
 # CONFIG_TOSHIBA_RBTX4927 is not set
 # CONFIG_TOSHIBA_RBTX4938 is not set
 # CONFIG_WR_PPMC is not set
+# CONFIG_TOSHIBA_FPCIB0 is not set
+CONFIG_PICMG_PCI_BACKPLANE_DEFAULT=y
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
+CONFIG_CEVT_TXX9=y
+CONFIG_GPIO_TXX9=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_HOTPLUG_CPU is not set
 # CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 CONFIG_CPU_BIG_ENDIAN=y
 # CONFIG_CPU_LITTLE_ENDIAN is not set
 CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
@@ -102,13 +114,20 @@ CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
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
@@ -142,18 +161,25 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 # CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 # CONFIG_HOTPLUG is not set
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
@@ -166,6 +192,14 @@ CONFIG_VM_EVENT_COUNTERS=y
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
@@ -187,20 +221,19 @@ CONFIG_IOSCHED_CFQ=y
 CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="cfq"
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
 
 #
-# PCCARD (PCMCIA/CardBus) support
-#
-
-#
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
@@ -210,6 +243,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
 
 #
@@ -243,25 +277,21 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
+# CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -269,6 +299,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 
@@ -277,6 +308,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_CFG80211 is not set
 # CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
 
@@ -305,6 +337,7 @@ CONFIG_BLK_DEV=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
@@ -316,10 +349,6 @@ CONFIG_BLK_DEV=y
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
 
 #
@@ -327,7 +356,7 @@ CONFIG_BLK_DEV=y
 #
 
 #
-# An alternative FireWire stack is available with EXPERIMENTAL=y
+# A new alternative FireWire stack is available with EXPERIMENTAL=y
 #
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
@@ -337,10 +366,27 @@ CONFIG_NETDEVICES=y
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
-# CONFIG_PHYLIB is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
+# CONFIG_MII is not set
 # CONFIG_AX88796 is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
@@ -349,6 +395,10 @@ CONFIG_MII=y
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
@@ -356,13 +406,13 @@ CONFIG_NET_PCI=y
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
 CONFIG_TC35815=y
-# CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
 # CONFIG_8139TOO is not set
+# CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -377,6 +427,7 @@ CONFIG_TC35815=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_PPP is not set
@@ -398,7 +449,6 @@ CONFIG_INPUT=y
 #
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
 
@@ -422,6 +472,7 @@ CONFIG_INPUT=y
 # Character devices
 #
 # CONFIG_VT is not set
+CONFIG_DEVKMEM=y
 CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_COMPUTONE is not set
 # CONFIG_ROCKETPORT is not set
@@ -429,7 +480,6 @@ CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_DIGIEPCA is not set
 # CONFIG_MOXA_INTELLIO is not set
 # CONFIG_MOXA_SMARTIO is not set
-# CONFIG_MOXA_SMARTIO_NEW is not set
 # CONFIG_ISI is not set
 # CONFIG_SYNCLINKMP is not set
 # CONFIG_SYNCLINK_GT is not set
@@ -461,22 +511,30 @@ CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
+# CONFIG_SPI is not set
+CONFIG_HAVE_GPIO_LIB=y
 
 #
-# SPI support
+# GPIO Support
+#
+
+#
+# I2C GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
 CONFIG_WATCHDOG=y
 # CONFIG_WATCHDOG_NOWAYOUT is not set
 
@@ -493,29 +551,46 @@ CONFIG_TXX9_WDT=y
 # CONFIG_WDTPCI is not set
 
 #
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
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
+# CONFIG_VIDEO_MEDIA is not set
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
 # Sound
@@ -524,7 +599,9 @@ CONFIG_TXX9_WDT=y
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
@@ -549,9 +626,10 @@ CONFIG_RTC_INTF_DEV=y
 # Platform RTC drivers
 #
 # CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
-# CONFIG_RTC_DRV_STK17TA8 is not set
 CONFIG_RTC_DRV_DS1742=y
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
@@ -559,23 +637,6 @@ CONFIG_RTC_DRV_DS1742=y
 #
 # on-CPU RTC drivers
 #
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
@@ -588,12 +649,10 @@ CONFIG_RTC_DRV_DS1742=y
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
@@ -620,7 +679,7 @@ CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 # CONFIG_TMPFS is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -628,17 +687,15 @@ CONFIG_RAMFS=y
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
-# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
@@ -654,10 +711,6 @@ CONFIG_SUNRPC=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
 
 #
@@ -665,13 +718,15 @@ CONFIG_MSDOS_PARTITION=y
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
+# CONFIG_SAMPLES is not set
 CONFIG_CMDLINE=""
 
 #
@@ -685,6 +740,7 @@ CONFIG_CMDLINE=""
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
diff --git a/arch/mips/configs/rbhma4200_defconfig b/arch/mips/configs/rbhma4200_defconfig
index f89482a..e0af6a9 100644
--- a/arch/mips/configs/rbhma4200_defconfig
+++ b/arch/mips/configs/rbhma4200_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc1
-# Thu Aug  2 22:55:57 2007
+# Linux kernel version: 2.6.26-rc9
+# Thu Jul 10 23:52:40 2008
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
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SIM is not set
@@ -24,6 +26,7 @@ CONFIG_MIPS=y
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
 # CONFIG_SGI_IP32 is not set
 # CONFIG_SIBYTE_CRHINE is not set
 # CONFIG_SIBYTE_CARMEL is not set
@@ -39,17 +42,26 @@ CONFIG_TOSHIBA_RBTX4927=y
 # CONFIG_TOSHIBA_RBTX4938 is not set
 # CONFIG_WR_PPMC is not set
 # CONFIG_TOSHIBA_FPCIB0 is not set
+CONFIG_PICMG_PCI_BACKPLANE_DEFAULT=y
+CONFIG_PCI_TX4927=y
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
+CONFIG_CEVT_TXX9=y
+CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_HOTPLUG_CPU is not set
 # CONFIG_NO_IOPORT is not set
 CONFIG_CPU_BIG_ENDIAN=y
 # CONFIG_CPU_LITTLE_ENDIAN is not set
@@ -107,13 +119,20 @@ CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
@@ -148,19 +167,26 @@ CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 # CONFIG_HOTPLUG is not set
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 CONFIG_ANON_INODES=y
@@ -173,9 +199,18 @@ CONFIG_VM_EVENT_COUNTERS=y
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
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 # CONFIG_MODULE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
@@ -197,20 +232,19 @@ CONFIG_DEFAULT_AS=y
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
+# CONFIG_PCI_LEGACY is not set
 CONFIG_MMU=y
 
 #
-# PCCARD (PCMCIA/CardBus) support
-#
-
-#
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
@@ -220,6 +254,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
 
 #
@@ -254,26 +289,22 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
+# CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -281,6 +312,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 
@@ -289,6 +321,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_CFG80211 is not set
 # CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
 
@@ -317,10 +350,11 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
@@ -332,10 +366,6 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
 
 #
@@ -343,7 +373,7 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 
 #
-# An alternative FireWire stack is available with EXPERIMENTAL=y
+# A new alternative FireWire stack is available with EXPERIMENTAL=y
 #
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
@@ -353,6 +383,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
@@ -366,7 +397,12 @@ CONFIG_NET_ETHERNET=y
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 CONFIG_NE2000=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 # CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
@@ -376,6 +412,7 @@ CONFIG_NE2000=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_PPP is not set
@@ -405,6 +442,7 @@ CONFIG_SERIO_LIBPS2=y
 # Character devices
 #
 # CONFIG_VT is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -428,22 +466,17 @@ CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
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
+# CONFIG_THERMAL_HWMON is not set
 CONFIG_WATCHDOG=y
 # CONFIG_WATCHDOG_NOWAYOUT is not set
 
@@ -451,7 +484,7 @@ CONFIG_WATCHDOG=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-CONFIG_TXX9_WDT=m
+CONFIG_TXX9_WDT=y
 
 #
 # PCI-based Watchdog Cards
@@ -460,29 +493,46 @@ CONFIG_TXX9_WDT=m
 # CONFIG_WDTPCI is not set
 
 #
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
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
+# CONFIG_VIDEO_MEDIA is not set
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
 # Sound
@@ -490,7 +540,9 @@ CONFIG_TXX9_WDT=m
 # CONFIG_SOUND is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
@@ -515,9 +567,10 @@ CONFIG_RTC_INTF_DEV=y
 # Platform RTC drivers
 #
 # CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
-# CONFIG_RTC_DRV_STK17TA8 is not set
 CONFIG_RTC_DRV_DS1742=y
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
@@ -525,23 +578,6 @@ CONFIG_RTC_DRV_DS1742=y
 #
 # on-CPU RTC drivers
 #
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
@@ -554,12 +590,10 @@ CONFIG_RTC_DRV_DS1742=y
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_DNOTIFY is not set
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-# CONFIG_DNOTIFY is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
@@ -588,7 +622,7 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -596,18 +630,16 @@ CONFIG_RAMFS=y
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
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
-# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
@@ -624,10 +656,6 @@ CONFIG_SUNRPC=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
 
 #
@@ -635,13 +663,15 @@ CONFIG_MSDOS_PARTITION=y
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
+# CONFIG_SAMPLES is not set
 CONFIG_CMDLINE=""
 CONFIG_SYS_SUPPORTS_KGDB=y
 
@@ -656,6 +686,7 @@ CONFIG_SYS_SUPPORTS_KGDB=y
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index 70cf697..50aa1b6 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc1
-# Thu Aug  2 22:59:53 2007
+# Linux kernel version: 2.6.26-rc9
+# Thu Jul 10 23:53:27 2008
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
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SIM is not set
@@ -24,6 +26,7 @@ CONFIG_MIPS=y
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
 # CONFIG_SGI_IP32 is not set
 # CONFIG_SIBYTE_CRHINE is not set
 # CONFIG_SIBYTE_CARMEL is not set
@@ -38,6 +41,8 @@ CONFIG_MIPS=y
 # CONFIG_TOSHIBA_RBTX4927 is not set
 CONFIG_TOSHIBA_RBTX4938=y
 # CONFIG_WR_PPMC is not set
+# CONFIG_TOSHIBA_FPCIB0 is not set
+CONFIG_PICMG_PCI_BACKPLANE_DEFAULT=y
 
 #
 # Multiplex Pin Select
@@ -45,21 +50,30 @@ CONFIG_TOSHIBA_RBTX4938=y
 CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61=y
 # CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND is not set
 # CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA is not set
+CONFIG_PCI_TX4927=y
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
+CONFIG_CEVT_TXX9=y
+CONFIG_CSRC_R4K=y
+CONFIG_GPIO_TXX9=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_HOTPLUG_CPU is not set
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_GPIO=y
-# CONFIG_CPU_BIG_ENDIAN is not set
-CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_BIG_ENDIAN=y
+# CONFIG_CPU_LITTLE_ENDIAN is not set
 CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
 CONFIG_IRQ_CPU=y
@@ -113,13 +127,20 @@ CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
@@ -154,19 +175,26 @@ CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 # CONFIG_HOTPLUG is not set
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 CONFIG_ANON_INODES=y
@@ -179,9 +207,18 @@ CONFIG_VM_EVENT_COUNTERS=y
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
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 # CONFIG_MODULE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
@@ -203,20 +240,19 @@ CONFIG_DEFAULT_AS=y
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
+# CONFIG_PCI_LEGACY is not set
 CONFIG_MMU=y
 
 #
-# PCCARD (PCMCIA/CardBus) support
-#
-
-#
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
@@ -226,6 +262,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
 
 #
@@ -260,26 +297,22 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
+# CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
 # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -287,6 +320,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 
@@ -295,6 +329,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_CFG80211 is not set
 # CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
 
@@ -323,10 +358,11 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
@@ -338,10 +374,6 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
 
 #
@@ -349,7 +381,7 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 
 #
-# An alternative FireWire stack is available with EXPERIMENTAL=y
+# A new alternative FireWire stack is available with EXPERIMENTAL=y
 #
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
@@ -359,10 +391,27 @@ CONFIG_NETDEVICES=y
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
-# CONFIG_PHYLIB is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
+# CONFIG_MII is not set
 # CONFIG_AX88796 is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
@@ -372,6 +421,10 @@ CONFIG_MII=y
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 CONFIG_NE2000=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
 # CONFIG_AMD8111_ETH is not set
@@ -379,13 +432,13 @@ CONFIG_NET_PCI=y
 # CONFIG_B44 is not set
 # CONFIG_FORCEDETH is not set
 CONFIG_TC35815=y
-# CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 # CONFIG_E100 is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
 # CONFIG_8139TOO is not set
+# CONFIG_R6040 is not set
 # CONFIG_SIS900 is not set
 # CONFIG_EPIC100 is not set
 # CONFIG_SUNDANCE is not set
@@ -400,6 +453,7 @@ CONFIG_TC35815=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_PPP is not set
@@ -424,6 +478,7 @@ CONFIG_TC35815=y
 # Character devices
 #
 # CONFIG_VT is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -447,17 +502,11 @@ CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
-
-#
-# SPI support
-#
 CONFIG_SPI=y
 CONFIG_SPI_MASTER=y
 
@@ -471,9 +520,25 @@ CONFIG_SPI_TXX9=y
 #
 CONFIG_SPI_AT25=y
 # CONFIG_SPI_TLE62X0 is not set
+CONFIG_HAVE_GPIO_LIB=y
+
+#
+# GPIO Support
+#
+
+#
+# I2C GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
+#
+# CONFIG_GPIO_MCP23S08 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
 CONFIG_WATCHDOG=y
 # CONFIG_WATCHDOG_NOWAYOUT is not set
 
@@ -490,29 +555,46 @@ CONFIG_TXX9_WDT=m
 # CONFIG_WDTPCI is not set
 
 #
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
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
+# CONFIG_VIDEO_MEDIA is not set
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
 # Sound
@@ -520,7 +602,9 @@ CONFIG_TXX9_WDT=m
 # CONFIG_SOUND is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
@@ -540,16 +624,18 @@ CONFIG_RTC_INTF_DEV_UIE_EMUL=y
 #
 # SPI RTC drivers
 #
-CONFIG_RTC_DRV_RS5C348=y
 # CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+CONFIG_RTC_DRV_RS5C348=y
 
 #
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
@@ -557,23 +643,6 @@ CONFIG_RTC_DRV_RS5C348=y
 #
 # on-CPU RTC drivers
 #
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
@@ -586,12 +655,10 @@ CONFIG_RTC_DRV_RS5C348=y
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_DNOTIFY is not set
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-# CONFIG_DNOTIFY is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
@@ -620,7 +687,7 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -628,18 +695,16 @@ CONFIG_RAMFS=y
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
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
-# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
@@ -656,10 +721,6 @@ CONFIG_SUNRPC=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
 
 #
@@ -667,13 +728,15 @@ CONFIG_MSDOS_PARTITION=y
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_CROSSCOMPILE=y
+# CONFIG_SAMPLES is not set
 CONFIG_CMDLINE=""
 CONFIG_SYS_SUPPORTS_KGDB=y
 
@@ -688,6 +751,7 @@ CONFIG_SYS_SUPPORTS_KGDB=y
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
