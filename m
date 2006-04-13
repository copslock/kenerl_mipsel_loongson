Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Apr 2006 23:45:29 +0100 (BST)
Received: from smtp6.centerbeam.com ([63.120.115.250]:11272 "EHLO
	SMTP6.centerbeam.com") by ftp.linux-mips.org with ESMTP
	id S8133712AbWDMWpC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Apr 2006 23:45:02 +0100
Received: from tararisvle2k03.tarari.centerbeam.com ([64.95.101.58]) by SMTP6.centerbeam.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 13 Apr 2006 15:56:54 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C65F4D.8DC96563"
Subject: System freeze accompanied by msg 'BUG: soft lockup detected on CPU'
Date:	Thu, 13 Apr 2006 15:56:51 -0700
Message-ID: <A8F5ABA4D8E37C4CA2515D4714C9EF8FDFBCA1@tararisvle2k03.tarari.centerbeam.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: System freeze accompanied by msg 'BUG: soft lockup detected on CPU'
Thread-Index: AcZfTVy3pSLw6qJtRI+89j49BtKCLgAAChuw
From:	"Adam Scislowicz" <AScislowicz@tarari.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 13 Apr 2006 22:56:54.0591 (UTC) FILETIME=[8F2DECF0:01C65F4D]
Return-Path: <AScislowicz@Tarari.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AScislowicz@tarari.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C65F4D.8DC96563
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Kernel: Linux 2.6.15
Target: mips (32bit, big endian), SMP 4way (2way also crashes)
preemption model =3D server (least preempt), do not preempt the big =
kernel
crash
Board: Broadcom 1480B

How to reproduce: I made a bash script which awks a file line by line...
	while true; do
		echo "crash me..."
		ls
	done

The neither the 'echo' or 'ls' commands are necessary. Originally I
would see it crash in a bash script which calls awk, or during the init
sciprts sometimes. The above script causes it to crash within a minute
every time I have run it.

[4294909.579000] BUG: soft lockup detected on CPU#0!
[4294909.579000] Cpu 0
[4294909.579000] $ 0   : 00000000 30001f00 00000002 00000000
[4294909.579000] $ 4   : 30001f01 b00260c8 0f0f0f0f 00000004
[4294909.579000] $ 8   : 00000000 1000001e 70000053 00000063
[4294909.579000] $12   : 7fca0010 00000004 00000000 00000004
[4294909.579000] $16   : 00000004 00000003 00000000 00000001
[4294909.579000] $20   : 8010e398 8f949dc8 8f93be20 00000000
[4294909.579000] $24   : 00000000 2aabb750
[4294909.579000] $28   : 8f948000 8f949d70 2ab0dd0b 8010b2f8
[4294909.579000] Hi    : 00000000
[4294909.579000] Lo    : 0000000c
[4294909.579000] epc   : 8010b314 smp_call_function+0x11c/0x1bc     Not
tainted
[4294909.579000] ra    : 8010b2f8 smp_call_function+0x100/0x1bc
[4294909.579000] Status: 30001f03    KERNEL EXL IE
[4294909.579000] Cause : 00809000
[4294909.579000] PrId  : 01041100

With 8010e398 being sb1_flush_icache_page_ipi()

Thank,
Adam Scislowicz=20

-- kernel .config

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.15
# Wed Apr 12 13:52:44 2006
#
CONFIG_MIPS=3Dy

#
# Machine selection
#
# CONFIG_MIPS_MTX1 is not set
# CONFIG_MIPS_BOSPORUS is not set
# CONFIG_MIPS_PB1000 is not set
# CONFIG_MIPS_PB1100 is not set
# CONFIG_MIPS_PB1500 is not set
# CONFIG_MIPS_PB1550 is not set
# CONFIG_MIPS_PB1200 is not set
# CONFIG_MIPS_DB1000 is not set
# CONFIG_MIPS_DB1100 is not set
# CONFIG_MIPS_DB1500 is not set
# CONFIG_MIPS_DB1550 is not set
# CONFIG_MIPS_DB1200 is not set
# CONFIG_MIPS_MIRAGE is not set
# CONFIG_MIPS_COBALT is not set
# CONFIG_MACH_DECSTATION is not set
# CONFIG_MIPS_EV64120 is not set
# CONFIG_MIPS_EV96100 is not set
# CONFIG_MIPS_IVR is not set
# CONFIG_MIPS_ITE8172 is not set
# CONFIG_MACH_JAZZ is not set
# CONFIG_LASAT is not set
# CONFIG_MIPS_ATLAS is not set
# CONFIG_MIPS_MALTA is not set
# CONFIG_MIPS_SEAD is not set
# CONFIG_MIPS_SIM is not set
# CONFIG_MOMENCO_JAGUAR_ATX is not set
# CONFIG_MOMENCO_OCELOT is not set
# CONFIG_MOMENCO_OCELOT_3 is not set
# CONFIG_MOMENCO_OCELOT_C is not set
# CONFIG_MOMENCO_OCELOT_G is not set
# CONFIG_MIPS_XXS1500 is not set
# CONFIG_PNX8550_V2PCI is not set
# CONFIG_PNX8550_JBS is not set
# CONFIG_DDB5074 is not set
# CONFIG_DDB5476 is not set
# CONFIG_DDB5477 is not set
# CONFIG_MACH_VR41XX is not set
# CONFIG_PMC_YOSEMITE is not set
# CONFIG_QEMU is not set
# CONFIG_SGI_IP22 is not set
# CONFIG_SGI_IP27 is not set
# CONFIG_SGI_IP32 is not set
CONFIG_SIBYTE_BIGSUR=3Dy
# CONFIG_SIBYTE_SWARM is not set
# CONFIG_SIBYTE_SENTOSA is not set
# CONFIG_SIBYTE_RHONE is not set
# CONFIG_SIBYTE_CARMEL is not set
# CONFIG_SIBYTE_PTSWARM is not set
# CONFIG_SIBYTE_LITTLESUR is not set
# CONFIG_SIBYTE_CRHINE is not set
# CONFIG_SIBYTE_CRHONE is not set
# CONFIG_SNI_RM200_PCI is not set
# CONFIG_TOSHIBA_JMR3927 is not set
# CONFIG_TOSHIBA_RBTX4927 is not set
# CONFIG_TOSHIBA_RBTX4938 is not set
CONFIG_SIBYTE_BCM1x80=3Dy
CONFIG_SIBYTE_SB1xxx_SOC=3Dy
# CONFIG_CPU_SB1_PASS_1 is not set
# CONFIG_CPU_SB1_PASS_2_1250 is not set
# CONFIG_CPU_SB1_PASS_2_2 is not set
# CONFIG_CPU_SB1_PASS_4 is not set
# CONFIG_CPU_SB1_PASS_2_112x is not set
# CONFIG_CPU_SB1_PASS_3 is not set
# CONFIG_SIMULATION is not set
# CONFIG_SB1_CEX_ALWAYS_FATAL is not set
# CONFIG_SB1_CERR_STALL is not set
CONFIG_SIBYTE_CFE=3Dy
# CONFIG_SIBYTE_CFE_CONSOLE is not set
# CONFIG_SIBYTE_BUS_WATCHER is not set
# CONFIG_SIBYTE_SB1250_PROF is not set
# CONFIG_SIBYTE_TBPROF is not set
CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_DMA_COHERENT=3Dy
CONFIG_CPU_BIG_ENDIAN=3Dy
# CONFIG_CPU_LITTLE_ENDIAN is not set
CONFIG_SYS_SUPPORTS_BIG_ENDIAN=3Dy
CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=3Dy
CONFIG_SWAP_IO_SPACE=3Dy
CONFIG_BOOT_ELF32=3Dy
CONFIG_MIPS_L1_CACHE_SHIFT=3D5

#
# CPU selection
#
# CONFIG_CPU_MIPS32_R1 is not set
# CONFIG_CPU_MIPS32_R2 is not set
# CONFIG_CPU_MIPS64_R1 is not set
# CONFIG_CPU_MIPS64_R2 is not set
# CONFIG_CPU_R3000 is not set
# CONFIG_CPU_TX39XX is not set
# CONFIG_CPU_VR41XX is not set
# CONFIG_CPU_R4300 is not set
# CONFIG_CPU_R4X00 is not set
# CONFIG_CPU_TX49XX is not set
# CONFIG_CPU_R5000 is not set
# CONFIG_CPU_R5432 is not set
# CONFIG_CPU_R6000 is not set
# CONFIG_CPU_NEVADA is not set
# CONFIG_CPU_R8000 is not set
# CONFIG_CPU_R10000 is not set
# CONFIG_CPU_RM7000 is not set
# CONFIG_CPU_RM9000 is not set
CONFIG_CPU_SB1=3Dy
CONFIG_SYS_HAS_CPU_SB1=3Dy
CONFIG_SYS_SUPPORTS_32BIT_KERNEL=3Dy
CONFIG_SYS_SUPPORTS_64BIT_KERNEL=3Dy
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=3Dy
CONFIG_CPU_SUPPORTS_64BIT_KERNEL=3Dy

#
# Kernel type
#
CONFIG_32BIT=3Dy
# CONFIG_64BIT is not set
CONFIG_PAGE_SIZE_4KB=3Dy
# CONFIG_PAGE_SIZE_8KB is not set
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
# CONFIG_SIBYTE_DMA_PAGEOPS is not set
# CONFIG_MIPS_MT is not set
# CONFIG_64BIT_PHYS_ADDR is not set
# CONFIG_CPU_ADVANCED is not set
CONFIG_CPU_HAS_LLSC=3Dy
CONFIG_CPU_HAS_SYNC=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_CPU_SUPPORTS_HIGHMEM=3Dy
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_SMP=3Dy
CONFIG_NR_CPUS=3D4
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_BKL is not set

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=3Dy
CONFIG_KOBJECT_UEVENT=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_CPUSETS is not set
CONFIG_INITRAMFS_SOURCE=3D""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_EMBEDDED=3Dy
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_MODULE_SRCVERSION_ALL=3Dy
CONFIG_KMOD=3Dy
CONFIG_STOP_MACHINE=3Dy

#
# Block layer
#
# CONFIG_LBD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_AS=3Dy
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"anticipatory"

#
# Bus options (PCI, PCMCIA, EISA, ISA, TC)
#
CONFIG_HW_HAS_PCI=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_PCI_LEGACY_PROC=3Dy
CONFIG_PCI_DEBUG=3Dy
CONFIG_MMU=3Dy

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=3Dy
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=3Dy
CONFIG_PCMCIA_LOAD_CIS=3Dy
CONFIG_PCMCIA_IOCTL=3Dy
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
CONFIG_TRAD_SIGNALS=3Dy

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm
CONFIG_NET_KEY=3Dy
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
CONFIG_IP_PNP=3Dy
CONFIG_IP_PNP_DHCP=3Dy
CONFIG_IP_PNP_BOOTP=3Dy
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=3Dy
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=3Dm
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D65536
CONFIG_BLK_DEV_INITRD=3Dy
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECS=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
CONFIG_BLK_DEV_IDETAPE=3Dy
CONFIG_BLK_DEV_IDEFLOPPY=3Dy
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dy
# CONFIG_BLK_DEV_IDEPCI is not set
# CONFIG_BLK_DEV_IDE_SWARM is not set
# CONFIG_IDE_ARM is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
CONFIG_NET_SB1250_MAC=3Dy
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
# CONFIG_SERIO_I8042 is not set
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_LIBPS2 is not set
CONFIG_SERIO_RAW=3Dm
# CONFIG_GAMEPORT is not set

#
# Character devices
#
# CONFIG_VT is not set
CONFIG_SERIAL_NONSTANDARD=3Dy
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_STALDRV is not set
CONFIG_SIBYTE_SB1250_DUART=3Dy
CONFIG_SIBYTE_SB1250_DUART_CONSOLE=3Dy

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_RTC is not set
CONFIG_GEN_RTC=3Dy
# CONFIG_GEN_RTC_X is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=3Dy
CONFIG_I2C_CHARDEV=3Dy

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set
CONFIG_I2C_ALGO_SIBYTE=3Dy

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
CONFIG_I2C_SIBYTE=3Dy
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
CONFIG_SENSORS_DS1337=3Dy
CONFIG_SENSORS_DS1374=3Dy
CONFIG_SENSORS_EEPROM=3Dy
CONFIG_SENSORS_PCF8574=3Dy
CONFIG_SENSORS_PCA9539=3Dy
CONFIG_SENSORS_PCF8591=3Dy
CONFIG_SENSORS_RTC8564=3Dy
CONFIG_SENSORS_MAX6875=3Dy
# CONFIG_RTC_X1205_I2C is not set
CONFIG_I2C_DEBUG_CORE=3Dy
CONFIG_I2C_DEBUG_ALGO=3Dy
CONFIG_I2C_DEBUG_BUS=3Dy
CONFIG_I2C_DEBUG_CHIP=3Dy

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set
# CONFIG_HWMON_VID is not set

#
# Misc devices
#

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
# CONFIG_USB is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=3Dy
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=3Dy
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=3Dy

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy
# CONFIG_RELAYFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_LOG_BUF_SHIFT=3D16
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_CROSSCOMPILE=3Dy
CONFIG_CMDLINE=3D""
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_KGDB is not set
# CONFIG_SB1XXX_CORELIS is not set
# CONFIG_RUNTIME_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=3Dy
CONFIG_KEYS_DEBUG_PROC_KEYS=3Dy
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dy
CONFIG_CRYPTO_MD4=3Dy
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dy
CONFIG_CRYPTO_SHA512=3Dy
CONFIG_CRYPTO_WP512=3Dm
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_BLOWFISH=3Dy
CONFIG_CRYPTO_TWOFISH=3Dy
CONFIG_CRYPTO_SERPENT=3Dy
CONFIG_CRYPTO_AES=3Dm
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_TEA=3Dm
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dy
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=3Dy
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy

------_=_NextPart_001_01C65F4D.8DC96563
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-asci=
i">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7226.0=
">
<TITLE>System freeze accompanied by msg 'BUG: soft lockup detected on CPU=
'</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Kernel=
: Linux 2.6.15</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Target=
: mips (32bit, big endian), SMP 4way (2way also crashes)</FONT></SPAN></P=
>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">preemp=
tion model =3D server (least preempt), do not preempt the big kernel cras=
h</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Board:=
 Broadcom 1480B</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">How to=
 reproduce: I made a bash script which awks a file line by line&#8230;</F=
ONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <FONT SIZE=3D2 FACE=3D"Arial">while true; do</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 FACE=3D"=
Arial">echo &#8220;crash me&#8230;&#8221;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 FACE=3D"=
Arial">ls</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <FONT SIZE=3D2 FACE=3D"Arial">done</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">The ne=
ither the &#8216;echo&#8217; or &#8216;ls&#8217; commands are necessary. =
Originally I would see it crash in a bash script which calls awk, or duri=
ng the init sciprts sometimes. The above script causes it to crash within=
 a minute every time I have run it.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] BUG: soft lockup detected on CPU#0!</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] Cpu 0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] $ 0&nbsp;&nbsp; : 00000000 30001f00 00000002 00000000</FONT></=
SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] $ 4&nbsp;&nbsp; : 30001f01 b00260c8 0f0f0f0f 00000004</FONT></=
SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] $ 8&nbsp;&nbsp; : 00000000 1000001e 70000053 00000063</FONT></=
SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] $12&nbsp;&nbsp; : 7fca0010 00000004 00000000 00000004</FONT></=
SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] $16&nbsp;&nbsp; : 00000004 00000003 00000000 00000001</FONT></=
SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] $20&nbsp;&nbsp; : 8010e398 8f949dc8 8f93be20 00000000</FONT></=
SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] $24&nbsp;&nbsp; : 00000000 2aabb750</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] $28&nbsp;&nbsp; : 8f948000 8f949d70 2ab0dd0b 8010b2f8</FONT></=
SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] Hi&nbsp;&nbsp;&nbsp; : 00000000</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] Lo&nbsp;&nbsp;&nbsp; : 0000000c</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] epc&nbsp;&nbsp; : 8010b314 smp_call_function+0x11c/0x1bc&nbsp;=
&nbsp;&nbsp;&nbsp; Not tainted</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] ra&nbsp;&nbsp;&nbsp; : 8010b2f8 smp_call_function+0x100/0x1bc<=
/FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] Status: 30001f03&nbsp;&nbsp;&nbsp; KERNEL EXL IE</FONT></SPAN>=
</P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] Cause : 00809000</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">[42949=
09.579000] PrId&nbsp; : 01041100</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">With 8=
010e398 being sb1_flush_icache_page_ipi()</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Thank,=
</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Adam S=
cislowicz </FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">-- ker=
nel .config</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Auto=
matically generated make config: don't edit</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Linu=
x kernel version: 2.6.15</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Wed =
Apr 12 13:52:44 2006</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MIPS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Mach=
ine selection</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_MTX1 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_BOSPORUS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_PB1000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_PB1100 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_PB1500 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_PB1550 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_PB1200 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_DB1000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_DB1100 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_DB1500 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_DB1550 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_DB1200 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_MIRAGE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_COBALT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MACH_DECSTATION is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_EV64120 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_EV96100 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_IVR is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_ITE8172 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MACH_JAZZ is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_LASAT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_ATLAS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_MALTA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_SEAD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_SIM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MOMENCO_JAGUAR_ATX is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MOMENCO_OCELOT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MOMENCO_OCELOT_3 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MOMENCO_OCELOT_C is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MOMENCO_OCELOT_G is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_XXS1500 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PNX8550_V2PCI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PNX8550_JBS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DDB5074 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DDB5476 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DDB5477 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MACH_VR41XX is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PMC_YOSEMITE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_QEMU is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SGI_IP22 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SGI_IP27 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SGI_IP32 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SIBYTE_BIGSUR=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_SWARM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_SENTOSA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_RHONE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_CARMEL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_PTSWARM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_LITTLESUR is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_CRHINE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_CRHONE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SNI_RM200_PCI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TOSHIBA_JMR3927 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TOSHIBA_RBTX4927 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TOSHIBA_RBTX4938 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SIBYTE_BCM1x80=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SIBYTE_SB1xxx_SOC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_SB1_PASS_1 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_SB1_PASS_2_1250 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_SB1_PASS_2_2 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_SB1_PASS_4 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_SB1_PASS_2_112x is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_SB1_PASS_3 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIMULATION is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SB1_CEX_ALWAYS_FATAL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SB1_CERR_STALL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SIBYTE_CFE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_CFE_CONSOLE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_BUS_WATCHER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_SB1250_PROF is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_TBPROF is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_RWSEM_GENERIC_SPINLOCK=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_GENERIC_CALIBRATE_DELAY=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_DMA_COHERENT=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CPU_BIG_ENDIAN=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_LITTLE_ENDIAN is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SYS_SUPPORTS_BIG_ENDIAN=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SYS_SUPPORTS_LITTLE_ENDIAN=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SWAP_IO_SPACE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BOOT_ELF32=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MIPS_L1_CACHE_SHIFT=3D5</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CPU =
selection</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_MIPS32_R1 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_MIPS32_R2 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_MIPS64_R1 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_MIPS64_R2 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_R3000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_TX39XX is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_VR41XX is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_R4300 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_R4X00 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_TX49XX is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_R5000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_R5432 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_R6000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_NEVADA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_R8000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_R10000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_RM7000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_RM9000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CPU_SB1=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SYS_HAS_CPU_SB1=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SYS_SUPPORTS_32BIT_KERNEL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SYS_SUPPORTS_64BIT_KERNEL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CPU_SUPPORTS_32BIT_KERNEL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CPU_SUPPORTS_64BIT_KERNEL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Kern=
el type</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_32BIT=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_64BIT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PAGE_SIZE_4KB=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PAGE_SIZE_8KB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PAGE_SIZE_16KB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PAGE_SIZE_64KB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIBYTE_DMA_PAGEOPS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MIPS_MT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_64BIT_PHYS_ADDR is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPU_ADVANCED is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CPU_HAS_LLSC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CPU_HAS_SYNC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_GENERIC_HARDIRQS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_GENERIC_IRQ_PROBE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CPU_SUPPORTS_HIGHMEM=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_ARCH_FLATMEM_ENABLE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SELECT_MEMORY_MODEL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FLATMEM_MANUAL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DISCONTIGMEM_MANUAL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SPARSEMEM_MANUAL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FLATMEM=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FLAT_NODE_MEM_MAP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SPARSEMEM_STATIC is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SPLIT_PTLOCK_CPUS=3D4</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SMP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NR_CPUS=3D4</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PREEMPT_NONE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PREEMPT_VOLUNTARY is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PREEMPT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PREEMPT_BKL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Code=
 maturity level options</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_EXPERIMENTAL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CLEAN_COMPILE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_LOCK_KERNEL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_INIT_ENV_ARG_LIMIT=3D32</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Gene=
