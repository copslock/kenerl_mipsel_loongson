Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 04:42:27 +0100 (BST)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:48497
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225197AbVFVDl7>; Wed, 22 Jun 2005 04:41:59 +0100
Received: from localhost.localdomain (oreo.jp.mvista.com [10.200.16.31])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id j5M3enS5027453;
	Wed, 22 Jun 2005 12:40:49 +0900
Date:	Wed, 22 Jun 2005 12:42:35 +0900
From:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: [patch 2.6.12 1/1] tx4938: Added the default config file for
 Toshiba RBHMA4500(TX4938)
Message-Id: <20050622124235.6229939e.Hiroshi_DOYU@montavista.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <Hiroshi_DOYU@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Hiroshi_DOYU@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hello,

This patch is against 2.6.12 and it works fine. 
Please review it.

	Hiroshi DOYU

----
Added the default config file for Toshiba RBHMA4500(TX4938)

Signed-off-by: Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
----

 arch/mips/configs/rbhma4500_defconfig | 1147 ++++++++++++++++++++++++++++++++++
 1 files changed, 1147 insertions(+)

Index: linux/arch/mips/configs/rbhma4500_defconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/mips/configs/rbhma4500_defconfig	2005-06-22 11:29:17.958628832 +0900
@@ -0,0 +1,1147 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.12-rc5
+# Tue Jun  7 14:36:19 2005
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
+# CONFIG_KOBJECT_UEVENT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
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
+# CONFIG_MODULE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
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
+# CONFIG_DDB5074 is not set
+# CONFIG_DDB5476 is not set
+# CONFIG_DDB5477 is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_PMC_YOSEMITE is not set
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
+CONFIG_TOSHIBA_RBTX4938=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_I8259=y
+# CONFIG_CPU_BIG_ENDIAN is not set
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_SWAP_IO_SPACE=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+CONFIG_HAVE_STD_PC_SERIAL_PORT=y
+CONFIG_TOSHIBA_BOARDS=y
+
+#
+# CPU selection
+#
+# CONFIG_CPU_MIPS32 is not set
+# CONFIG_CPU_MIPS64 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+# CONFIG_CPU_VR41XX is not set
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+CONFIG_CPU_TX49XX=y
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
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
+
+#
+# Kernel type
+#
+CONFIG_MIPS32=y
+# CONFIG_MIPS64 is not set
+# CONFIG_64BIT is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_CPU_ADVANCED=y
+CONFIG_CPU_HAS_LLSC=y
+CONFIG_CPU_HAS_LLDSCD=y
+CONFIG_CPU_HAS_WB=y
+CONFIG_CPU_HAS_SYNC=y
+# CONFIG_PREEMPT is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+# CONFIG_PCI_LEGACY_PROC is not set
+CONFIG_PCI_NAMES=y
+CONFIG_ISA=y
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
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_AMDSTD_RETRY=0
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_XIP is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+# CONFIG_PNP is not set
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
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
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
+CONFIG_BLK_DEV_IDECD=y
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_IDEPCI_SHARE_IRQ=y
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
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_ARM is not set
+# CONFIG_IDE_CHIPSETS is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Old CD-ROM drivers (not SCSI, not IDE)
+#
+# CONFIG_CD_NO_IDESCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+CONFIG_IPV6=m
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_IPV6_TUNNEL is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_CONNTRACK is not set
+# CONFIG_IP_NF_CONNTRACK_MARK is not set
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+
+#
+# IPv6: Netfilter Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP6_NF_QUEUE is not set
+# CONFIG_IP6_NF_IPTABLES is not set
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
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+CONFIG_TUN=m
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
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_SMC is not set
+# CONFIG_NET_VENDOR_RACAL is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_AT1700 is not set
+# CONFIG_DEPCA is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_ISA=y
+# CONFIG_E2100 is not set
+# CONFIG_EWRK3 is not set
+# CONFIG_EEXPRESS is not set
+# CONFIG_EEXPRESS_PRO is not set
+# CONFIG_HPLAN_PLUS is not set
+# CONFIG_HPLAN is not set
+# CONFIG_LP486E is not set
+# CONFIG_ETH16I is not set
+CONFIG_NE2000=y
+# CONFIG_SEEQ8005 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_AC3200 is not set
+# CONFIG_APRICOT is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_CS89x0 is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_LAN_SAA9730 is not set
+# CONFIG_NET_POCKET is not set
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
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
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
+CONFIG_NET_RADIO=y
+
+#
+# Obsolete Wireless cards support (pre-802.11)
+#
+# CONFIG_STRIP is not set
+# CONFIG_ARLAN is not set
+# CONFIG_WAVELAN is not set
+
+#
+# Wireless 802.11b ISA/PCI cards support
+#
+# CONFIG_AIRO is not set
+# CONFIG_HERMES is not set
+# CONFIG_ATMEL is not set
+
+#
+# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
+#
+# CONFIG_PRISM54 is not set
+CONFIG_NET_WIRELESS=y
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+CONFIG_PPP=m
+CONFIG_PPP_MULTILINK=y
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_PPP_DEFLATE=m
+# CONFIG_PPP_BSDCOMP is not set
+CONFIG_PPPOE=m
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
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
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_INPORT is not set
+# CONFIG_MOUSE_LOGIBM is not set
+# CONFIG_MOUSE_PC110PAD is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
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
+CONFIG_SERIAL_TXX9=y
+CONFIG_HAS_TXX9_SERIAL=y
+CONFIG_SERIAL_TXX9_CONSOLE=y
+CONFIG_SERIAL_TXX9_STDSERIAL=y
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
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_DRM is not set
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
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
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
+CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+CONFIG_FB_SOFT_CURSOR=y
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+# CONFIG_FB_NVIDIA is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+# CONFIG_FB_RADEON_OLD is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+CONFIG_FB_ATY=y
+CONFIG_FB_ATY_CT=y
+# CONFIG_FB_ATY_GENERIC_LCD is not set
+# CONFIG_FB_ATY_XL_INIT is not set
+# CONFIG_FB_ATY_GX is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_SMIVGX is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_E1356 is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_VIRTUAL is not set
+
+#
+# Console display driver support
+#
+CONFIG_VGA_CONSOLE=y
+# CONFIG_MDA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+
+#
+# Logo configuration
+#
+# CONFIG_LOGO is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
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
+# CONFIG_USB_OHCI_HCD is not set
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
+# CONFIG_USB_STORAGE is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+CONFIG_USB_HIDINPUT=y
+# CONFIG_HID_FF is not set
+CONFIG_USB_HIDDEV=y
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
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
+# CONFIG_USB_ZD1201 is not set
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
+
+#
+# USB ATM/DSL drivers
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
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=m
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+CONFIG_REISERFS_FS=m
+# CONFIG_REISERFS_CHECK is not set
+# CONFIG_REISERFS_PROC_INFO is not set
+# CONFIG_REISERFS_FS_XATTR is not set
+# CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
+CONFIG_XFS_FS=m
+CONFIG_XFS_EXPORT=y
+# CONFIG_XFS_RT is not set
+# CONFIG_XFS_QUOTA is not set
+# CONFIG_XFS_SECURITY is not set
+# CONFIG_XFS_POSIX_ACL is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=m
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+# CONFIG_JOLIET is not set
+# CONFIG_ZISOFS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+# CONFIG_MSDOS_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_SYSFS=y
+CONFIG_DEVFS_FS=y
+CONFIG_DEVFS_MOUNT=y
+# CONFIG_DEVFS_DEBUG is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
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
+# CONFIG_JFFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+# CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_JFFS2_FS_NOR_ECC is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+CONFIG_CRAMFS=y
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
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+CONFIG_NFSD=m
+# CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_TCP is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=m
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+CONFIG_SMB_FS=m
+# CONFIG_SMB_NLS_DEFAULT is not set
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
+CONFIG_CMDLINE=""
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
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
+CONFIG_CRC_CCITT=m
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
