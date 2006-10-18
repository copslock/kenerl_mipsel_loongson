Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 15:38:49 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:6703 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038525AbWJROio (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2006 15:38:44 +0100
Received: by mo.po.2iij.net (mo32) id k9IEcfSs036628; Wed, 18 Oct 2006 23:38:41 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox32) id k9IEcYwE045506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Oct 2006 23:38:36 +0900 (JST)
Date:	Wed, 18 Oct 2006 23:36:15 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] update pnx8500-jbs_defconfig
Message-Id: <20061018233615.5e41d949.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated pnx8550-jbs_defconfig.
The current pnx8550-jbs_defconfig, CONFIG_SGI_IP22 has been selected.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/pnx8550-jbs_defconfig mips/arch/mips/configs/pnx8550-jbs_defconfig
--- mips-orig/arch/mips/configs/pnx8550-jbs_defconfig	2006-10-14 22:54:18.650300750 +0900
+++ mips/arch/mips/configs/pnx8550-jbs_defconfig	2006-10-14 23:02:51.574111750 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Thu Jul  6 10:04:18 2006
+# Linux kernel version: 2.6.19-rc2
+# Sat Oct 14 23:01:16 2006
 #
 CONFIG_MIPS=y
 
@@ -25,8 +25,6 @@ CONFIG_MIPS=y
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MIPS_EV64120 is not set
-# CONFIG_MIPS_IVR is not set
-# CONFIG_MIPS_ITE8172 is not set
 # CONFIG_MACH_JAZZ is not set
 # CONFIG_LASAT is not set
 # CONFIG_MIPS_ATLAS is not set
@@ -41,13 +39,13 @@ CONFIG_MIPS=y
 # CONFIG_MOMENCO_OCELOT_G is not set
 # CONFIG_MIPS_XXS1500 is not set
 # CONFIG_PNX8550_V2PCI is not set
-# CONFIG_PNX8550_JBS is not set
+CONFIG_PNX8550_JBS=y
 # CONFIG_DDB5477 is not set
 # CONFIG_MACH_VR41XX is not set
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_QEMU is not set
 # CONFIG_MARKEINS is not set
-CONFIG_SGI_IP22=y
+# CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
 # CONFIG_SGI_IP32 is not set
 # CONFIG_SIBYTE_BIGSUR is not set
@@ -67,25 +65,21 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_TIME=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-CONFIG_ARC=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
-CONFIG_CPU_BIG_ENDIAN=y
-# CONFIG_CPU_LITTLE_ENDIAN is not set
-CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
-CONFIG_IRQ_CPU=y
-CONFIG_SWAP_IO_SPACE=y
-CONFIG_ARC32=y
-CONFIG_BOOT_ELF32=y
+# CONFIG_CPU_BIG_ENDIAN is not set
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_PNX8550=y
+CONFIG_SOC_PNX8550=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
-# CONFIG_ARC_CONSOLE is not set
-CONFIG_ARC_PROMLIB=y
 
 #
 # CPU selection
 #
-# CONFIG_CPU_MIPS32_R1 is not set
+CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
 # CONFIG_CPU_MIPS64_R2 is not set
@@ -93,7 +87,7 @@ CONFIG_ARC_PROMLIB=y
 # CONFIG_CPU_TX39XX is not set
 # CONFIG_CPU_VR41XX is not set
 # CONFIG_CPU_R4300 is not set
-CONFIG_CPU_R4X00=y
+# CONFIG_CPU_R4X00 is not set
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
@@ -104,12 +98,11 @@ CONFIG_CPU_R4X00=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
-CONFIG_SYS_HAS_CPU_R4X00=y
-CONFIG_SYS_HAS_CPU_R5000=y
+CONFIG_SYS_HAS_CPU_MIPS32_R1=y
+CONFIG_CPU_MIPS32=y
+CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
-CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
-CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
 #
 # Kernel type
@@ -120,17 +113,17 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
-CONFIG_BOARD_SCACHE=y
-CONFIG_IP22_CPU_SCACHE=y
+CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
-# CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_MT_SMP is not set
+# CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
 # CONFIG_64BIT_PHYS_ADDR is not set
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_CPU_SUPPORTS_HIGHMEM=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
@@ -144,12 +137,12 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
-# CONFIG_HZ_250 is not set
+CONFIG_HZ_250=y
 # CONFIG_HZ_256 is not set
-CONFIG_HZ_1000=y
+# CONFIG_HZ_1000 is not set
 # CONFIG_HZ_1024 is not set
 CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
-CONFIG_HZ=1000
+CONFIG_HZ=250
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
@@ -171,16 +164,20 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -189,12 +186,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -211,6 +208,7 @@ CONFIG_KMOD=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -231,8 +229,10 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
-CONFIG_HW_HAS_EISA=y
-# CONFIG_EISA is not set
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
+# CONFIG_PCI_DEBUG is not set
 CONFIG_MMU=y
 
 #
@@ -243,6 +243,7 @@ CONFIG_MMU=y
 #
 # PCI Hotplug Support
 #
+# CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
@@ -265,6 +266,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
@@ -283,16 +285,18 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
-CONFIG_NETWORK_SECMARK=y
+# CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -318,7 +322,6 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -371,13 +374,20 @@ CONFIG_FW_LOADER=y
 #
 # Block devices
 #
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -386,6 +396,7 @@ CONFIG_BLK_DEV_INITRD=y
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
+CONFIG_IDE_MAX_HWIFS=4
 CONFIG_BLK_DEV_IDE=y
 
 #
