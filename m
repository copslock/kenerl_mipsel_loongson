Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2005 15:21:59 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:47832 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225987AbVHROVf>;
	Thu, 18 Aug 2005 15:21:35 +0100
Received: MO(mo00)id j7IEQNDc009714; Thu, 18 Aug 2005 23:26:23 +0900 (JST)
Received: MDO(mdo01) id j7IEQMj5008845; Thu, 18 Aug 2005 23:26:23 +0900 (JST)
Received: from stratos (h009.p499.iij4u.or.jp [210.149.243.9])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j7IEQLfC027414
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Thu, 18 Aug 2005 23:26:22 +0900 (JST)
Date:	Thu, 18 Aug 2005 23:26:20 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: add Mini-ITX DIMM Base support
Message-Id: <20050818232620.05d169a8.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added TANBAC Mini-ITX DIMM Base(TB0287) support.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/configs/tb0287_defconfig a/arch/mips/configs/tb0287_defconfig
--- a-orig/arch/mips/configs/tb0287_defconfig	1970-01-01 09:00:00.000000000 +0900
+++ a/arch/mips/configs/tb0287_defconfig	2005-08-18 23:21:10.000000000 +0900
@@ -0,0 +1,1028 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.13-rc6
+# Thu Aug 18 23:20:57 2005
+#
+CONFIG_MIPS=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_KMOD=y
+
+#
+# Machine selection
+#
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_DB1200 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MIPS_EV64120 is not set
+# CONFIG_MIPS_EV96100 is not set
+# CONFIG_MIPS_IVR is not set
+# CONFIG_MIPS_ITE8172 is not set
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MIPS_ATLAS is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SEAD is not set
+# CONFIG_MOMENCO_JAGUAR_ATX is not set
+# CONFIG_MOMENCO_OCELOT is not set
+# CONFIG_MOMENCO_OCELOT_3 is not set
+# CONFIG_MOMENCO_OCELOT_C is not set
+# CONFIG_MOMENCO_OCELOT_G is not set
+# CONFIG_MIPS_XXS1500 is not set
+# CONFIG_PNX8550_V2PCI is not set
+# CONFIG_PNX8550_JBS is not set
+# CONFIG_DDB5074 is not set
+# CONFIG_DDB5476 is not set
+# CONFIG_DDB5477 is not set
+CONFIG_MACH_VR41XX=y
+# CONFIG_PMC_YOSEMITE is not set
+# CONFIG_QEMU is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP32 is not set
+# CONFIG_SIBYTE_SWARM is not set
+# CONFIG_SIBYTE_SENTOSA is not set
+# CONFIG_SIBYTE_RHONE is not set
+# CONFIG_SIBYTE_CARMEL is not set
+# CONFIG_SIBYTE_PTSWARM is not set
+# CONFIG_SIBYTE_LITTLESUR is not set
+# CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SNI_RM200_PCI is not set
+# CONFIG_TOSHIBA_JMR3927 is not set
+# CONFIG_TOSHIBA_RBTX4927 is not set
+# CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_NEC_CMBVR4133 is not set
+# CONFIG_CASIO_E55 is not set
+# CONFIG_IBM_WORKPAD is not set
+CONFIG_TANBAC_TB022X=y
+# CONFIG_TANBAC_TB0226 is not set
+CONFIG_TANBAC_TB0287=y
+# CONFIG_VICTOR_MPC30X is not set
+# CONFIG_ZAO_CAPCELLA is not set
+CONFIG_PCI_VR41XX=y
+# CONFIG_VRC4173 is not set
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_CPU_BIG_ENDIAN is not set
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
+# CONFIG_CPU_MIPS32_R1 is not set
+# CONFIG_CPU_MIPS32_R2 is not set
+# CONFIG_CPU_MIPS64_R1 is not set
+# CONFIG_CPU_MIPS64_R2 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+CONFIG_CPU_VR41XX=y
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+# CONFIG_CPU_TX49XX is not set
+# CONFIG_CPU_R5000 is not set
+# CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_RM9000 is not set
+# CONFIG_CPU_SB1 is not set
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
+
+#
+# Kernel type
+#
+CONFIG_32BIT=y
+# CONFIG_64BIT is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+# CONFIG_MIPS_MT is not set
+# CONFIG_CPU_ADVANCED is not set
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+# CONFIG_PCI_LEGACY_PROC is not set
+CONFIG_PCI_NAMES=y
+CONFIG_MMU=y
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+CONFIG_XFRM_USER=m
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_ASK_IP_FIB_HASH=y
+# CONFIG_IP_FIB_TRIE is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+CONFIG_NET_IPIP=m
+CONFIG_NET_IPGRE=m
+# CONFIG_NET_IPGRE_BROADCAST is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+CONFIG_TCP_CONG_ADVANCED=y
+
+#
+# TCP congestion control
+#
+CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_WESTWOOD=m
+CONFIG_TCP_CONG_HTCP=m
+# CONFIG_TCP_CONG_HSTCP is not set
+# CONFIG_TCP_CONG_HYBLA is not set
+# CONFIG_TCP_CONG_VEGAS is not set
+# CONFIG_TCP_CONG_SCALABLE is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=m
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CDROM_PKTCDVD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_BLK_DEV_IDESCSI is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+# CONFIG_IDEPCI_SHARE_IRQ is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_GENERIC is not set
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
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_IT821X is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+CONFIG_BLK_DEV_SIIMAGE=y
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_ARM is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+CONFIG_SCSI=y
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+
+#
+# SCSI Transport Attributes
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_QLA24XX is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+CONFIG_IEEE1394=m
+
+#
+# Subsystem Options
+#
+# CONFIG_IEEE1394_VERBOSEDEBUG is not set
+# CONFIG_IEEE1394_OUI_DB is not set
+CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
+CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
+# CONFIG_IEEE1394_EXPORT_FULL_API is not set
+
+#
+# Device Drivers
+#
+
+#
+# Texas Instruments PCILynx requires I2C
+#
+CONFIG_IEEE1394_OHCI1394=m
+
+#
+# Protocol Drivers
+#
+CONFIG_IEEE1394_VIDEO1394=m
+CONFIG_IEEE1394_SBP2=m
+# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
+CONFIG_IEEE1394_ETH1394=m
+CONFIG_IEEE1394_DV1394=m
+CONFIG_IEEE1394_RAWIO=m
+CONFIG_IEEE1394_CMP=m
+CONFIG_IEEE1394_AMDTP=m
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=m
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+CONFIG_R8169=y
+# CONFIG_R8169_NAPI is not set
+# CONFIG_SKGE is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_TANBAC_TB0219 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
+CONFIG_GPIO_VR41XX=y
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+# CONFIG_I2C_SENSOR is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+# CONFIG_HWMON is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB=m
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
+CONFIG_USB_EHCI_HCD=m
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=m
+# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_BLUETOOTH_TTY is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=m
+CONFIG_USB_HIDINPUT=y
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
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
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_ITMTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB Multimedia devices
+#
+# CONFIG_USB_DABUSB is not set
+
+#
+# Video4Linux support is needed for USB Multimedia device support
+#
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
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGETKIT is not set
+# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+
+#
+# USB DSL modem support
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# SN Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+
+#
+# XFS support
+#
+CONFIG_XFS_FS=y
+# CONFIG_XFS_RT is not set
+CONFIG_XFS_QUOTA=y
+# CONFIG_XFS_SECURITY is not set
+CONFIG_XFS_POSIX_ACL=y
+# CONFIG_MINIX_FS is not set
+CONFIG_ROMFS_FS=m
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_QUOTACTL=y
+# CONFIG_DNOTIFY is not set
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_DEVPTS_FS_XATTR=y
+CONFIG_DEVPTS_FS_SECURITY=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_CRAMFS=m
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CROSSCOMPILE=y
+CONFIG_CMDLINE="mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
+
+#
+# Security options
+#
+CONFIG_KEYS=y
+CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=m
diff -urN -X dontdiff a-orig/arch/mips/pci/Makefile a/arch/mips/pci/Makefile
--- a-orig/arch/mips/pci/Makefile	2005-07-26 23:37:04.000000000 +0900
+++ a/arch/mips/pci/Makefile	2005-08-18 23:08:21.000000000 +0900
@@ -49,6 +49,7 @@
 obj-$(CONFIG_SNI_RM200_PCI)	+= fixup-sni.o ops-sni.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
+obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
 obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o pci-jmr3927.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
 obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-tx4938.o ops-tx4938.o
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-tb0287.c a/arch/mips/pci/fixup-tb0287.c
--- a-orig/arch/mips/pci/fixup-tb0287.c	1970-01-01 09:00:00.000000000 +0900
+++ a/arch/mips/pci/fixup-tb0287.c	2005-08-18 23:08:21.000000000 +0900
@@ -0,0 +1,65 @@
+/*
+ *  fixup-tb0287.c, The TANBAC TB0287 specific PCI fixups.
+ *
+ *  Copyright (C) 2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/vr41xx/tb0287.h>
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	unsigned char bus;
+	int irq = -1;
+
+	bus = dev->bus->number;
+	if (bus == 0) {
+		switch (slot) {
+		case 16:
+			irq = TB0287_SM501_IRQ;
+			break;
+		case 17:
+			irq = TB0287_SIL680A_IRQ;
+			break;
+		default:
+			break;
+		}
+	} else if (bus == 1) {
+		switch (PCI_SLOT(dev->devfn)) {
+		case 0:
+			irq = TB0287_PCI_SLOT_IRQ;
+			break;
+		case 2:
+		case 3:
+			irq = TB0287_RTL8110_IRQ;
+			break;
+		default:
+			break;
+		}
+	} else if (bus > 1) {
+		irq = TB0287_PCI_SLOT_IRQ;
+	}
+
+	return irq;
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/Kconfig a/arch/mips/vr41xx/Kconfig
--- a-orig/arch/mips/vr41xx/Kconfig	2005-08-13 09:43:00.000000000 +0900
+++ a/arch/mips/vr41xx/Kconfig	2005-08-18 23:14:54.000000000 +0900
@@ -63,6 +63,16 @@
 	  The TANBAC TB0226 (Mbase) is a MIPS-based platform manufactured by
 	  TANBAC.  Please refer to <http://www.tanbac.co.jp/> about Mbase.
 
+config TANBAC_TB0287
+	bool "Support for TANBAC Mini-ITX DIMM base(TB0287)"
+	depends on TANBAC_TB022X
+	select PCI
+	select PCI_VR41XX
+	select GPIO_VR41XX
+	help
+	  The TANBAC Mini-ITX DIMM base(TB0287) is a MIPS-based platform manufactured by TANBAC.
+	  Please refer to <http://www.tanbac.co.jp/> about Mini-ITX DIMM base.
+
 config VICTOR_MPC30X
 	bool "Support for Victor MP-C303/304"
 	depends on MACH_VR41XX
diff -urN -X dontdiff a-orig/include/asm-mips/vr41xx/tb0287.h a/include/asm-mips/vr41xx/tb0287.h
--- a-orig/include/asm-mips/vr41xx/tb0287.h	1970-01-01 09:00:00.000000000 +0900
+++ a/include/asm-mips/vr41xx/tb0287.h	2005-08-18 23:08:21.000000000 +0900
@@ -0,0 +1,45 @@
+/*
+ *  tb0287.h, Include file for TANBAC TB0287 mini-ITX board.
+ *  
+ *  Copyright (C) 2005  Media Lab Inc. <ito@mlb.co.jp>
+ *
+ *  This code is largely based on tb0219.h.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __TANBAC_TB0287_H
+#define __TANBAC_TB0287_H
+
+#include <asm/vr41xx/vr41xx.h>
+
+/*
+ * General-Purpose I/O Pin Number
+ */
+#define TB0287_PCI_SLOT_PIN		2
+#define TB0287_SM501_PIN		3
+#define TB0287_POWER_OFF_PIN		4
+#define TB0287_R2045_CE_PIN		6
+#define TB0287_SIL680A_PIN		8
+#define TB0287_RTL8110_PIN		13
+
+/*
+ * Interrupt Number
+ */
+#define TB0287_PCI_SLOT_IRQ		GIU_IRQ(TB0287_PCI_SLOT_PIN)
+#define TB0287_SM501_IRQ		GIU_IRQ(TB0287_SM501_PIN)
+#define TB0287_SIL680A_IRQ		GIU_IRQ(TB0287_SIL680A_PIN)
+#define TB0287_RTL8110_IRQ		GIU_IRQ(TB0287_RTL8110_PIN)
+
+#endif /* __TANBAC_TB0287_H */
