Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2010 11:42:54 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:46191 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491818Ab0CYKmp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Mar 2010 11:42:45 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id BD3A434181AA;
        Thu, 25 Mar 2010 11:42:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kg1Z8NXT7mGT; Thu, 25 Mar 2010 11:42:44 +0100 (CET)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id F19493418193;
        Thu, 25 Mar 2010 11:42:43 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
Date:   Thu, 25 Mar 2010 11:42:22 +0100
Subject: [PATCH 1/2] bcm63xx: update defconfig
MIME-Version: 1.0
X-UID:  26408
X-Length: 23756
Organization: Freebox
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003251142.22455.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

The defconfig was out-of-sync since 2.6.30-rc6, update it with the new symbols
enable BCM6338, 6345, wireless, b43 driver and LEDs support.

Signed-off-by:  Fainelli <ffainelli@freebox.fr>
---
diff --git a/arch/mips/configs/bcm63xx_defconfig b/arch/mips/configs/bcm63xx_defconfig
index 7fee027..6389ca0 100644
--- a/arch/mips/configs/bcm63xx_defconfig
+++ b/arch/mips/configs/bcm63xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.30-rc6
-# Sun May 31 20:17:18 2009
+# Linux kernel version: 2.6.34-rc2
+# Tue Mar 23 10:36:32 2010
 #
 CONFIG_MIPS=y
 
@@ -9,13 +9,14 @@ CONFIG_MIPS=y
 # Machine selection
 #
 # CONFIG_MACH_ALCHEMY is not set
+# CONFIG_AR7 is not set
 # CONFIG_BCM47XX is not set
 CONFIG_BCM63XX=y
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
 # CONFIG_LASAT is not set
-# CONFIG_LEMOTE_FULONG is not set
+# CONFIG_MACH_LOONGSON is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SIM is not set
 # CONFIG_NEC_MARKEINS is not set
@@ -26,6 +27,7 @@ CONFIG_BCM63XX=y
 # CONFIG_PNX8550_STB810 is not set
 # CONFIG_PMC_MSP is not set
 # CONFIG_PMC_YOSEMITE is not set
+# CONFIG_POWERTV is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
 # CONFIG_SGI_IP28 is not set
@@ -45,13 +47,17 @@ CONFIG_BCM63XX=y
 # CONFIG_WR_PPMC is not set
 # CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
 # CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
 
 #
 # CPU support
 #
+CONFIG_BCM63XX_CPU_6338=y
+CONFIG_BCM63XX_CPU_6345=y
 CONFIG_BCM63XX_CPU_6348=y
 CONFIG_BCM63XX_CPU_6358=y
 CONFIG_BOARD_BCM963XX=y
+CONFIG_LOONGSON_UART_BASE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -69,10 +75,8 @@ CONFIG_CEVT_R4K=y
 CONFIG_CSRC_R4K_LIB=y
 CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
-CONFIG_DMA_NEED_PCI_MAP_STATE=y
-CONFIG_EARLY_PRINTK=y
+CONFIG_NEED_DMA_MAP_STATE=y
 CONFIG_SYS_HAS_EARLY_PRINTK=y
-# CONFIG_HOTPLUG_CPU is not set
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_GPIO=y
 CONFIG_CPU_BIG_ENDIAN=y
@@ -85,7 +89,8 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 #
 # CPU selection
 #
-# CONFIG_CPU_LOONGSON2 is not set
+# CONFIG_CPU_LOONGSON2E is not set
+# CONFIG_CPU_LOONGSON2F is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -128,7 +133,7 @@ CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
-CONFIG_CPU_HAS_LLSC=y
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -146,9 +151,8 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_UNEVICTABLE_LRU=y
-CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 # CONFIG_HIGH_RES_TIMERS is not set
@@ -170,6 +174,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -189,15 +194,12 @@ CONFIG_LOCALVERSION=""
 #
 # RCU Subsystem
 #
-CONFIG_CLASSIC_RCU=y
 # CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_PREEMPT_RCU is not set
+CONFIG_TINY_RCU=y
 # CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=17
