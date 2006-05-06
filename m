Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 May 2006 10:04:52 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:42626 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8133433AbWEFJEc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 May 2006 10:04:32 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k4694PcR005718;
	Sat, 6 May 2006 02:04:25 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 6 May 2006 02:04:25 -0700
Received: from [192.168.1.101] ([147.11.69.1]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 6 May 2006 02:04:22 -0700
Message-ID: <445C6694.6010901@windriver.com>
Date:	Sat, 06 May 2006 17:04:20 +0800
From:	"Mark.Zhan" <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	ralf@linux-mips.org
Subject: Re: [PATCH 1/2] Wind River 4KC PPMC Eval Board Support
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2006 09:04:23.0160 (UTC) FILETIME=[114EAF80:01C670EC]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

According to your comments, I re-create the patch. Hopefully, no line-wrapped problems:-)
Patch 1 and 2 in the original mails are concatenated into one patch in this mail.

Best Regards,
Mark.Zhan

Signed-off-by: Rongkai.Zhan <rongkai.zhan@windriver.com>

----

diff -uprN linux-2.6.16.11/arch/mips/configs/wrppmc_defconfig linux-2.6.16.11-ppmc/arch/mips/configs/wrppmc_defconfig
--- linux-2.6.16.11/arch/mips/configs/wrppmc_defconfig	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/configs/wrppmc_defconfig	2006-05-05 17:11:22.000000000 +0800
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
diff -uprN linux-2.6.16.11/arch/mips/gt64120/wrppmc/int-handler.S linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/int-handler.S
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/int-handler.S	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/int-handler.S	2006-05-06 15:41:04.000000000 +0800
@@ -0,0 +1,59 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1995, 1996, 1997, 2003 by Ralf Baechle
+ * Copyright (C) Wind River System Inc. Rongkai.Zhan <rongkai.zhan@windriver.com>
+ */
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/mach-wrppmc/mach-gt64120.h>
+
+	.align	5
+	.set	noat
+NESTED(handle_IRQ, PT_SIZE, sp)
+	SAVE_ALL
+	CLI				# Important: mark KERNEL mode !
+	.set	at
+
+	mfc0	t0, CP0_CAUSE		# get pending interrupts
+	mfc0	t1, CP0_STATUS		# get enabled interrupts
+	and	t0, t0, t1		# get allowed interrupts
+	andi	t0, t0, 0xFF00
+	beqz	t0, 1f
+	move	a1, sp			# Prepare 'struct pt_regs *regs' pointer
+
+	andi	t1, t0, CAUSEF_IP7	# CPU Compare/Count internal timer
+	bnez	t1, handle_cputimer_irq
+	andi	t1, t0, CAUSEF_IP6	# UART 16550 port
+	bnez	t1, handle_uart_irq
+	andi	t1, t0, CAUSEF_IP3	# PCI INT_A
+	bnez	t1, handle_pci_intA_irq
+
+	/* wrong alarm or masked ... */
+1:	j	spurious_interrupt
+	nop
+END(handle_IRQ)
+
+	.align	5
+handle_cputimer_irq:
+	li	a0, WRPPMC_MIPS_TIMER_IRQ
+	jal	do_IRQ
+	j	ret_from_irq
+
+	.align	5
+handle_uart_irq:
+	li	a0, WRPPMC_UART16550_IRQ
+	jal	do_IRQ
+	j	ret_from_irq
+
+	.align	5
+handle_pci_intA_irq:
+	li	a0, WRPPMC_PCI_INTA_IRQ
+	jal	do_IRQ
+	j	ret_from_irq
+
diff -uprN linux-2.6.16.11/arch/mips/gt64120/wrppmc/irq.c linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/irq.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/irq.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/irq.c	2006-05-06 15:39:27.000000000 +0800
@@ -0,0 +1,63 @@
+/*
+ * irq.c: GT64120 Interrupt Controller
+ *
+ * Copyright (C) 2006, Wind River System Inc.
+ * Author: Rongkai.Zhan, <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/module.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/bitops.h>
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+#include <asm/irq_cpu.h>
+#include <asm/gt64120.h>
+
+extern asmlinkage void handle_IRQ(void);
+
+/**
+ * Initialize GT64120 Interrupt Controller
+ */
+void gt64120_init_pic(void)
+{
+	/* clear CPU Interrupt Cause Registers */
+	GT_WRITE(GT_INTRCAUSE_OFS, (0x1F << 21));
+	GT_WRITE(GT_HINTRCAUSE_OFS, 0x00);
+	
+	/* Disable all interrupts from GT64120 bridge chip */
+	GT_WRITE(GT_INTRMASK_OFS, 0x00);
+	GT_WRITE(GT_HINTRMASK_OFS, 0x00);
+	GT_WRITE(GT_PCI0_ICMASK_OFS, 0x00);
+	GT_WRITE(GT_PCI0_HICMASK_OFS, 0x00);
+}
+
+void __init arch_init_irq(void)
+{
+	/* enable all CPU interrupt bits. */
+	set_c0_status(ST0_IM);	/* IE bit is still 0 */
+
+	/* Install MIPS Interrupt Trap Vector */
+	set_except_vector(0, handle_IRQ);
+
+	/* IRQ 0 - 7 are for MIPS common irq_cpu controller */
+	mips_cpu_irq_init(0);
+	
+	gt64120_init_pic();
+}
diff -uprN linux-2.6.16.11/arch/mips/gt64120/wrppmc/Makefile linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/Makefile
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/Makefile	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/Makefile	2006-04-14 15:25:48.000000000 +0800
@@ -0,0 +1,14 @@
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright 2006 Wind River System, Inc.
+# Author: Rongkai.Zhan <rongkai.zhan@windriver.com>
+#
+# Makefile for the Wind River MIPS 4KC PPMC Eval Board
+#
+
+obj-y	+= int-handler.o irq.o reset.o setup.o time.o pci.o
+
+EXTRA_AFLAGS := $(CFLAGS)
diff -uprN linux-2.6.16.11/arch/mips/gt64120/wrppmc/pci.c linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/pci.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/pci.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/pci.c	2006-05-05 17:25:48.000000000 +0800
@@ -0,0 +1,53 @@
+/*
+ * pci.c: GT64120 PCI support.
+ *
+ * Copyright (C) 2006, Wind River System Inc. Rongkai.Zhan <rongkai.zhan@windriver.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <asm/gt64120.h>
+
+extern struct pci_ops gt64120_pci_ops;
+
+static struct resource pci0_io_resource = {
+	.name  = "pci_0 io",
+	.start = GT_PCI_IO_BASE,
+	.end   = GT_PCI_IO_BASE + GT_PCI_IO_SIZE - 1,
+	.flags = IORESOURCE_IO,
+};
+
+static struct resource pci0_mem_resource = {
+	.name  = "pci_0 memory",
+	.start = GT_PCI_MEM_BASE,
+	.end   = GT_PCI_MEM_BASE + GT_PCI_MEM_SIZE - 1,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct pci_controller hose_0 = {
+	.pci_ops	= &gt64120_pci_ops,
+	.io_resource	= &pci0_io_resource,
+	.mem_resource	= &pci0_mem_resource,
+};
+
+static int __init gt64120_pci_init(void)
+{
+	u32 tmp;
+
+	tmp = GT_READ(GT_PCI0_CMD_OFS);		/* Huh??? -- Ralf  */
+	tmp = GT_READ(GT_PCI0_BARE_OFS);
+
+	/* reset the whole PCI I/O space range */
+	ioport_resource.start = GT_PCI_IO_BASE;
+	ioport_resource.end = GT_PCI_IO_BASE + GT_PCI_IO_SIZE - 1;
+
+	register_pci_controller(&hose_0);
+	return 0;
+}
+
+arch_initcall(gt64120_pci_init);
diff -uprN linux-2.6.16.11/arch/mips/gt64120/wrppmc/reset.c linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/reset.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/reset.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/reset.c	2006-04-13 22:24:56.000000000 +0800
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1997 Ralf Baechle
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/system.h>
+#include <asm/cacheflush.h>
+
+void wrppmc_machine_restart(char *command)
+{
+	/*
+	 * Ouch, we're still alive ... This time we take the silver bullet ...
+	 * ... and find that we leave the hardware in a state in which the
+	 * kernel in the flush locks up somewhen during of after the PCI
+	 * detection stuff.
+	 */
+	local_irq_disable();
+	set_c0_status(ST0_BEV | ST0_ERL);
+	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+	flush_cache_all();
+	write_c0_wired(0);
+	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
+}
+
+void wrppmc_machine_halt(void)
+{
+	local_irq_disable();
+	
+	printk(KERN_NOTICE "You can safely turn off the power\n");
+	while (1) {
+		__asm__(
+			".set\tmips3\n\t"
+			"wait\n\t"
+			".set\tmips0"
+		);
+	}
+}
+
+void wrppmc_machine_power_off(void)
+{
+	wrppmc_machine_halt();
+}
diff -uprN linux-2.6.16.11/arch/mips/gt64120/wrppmc/setup.c linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/setup.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/setup.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/setup.c	2006-05-06 16:05:30.000000000 +0800
@@ -0,0 +1,173 @@
+/*
+ * setup.c: Setup pointers to hardware dependent routines.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1996, 1997, 2004 by Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2006, Wind River System Inc. Rongkai.zhan <rongkai.zhan@windriver.com>
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/pm.h>
+
+#include <asm/io.h>
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/gt64120.h>
+
+unsigned long gt64120_base = KSEG1ADDR(0x14000000);
+
+#ifdef WRPPMC_EARLY_DEBUG
+
+static volatile unsigned char * wrppmc_led = \
+	(volatile unsigned char *)KSEG1ADDR(WRPPMC_LED_BASE);
+
+/*
+ * PPMC LED control register:
+ * -) bit[0] controls DS1 LED (1 - OFF, 0 - ON)
+ * -) bit[1] controls DS2 LED (1 - OFF, 0 - ON)
+ * -) bit[2] controls DS4 LED (1 - OFF, 0 - ON)
+ */
+void wrppmc_led_on(int mask)
+{
+	unsigned char value = *wrppmc_led;
+	
+	value &= (0xF8 | mask);
+	*wrppmc_led = value;
+}
+
+/* If mask = 0, turn off all LEDs */
+void wrppmc_led_off(int mask)
+{
+	unsigned char value = *wrppmc_led;
+
+	value |= (0x7 & mask);
+	*wrppmc_led = value;
+}
+
+/*
+ * We assume that bootloader has initialized UART16550 correctly
+ */
+void __init wrppmc_early_putc(char ch)
+{
+	static volatile unsigned char *wrppmc_uart = \
+		(volatile unsigned char *)KSEG1ADDR(WRPPMC_UART16550_BASE);
+	unsigned char value;
+
+	/* Wait until Transmit-Holding-Register is empty */
+	while (1) {
+		value = *(wrppmc_uart + 5);
+		if (value & 0x20)
+			break;
+	}
+	
+	*wrppmc_uart = ch;
+}
+
+void __init wrppmc_early_printk(const char *fmt, ...)
+{
+	static char pbuf[256] = {'\0', };
+	char *ch = pbuf;
+	va_list args;
+	unsigned int i;
+
+	memset(pbuf, 0, 256);
+	va_start(args, fmt);
+	i = vsprintf(pbuf, fmt, args);
+	va_end(args);
+
+	/* Print the string */
+	while (*ch != '\0') {
+		wrppmc_early_putc(*ch);
+		/* if print '\n', also print '\r' */
+		if (*ch++ == '\n')
+			wrppmc_early_putc('\r');
+	}
+}
+#endif /* WRPPMC_EARLY_DEBUG */
+
+unsigned long __init prom_free_prom_memory(void)
+{
+	return 0;
+}
+
+#ifdef CONFIG_SERIAL_8250
+static void wrppmc_setup_serial(void)
+{
+	struct uart_port up;
+	
+	memset(&up, 0x00, sizeof(struct uart_port));
+
+	/*
+	 * A note about mapbase/membase
+	 * -) mapbase is the physical address of the IO port.
+	 * -) membase is an 'ioremapped' cookie.
+	 */
+	up.line = 0;
+	up.type = PORT_16550;
+	up.iotype = UPIO_MEM;
+	up.mapbase = WRPPMC_UART16550_BASE;
+	up.membase = ioremap(up.mapbase, 8);
+	up.irq = WRPPMC_UART16550_IRQ;
+	up.uartclk = WRPPMC_UART16550_CLOCK;
+	up.flags = UPF_SKIP_TEST/* | UPF_BOOT_AUTOCONF */;
+	up.regshift = 0;
+	
+	early_serial_setup(&up);
+}
+#endif
+
+void __init plat_setup(void)
+{
+	extern void wrppmc_time_init(void);
+	extern void wrppmc_timer_setup(struct irqaction *);
+	extern void wrppmc_machine_restart(char *command);
+	extern void wrppmc_machine_halt(void);
+	extern void wrppmc_machine_power_off(void);
+	
+	_machine_restart = wrppmc_machine_restart;
+	_machine_halt	 = wrppmc_machine_halt;
+	pm_power_off	 = wrppmc_machine_power_off;
+	
+	/* Use MIPS Count/Compare Timer */
+	board_time_init   = wrppmc_time_init;
+	board_timer_setup = wrppmc_timer_setup;
+
+	/* This makes the operations of 'in/out[bwl]' to the
+	 * physical address ( < KSEG0) can work via KSEG1
+	 */
+	set_io_port_base(KSEG1);
+
+#ifdef CONFIG_SERIAL_8250
+	wrppmc_setup_serial();
+#endif
+}
+
+const char *get_system_type(void)
+{
+	return "Wind River PPMC (GT64120)";
+}
+
+/*
+ * Initializes basic routines and structures pointers, memory size (as
+ * given by the bios and saves the command line.
+ */
+void __init prom_init(void)
+{
+	mips_machgroup = MACH_GROUP_GALILEO;
+	mips_machtype = MACH_EV64120A;
+
+	add_memory_region(WRPPMC_SDRAM_SCS0_BASE, WRPPMC_SDRAM_SCS0_SIZE, BOOT_MEM_RAM);
+	add_memory_region(WRPPMC_BOOTROM_BASE, WRPPMC_BOOTROM_SIZE, BOOT_MEM_ROM_DATA);
+	
+	wrppmc_early_printk("prom_init: GT64120 SDRAM Bank 0: 0x%x - 0x%08lx\n",
+			WRPPMC_SDRAM_SCS0_BASE, (WRPPMC_SDRAM_SCS0_BASE + WRPPMC_SDRAM_SCS0_SIZE));
+}
diff -uprN linux-2.6.16.11/arch/mips/gt64120/wrppmc/time.c linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/time.c
--- linux-2.6.16.11/arch/mips/gt64120/wrppmc/time.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/gt64120/wrppmc/time.c	2006-05-05 16:39:32.000000000 +0800
@@ -0,0 +1,57 @@
+/*
+ * time.c: MIPS CPU Count/Compare timer hookup
+ *
+ * Author: Mark.Zhan, <rongkai.zhan@windriver.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1996, 1997, 2004 by Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2006, Wind River System Inc.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/param.h>	/* for HZ */
+#include <linux/irq.h>
+#include <linux/timex.h>
+#include <linux/interrupt.h>
+
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/bootinfo.h>
+#include <asm/gt64120.h>
+
+#define WRPPMC_CPU_CLK_FREQ 40000000 /* 40MHZ */
+
+void __init wrppmc_timer_setup(struct irqaction *irq)
+{
+	/* Install ISR for timer interrupt */
+	setup_irq(WRPPMC_MIPS_TIMER_IRQ, irq);
+
+	/* to generate the first timer interrupt */
+	write_c0_compare(mips_hpt_frequency/HZ);
+	write_c0_count(0);
+}
+
+/*
+ * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
+ *
+ * NOTE: We disable all GT64120 timers, and use MIPS processor internal
+ * timer as the source of kernel clock tick.
+ */
+void __init wrppmc_time_init(void)
+{
+	/* Disable GT64120 timers */
+	GT_WRITE(GT_TC_CONTROL_OFS, 0x00);
+	GT_WRITE(GT_TC0_OFS, 0x00);
+	GT_WRITE(GT_TC1_OFS, 0x00);
+	GT_WRITE(GT_TC2_OFS, 0x00);
+	GT_WRITE(GT_TC3_OFS, 0x00);
+
+	/* Use MIPS compare/count internal timer */
+	mips_hpt_frequency = WRPPMC_CPU_CLK_FREQ;
+}
diff -uprN linux-2.6.16.11/arch/mips/Kconfig linux-2.6.16.11-ppmc/arch/mips/Kconfig
--- linux-2.6.16.11/arch/mips/Kconfig	2006-04-25 04:20:24.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/Kconfig	2006-05-05 10:53:40.000000000 +0800
@@ -326,6 +326,27 @@ config MIPS_SEAD
 	  This enables support for the MIPS Technologies SEAD evaluation
 	  board.