ral setup</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_LOCALVERSION=3D&quot;&quot;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_LOCALVERSION_AUTO=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SWAP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SYSVIPC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_POSIX_MQUEUE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BSD_PROCESS_ACCT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SYSCTL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_AUDIT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_HOTPLUG=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_KOBJECT_UEVENT=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IKCONFIG=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IKCONFIG_PROC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CPUSETS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_INITRAMFS_SOURCE=3D&quot;&quot;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CC_OPTIMIZE_FOR_SIZE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_EMBEDDED=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_KALLSYMS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_KALLSYMS_ALL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_KALLSYMS_EXTRA_PASS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PRINTK=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BUG=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BASE_FULL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FUTEX=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_EPOLL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SHMEM=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CC_ALIGN_FUNCTIONS=3D0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CC_ALIGN_LABELS=3D0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CC_ALIGN_LOOPS=3D0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CC_ALIGN_JUMPS=3D0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TINY_SHMEM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BASE_SMALL=3D0</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Load=
able module support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MODULES=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MODULE_UNLOAD=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MODULE_FORCE_UNLOAD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_OBSOLETE_MODPARM=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MODVERSIONS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MODULE_SRCVERSION_ALL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_KMOD=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_STOP_MACHINE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Bloc=
k layer</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_LBD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># IO S=
chedulers</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IOSCHED_NOOP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IOSCHED_AS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IOSCHED_DEADLINE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IOSCHED_CFQ=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_DEFAULT_AS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEFAULT_DEADLINE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEFAULT_CFQ is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEFAULT_NOOP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_DEFAULT_IOSCHED=3D&quot;anticipatory&quot;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Bus =
options (PCI, PCMCIA, EISA, ISA, TC)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_HW_HAS_PCI=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PCI=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PCI_DOMAINS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PCI_LEGACY_PROC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PCI_DEBUG=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MMU=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># PCCA=
RD (PCMCIA/CardBus) support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PCCARD=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PCMCIA_DEBUG is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PCMCIA=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PCMCIA_LOAD_CIS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PCMCIA_IOCTL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CARDBUS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># PC-c=
ard bridges</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_YENTA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PD6729 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I82092 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># PCI =
Hotplug Support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HOTPLUG_PCI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Exec=
utable file formats</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BINFMT_ELF=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BINFMT_MISC is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_TRAD_SIGNALS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Netw=
orking</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NET=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Netw=
orking options</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PACKET=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PACKET_MMAP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_UNIX=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_XFRM=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_XFRM_USER=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NET_KEY=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_INET=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IP_MULTICAST is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IP_ADVANCED_ROUTER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IP_FIB_HASH=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IP_PNP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IP_PNP_DHCP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IP_PNP_BOOTP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IP_PNP_RARP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_IPIP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_IPGRE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ARPD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SYN_COOKIES is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_INET_AH is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_INET_ESP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_INET_IPCOMP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_INET_TUNNEL=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_INET_DIAG=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_INET_TCP_DIAG=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TCP_CONG_ADVANCED is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_TCP_CONG_BIC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IPV6 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NETFILTER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># DCCP=
 Configuration (EXPERIMENTAL)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IP_DCCP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># SCTP=
 Configuration (EXPERIMENTAL)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IP_SCTP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ATM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BRIDGE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_VLAN_8021Q is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DECNET is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_LLC2 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IPX is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ATALK is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_X25 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_LAPB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_DIVERT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ECONET is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_WAN_ROUTER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># QoS =
