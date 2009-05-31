Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:30:55 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34590 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024262AbZEaSas (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:30:48 +0100
Received: by ewy19 with SMTP id 19so7634149ewy.0
        for <multiple recipients>; Sun, 31 May 2009 11:30:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5agofXt0yYUfqss3VP03mqkNAUDLdh4Rue6YnQMeRF4=;
        b=BQFqjy4peidm3szTHOkZyza2QaM5XP4mq0J1QoJTzRi0NGS0dJniL1ZC4R6q2Vht/g
         ebFNzIIx9214BgjPH8sGoIZ8FbnZ+ymwPAyEB2Q1EWWW5zx5aqZe/WpyMbev7qmPiAvj
         RYd/B4R4yjCK6nxy4u3th3R6esnmHbPj3/g2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=r5+KEOa505b0k0T4vkudElsihdZEA/PXXzuwmGcZ9oDLoD+0LK/F/k5q+3rXdu2K1J
         3D+yGCO133p5/WFsg6aM+X3Mz/rDGXlKIA7QoBHrgDihfuqXSSc5phyWOA+6j0hHIvWr
         Y0rDyvDL+ceec3iL27dbRYuLoq85fvOiQfkmY=
Received: by 10.210.59.14 with SMTP id h14mr2991561eba.82.1243794642671;
        Sun, 31 May 2009 11:30:42 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 10sm6238409eyz.11.2009.05.31.11.30.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:30:42 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:30:38 +0200
Subject: [PATCH 08/10] bcm63xx: update defconfig with gpiolib
MIME-Version: 1.0
X-UID:	140
X-Length: 14322
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312030.38974.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch updates the bcm63xx defconfig now that we
have added gpiolib support to the kernel.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/configs/bcm63xx_defconfig b/arch/mips/configs/bcm63xx_defconfig
index 74a358b..fc99a10 100644
--- a/arch/mips/configs/bcm63xx_defconfig
+++ b/arch/mips/configs/bcm63xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27
-# Fri Oct 17 18:35:02 2008
+# Linux kernel version: 2.6.30-rc6
+# Sun May 31 19:34:53 2009
 #
 CONFIG_MIPS=y
 
@@ -19,8 +19,10 @@ CONFIG_BCM63XX=y
 # CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MARKEINS is not set
+# CONFIG_NEC_MARKEINS is not set
 # CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
 # CONFIG_PMC_MSP is not set
@@ -42,6 +44,8 @@ CONFIG_BCM63XX=y
 # CONFIG_MACH_TX49XX is not set
 # CONFIG_MIKROTIK_RB532 is not set
 # CONFIG_WR_PPMC is not set
+# CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
+# CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
 
 #
 # CPU support
@@ -59,9 +63,11 @@ CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CMOS_UPDATE=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
 CONFIG_CEVT_R4K=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
@@ -93,6 +99,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -100,6 +107,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
@@ -115,6 +123,7 @@ CONFIG_32BIT=y
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_32KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
@@ -135,10 +144,12 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 # CONFIG_HIGH_RES_TIMERS is not set
@@ -175,10 +186,19 @@ CONFIG_LOCALVERSION=""
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=17
-# CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
@@ -190,12 +210,12 @@ CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 # CONFIG_PCSPKR_PLATFORM is not set
-CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
 # CONFIG_EPOLL is not set
@@ -205,21 +225,21 @@ CONFIG_BASE_FULL=y
 # CONFIG_SHMEM is not set
 # CONFIG_AIO is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_PCI_QUIRKS=y
 # CONFIG_SLUB_DEBUG is not set
+CONFIG_COMPAT_BRK=y
 # CONFIG_SLAB is not set
 CONFIG_SLUB=y
 # CONFIG_SLOB is not set
 # CONFIG_PROFILING is not set
 # CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
+# CONFIG_SLOW_WORK is not set
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
-CONFIG_TINY_SHMEM=y
 CONFIG_BASE_SMALL=0
 # CONFIG_MODULES is not set
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -235,7 +255,7 @@ CONFIG_IOSCHED_NOOP=y
 # CONFIG_DEFAULT_CFQ is not set
 CONFIG_DEFAULT_NOOP=y
 CONFIG_DEFAULT_IOSCHED="noop"
-CONFIG_CLASSIC_RCU=y
+# CONFIG_FREEZER is not set
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
@@ -245,6 +265,8 @@ CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 # CONFIG_PCI_LEGACY is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
 CONFIG_MMU=y
 CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
@@ -266,6 +288,7 @@ CONFIG_PCMCIA_BCM63XX=y
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_HAVE_AOUT is not set
 # CONFIG_BINFMT_MISC is not set
 CONFIG_TRAD_SIGNALS=y
@@ -324,7 +347,9 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
 # CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
 
 #
 # Network testing
@@ -335,8 +360,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
-# CONFIG_PHONET is not set
 # CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
 
@@ -407,9 +432,7 @@ CONFIG_MTD_CFI_UTIL=y
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_PHYSMAP_START=0x8000000
-CONFIG_MTD_PHYSMAP_LEN=0
-CONFIG_MTD_PHYSMAP_BANKWIDTH=2
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
 # CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
@@ -432,6 +455,11 @@ CONFIG_MTD_PHYSMAP_BANKWIDTH=2
 # CONFIG_MTD_ONENAND is not set
 
 #
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
 # UBI - Unsorted block images
 #
 # CONFIG_MTD_UBI is not set
@@ -463,6 +491,7 @@ CONFIG_HAVE_IDE=y
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
+CONFIG_COMPAT_NET_DEV_OPS=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
@@ -486,6 +515,9 @@ CONFIG_PHYLIB=y
 CONFIG_BCM63XX_PHY=y
 # CONFIG_ICPLUS_PHY is not set
 # CONFIG_REALTEK_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_LSI_ET1011C_PHY is not set
 # CONFIG_FIXED_PHY is not set
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
@@ -495,7 +527,10 @@ CONFIG_MII=y
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_SMC91X is not set
 # CONFIG_DM9000 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
@@ -518,7 +553,10 @@ CONFIG_BCM63XX_ENET=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
-# CONFIG_IWLWIFI_LEDS is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
 
 #
 # USB Network Adapters
@@ -592,17 +630,37 @@ CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 # CONFIG_SPI is not set
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_GPIO_SYSFS is not set
+
+#
+# Memory mapped GPIO expanders:
+#
+
+#
+# I2C GPIO expanders:
+#
+
+#
+# PCI GPIO expanders:
+#
+# CONFIG_GPIO_BT8XX is not set
+
+#
+# SPI GPIO expanders:
+#
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
 # CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
 # Sonics Silicon Backplane
 #
-CONFIG_SSB_POSSIBLE=y
 # CONFIG_SSB is not set
 
 #
@@ -611,9 +669,8 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
-# CONFIG_UCB1400_CORE is not set
 # CONFIG_MFD_TMIO is not set
-# CONFIG_MFD_WM8400 is not set
+# CONFIG_REGULATOR is not set
 
 #
 # Multimedia devices
@@ -667,6 +724,8 @@ CONFIG_USB=y
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 # CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
 
 #
 # USB Host Controller Drivers
@@ -676,6 +735,7 @@ CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
+# CONFIG_USB_OXU210HP_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_ISP1760_HCD is not set
 CONFIG_USB_OHCI_HCD=y
@@ -685,6 +745,8 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_UHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
 # CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_WHCI_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
 # USB Device Class drivers
@@ -692,13 +754,14 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
 # CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
 
 #
-# may also be needed; see USB_STORAGE Help for more information
+# also be needed; see USB_STORAGE Help for more info
 #
 # CONFIG_USB_LIBUSUAL is not set
 
@@ -718,6 +781,7 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
 # CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
@@ -725,7 +789,6 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
 # CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
@@ -734,7 +797,15 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
 # CONFIG_USB_GADGET is not set
+
+#
+# OTG and related infrastructure
+#
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+# CONFIG_UWB is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
@@ -743,7 +814,9 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
+# CONFIG_STAGING is not set
 
 #
 # File systems
@@ -757,6 +830,7 @@ CONFIG_RTC_LIB=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY is not set
 # CONFIG_QUOTA is not set
@@ -765,6 +839,11 @@ CONFIG_RTC_LIB=y
 # CONFIG_FUSE_FS is not set
 
 #
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 # CONFIG_ISO9660_FS is not set
@@ -789,10 +868,7 @@ CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 # CONFIG_CONFIGFS_FS is not set
-
-#
-# Miscellaneous filesystems
-#
+CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
 # CONFIG_HFS_FS is not set
@@ -802,6 +878,7 @@ CONFIG_TMPFS=y
 # CONFIG_EFS_FS is not set
 # CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_OMFS_FS is not set
@@ -810,6 +887,7 @@ CONFIG_TMPFS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
 
 #
@@ -836,7 +914,20 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_MEMORY_INIT is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
-# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
+CONFIG_TRACING_SUPPORT=y
+
+#
+# Tracers
+#
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_EVENT_TRACER is not set
+# CONFIG_BOOT_TRACER is not set
+# CONFIG_TRACE_BRANCH_PROFILING is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 CONFIG_CMDLINE="console=ttyS0,115200"
@@ -849,11 +940,13 @@ CONFIG_CMDLINE="console=ttyS0,115200"
 # CONFIG_SECURITYFS is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 # CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_T10DIF is not set
@@ -864,3 +957,4 @@ CONFIG_CRC32=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
