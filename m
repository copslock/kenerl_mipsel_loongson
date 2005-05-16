Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2005 10:57:09 +0100 (BST)
Received: from krt.tmd.ns.ac.yu ([IPv6:::ffff:147.91.177.65]:11205 "EHLO
	krt.neobee.net") by linux-mips.org with ESMTP id <S8225429AbVEPJ4v>;
	Mon, 16 May 2005 10:56:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j4GA1rZF028213
	for <linux-mips@linux-mips.org>; Mon, 16 May 2005 12:01:58 +0200
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 26129-06 for <linux-mips@linux-mips.org>;
 Mon, 16 May 2005 12:01:53 +0200 (CEST)
Received: from davidovic ([192.168.0.89])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j4GA1V1p028192
	for <linux-mips@linux-mips.org>; Mon, 16 May 2005 12:01:42 +0200
Message-Id: <200505161001.j4GA1V1p028192@krt.neobee.net>
Reply-To: <mile.davidovic@micronasnit.com>
From:	"Mile Davidovic" <mile.davidovic@micronasnit.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Mips 4lkecr2 
Date:	Mon, 16 May 2005 11:57:02 +0200
Organization: MicronasNIT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVZ/Ztp2O6Vmjq4Ra+I50hdZ4Uw4g==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Virus-Scanned: by amavisd-new at krt.neobee.net
Return-Path: <mile.davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mile.davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello all

I have embedded processor with MIPS 4KECr2 processor and tried to port
linux-2.6.11-mipscvs-20050313.
I follow tutorial from linux-mips and add custom code for int handler, time
...
But I have some problem with detecting of cpu. In cpu-probe.c I added:
cpu_probe_mips with:
       case PRID_IMP_4KEC:
       case PRID_IMP_4KECR2:   /* this line is added */
        c->cputype = CPU_4KEC;
		c->isa_level = MIPS_CPU_ISA_M32;

Is it ok ? Did I forgot something?

I have problem with mem_init, here is output log, can You please tell me
what is problem with this?
Linux version 2.6.11-mipscvs-20050313-md (davidovic@rhel.micronasnit.com)
(gcc version 3.4.2) #207 Mon May 16 10:37:55 CEST 2005
CPU revision is: 00019064
Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: 
Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
Primary data cache 8kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (20 instructions).
Synthesized TLB load handler fastpath (32 instructions).
Synthesized TLB store handler fastpath (32 instructions).
Synthesized TLB modify handler fastpath (31 instructions).
PID hash table entries: 512 (order: 9, 8192 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Bad page state at __free_pages_ok (in process 'swapper', page 810037c0)
flags:0x00000000 mapping:00000004 mapcount:0 count:0
Backtrace:
Call Trace:
 [<8004ca80>] bad_page+0x70/0xc0
 [<8004ceb0>] __free_pages_ok+0xb0/0x1d8
 [<8017a0a0>] free_all_bootmem_core+0x2c0/0x2d4
 [<8017acc8>] alloc_large_system_hash+0x28c/0x2fc
 [<80170a24>] mem_init+0x50/0x1b4
 [<8017c044>] inode_init_early+0x68/0xbc
 [<8016e604>] vgca_timer_setup+0xc8/0xfc
 [<80180000>] pcf8591_init+0x38/0x64
 [<801678c0>] start_kernel+0x15c/0x258
 [<801672b4>] unknown_bootoption+0x0/0x310
Trying to fix it up, but a reboot is needed
Bad page state at __free_pages_ok (in process 'swapper', page 810038c0)
flags:0x00000000 mapping:00002080 mapcount:0 count:0
Backtrace:
Call Trace:
 [<8004ca80>] bad_page+0x70/0xc0
 [<8004ceb0>] __free_pages_ok+0xb0/0x1d8
 [<8017a0a0>] free_all_bootmem_core+0x2c0/0x2d4
 [<8017acc8>] alloc_large_system_hash+0x28c/0x2fc
 [<80170a24>] mem_init+0x50/0x1b4
 [<8017c044>] inode_init_early+0x68/0xbc
 [<8016e604>] vgca_timer_setup+0xc8/0xfc
 [<80180000>] pcf8591_init+0x38/0x64
 [<801678c0>] start_kernel+0x15c/0x258
 [<801672b4>] unknown_bootoption+0x0/0x310

Here is my .config file:
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.11-mipscvs-20050313
# Mon May 16 10:23:48 2005
#
CONFIG_MIPS=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION="-md"
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_HOTPLUG is not set
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_SHMEM is not set
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_TINY_SHMEM=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

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
CONFIG_MIPS_VGCA_EVA=y
# CONFIG_MIPS_MALTA is not set
# CONFIG_MIPS_SEAD is not set
# CONFIG_MOMENCO_JAGUAR_ATX is not set
# CONFIG_MOMENCO_OCELOT is not set
# CONFIG_MOMENCO_OCELOT_3 is not set
# CONFIG_MOMENCO_OCELOT_C is not set
# CONFIG_MOMENCO_OCELOT_G is not set
# CONFIG_MIPS_XXS1500 is not set
# CONFIG_DDB5074 is not set
# CONFIG_DDB5476 is not set
# CONFIG_DDB5477 is not set
# CONFIG_NEC_OSPREY is not set
# CONFIG_MACH_VR41XX is not set
# CONFIG_PMC_YOSEMITE is not set
# CONFIG_SGI_IP22 is not set
# CONFIG_SGI_IP27 is not set
# CONFIG_SGI_IP32 is not set
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
CONFIG_VGCA_HW_TOGGLE_BUG=y
CONFIG_VGCA_HW_RELOAD_BUG=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_DMA_NONCOHERENT=y
CONFIG_CPU_BIG_ENDIAN=y
# CONFIG_CPU_LITTLE_ENDIAN is not set
CONFIG_SYS_SUPPORTS_BIG_ENDIAN=y
CONFIG_BOOT_ELF32=y
CONFIG_MIPS_L1_CACHE_SHIFT=5

#
# CPU selection
#
CONFIG_CPU_MIPS32=y
# CONFIG_CPU_MIPS64 is not set
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
# CONFIG_CPU_SB1 is not set
CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y

#
# Kernel type
#
CONFIG_MIPS32=y
# CONFIG_MIPS64 is not set
# CONFIG_64BIT is not set
CONFIG_PAGE_SIZE_4KB=y
# CONFIG_PAGE_SIZE_8KB is not set
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
CONFIG_CPU_HAS_PREFETCH=y
# CONFIG_64BIT_PHYS_ADDR is not set
CONFIG_CPU_ADVANCED=y
CONFIG_CPU_HAS_LLSC=y
# CONFIG_CPU_HAS_LLDSCD is not set
# CONFIG_CPU_HAS_WB is not set
CONFIG_CPU_HAS_SYNC=y
# CONFIG_PREEMPT is not set

#
# Bus options (PCI, PCMCIA, EISA, ISA, TC)
#
CONFIG_MMU=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PC-card bridges
#

#
# PCI Hotplug Support
#

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_TRAD_SIGNALS=y
# CONFIG_BINFMT_IRIX is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

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
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#

#
# Networking support
#
# CONFIG_NET is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_SERIO is not set
# CONFIG_SERIO_I8042 is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_VGCA=y
CONFIG_SERIAL_VGCA_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=y
CONFIG_DTLK=y
# CONFIG_R3964 is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
CONFIG_I2C_ISA=y
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_FSCHER is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=y
CONFIG_SENSORS_PCF8574=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#

#
# Graphics support
#
# CONFIG_FB is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be
needed; see USB_STORAGE Help for more information
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
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=y
# CONFIG_QUOTA is not set
# CONFIG_DNOTIFY is not set
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_SECURITY=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

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
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
CONFIG_CROSSCOMPILE=y
CONFIG_CMDLINE=""
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_KGDB is not set
CONFIG_RUNTIME_DEBUG=y
# CONFIG_MIPS_UNCACHED is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y 

Best regards MIle