+config WR_PPMC
+	bool "Support for Wind River PPMC board"
+	select IRQ_CPU
+	select BOOT_ELF32
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select MIPS_GT64120
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS64_R1
+	select SYS_HAS_CPU_NEVADA
+	select SYS_HAS_CPU_RM7000
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	help
+	  This enables support for the Wind River MIPS32 4KC PPMC evaluation
+	  board, which is based on GT64120 bridge chip.
+
 config MIPS_SIM
 	bool 'Support for MIPS simulator (MIPSsim)'
 	select DMA_NONCOHERENT
diff -uprN linux-2.6.16.11/arch/mips/Makefile linux-2.6.16.11-ppmc/arch/mips/Makefile
--- linux-2.6.16.11/arch/mips/Makefile	2006-04-25 04:20:24.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/Makefile	2006-05-05 12:42:16.000000000 +0800
@@ -419,6 +419,13 @@ cflags-$(CONFIG_MIPS_EV96100)	+= -Iinclu
 load-$(CONFIG_MIPS_EV96100)	+= 0xffffffff80100000

 #
+# Wind River PPMC Board (4KC + GT64120)
+#
+core-$(CONFIG_WR_PPMC)		+= arch/mips/gt64120/wrppmc/
+cflags-$(CONFIG_WR_PPMC)		+= -Iinclude/asm-mips/mach-wrppmc
+load-$(CONFIG_WR_PPMC)		+= 0xffffffff80100000
+
+#
 # Globespan IVR eval board with QED 5231 CPU
 #
 core-$(CONFIG_ITE_BOARD_GEN)	+= arch/mips/ite-boards/generic/