and/or fair queueing</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_SCHED is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Netw=
ork testing</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_PKTGEN is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HAMRADIO is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IRDA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IEEE80211 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Devi=
ce Drivers</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Gene=
ric Driver Options</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_STANDALONE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PREVENT_FIRMWARE_BUILD=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FW_LOADER=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEBUG_DRIVER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Conn=
ector - unified userspace &lt;-&gt; kernelspace linker</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CONNECTOR is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Memo=
ry Technology Devices (MTD)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MTD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Para=
llel port support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PARPORT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Plug=
 and Play support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Bloc=
k devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_CPQ_DA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_CPQ_CISS_DA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_DAC960 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_UMEM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_COW_COMMON is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_LOOP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_CRYPTOLOOP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_NBD=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_SX8 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_RAM=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_RAM_COUNT=3D16</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_RAM_SIZE=3D65536</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_INITRD=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CDROM_PKTCDVD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ATA_OVER_ETH is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># ATA/=
ATAPI/MFM/RLL support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IDE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_IDE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Plea=
se see Documentation/ide.txt for help/info on IDE drives</FONT></SPAN></P=
>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_IDE_SATA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_IDEDISK=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IDEDISK_MULTI_MODE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_IDECS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_IDECD=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_IDETAPE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_BLK_DEV_IDEFLOPPY=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IDE_TASK_IOCTL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># IDE =
chipset support/bugfixes</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_IDE_GENERIC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_IDEPCI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_IDE_SWARM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IDE_ARM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_IDEDMA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IDEDMA_AUTO is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BLK_DEV_HD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># SCSI=
 device support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_RAID_ATTRS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SCSI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Mult=
