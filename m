Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2004 20:41:56 +0000 (GMT)
Received: from rrcs-sw-24-153-140-91.biz.rr.com ([IPv6:::ffff:24.153.140.91]:11136
	"EHLO public.nshore.com") by linux-mips.org with ESMTP
	id <S8224939AbUBIUly>; Mon, 9 Feb 2004 20:41:54 +0000
Received: from nshore.com (gate.nshore.com [192.168.1.2])
	by public.nshore.com (8.11.6/8.11.6) with ESMTP id i19KfAc02080
	for <linux-mips@linux-mips.org>; Mon, 9 Feb 2004 14:41:10 -0600
Message-ID: <4027F08D.5030601@nshore.com>
Date: Mon, 09 Feb 2004 14:41:49 -0600
From: Tahoma Toelkes <tahoma@nshore.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: difficulties with NFSROOT and DHCP
Content-Type: multipart/mixed;
 boundary="------------040803020409020006070105"
Return-Path: <tahoma@nshore.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tahoma@nshore.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040803020409020006070105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The context is that I am in the process of bringing up a 2.4.24 kernel 
(pulled from linux-mips CVS using the linux_2_4_24 tag) on a DBAu1500 
board (Zinfandel).

I'm having trouble mounting my root filesystem over NFS.  After the 
ethernet ports have been enumerated, the kernel attempts to contact the 
DHCP server to obtain its IP configuration information.  At this point 
the boot sequence hangs, perpetually retrying the DHCP server.  Here are 
the last several lines from the log of the boot messages, prefixed with 
a vertical bar to set them apart:

| Sending DHCP requests .<6>eth0: link up
| eth0: going to full duplex
| ..... timed out!
| IP-Config: Retrying forever (NFS root)...
| Sending DHCP requests ...... timed out!
| IP-Config: Retrying forever (NFS root)...
| Sending DHCP requests ..

I've verified that the exported root filesystem can be mounted by 
another Linux workstation.  I've also verified on the DHCP server that 
it is seeing the board initiate a DHCP discovery and that the DHCP 
server is replying with offer for the correct address.  Here is an 
excerpt from '/var/log/messages' on the DHCP server:

| Feb  9 13:25:33 kapala dhcpd: DHCPDISCOVER from 00:50:c2:0c:38:8a via eth0
| Feb  9 13:25:33 kapala dhcpd: DHCPOFFER on 172.16.108.42 to 
00:50:c2:0c:38:8a via eth0

For completeness sake, I've attached the full log of the boot sequence 
until it hangs as well as my current kernel configuration.  If any of 
you have seen this particular problem and know how to get around it, 
please respond.  Further, if you simply have suggestions for avenues I 
could explore, I would appreciate any advice you might have to offer.


Humbly yours,
-- Tahoma


--------------040803020409020006070105
Content-Type: text/plain;
 name="minicom.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="minicom.cap"




YAMON ROM Monitor, Revision 02.15DB1500.
Copyright (c) 1999-2000 MIPS Technologies, Inc. - All Rights Reserved.

For a list of available commands, type 'help'.

Compilation time =            Nov  5 2002  11:42:43
MAC address =                 00.50.c2.0c.38.8a
Processor Company ID =        0x03
Processor ID/revision =       0x02 / 0x00
Endianness =                  Big
CPU =                         396 MHz
Flash memory size =           32 MByte
SDRAM size =                  64 MByte
First free SDRAM address =    0x8008a0d4

YAMON> load asc:
About to load asc://tty0
Press Ctrl-C to break
Start dump from terminal program