-# CONFIG_GROUP_SCHED is not set
-# CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
@@ -205,11 +207,11 @@ CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_BLK_DEV_INITRD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
@@ -223,6 +225,10 @@ CONFIG_BASE_FULL=y
 # CONFIG_EVENTFD is not set
 # CONFIG_SHMEM is not set
 # CONFIG_AIO is not set
+
+#
+# Kernel Performance Events And Counters
+#
 # CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_PCI_QUIRKS=y
 # CONFIG_SLUB_DEBUG is not set
@@ -231,14 +237,17 @@ CONFIG_COMPAT_BRK=y
 CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
-# CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
+
+#
+# GCOV-based kernel profiling
+#
 # CONFIG_SLOW_WORK is not set
-# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_BASE_SMALL=0
 # CONFIG_MODULES is not set
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -246,14 +255,41 @@ CONFIG_BLOCK=y
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-# CONFIG_IOSCHED_AS is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-# CONFIG_DEFAULT_AS is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 # CONFIG_DEFAULT_CFQ is not set
 CONFIG_DEFAULT_NOOP=y
 CONFIG_DEFAULT_IOSCHED="noop"
+# CONFIG_INLINE_SPIN_TRYLOCK is not set
+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK is not set
+# CONFIG_INLINE_SPIN_LOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
+CONFIG_INLINE_SPIN_UNLOCK=y
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+CONFIG_INLINE_READ_UNLOCK=y
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+CONFIG_INLINE_WRITE_UNLOCK=y
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
 # CONFIG_FREEZER is not set
 
 #
@@ -263,15 +299,12 @@ CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-# CONFIG_PCI_LEGACY is not set
 # CONFIG_PCI_STUB is not set
 # CONFIG_PCI_IOV is not set
 CONFIG_MMU=y
 CONFIG_PCCARD=y
-# CONFIG_PCMCIA_DEBUG is not set
 CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
-CONFIG_PCMCIA_IOCTL=y
 CONFIG_CARDBUS=y
 
 #
@@ -295,6 +328,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
 CONFIG_NET=y
@@ -333,6 +367,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -347,6 +382,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 # CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -359,7 +395,27 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_WIRELESS is not set
+CONFIG_WIRELESS=y
+CONFIG_WEXT_CORE=y
+CONFIG_WEXT_PROC=y
+CONFIG_CFG80211=y
+CONFIG_NL80211_TESTMODE=y
+# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
+# CONFIG_CFG80211_REG_DEBUG is not set
+CONFIG_CFG80211_DEFAULT_PS=y
+# CONFIG_CFG80211_INTERNAL_REGDB is not set
+CONFIG_CFG80211_WEXT=y
+CONFIG_WIRELESS_EXT_SYSFS=y
+# CONFIG_LIB80211 is not set
+CONFIG_MAC80211=y
+# CONFIG_MAC80211_RC_PID is not set
+CONFIG_MAC80211_RC_MINSTREL=y
+# CONFIG_MAC80211_RC_DEFAULT_PID is not set
+CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
+CONFIG_MAC80211_RC_DEFAULT="minstrel"
+# CONFIG_MAC80211_MESH is not set
+CONFIG_MAC80211_LEDS=y
+# CONFIG_MAC80211_DEBUG_MENU is not set
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
@@ -471,6 +527,7 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 # CONFIG_SCSI_DMA is not set
@@ -484,13 +541,16 @@ CONFIG_HAVE_IDE=y
 #
 
 #
-# Enable only one of the two stacks, unless you know what you are doing
+# You can enable one or both FireWire driver stacks.
+#
+
+#
+# The newer stack is recommended.
 #
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
-CONFIG_COMPAT_NET_DEV_OPS=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
@@ -529,6 +589,7 @@ CONFIG_MII=y
 # CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
 # CONFIG_ETHOC is not set
+# CONFIG_SMSC911X is not set
 # CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
@@ -541,17 +602,48 @@ CONFIG_MII=y
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_NET_PCI is not set
 # CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
 # CONFIG_ATL2 is not set
 CONFIG_BCM63XX_ENET=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