i-device support (RAID and LVM)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Fusi=
on MPT device support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_FUSION is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># IEEE=
 1394 (FireWire) support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IEEE1394 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># I2O =
device support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2O is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Netw=
ork device support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NETDEVICES=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DUMMY is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BONDING is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_EQUALIZER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TUN is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># ARCn=
et devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ARCNET is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># PHY =
device support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PHYLIB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Ethe=
rnet (10 or 100Mbit)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NET_ETHERNET=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MII=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HAPPYMEAL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SUNGEM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CASSINI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_VENDOR_3COM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Tuli=
p family network device support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_TULIP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HP100 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_PCI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Ethe=
rnet (1000 Mbit)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ACENIC is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DL2K is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_E1000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NS83820 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HAMACHI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_YELLOWFIN is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_R8169 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NET_SB1250_MAC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SIS190 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SKGE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SK98LIN is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TIGON3 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BNX2 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Ethe=
rnet (10000 Mbit)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CHELSIO_T1 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IXGB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_S2IO is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Toke=
n Ring devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TR is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Wire=
less LAN (non-hamradio)</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_RADIO is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># PCMC=
IA network device support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_PCMCIA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Wan =
interfaces</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_WAN is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_FDDI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HIPPI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PPP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SLIP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SHAPER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NETCONSOLE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NETPOLL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NET_POLL_CONTROLLER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># ISDN=
 subsystem</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ISDN is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Tele=