diff -uprN linux-2.6.16.11/arch/mips/pci/fixup-wrppmc.c linux-2.6.16.11-ppmc/arch/mips/pci/fixup-wrppmc.c
--- linux-2.6.16.11/arch/mips/pci/fixup-wrppmc.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/pci/fixup-wrppmc.c	2006-05-06 15:24:57.000000000 +0800
@@ -0,0 +1,37 @@
+/*
+ * fixup-wrppmc.c: PPMC board specific PCI fixup
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006, Wind River Inc. Rongkai.zhan (rongkai.zhan@windriver.com)
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/gt64120.h>
+
+/* PCI interrupt pins */
+#define PCI_INTA		1
+#define PCI_INTB		2
+#define PCI_INTC		3
+#define PCI_INTD		4
+
+#define PCI_SLOT_MAXNR	32 /* Each PCI bus has 32 physical slots */
+
+static char pci_irq_tab[PCI_SLOT_MAXNR][5] __initdata = {
+	/* 0    INTA   INTB   INTC   INTD */
+	[0] = {0, 0, 0, 0, 0},		/* Slot 0: GT64120 PCI bridge */
+	[6] = {0, WRPPMC_PCI_INTA_IRQ, 0, 0, 0},
+};
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return pci_irq_tab[slot][pin];
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
diff -uprN linux-2.6.16.11/arch/mips/pci/Makefile linux-2.6.16.11-ppmc/arch/mips/pci/Makefile
--- linux-2.6.16.11/arch/mips/pci/Makefile	2006-04-25 04:20:24.000000000 +0800
+++ linux-2.6.16.11-ppmc/arch/mips/pci/Makefile	2006-05-05 11:30:44.000000000 +0800
@@ -57,3 +57,4 @@ obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-
 obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-tx4938.o ops-tx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
+obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
diff -uprN linux-2.6.16.11/include/asm-mips/mach-wrppmc/mach-gt64120.h linux-2.6.16.11-ppmc/include/asm-mips/mach-wrppmc/mach-gt64120.h
--- linux-2.6.16.11/include/asm-mips/mach-wrppmc/mach-gt64120.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.16.11-ppmc/include/asm-mips/mach-wrppmc/mach-gt64120.h	2006-05-06 15:31:51.000000000 +0800
@@ -0,0 +1,84 @@
+/*
+ * This is a direct copy of the ev96100.h file, with a global
+ * search and replace.  The numbers are the same.
+ *
+ * The reason I'm duplicating this is so that the 64120/96100
+ * defines won't be confusing in the source code.
+ */
+#ifndef __ASM_MIPS_GT64120_H
+#define __ASM_MIPS_GT64120_H
+
+/*
+ * This is the CPU physical memory map of PPMC Board:
+ *
+ *    0x00000000-0x03FFFFFF      - 64MB SDRAM (SCS[0]#)
+ *    0x1C000000-0x1C000000      - LED (CS0)
+ *    0x1C800000-0x1C800007      - UART 16550 port (CS1)
+ *    0x1F000000-0x1F000000      - MailBox (CS3)
+ *    0x1FC00000-0x20000000      - 4MB Flash (BOOT CS)
+ */
+
+#define WRPPMC_SDRAM_SCS0_BASE	0x00000000
+#define WRPPMC_SDRAM_SCS0_SIZE	0x04000000
+
+#define WRPPMC_UART16550_BASE	0x1C800000
+#define WRPPMC_UART16550_CLOCK	3686400 /* 3.68MHZ */
+
+#define WRPPMC_LED_BASE		0x1C000000
+#define WRPPMC_MBOX_BASE	0x1F000000
+
+#define WRPPMC_BOOTROM_BASE	0x1FC00000
+#define WRPPMC_BOOTROM_SIZE	0x00400000 /* 4M Flash */
+
+#define WRPPMC_MIPS_TIMER_IRQ	7 /* MIPS compare/count timer interrupt */
+#define WRPPMC_UART16550_IRQ	6
+#define WRPPMC_PCI_INTA_IRQ	3
+
+/*
+ * PCI Bus I/O and Memory resources allocation
+ *
+ * NOTE: We only have PCI_0 hose interface
+ */
+#define GT_PCI_MEM_BASE	0x13000000UL
+#define GT_PCI_MEM_SIZE	0x02000000UL
+#define GT_PCI_IO_BASE	0x11000000UL
+#define GT_PCI_IO_SIZE	0x02000000UL
+#define GT_ISA_IO_BASE	PCI_IO_BASE
+
+/*
+ * PCI interrupts will come in on either the INTA or INTD interrups lines,
+ * which are mapped to the #2 and #5 interrupt pins of the MIPS.  On our
+ * boards, they all either come in on IntD or they all come in on IntA, they
+ * aren't mixed. There can be numerous PCI interrupts, so we keep a list of the
+ * "requested" interrupt numbers and go through the list whenever we get an
+ * IntA/D.
+ *
+ * Interrupts < 8 are directly wired to the processor; PCI INTA is 8 and
+ * INTD is 11.
+ */
+#define GT_TIMER	4
+#define GT_INTA		2
+#define GT_INTD		5
+
+#ifndef __ASSEMBLY__
+
+/*
+ * GT64120 internal register space base address
+ */
+extern unsigned long gt64120_base;
+
+#define GT64120_BASE	(gt64120_base)
+
+/* define WRPPMC_EARLY_DEBUG to enable early output something to UART */
+#undef WRPPMC_EARLY_DEBUG
+
+#ifdef WRPPMC_EARLY_DEBUG
+extern void wrppmc_led_on(int mask);
+extern void wrppmc_led_off(int mask);
+extern void wrppmc_early_printk(const char *fmt, ...);
+#else
+#define wrppmc_early_printk(fmt, ...) do {} while (0)
+#endif /* WRPPMC_EARLY_DEBUG */
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_MIPS_GT64120_H */
