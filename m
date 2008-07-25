Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 17:35:05 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:2068 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28580101AbYGYQfB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 17:35:01 +0100
Received: by mo.po.2iij.net (mo30) id m6PGYubv075993; Sat, 26 Jul 2008 01:34:56 +0900 (JST)
Received: from delta (16.26.30.125.dy.iij4u.or.jp [125.30.26.16])
	by mbox.po.2iij.net (po-mbox301) id m6PGYq6k009771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 26 Jul 2008 01:34:52 +0900
Date:	Sat, 26 Jul 2008 01:34:52 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] update cobalt_defconfig
Message-Id: <20080726013452.01600261.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Select new LCD framebuffer driver.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/configs/cobalt_defconfig linux/arch/mips/configs/cobalt_defconfig
--- linux-orig/arch/mips/configs/cobalt_defconfig	2008-07-25 09:55:54.477677831 +0900
+++ linux/arch/mips/configs/cobalt_defconfig	2008-07-25 14:44:40.674883873 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc5
-# Thu Sep  6 13:14:29 2007
+# Linux kernel version: 2.6.26
+# Fri Jul 25 10:25:34 2008
 #
 CONFIG_MIPS=y
 
@@ -10,9 +10,11 @@ CONFIG_MIPS=y
 #
 # CONFIG_MACH_ALCHEMY is not set
 # CONFIG_BASLER_EXCITE is not set
+# CONFIG_BCM47XX is not set
 CONFIG_MIPS_COBALT=y
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
 # CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SIM is not set
@@ -24,6 +26,7 @@ CONFIG_MIPS_COBALT=y
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
 # CONFIG_SGI_IP32 is not set
 # CONFIG_SIBYTE_CRHINE is not set
 # CONFIG_SIBYTE_CARMEL is not set
@@ -34,19 +37,25 @@ CONFIG_MIPS_COBALT=y
 # CONFIG_SIBYTE_SENTOSA is not set
 # CONFIG_SIBYTE_BIGSUR is not set
 # CONFIG_SNI_RM is not set
-# CONFIG_TOSHIBA_JMR3927 is not set
-# CONFIG_TOSHIBA_RBTX4927 is not set
-# CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_MACH_TX39XX is not set
+# CONFIG_MACH_TX49XX is not set
+# CONFIG_MIKROTIK_RB532 is not set
 # CONFIG_WR_PPMC is not set
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
+CONFIG_CEVT_GT641XX=y
+CONFIG_CEVT_R4K=y
+CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_EARLY_PRINTK=y
@@ -108,6 +117,7 @@ CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -115,10 +125,16 @@ CONFIG_FLATMEM_MANUAL=y
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
@@ -151,23 +167,28 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_CGROUPS is not set
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 CONFIG_RELAY=y
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
+CONFIG_PCSPKR_PLATFORM=y
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
@@ -177,23 +198,37 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_IOREMAP_PROT is not set
+# CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+# CONFIG_HAVE_DMA_ATTRS is not set
+# CONFIG_USE_GENERIC_SMP_HELPERS is not set
+# CONFIG_HAVE_CLK is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
-# CONFIG_KMOD is not set
+CONFIG_KMOD=y
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
 # CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
 # IO Schedulers
@@ -207,18 +242,18 @@ CONFIG_DEFAULT_AS=y
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
+CONFIG_I8253=y
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
 
@@ -232,8 +267,8 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
-CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -250,6 +285,7 @@ CONFIG_XFRM=y
 CONFIG_XFRM_USER=y
 # CONFIG_XFRM_SUB_POLICY is not set
 CONFIG_XFRM_MIGRATE=y
+# CONFIG_XFRM_STATISTICS is not set
 CONFIG_NET_KEY=y
 CONFIG_NET_KEY_MIGRATE=y
 CONFIG_INET=y
@@ -269,6 +305,7 @@ CONFIG_IP_FIB_HASH=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -276,8 +313,6 @@ CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
@@ -294,10 +329,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -305,6 +336,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
@@ -326,9 +358,12 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
@@ -337,6 +372,7 @@ CONFIG_MTD=y
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -350,6 +386,7 @@ CONFIG_MTD_BLKDEVS=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -384,6 +421,7 @@ CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_START=0x0
 CONFIG_MTD_PHYSMAP_LEN=0x0
 CONFIG_MTD_PHYSMAP_BANKWIDTH=0
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -423,7 +461,9 @@ CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
 # CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
@@ -462,10 +502,15 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
 # CONFIG_SCSI_LOWLEVEL is not set
+# CONFIG_SCSI_DH is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
+CONFIG_SATA_PMP=y
 # CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SIL24 is not set
+CONFIG_ATA_SFF=y
 # CONFIG_SATA_SVW is not set
 # CONFIG_ATA_PIIX is not set
 # CONFIG_SATA_MV is not set
@@ -475,7 +520,6 @@ CONFIG_ATA=y
 # CONFIG_SATA_PROMISE is not set
 # CONFIG_SATA_SX4 is not set
 # CONFIG_SATA_SIL is not set
-# CONFIG_SATA_SIL24 is not set
 # CONFIG_SATA_SIS is not set
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
@@ -504,7 +548,9 @@ CONFIG_ATA=y
 # CONFIG_PATA_MPIIX is not set
 # CONFIG_PATA_OLDPIIX is not set
 # CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
 # CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
 # CONFIG_PATA_OPTI is not set
 # CONFIG_PATA_OPTIDMA is not set
 # CONFIG_PATA_PDC_OLD is not set