phony Support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PHONE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Inpu=
t device support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_INPUT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Hard=
ware I/O ports</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SERIO=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SERIO_I8042 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SERIO_SERPORT=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SERIO_PCIPS2 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SERIO_LIBPS2 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SERIO_RAW=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_GAMEPORT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Char=
acter devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_VT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SERIAL_NONSTANDARD=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ROCKETPORT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CYCLADES is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DIGIEPCA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MOXA_SMARTIO is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ISI is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SYNCLINKMP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_N_HDLC is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SPECIALIX is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SX is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_STALDRV is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SIBYTE_SB1250_DUART=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SIBYTE_SB1250_DUART_CONSOLE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Seri=
al drivers</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SERIAL_8250 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Non-=
8250 serial port support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SERIAL_JSM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_UNIX98_PTYS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_LEGACY_PTYS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_LEGACY_PTY_COUNT=3D256</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># IPMI=
</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_IPMI_HANDLER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Watc=
hdog Cards</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_WATCHDOG is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_RTC is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_GEN_RTC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_GEN_RTC_X is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DTLK is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_R3964 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_APPLICOM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Ftap=
e, the floppy tape device driver</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DRM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># PCMC=
IA character devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SYNCLINK_CS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CARDMAN_4000 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CARDMAN_4040 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_RAW_DRIVER is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># TPM =
devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TCG_TPM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TELCLOCK is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># I2C =
support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_I2C=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_I2C_CHARDEV=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># I2C =
Algorithms</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_ALGOBIT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_ALGOPCF is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_ALGOPCA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_I2C_ALGO_SIBYTE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># I2C =
Hardware Bus support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_ALI1535 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_ALI1563 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_ALI15X3 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_AMD756 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_AMD8111 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_I801 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_I810 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_PIIX4 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_NFORCE2 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_PARPORT_LIGHT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_PROSAVAGE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_SAVAGE4 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_I2C_SIBYTE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SCx200_ACB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_SIS5595 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_SIS630 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_SIS96X is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_STUB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_VIA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_VIAPRO is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_VOODOO3 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_I2C_PCA_ISA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Misc=
ellaneous I2C Chip support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SENSORS_DS1337=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SENSORS_DS1374=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SENSORS_EEPROM=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SENSORS_PCF8574=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SENSORS_PCA9539=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SENSORS_PCF8591=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SENSORS_RTC8564=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SENSORS_MAX6875=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_RTC_X1205_I2C is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_I2C_DEBUG_CORE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_I2C_DEBUG_ALGO=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_I2C_DEBUG_BUS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_I2C_DEBUG_CHIP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Dall=
as's 1-wire bus</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_W1 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Hard=
ware Monitoring support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HWMON is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HWMON_VID is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Misc=
 devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Mult=
