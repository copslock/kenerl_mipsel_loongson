Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2006 16:48:18 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:36228 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8133737AbWEEPsE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 May 2006 16:48:04 +0100
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k45Flwe2016499;
	Fri, 5 May 2006 08:47:58 -0700 (PDT)
Received: from ism-mail01.corp.ad.wrs.com ([147.11.96.20]) by ala-mail04.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 5 May 2006 08:47:57 -0700
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 2/2] Wind River 4KC PPMC Eval Board Support
Date:	Fri, 5 May 2006 17:47:52 +0200
Message-ID: <6A3254532ACD7A42805B4E1BFD18080EB307A1@ism-mail01.corp.ad.wrs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] Wind River 4KC PPMC Eval Board Support
Thread-Index: AcZwW0TGyEhwQz99RFOuj7nfOpsWyg==
From:	"Zhan, Rongkai" <rongkai.zhan@windriver.com>
To:	<linux-mips@linux-mips.org>
Cc:	<ralf@linux-mips.org>
X-OriginalArrivalTime: 05 May 2006 15:47:57.0916 (UTC) FILETIME=[480379C0:01C6705B]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

Hello,

Here is the default configuration file for Wind River PPMC Eval Board.

Mark. Zhan

Signed-off-by: Rongkai.Zhan <Rongkai.zhan@windriver.com>

diff -urN linux-2.6.16.11/arch/mips/configs/wrppmc_defconfig
linux-2.6.16.11-ppmc/arch/mips/configs/wrppmc_defconfig
--- linux-2.6.16.11/arch/mips/configs/wrppmc_defconfig	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/configs/wrppmc_defconfig
2006-05-05 17:11:22.000000000 +0800
@@ -0,0 +1,801 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.16.11
+# Fri May  5 17:11:22 2006
+#
+CONFIG_MIPS=y
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
+CONFIG_WR_PPMC=y
+# CONFIG_MIPS_SIM is not set
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
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_PMC_YOSEMITE is not set
+# CONFIG_QEMU is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP32 is not set
+# CONFIG_SIBYTE_BIGSUR is not set
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
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_DMA_NEED_PCI_MAP_STATE=y
+CONFIG_CPU_BIG_ENDIAN=y
+# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_MIPS_GT64120=y
+CONFIG_SWAP_IO_SPACE=y
+CONFIG_BOOT_ELF32=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
+CONFIG_CPU_MIPS32_R1=y
+# CONFIG_CPU_MIPS32_R2 is not set
+# CONFIG_CPU_MIPS64_R1 is not set
+# CONFIG_CPU_MIPS64_R2 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+# CONFIG_CPU_VR41XX is not set
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
+CONFIG_SYS_HAS_CPU_MIPS32_R1=y
+CONFIG_SYS_HAS_CPU_MIPS32_R2=y
+CONFIG_SYS_HAS_CPU_MIPS64_R1=y
+CONFIG_SYS_HAS_CPU_NEVADA=y
+CONFIG_SYS_HAS_CPU_RM7000=y
+CONFIG_CPU_MIPS32=y
+CONFIG_CPU_MIPSR1=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
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
+CONFIG_CPU_HAS_PREFETCH=y
+# CONFIG_MIPS_MT is not set
+# CONFIG_64BIT_PHYS_ADDR is not set
+# CONFIG_CPU_ADVANCED is not set
+CONFIG_CPU_HAS_LLSC=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_CPU_SUPPORTS_HIGHMEM=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_SLAB=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
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
+# CONFIG_KMOD is not set
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_LEGACY_PROC=y
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
+CONFIG_HOTPLUG_PCI=y
+# CONFIG_HOTPLUG_PCI_FAKE is not set
+# CONFIG_HOTPLUG_PCI_CPCI is not set
+# CONFIG_HOTPLUG_PCI_SHPC is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
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
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+CONFIG_IP_MROUTE=y
+# CONFIG_IP_PIMSM_V1 is not set
+# CONFIG_IP_PIMSM_V2 is not set
+CONFIG_ARPD=y
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
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
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
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
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
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
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
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
+# Network device support
+#
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
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
+# PHY device support
+#
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
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_DM9000 is not set
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
+CONFIG_E100=y
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
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
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
+# CONFIG_INPUT is not set
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
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
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
+CONFIG_RTC=y
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
+# CONFIG_TELCLOCK is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
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
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
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
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
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
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
+# CONFIG_CONFIGFS_FS is not set
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
+# CONFIG_CRAMFS is not set
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
+# CONFIG_9P_FS is not set
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
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CROSSCOMPILE=y
+CONFIG_CMDLINE="console=ttyS0,115200n8"
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
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+CONFIG_CRC32=y
+CONFIG_LIBCRC32C=y