YAMON> go . root=/dev/nfs nfsroot=172.16.108.11:/export/root ip=172.16.108.42:1  
loaded at:     81000000 8109B000
zimage at:     810063D0 8109A3D0
Uncompressing Linux at load address 80100000
Now booting the kernel
CPU revision is: 01030200
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB 4-way, linesize 32 bytes.
Linux version 2.4.24-pre2 (tahoma@localhost.localdomain) (gcc version 3.3.2) #2 Mon Feb 9 10:08:58 CST 2004
AMD Alchemy Au1500/Db1500 Board
Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs nfsroot=172.16.108.11:/export/root ip=172.16.108.42 console=ttyS0,115200
calculating r4koff... 003c6cc0(3960000)
CPU frequency 396.00 MHz
Calibrating delay loop... 395.67 BogoMIPS
Memory: 62188k/65536k available (1286k kernel code, 3348k reserved, 72k data, 100k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x80270d58
Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x50000000
00:0c.0 Class 0104: 1103:0007 (rev 01)
        I/O at 0x00000300 [size=0x8]
        I/O at 0x00000308 [size=0x4]
        I/O at 0x00000310 [size=0x8]
        I/O at 0x00000318 [size=0x4]
        I/O at 0x00000400 [size=0x100]
Non-coherent PCI accesses enabled
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Serial driver version 1.01 (2001-02-08) with no serial options enabled
ttyS00 at 0xb1100000 (irq = 0) is a 16550
ttyS01 at 0xb1200000 (irq = 1) is a 16550
ttyS02 at 0xb1300000 (irq = 2) is a 16550
ttyS03 at 0xb1400000 (irq = 3) is a 16550
Generic MIPS RTC Driver v1.0
au1000eth.c:1.4 ppopov@mvista.com
eth0: Au1x Ethernet found at 0xb1500000, irq 28
eth0: AMD 79C874 10/100 BaseT PHY at phy address 31
eth0: Using AMD 79C874 10/100 BaseT PHY as default
eth1: Au1x Ethernet found at 0xb1510000, irq 29
eth1: AMD 79C874 10/100 BaseT PHY at phy address 31
eth1: Using AMD 79C874 10/100 BaseT PHY as default
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
Sending DHCP requests .<6>eth0: link up
eth0: going to full duplex
..... timed out!
IP-Config: Retrying forever (NFS root)...
Sending DHCP requests ...... timed out!
IP-Config: Retrying forever (NFS root)...
Sending DHCP requests ..
--------------040803020409020006070105
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_MIPS=y
CONFIG_MIPS32=y
# CONFIG_MIPS64 is not set

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
# CONFIG_KMOD is not set

#
# Machine selection
#
# CONFIG_ACER_PICA_61 is not set
# CONFIG_MIPS_BOSPORUS is not set
# CONFIG_MIPS_MIRAGE is not set
# CONFIG_MIPS_DB1000 is not set
# CONFIG_MIPS_DB1100 is not set
CONFIG_MIPS_DB1500=y
# CONFIG_MIPS_PB1000 is not set
# CONFIG_MIPS_PB1100 is not set
# CONFIG_MIPS_PB1500 is not set
# CONFIG_MIPS_HYDROGEN3 is not set
# CONFIG_MIPS_PB1550 is not set
# CONFIG_MIPS_XXS1500 is not set
# CONFIG_MIPS_MTX1 is not set
# CONFIG_COGENT_CSB250 is not set
# CONFIG_BAGET_MIPS is not set
# CONFIG_CASIO_E55 is not set
# CONFIG_MIPS_COBALT is not set
# CONFIG_DECSTATION is not set
# CONFIG_MIPS_EV64120 is not set
# CONFIG_MIPS_EV96100 is not set
# CONFIG_MIPS_IVR is not set
# CONFIG_HP_LASERJET is not set
# CONFIG_IBM_WORKPAD is not set
# CONFIG_LASAT is not set
# CONFIG_MIPS_ITE8172 is not set
# CONFIG_MIPS_ATLAS is not set
# CONFIG_MIPS_MAGNUM_4000 is not set
# CONFIG_MIPS_MALTA is not set
# CONFIG_MIPS_SEAD is not set
# CONFIG_MOMENCO_OCELOT is not set
# CONFIG_MOMENCO_OCELOT_G is not set
# CONFIG_MOMENCO_OCELOT_C is not set
# CONFIG_MOMENCO_JAGUAR_ATX is not set
# CONFIG_PMC_YOSEMITE is not set
# CONFIG_DDB5074 is not set
# CONFIG_DDB5476 is not set
# CONFIG_DDB5477 is not set
# CONFIG_NEC_OSPREY is not set
# CONFIG_NEC_EAGLE is not set
# CONFIG_OLIVETTI_M700 is not set
# CONFIG_NINO is not set
# CONFIG_SGI_IP22 is not set
# CONFIG_SGI_IP27 is not set
# CONFIG_SIBYTE_SB1xxx_SOC is not set
# CONFIG_SNI_RM200_PCI is not set
# CONFIG_TANBAC_TB0226 is not set
# CONFIG_TANBAC_TB0229 is not set
# CONFIG_TOSHIBA_JMR3927 is not set
# CONFIG_TOSHIBA_RBTX4927 is not set
# CONFIG_VICTOR_MPC30X is not set
# CONFIG_ZAO_CAPCELLA is not set
# CONFIG_HIGHMEM is not set
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
CONFIG_SOC_AU1X00=y
CONFIG_SOC_AU1500=y
CONFIG_NEW_TIME_C=y
CONFIG_PCI=y
CONFIG_NEW_PCI=y
CONFIG_PCI_AUTO=y
CONFIG_NONCOHERENT_IO=y
CONFIG_PC_KEYB=y
# CONFIG_MIPS_AU1000 is not set

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
CONFIG_PAGE_SIZE_4KB=y
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
CONFIG_CPU_HAS_PREFETCH=y
# CONFIG_VTAG_ICACHE is not set
# CONFIG_64BIT_PHYS_ADDR is not set
CONFIG_CPU_ADVANCED=y
# CONFIG_CPU_HAS_LLSC is not set
# CONFIG_CPU_HAS_LLDSCD is not set
# CONFIG_CPU_HAS_WB is not set
CONFIG_CPU_HAS_SYNC=y

#
# General setup
#
# CONFIG_CPU_LITTLE_ENDIAN is not set
# CONFIG_BINFMT_IRIX is not set
CONFIG_NET=y
# CONFIG_PCI_NAMES is not set
# CONFIG_ISA is not set
# CONFIG_TC is not set
# CONFIG_MCA is not set
# CONFIG_SBUS is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_SYSCTL is not set
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_MIPS32_COMPAT is not set
# CONFIG_MIPS32_O32 is not set
# CONFIG_MIPS32_N32 is not set
# CONFIG_BINFMT_ELF32 is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_OOM_KILLER is not set
# CONFIG_PM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
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
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

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
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

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
CONFIG_MIPS_AU1X00_ENET=y
# CONFIG_BCM5222_DUAL_PHY is not set
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
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
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

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
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL is not set
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
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set
# CONFIG_SERIAL_TX3912 is not set
# CONFIG_SERIAL_TX3912_CONSOLE is not set
# CONFIG_SERIAL_TXX9 is not set
# CONFIG_SERIAL_TXX9_CONSOLE is not set
CONFIG_AU1X00_UART=y
CONFIG_AU1X00_SERIAL_CONSOLE=y
# CONFIG_AU1X00_USB_TTY is not set
# CONFIG_AU1X00_USB_RAW is not set
# CONFIG_TXX927_SERIAL is not set
# CONFIG_UNIX98_PTYS is not set

#
# I2C support
#
# CONFIG_I2C is not set

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
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
CONFIG_MIPS_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set
# CONFIG_AU1X00_GPIO is not set
# CONFIG_TS_AU1X00_ADS7846 is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_ROOT_NFS=y
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_CROSSCOMPILE=y
# CONFIG_RUNTIME_DEBUG is not set
# CONFIG_KGDB is not set
# CONFIG_GDB_CONSOLE is not set
CONFIG_DEBUG_INFO=y
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_MIPS_UNCACHED is not set
CONFIG_LOG_BUF_SHIFT=14

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=y
# CONFIG_ZLIB_DEFLATE is not set

--------------040803020409020006070105--