@@ -404,8 +415,39 @@ CONFIG_BLK_DEV_IDESCSI=y
 # IDE chipset support/bugfixes
 #
 CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_IDEPCI_SHARE_IRQ=y
+CONFIG_BLK_DEV_OFFBOARD=y
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_OPTI621 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+# CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+CONFIG_BLK_DEV_HPT366=y
+# CONFIG_BLK_DEV_JMICRON is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
 # CONFIG_IDE_ARM is not set
-# CONFIG_BLK_DEV_IDEDMA is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
 # CONFIG_IDEDMA_AUTO is not set
 # CONFIG_BLK_DEV_HD is not set
 
@@ -414,6 +456,7 @@ CONFIG_IDE_GENERIC=y
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -434,22 +477,54 @@ CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_ISCSI_ATTRS=m
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
 #
 CONFIG_ISCSI_TCP=m
-# CONFIG_SGIWD93_SCSI is not set
-# CONFIG_SCSI_SATA is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
+
+#
 # Multi-device support (RAID and LVM)
 #
 # CONFIG_MD is not set
@@ -458,14 +533,19 @@ CONFIG_ISCSI_TCP=m
 # Fusion MPT device support
 #
 # CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
 #
+# CONFIG_I2O is not set
 
 #
 # Network device support
@@ -477,6 +557,11 @@ CONFIG_NETDEVICES=y
 # CONFIG_TUN is not set
 
 #
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
 # PHY device support
 #
 # CONFIG_PHYLIB is not set
@@ -486,20 +571,73 @@ CONFIG_NETDEVICES=y
 #
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_DM9000 is not set
-# CONFIG_SGISEEQ is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+CONFIG_8139TOO=y
+# CONFIG_8139TOO_PIO is not set
+CONFIG_8139TOO_TUNE_TWISTER=y
+CONFIG_8139TOO_8129=y
+# CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_LAN_SAA9730 is not set
 
 #
 # Ethernet (1000 Mbit)
 #
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
 #
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
 
 #
 # Token Ring devices
 #
+# CONFIG_TR is not set
 
 #
 # Wireless LAN (non-hamradio)
@@ -510,8 +648,11 @@ CONFIG_MII=y
 # Wan interfaces
 #
 # CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -531,6 +672,7 @@ CONFIG_MII=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -556,6 +698,7 @@ CONFIG_INPUT=y
 CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_PCIPS2 is not set
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
@@ -566,7 +709,7 @@ CONFIG_SERIO_LIBPS2=y
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
-CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -577,7 +720,8 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 #
 # Non-8250 serial port support
 #
-# CONFIG_SERIAL_IP22_ZILOG is not set
+# CONFIG_SERIAL_IP3106 is not set
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -591,16 +735,17 @@ CONFIG_LEGACY_PTY_COUNT=256
 # Watchdog Cards
 #
 # CONFIG_WATCHDOG is not set
-# CONFIG_HW_RANDOM is not set
+CONFIG_HW_RANDOM=y
 # CONFIG_RTC is not set
-# CONFIG_SGI_DS1286 is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
 #
+# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -631,35 +776,37 @@ CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
 # CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_VT1211 is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
 # Misc devices
 #
+# CONFIG_TIFM_CORE is not set
 
 #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_SGI_NEWPORT_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -669,15 +816,131 @@ CONFIG_DUMMY_CONSOLE=y
 #
 # USB support
 #
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+CONFIG_USB_STORAGE_DATAFAB=y
+CONFIG_USB_STORAGE_FREECOM=y
+CONFIG_USB_STORAGE_ISD200=y
+CONFIG_USB_STORAGE_DPCM=y
+CONFIG_USB_STORAGE_USBAT=y
+CONFIG_USB_STORAGE_SDDR09=y
+CONFIG_USB_STORAGE_SDDR55=y
+CONFIG_USB_STORAGE_JUMPSHOT=y
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Input Devices
+#
+# CONFIG_USB_HID is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_TOUCHSCREEN is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_ATI_REMOTE2 is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+
+#
+# USB DSL modem support
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -703,6 +966,7 @@ CONFIG_DUMMY_CONSOLE=y
 #
 # InfiniBand support
 #
+# CONFIG_INFINIBAND is not set
 
 #
 # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
@@ -733,10 +997,12 @@ CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -769,8 +1035,10 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 # CONFIG_PROC_KCORE is not set
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -813,7 +1081,6 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -824,7 +1091,6 @@ CONFIG_SUNRPC=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-CONFIG_SGI_PARTITION=y
 
 #
 # Native Language Support
@@ -880,6 +1146,7 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -893,13 +1160,17 @@ CONFIG_DEBUG_SLAB=y
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="console=ttyS1,38400n8 kgdb=ttyS0 root=/dev/nfs ip=bootp"
@@ -918,6 +1189,9 @@ CONFIG_CMDLINE="console=ttyS1,38400n8 kg
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=m
+CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_MANAGER=m
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
@@ -927,6 +1201,8 @@ CONFIG_CRYPTO_MD5=m
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=m
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