imedia Capabilities Port drivers</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Mult=
imedia devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_VIDEO_DEV is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Digi=
tal Video Broadcasting Devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DVB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Grap=
hics support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_FB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Soun=
d</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SOUND is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># USB =
support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_USB_ARCH_HAS_HCD=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_USB_ARCH_HAS_OHCI=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_USB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># NOTE=
: USB_STORAGE enables SCSI, and 'SCSI disk support'</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># USB =
Gadget Support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_USB_GADGET is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># MMC/=
SD Card support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MMC is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Infi=
niBand support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_INFINIBAND is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># SN D=
evices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># File=
 systems</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_EXT2_FS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_EXT2_FS_XATTR=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_EXT2_FS_POSIX_ACL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_EXT2_FS_SECURITY=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_EXT2_FS_XIP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_EXT3_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_JBD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FS_MBCACHE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_REISERFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_JFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FS_POSIX_ACL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_XFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_MINIX_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ROMFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_INOTIFY=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_QUOTA is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_DNOTIFY=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_AUTOFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_AUTOFS4_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FUSE_FS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CD-R=
OM/DVD Filesystems</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ISO9660_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_UDF_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># DOS/=
FAT/NT Filesystems</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FAT_FS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MSDOS_FS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_VFAT_FS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FAT_DEFAULT_CODEPAGE=3D437</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_FAT_DEFAULT_IOCHARSET=3D&quot;iso8859-1&quot;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NTFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Pseu=
do filesystems</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PROC_FS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PROC_KCORE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SYSFS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_TMPFS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HUGETLB_PAGE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_RAMFS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_RELAYFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Misc=
ellaneous filesystems</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_ADFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_AFFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HFSPLUS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BEFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_BFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_EFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CRAMFS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_VXFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_HPFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_QNX4FS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SYSV_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_UFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Netw=
ork File Systems</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NFS_FS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NFS_V3=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NFS_V3_ACL is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NFS_V4 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NFS_DIRECTIO is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NFSD is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_ROOT_NFS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_LOCKD=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_LOCKD_V4=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NFS_COMMON=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_SUNRPC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_RPCSEC_GSS_KRB5 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_RPCSEC_GSS_SPKM3 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SMB_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CIFS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NCP_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CODA_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_AFS_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_9P_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Part=
ition Types</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PARTITION_ADVANCED is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MSDOS_PARTITION=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Nati=
ve Language Support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NLS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_NLS_DEFAULT=3D&quot;iso8859-1&quot;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_437 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_737 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_775 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_850 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_852 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_855 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_857 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_860 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_861 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_862 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_863 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_864 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_865 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_866 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_869 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_936 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_950 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_932 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_949 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_874 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_8 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_1250 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_CODEPAGE_1251 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ASCII is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_1 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_2 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_3 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_4 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_5 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_6 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_7 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_9 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_13 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_14 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_ISO8859_15 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_KOI8_R is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_KOI8_U is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_NLS_UTF8 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Prof=
iling support</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_PROFILING is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Kern=
el hacking</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_PRINTK_TIME=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_DEBUG_KERNEL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_MAGIC_SYSRQ=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_LOG_BUF_SHIFT=3D16</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_DETECT_SOFTLOCKUP=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SCHEDSTATS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEBUG_SLAB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEBUG_SPINLOCK is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEBUG_SPINLOCK_SLEEP is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEBUG_KOBJECT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEBUG_INFO is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEBUG_FS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEBUG_VM is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_RCU_TORTURE_TEST is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CROSSCOMPILE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CMDLINE=3D&quot;&quot;</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_DEBUG_STACK_USAGE is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_KGDB is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SB1XXX_CORELIS is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_RUNTIME_DEBUG is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Secu=
rity options</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_KEYS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_KEYS_DEBUG_PROC_KEYS=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_SECURITY is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Cryp=
tographic options</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_HMAC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_NULL=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_MD4=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_MD5=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_SHA1=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_SHA256=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_SHA512=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_WP512=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_TGR192=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_DES=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_BLOWFISH=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_TWOFISH=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_SERPENT=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_AES=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CRYPTO_CAST5 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CRYPTO_CAST6 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_TEA=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CRYPTO_ARC4 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_KHAZAD=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_ANUBIS=3Dm</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_DEFLATE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRYPTO_MICHAEL_MIC=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CRYPTO_CRC32C is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CRYPTO_TEST is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Hard=
ware crypto devices</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Libr=
ary routines</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FON=
T></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CRC_CCITT is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_CRC16 is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_CRC32=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># CONF=
IG_LIBCRC32C is not set</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_ZLIB_INFLATE=3Dy</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">CONFIG=
_ZLIB_DEFLATE=3Dy</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"=
en-us"></SPAN></P>

<FONT size=3D"2" face=3D"arial"><EM/></FONT></BODY>
</HTML>=

------_=_NextPart_001_01C65F4D.8DC96563--