-
-#
-# Wireless LAN
-#
-# CONFIG_WLAN_PRE80211 is not set
-# CONFIG_WLAN_80211 is not set
+CONFIG_WLAN=y
+# CONFIG_PCMCIA_RAYCS is not set
+# CONFIG_LIBERTAS_THINFIRM is not set
+# CONFIG_ATMEL is not set
+# CONFIG_AT76C50X_USB is not set
+# CONFIG_AIRO_CS is not set
+# CONFIG_PCMCIA_WL3501 is not set
+# CONFIG_PRISM54 is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_USB_NET_RNDIS_WLAN is not set
+# CONFIG_RTL8180 is not set
+# CONFIG_RTL8187 is not set
+# CONFIG_ADM8211 is not set
+# CONFIG_MAC80211_HWSIM is not set
+# CONFIG_MWL8K is not set
+# CONFIG_ATH_COMMON is not set
+CONFIG_B43=y
+CONFIG_B43_PCI_AUTOSELECT=y
+CONFIG_B43_PCICORE_AUTOSELECT=y
+# CONFIG_B43_PCMCIA is not set
+CONFIG_B43_PIO=y
+# CONFIG_B43_PHY_LP is not set
+CONFIG_B43_LEDS=y
+# CONFIG_B43_DEBUG is not set
+# CONFIG_B43LEGACY is not set
+# CONFIG_HOSTAP is not set
+# CONFIG_IPW2100 is not set
+# CONFIG_IPW2200 is not set
+# CONFIG_IWLWIFI is not set
+# CONFIG_LIBERTAS is not set
+# CONFIG_HERMES is not set
+# CONFIG_P54_COMMON is not set
+# CONFIG_RT2X00 is not set
+# CONFIG_WL12XX is not set
+# CONFIG_ZD1211RW is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -574,6 +666,7 @@ CONFIG_BCM63XX_ENET=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_VMXNET3 is not set
 # CONFIG_ISDN is not set
 # CONFIG_PHONE is not set
 
@@ -607,6 +700,7 @@ CONFIG_BCM63XX_ENET=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_TIMBERDALE is not set
 CONFIG_SERIAL_BCM63XX=y
 CONFIG_SERIAL_BCM63XX_CONSOLE=y
 # CONFIG_UNIX98_PTYS is not set
@@ -629,6 +723,11 @@ CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
 # CONFIG_GPIO_SYSFS is not set
@@ -636,6 +735,8 @@ CONFIG_GPIOLIB=y
 #
 # Memory mapped GPIO expanders:
 #
+# CONFIG_GPIO_IT8761E is not set
+# CONFIG_GPIO_SCH is not set
 
 #
 # I2C GPIO expanders:
@@ -644,16 +745,21 @@ CONFIG_GPIOLIB=y
 #
 # PCI GPIO expanders:
 #
+# CONFIG_GPIO_CS5535 is not set
 # CONFIG_GPIO_BT8XX is not set
+# CONFIG_GPIO_LANGWELL is not set
 
 #
 # SPI GPIO expanders:
 #
+
+#
+# AC97 GPIO expanders:
+#
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
-# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
 
@@ -662,15 +768,16 @@ CONFIG_SSB_POSSIBLE=y
 #
 CONFIG_SSB=y
 CONFIG_SSB_SPROM=y
+CONFIG_SSB_BLOCKIO=y
 CONFIG_SSB_PCIHOST_POSSIBLE=y
 CONFIG_SSB_PCIHOST=y
-# CONFIG_SSB_B43_PCI_BRIDGE is not set
+CONFIG_SSB_B43_PCI_BRIDGE=y
 CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
 # CONFIG_SSB_PCMCIAHOST is not set
 # CONFIG_SSB_SILENT is not set
 # CONFIG_SSB_DEBUG is not set
 CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
-# CONFIG_SSB_DRIVER_PCICORE is not set
+CONFIG_SSB_DRIVER_PCICORE=y
 # CONFIG_SSB_DRIVER_MIPS is not set
 
 #