@@ -518,29 +564,27 @@ CONFIG_ATA=y
 CONFIG_PATA_VIA=y
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
+# CONFIG_PATA_SCH is not set
 # CONFIG_MD is not set
+# CONFIG_FUSION is not set
 
 #
-# Fusion MPT device support
+# IEEE 1394 (FireWire) support
 #
-# CONFIG_FUSION is not set
-# CONFIG_FUSION_SPI is not set
-# CONFIG_FUSION_FC is not set
-# CONFIG_FUSION_SAS is not set
 
 #
-# IEEE 1394 (FireWire) support
+# Enable only one of the two stacks, unless you know what you are doing
 #
 # CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 # CONFIG_I2O is not set
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
 # CONFIG_ARCNET is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
@@ -562,7 +606,12 @@ CONFIG_TULIP=y
 # CONFIG_DM9102 is not set
 # CONFIG_ULI526X is not set
 # CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 # CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
@@ -572,6 +621,7 @@ CONFIG_TULIP=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # USB Network Adapters
@@ -580,7 +630,6 @@ CONFIG_TULIP=y
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
@@ -588,7 +637,6 @@ CONFIG_TULIP=y
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 # CONFIG_NET_FC is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -607,7 +655,6 @@ CONFIG_INPUT_POLLDEV=y
 #
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
@@ -642,7 +689,9 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
@@ -664,65 +713,122 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
-CONFIG_COBALT_LCD=y
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_DRM is not set
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
+# CONFIG_THERMAL_HWMON is not set
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
+# CONFIG_MFD_CORE is not set
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
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
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
+# CONFIG_FB_S3 is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_VT8623 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
+# CONFIG_FB_PM3 is not set
+# CONFIG_FB_CARMINE is not set
+CONFIG_FB_COBALT=y
+# CONFIG_FB_VIRTUAL is not set
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
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-
-#
-# Sound
-#
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+# CONFIG_LOGO is not set
 # CONFIG_SOUND is not set
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=m
 # CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
 
 #
 # USB Input Devices
@@ -743,6 +849,7 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=m
 # CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
 # Miscellaneous USB options
@@ -751,15 +858,18 @@ CONFIG_USB=m
 # CONFIG_USB_DEVICE_CLASS is not set
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
@@ -773,6 +883,7 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 #
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -785,6 +896,7 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
 # CONFIG_USB_STORAGE_DPCM is not set
 # CONFIG_USB_STORAGE_USBAT is not set
 # CONFIG_USB_STORAGE_SDDR09 is not set
@@ -793,6 +905,7 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_ALAUDA is not set
 # CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
@@ -800,15 +913,11 @@ CONFIG_USB_STORAGE=m
 #
 # CONFIG_USB_MDC800 is not set
 # CONFIG_USB_MICROTEK is not set
-CONFIG_USB_MON=y
+# CONFIG_USB_MON is not set
 
 #
 # USB port drivers
 #
-
-#
-# USB Serial Converter support
-#
 # CONFIG_USB_SERIAL is not set
 
 #
@@ -833,16 +942,10 @@ CONFIG_USB_MON=y
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
+# CONFIG_USB_ISIGHTFW is not set
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 
@@ -858,6 +961,8 @@ CONFIG_LEDS_COBALT_RAQ=y
 CONFIG_LEDS_TRIGGERS=y
 # CONFIG_LEDS_TRIGGER_TIMER is not set
 # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
+# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
@@ -882,9 +987,10 @@ CONFIG_RTC_INTF_DEV=y
 # Platform RTC drivers
 #
 CONFIG_RTC_DRV_CMOS=y
+# CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
-# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
@@ -892,23 +998,7 @@ CONFIG_RTC_DRV_CMOS=y
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
+# CONFIG_DMADEVICES is not set
 # CONFIG_UIO is not set
 
 #
@@ -923,22 +1013,22 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_EXT4DEV_FS is not set
+CONFIG_EXT4DEV_FS=y
+CONFIG_EXT4DEV_FS_XATTR=y
+CONFIG_EXT4DEV_FS_POSIX_ACL=y
+CONFIG_EXT4DEV_FS_SECURITY=y
 CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
+CONFIG_JBD2=y
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
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
@@ -967,7 +1057,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 CONFIG_CONFIGFS_FS=y
 
 #
@@ -983,32 +1072,28 @@ CONFIG_CONFIGFS_FS=y
 # CONFIG_JFFS2_FS is not set
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
 CONFIG_NFS_V3_ACL=y
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=y
 CONFIG_NFSD_V2_ACL=y
 CONFIG_NFSD_V3=y
 CONFIG_NFSD_V3_ACL=y
 # CONFIG_NFSD_V4 is not set
-CONFIG_NFSD_TCP=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
 CONFIG_NFS_ACL_SUPPORT=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1022,34 +1107,26 @@ CONFIG_SUNRPC=y
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
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_SAMPLES is not set
 CONFIG_CMDLINE=""
 
 #
@@ -1057,14 +1134,95 @@ CONFIG_CMDLINE=""
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-# CONFIG_CRYPTO is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
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
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
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
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
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
+# CONFIG_CRYPTO_LZO is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
-# CONFIG_CRC16 is not set
+CONFIG_CRC16=y
+# CONFIG_CRC_T10DIF is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
