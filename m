Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1S6WV330833
	for linux-mips-outgoing; Wed, 27 Feb 2002 22:32:31 -0800
Received: from gda-server ([202.88.152.146])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1S6V9930823
	for <linux-mips@oss.sgi.com>; Wed, 27 Feb 2002 22:31:10 -0800
Received: from [192.168.0.186] by gda-server
  (ArGoSoft Mail Server, Version 1.5 (1.5.0.8)); Thu, 28 Feb 2002 11:03:49 
Message-ID: <3C7E68ED.93B565AB@gdatech.co.in>
Date: Thu, 28 Feb 2002 22:59:17 +0530
From: santhosh <ps.santhosh@gdatech.co.in>
Organization: gdatech
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: compiler error
Content-Type: multipart/mixed;
 boundary="------------9DA6765BB54D5478D8D854B8"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------9DA6765BB54D5478D8D854B8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi all,

     i am working  on MIPS64 based (SB1250) board.
when i tried to compile the kernel i am getting the following
error messages


Assembler messages:
Error: invalid architecture -mcpu=sb1
cc1: bad value (sb1) for -mcpu= switch
init/main.c:198: output pipe has been closed
cpp: output pipe has been closed
make: *** [init/main.o] Error 1

i am attaching the  configuration file (.config file)
with this.
 can anyone direct me in correct path

santhosh

--------------9DA6765BB54D5478D8D854B8
Content-Type: text/plain; charset=us-ascii;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_MIPS=y
CONFIG_MIPS32=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Machine selection
#
# CONFIG_ACER_PICA_61 is not set
# CONFIG_ALGOR_P4032 is not set
# CONFIG_BAGET_MIPS is not set
# CONFIG_MIPS_COBALT is not set
# CONFIG_DECSTATION is not set
# CONFIG_DDB5074 is not set
# CONFIG_MIPS_EV64120 is not set
# CONFIG_MIPS_EV96100 is not set
# CONFIG_MIPS_ATLAS is not set
# CONFIG_MIPS_MALTA is not set
CONFIG_SIBYTE_SB1xxx_SOC=y
CONFIG_SIBYTE_SB1250=y
# CONFIG_SIBYTE_BCM1120 is not set
# CONFIG_SIBYTE_BCM1125 is not set
# CONFIG_SIBYTE_BCM1125H is not set
# CONFIG_SIMULATION is not set
# CONFIG_SIBYTE_STANDALONE is not set
# CONFIG_SIBYTE_SB1250_PROF is not set
# CONFIG_BCM1250_TBPROF is not set
CONFIG_SMP=y
# CONFIG_PCI is not set
CONFIG_SIBYTE_SWARM=y
# CONFIG_L3DEMO is not set
# CONFIG_NINO is not set
# CONFIG_MIPS_MAGNUM_4000 is not set
# CONFIG_MOMENCO_OCELOT is not set
# CONFIG_DDB5476 is not set
# CONFIG_DDB5477 is not set
# CONFIG_NEC_OSPREY is not set
# CONFIG_OLIVETTI_M700 is not set
# CONFIG_SGI_IP22 is not set
# CONFIG_SNI_RM200_PCI is not set
# CONFIG_MIPS_ITE8172 is not set
# CONFIG_MIPS_IVR is not set
# CONFIG_MIPS_PB1000 is not set
# CONFIG_TOSHIBA_JMR3927 is not set
# CONFIG_HP_LASERJET is not set
# CONFIG_HIGHMEM is not set
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
# CONFIG_MCA is not set
# CONFIG_SBUS is not set
CONFIG_NEW_IRQ=y
CONFIG_NEW_TIME_C=y
CONFIG_DUMMY_KEYB=y
CONFIG_SWAP_IO_SPACE=y
# CONFIG_ISA is not set
# CONFIG_EISA is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# CPU selection
#
# CONFIG_CPU_R3000 is not set
# CONFIG_CPU_TX39XX is not set
# CONFIG_CPU_R6000 is not set
# CONFIG_CPU_VR41XX is not set
# CONFIG_CPU_R4300 is not set
# CONFIG_CPU_R4X00 is not set
# CONFIG_CPU_TX49XX is not set
# CONFIG_CPU_R5000 is not set
# CONFIG_CPU_R5432 is not set
# CONFIG_CPU_RM7000 is not set
# CONFIG_CPU_NEVADA is not set
# CONFIG_CPU_R10000 is not set
CONFIG_CPU_SB1=y
# CONFIG_CPU_MIPS32 is not set
# CONFIG_CPU_MIPS64 is not set
CONFIG_SB1_PASS_1_WORKAROUNDS=y
CONFIG_SB1_CACHE_ERROR=y
CONFIG_VTAG_ICACHE=y
CONFIG_CPU_HAS_PREFETCH=y
# CONFIG_64BIT_PHYS_ADDR is not set
# CONFIG_CPU_ADVANCED is not set
CONFIG_CPU_HAS_LLSC=y
CONFIG_CPU_HAS_LLDSCD=y
# CONFIG_CPU_HAS_WB is not set