@@ -680,27 +787,15 @@ CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_TIMBERDALE is not set
+# CONFIG_LPC_SCH is not set
 # CONFIG_REGULATOR is not set
-
-#
-# Multimedia devices
-#
-
-#
-# Multimedia core support
-#
-# CONFIG_VIDEO_DEV is not set
-# CONFIG_DVB_CORE is not set
-# CONFIG_VIDEO_MEDIA is not set
-
-#
-# Multimedia drivers
-#
-# CONFIG_DAB is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
 #
+# CONFIG_VGA_ARB is not set
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
@@ -710,11 +805,7 @@ CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
 #
 # Display device support
 #
-CONFIG_DISPLAY_SUPPORT=y
-
-#
-# Display hardware drivers
-#
+# CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_SOUND is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -741,13 +832,14 @@ CONFIG_USB=y
 # USB Host Controller Drivers
 #
 # CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_XHCI_HCD is not set
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
-CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
 # CONFIG_USB_OXU210HP_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_ISP1362_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_HCD_SSB is not set
 CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
@@ -796,7 +888,6 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
-# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
@@ -807,8 +898,8 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
 # CONFIG_USB_ISIGHTFW is not set
-# CONFIG_USB_VST is not set
 # CONFIG_USB_GADGET is not set
 
 #
@@ -819,7 +910,29 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_UWB is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_GPIO_PLATFORM=y
+# CONFIG_LEDS_LT3593 is not set
+CONFIG_LEDS_TRIGGERS=y
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGER_TIMER=y
+# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
+# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+
+#
+# iptables trigger is under Netfilter config (LED target)
+#
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
@@ -827,6 +940,10 @@ CONFIG_RTC_LIB=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
 # CONFIG_STAGING is not set
 
 #
@@ -838,12 +955,16 @@ CONFIG_RTC_LIB=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
-# CONFIG_FILE_LOCKING is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+# CONFIG_FILE_LOCKING is not set
+CONFIG_FSNOTIFY=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY is not set
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
@@ -875,8 +996,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SYSFS=y
-CONFIG_TMPFS=y
-# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 # CONFIG_CONFIGFS_FS is not set
 CONFIG_MISC_FILESYSTEMS=y
@@ -888,6 +1007,7 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
 # CONFIG_JFFS2_FS is not set
+# CONFIG_LOGFS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -898,7 +1018,6 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
 
 #
@@ -906,7 +1025,46 @@ CONFIG_MISC_FILESYSTEMS=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-# CONFIG_NLS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
 # CONFIG_DLM is not set
 
 #
@@ -918,29 +1076,23 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_DEBUG_MEMORY_INIT is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
 CONFIG_TRACING_SUPPORT=y
-
-#
-# Tracers
-#
-# CONFIG_IRQSOFF_TRACER is not set
-# CONFIG_SCHED_TRACER is not set
-# CONFIG_CONTEXT_SWITCH_TRACER is not set
-# CONFIG_EVENT_TRACER is not set
-# CONFIG_BOOT_TRACER is not set
-# CONFIG_TRACE_BRANCH_PROFILING is not set
-# CONFIG_KMEMTRACE is not set
-# CONFIG_WORKQUEUE_TRACER is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_FTRACE is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
+CONFIG_EARLY_PRINTK=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200"
 # CONFIG_CMDLINE_OVERRIDE is not set
@@ -951,8 +1103,108 @@ CONFIG_CMDLINE="console=ttyS0,115200"
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITYFS is not set
-# CONFIG_SECURITY_FILE_CAPABILITIES is not set
-# CONFIG_CRYPTO is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=y
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_GHASH is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+CONFIG_CRYPTO_AES=y
+# CONFIG_CRYPTO_ANUBIS is not set
+CONFIG_CRYPTO_ARC4=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+CONFIG_CRYPTO_ANSI_CPRNG=y
+# CONFIG_CRYPTO_HW is not set
 # CONFIG_BINARY_PRINTF is not set
 
 #