#
# General setup
#
# CONFIG_CPU_LITTLE_ENDIAN is not set
CONFIG_KCORE_ELF=y
CONFIG_ELF_KERNEL=y
# CONFIG_BINFMT_IRIX is not set
# CONFIG_FORWARD_KEYBOARD is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_NET=y
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_SYSCTL is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_PARTITIONS is not set

#
# User Modules And Translation Layers
#
# CONFIG_MTD_CHAR is not set
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BUSWIDTH=1

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLKMTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC1000 is not set
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOCPROBE is not set

#
# NAND Flash Device Drivers
#
# CONFIG_MTD_NAND is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# MIPS initrd options
#
CONFIG_EMBEDDED_RAMDISK=y
# CONFIG_SIBYTE_RAMDISK_SIMPLE_INIT is not set
CONFIG_SIBYTE_RAMDISK_GENERAL=y
# CONFIG_SIBYTE_RAMDISK_PROMICE_CONSOLE is not set
# CONFIG_SIBYTE_RAMDISK_NIDEMO is not set
# CONFIG_SIBYTE_RAMDISK_SCREENING is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Networking options
#
# CONFIG_PACKET is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_ARPD=y
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_IPV6=y
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=y
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
# CONFIG_NET_SCH_CBQ is not set
# CONFIG_NET_SCH_CSZ is not set
# CONFIG_NET_SCH_PRIO is not set
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_GRED is not set
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_QOS=y
# CONFIG_NET_ESTIMATOR is not set
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_TCINDEX is not set
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_POLICE is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_SB1250_MAC=y
# CONFIG_NET_SB1250_MAC_QUIET is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC_OMIT_TIGON_I is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
CONFIG_NET_FC=y
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Character devices
#
# CONFIG_VT is not set
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set
# CONFIG_SERIAL_TX3912 is not set
# CONFIG_AU1000_UART is not set
# CONFIG_TXX927_SERIAL is not set
CONFIG_SIBYTE_SB1250_DUART=y
CONFIG_SIBYTE_SB1250_DUART_CONSOLE=y
CONFIG_SB1250_DUART_OUTPUT_BUF_SIZE=1024
# CONFIG_SIBYTE_SB1250_DUART_NO_PORT_1 is not set
# CONFIG_PROMICE is not set
CONFIG_SIBYTE_SB1250_JTAG=y
CONFIG_SIBYTE_SB1250_JTAG_CONSOLE=y
CONFIG_SB1250_JTAG_OUTPUT_BUF_SIZE=1024
CONFIG_SERIAL_CONSOLE=y
# CONFIG_UNIX98_PTYS is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_SWARM is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_PROC is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=y
# CONFIG_WDT is not set
CONFIG_WDTPCI=y
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_EFS_FS=y
CONFIG_JFFS_FS=y
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_JFFS_PROC_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
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
# CONFIG_NLS_CODEPAGE_1251 is not set
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
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#

#
# USB Controllers
#

#
# USB Device Class drivers
#

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# USB Imaging devices
#

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#

#
# USB port drivers
#

#
# USB Serial Converter support
#

#
# USB Miscellaneous drivers
#

#
# Input core support
#
# CONFIG_INPUT is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768

#
# Kernel hacking
#
CONFIG_CROSSCOMPILE=y
# CONFIG_REMOTE_DEBUG is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG is not set
# CONFIG_MAGIC_SYSRQ is not set

--------------9DA6765BB54D5478D8D854B8--
