Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2007 12:38:49 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:9001 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022402AbXHNLhk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2007 12:37:40 +0100
Received: by mo.po.2iij.net (mo32) id l7EBbblM071521; Tue, 14 Aug 2007 20:37:37 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox302) id l7EBbZrj015281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Aug 2007 20:37:35 +0900
Date:	Tue, 14 Aug 2007 20:33:54 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] update tb0287_defconfig
Message-Id: <20070814203354.170e4304.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Update tb0287_defconfig

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/tb0287_defconfig mips/arch/mips/configs/tb0287_defconfig
--- mips-orig/arch/mips/configs/tb0287_defconfig	2007-08-09 10:04:28.278961000 +0900
+++ mips/arch/mips/configs/tb0287_defconfig	2007-08-09 14:04:03.329868250 +0900
@@ -1,68 +1,56 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc1
-# Thu Feb 22 10:38:09 2007
+# Linux kernel version: 2.6.23-rc2
+# Thu Aug  9 14:03:54 2007
 #
 CONFIG_MIPS=y
 
 #
 # Machine selection
 #
-CONFIG_ZONE_DMA=y
-# CONFIG_MIPS_MTX1 is not set
-# CONFIG_MIPS_BOSPORUS is not set
-# CONFIG_MIPS_PB1000 is not set
-# CONFIG_MIPS_PB1100 is not set
-# CONFIG_MIPS_PB1500 is not set
-# CONFIG_MIPS_PB1550 is not set
-# CONFIG_MIPS_PB1200 is not set
-# CONFIG_MIPS_DB1000 is not set
-# CONFIG_MIPS_DB1100 is not set
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-# CONFIG_MIPS_DB1200 is not set
-# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MACH_ALCHEMY is not set
 # CONFIG_BASLER_EXCITE is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_ATLAS is not set
 # CONFIG_MIPS_MALTA is not set
 # CONFIG_MIPS_SEAD is not set
-# CONFIG_WR_PPMC is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MOMENCO_JAGUAR_ATX is not set
-# CONFIG_MIPS_XXS1500 is not set
+# CONFIG_MARKEINS is not set
+CONFIG_MACH_VR41XX=y
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
-CONFIG_MACH_VR41XX=y
+# CONFIG_PMC_MSP is not set
 # CONFIG_PMC_YOSEMITE is not set
 # CONFIG_QEMU is not set
-# CONFIG_MARKEINS is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
 # CONFIG_SGI_IP32 is not set
-# CONFIG_SIBYTE_BIGSUR is not set
+# CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CARMEL is not set
+# CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_RHONE is not set
 # CONFIG_SIBYTE_SWARM is not set
+# CONFIG_SIBYTE_LITTLESUR is not set
 # CONFIG_SIBYTE_SENTOSA is not set
-# CONFIG_SIBYTE_RHONE is not set
-# CONFIG_SIBYTE_CARMEL is not set
 # CONFIG_SIBYTE_PTSWARM is not set
-# CONFIG_SIBYTE_LITTLESUR is not set
-# CONFIG_SIBYTE_CRHINE is not set
-# CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_BIGSUR is not set
 # CONFIG_SNI_RM is not set
 # CONFIG_TOSHIBA_JMR3927 is not set
 # CONFIG_TOSHIBA_RBTX4927 is not set
 # CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_WR_PPMC is not set
 # CONFIG_CASIO_E55 is not set
 # CONFIG_IBM_WORKPAD is not set
 # CONFIG_NEC_CMBVR4133 is not set
 CONFIG_TANBAC_TB022X=y
-# CONFIG_TANBAC_TB0226 is not set
-CONFIG_TANBAC_TB0287=y
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
+# CONFIG_TANBAC_TB0219 is not set
+# CONFIG_TANBAC_TB0226 is not set
+CONFIG_TANBAC_TB0287=y
 CONFIG_PCI_VR41XX=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
@@ -75,6 +63,8 @@ CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
+# CONFIG_HOTPLUG_CPU is not set
+# CONFIG_NO_IOPORT is not set
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
@@ -84,6 +74,7 @@ CONFIG_MIPS_L1_CACHE_SHIFT=5
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2 is not set
 # CONFIG_CPU_MIPS32_R1 is not set
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -105,7 +96,6 @@ CONFIG_CPU_VR41XX=y
 # CONFIG_CPU_SB1 is not set
 CONFIG_SYS_HAS_CPU_VR41XX=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
-CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
@@ -121,7 +111,6 @@ CONFIG_PAGE_SIZE_4KB=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
-# CONFIG_MIPS_VPE_LOADER is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -135,86 +124,83 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=1
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
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
 # CONFIG_KEXEC is not set
+CONFIG_SECCOMP=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
 
 #
 # IO Schedulers
@@ -234,15 +220,14 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-
-#
-# PCI Hotplug Support
-#
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
@@ -254,10 +239,7 @@ CONFIG_TRAD_SIGNALS=y
 #
 # Power management options
 #
-CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
-# CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
+# CONFIG_PM is not set
 
 #
 # Networking
@@ -267,14 +249,9 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
-CONFIG_XFRM=y
-# CONFIG_XFRM_USER is not set
-# CONFIG_XFRM_SUB_POLICY is not set
-CONFIG_XFRM_MIGRATE=y
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -284,7 +261,6 @@ CONFIG_ASK_IP_FIB_HASH=y
 CONFIG_IP_FIB_HASH=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
-# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 # CONFIG_IP_PNP_DHCP is not set
@@ -301,9 +277,9 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 CONFIG_INET_TUNNEL=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 CONFIG_TCP_CONG_ADVANCED=y
@@ -317,6 +293,8 @@ CONFIG_TCP_CONG_HTCP=m
 # CONFIG_TCP_CONG_SCALABLE is not set
 # CONFIG_TCP_CONG_LP is not set
 # CONFIG_TCP_CONG_VENO is not set
+# CONFIG_TCP_CONG_YEAH is not set
+# CONFIG_TCP_CONG_ILLINOIS is not set
 CONFIG_DEFAULT_BIC=y
 # CONFIG_DEFAULT_CUBIC is not set
 # CONFIG_DEFAULT_HTCP is not set
@@ -324,26 +302,14 @@ CONFIG_DEFAULT_BIC=y
 # CONFIG_DEFAULT_WESTWOOD is not set
 # CONFIG_DEFAULT_RENO is not set
 CONFIG_DEFAULT_TCP_CONG="bic"
-CONFIG_TCP_MD5SIG=y
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
 CONFIG_NETWORK_SECMARK=y
 # CONFIG_NETFILTER is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -369,10 +335,20 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_AF_RXRPC is not set
 CONFIG_FIB_RULES=y
 
 #
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
 # Device Drivers
 #
 
@@ -381,31 +357,12 @@ CONFIG_FIB_RULES=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=m
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 # CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_DA is not set
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
@@ -420,19 +377,9 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
-CONFIG_SGI_IOC4=m
-# CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_MISC_DEVICES is not set
 # CONFIG_IDE is not set
 
 #
@@ -440,6 +387,7 @@ CONFIG_SGI_IOC4=m
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
 CONFIG_SCSI_TGT=m
 # CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
@@ -461,6 +409,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -468,48 +417,8 @@ CONFIG_SCSI_SCAN_ASYNC=y
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
-# CONFIG_ISCSI_TCP is not set
-# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
-# CONFIG_SCSI_3W_9XXX is not set
-# CONFIG_SCSI_ACARD is not set
-# CONFIG_SCSI_AACRAID is not set
-# CONFIG_SCSI_AIC7XXX is not set
-# CONFIG_SCSI_AIC7XXX_OLD is not set
-# CONFIG_SCSI_AIC79XX is not set
-# CONFIG_SCSI_AIC94XX is not set
-# CONFIG_SCSI_DPT_I2O is not set
-# CONFIG_SCSI_ARCMSR is not set
-# CONFIG_MEGARAID_NEWGEN is not set
-# CONFIG_MEGARAID_LEGACY is not set
-# CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_HPTIOP is not set
-# CONFIG_SCSI_DMX3191D is not set
-# CONFIG_SCSI_FUTURE_DOMAIN is not set
-# CONFIG_SCSI_IPS is not set
-# CONFIG_SCSI_INITIO is not set
-# CONFIG_SCSI_INIA100 is not set
-# CONFIG_SCSI_STEX is not set
-# CONFIG_SCSI_SYM53C8XX_2 is not set
-# CONFIG_SCSI_IPR is not set
-# CONFIG_SCSI_QLOGIC_1280 is not set
-# CONFIG_SCSI_QLA_FC is not set
-# CONFIG_SCSI_QLA_ISCSI is not set
-# CONFIG_SCSI_LPFC is not set
-# CONFIG_SCSI_DC395x is not set
-# CONFIG_SCSI_DC390T is not set
-# CONFIG_SCSI_NSP32 is not set
-# CONFIG_SCSI_DEBUG is not set
-# CONFIG_SCSI_SRP is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
+# CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
 # CONFIG_SATA_AHCI is not set
@@ -532,6 +441,7 @@ CONFIG_ATA=y
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
 # CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
 # CONFIG_PATA_CMD64X is not set
 # CONFIG_PATA_CS5520 is not set
 # CONFIG_PATA_CS5530 is not set
@@ -564,10 +474,6 @@ CONFIG_PATA_SIL680=y
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
 
 #
@@ -581,17 +487,16 @@ CONFIG_PATA_SIL680=y
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
 CONFIG_IEEE1394=m
 
 #
 # Subsystem Options
 #
 # CONFIG_IEEE1394_VERBOSEDEBUG is not set
-CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
-CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
 
 #
-# Device Drivers
+# Controllers
 #
 
 #
@@ -600,59 +505,63 @@ CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
 CONFIG_IEEE1394_OHCI1394=m
 
 #
-# Protocol Drivers
+# Protocols
 #
 CONFIG_IEEE1394_VIDEO1394=m
 CONFIG_IEEE1394_SBP2=m
+# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
+CONFIG_IEEE1394_ETH1394_ROM_ENTRY=y
 CONFIG_IEEE1394_ETH1394=m
 CONFIG_IEEE1394_DV1394=m
 CONFIG_IEEE1394_RAWIO=m
-
-#
-# I2O device support
-#
 # CONFIG_I2O is not set
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# ARCnet devices
-#
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_CASSINI is not set
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_DM9000 is not set
-
-#
-# Tulip family network device support
-#
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
-# CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_TC35815 is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+CONFIG_8139TOO=y
+CONFIG_8139TOO_PIO=y
+# CONFIG_8139TOO_TUNE_TWISTER is not set
+# CONFIG_8139TOO_8129 is not set
+# CONFIG_8139_OLD_RX_RESET is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+CONFIG_VIA_RHINE=y
+CONFIG_VIA_RHINE_MMIO=y
+# CONFIG_VIA_RHINE_NAPI is not set
+# CONFIG_SC92031 is not set
+CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
@@ -664,35 +573,29 @@ CONFIG_R8169=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
+CONFIG_VIA_VELOCITY=y
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=m
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=m
-
-#
-# Token Ring devices
-#
+# CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
 
 #
-# Wireless LAN (non-hamradio)
+# Wireless LAN
 #
-# CONFIG_NET_RADIO is not set
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 
 #
-# Wan interfaces
+# USB Network Adapters
 #
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -703,15 +606,7 @@ CONFIG_NETXEN_NIC=m
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
@@ -719,11 +614,15 @@ CONFIG_NETXEN_NIC=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
 #
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
@@ -735,6 +634,7 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -769,35 +669,18 @@ CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_TANBAC_TB0219 is not set
+# CONFIG_GPIO_TB0219 is not set
 # CONFIG_DRM is not set
 CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -805,17 +688,9 @@ CONFIG_GPIO_VR41XX=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
 
 #
 # Multifunction device drivers
@@ -826,23 +701,31 @@ CONFIG_MFD_SM501=y
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
-# CONFIG_DVB is not set
-# CONFIG_USB_DABUSB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
@@ -850,7 +733,7 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 # CONFIG_FB_TILEBLITTING is not set
 
 #
-# Frambuffer hardware drivers
+# Frame buffer hardware drivers
 #
 # CONFIG_FB_CIRRUS is not set
 # CONFIG_FB_PM2 is not set
@@ -871,8 +754,10 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 # CONFIG_FB_KYRO is not set
 # CONFIG_FB_3DFX is not set
 # CONFIG_FB_VOODOO1 is not set
-# CONFIG_FB_SMIVGX is not set
+# CONFIG_FB_VT8623 is not set
 # CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
+# CONFIG_FB_PM3 is not set
 CONFIG_FB_SM501=y
 # CONFIG_FB_VIRTUAL is not set
 
@@ -881,27 +766,44 @@ CONFIG_FB_SM501=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE is not set
-
-#
-# Logo configuration
-#
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
 # CONFIG_LOGO is not set
 
 #
 # Sound
 #
 # CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
-# HID Devices
+# USB Input Devices
 #
-CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
+CONFIG_USB_HID=m
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
 
 #
-# USB support
+# USB HID Boot Protocol drivers
 #
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
@@ -912,8 +814,8 @@ CONFIG_USB=m
 # Miscellaneous USB options
 #
 # CONFIG_USB_DEVICEFS is not set
+CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_SUSPEND is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -923,7 +825,6 @@ CONFIG_USB_EHCI_HCD=m
 # CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
-# CONFIG_USB_EHCI_BIG_ENDIAN_MMIO is not set
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=m
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
@@ -931,6 +832,7 @@ CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_UHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
 
 #
 # USB Device Class drivers
@@ -959,47 +861,10 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_LIBUSUAL is not set
 
 #
-# USB Input Devices
-#
-CONFIG_USB_HID=m
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_HID_FF is not set
-# CONFIG_USB_HIDDEV is not set
-
-#
-# USB HID Boot Protocol drivers
-#
-# CONFIG_USB_KBD is not set
-# CONFIG_USB_MOUSE is not set
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_ACECAD is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_TOUCHSCREEN is not set
-# CONFIG_USB_YEALINK is not set
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-# CONFIG_USB_ATI_REMOTE2 is not set
-# CONFIG_USB_KEYSPAN_REMOTE is not set
-# CONFIG_USB_APPLETOUCH is not set
-# CONFIG_USB_GTCO is not set
-
-#
 # USB Imaging devices
 #
 # CONFIG_USB_MDC800 is not set
 # CONFIG_USB_MICROTEK is not set
-
-#
-# USB Network Adapters
-#
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
-# CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
-# CONFIG_USB_USBNET is not set
 CONFIG_USB_MON=y
 
 #
@@ -1032,6 +897,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 
 #
 # USB DSL modem support
@@ -1041,37 +907,9 @@ CONFIG_USB_MON=y
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
-
-#
-# LED devices
-#
 # CONFIG_NEW_LEDS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
-# InfiniBand support
-#
 # CONFIG_INFINIBAND is not set
-
-#
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
-
-#
-# Real Time Clock
-#
 # CONFIG_RTC_CLASS is not set
 
 #
@@ -1088,12 +926,9 @@ CONFIG_USB_MON=y
 #
 
 #
-# Auxiliary Display support
-#
-
-#
-# Virtualization
+# Userspace I/O
 #
+# CONFIG_UIO is not set
 
 #
 # File systems
@@ -1111,7 +946,7 @@ CONFIG_JBD=y
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FS_POSIX_ACL=y
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 # CONFIG_XFS_SECURITY is not set
@@ -1125,10 +960,11 @@ CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_QUOTACTL=y
-# CONFIG_DNOTIFY is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 # CONFIG_FUSE_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # CD-ROM/DVD Filesystems
@@ -1151,10 +987,10 @@ CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_POSIX_ACL is not set
+CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-CONFIG_CONFIGFS_FS=m
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -1181,12 +1017,18 @@ CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
-# CONFIG_NFSD is not set
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V3_ACL is not set
+# CONFIG_NFSD_V4 is not set
+CONFIG_NFSD_TCP=y
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=m
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1194,7 +1036,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -1210,10 +1051,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Distributed Lock Manager
 #
-CONFIG_DLM=m
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
-# CONFIG_DLM_DEBUG is not set
+# CONFIG_DLM is not set
 
 #
 # Profiling support
@@ -1231,7 +1069,6 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
 
@@ -1240,63 +1077,20 @@ CONFIG_CMDLINE="mem=64M console=ttyVR0,1
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=m
-CONFIG_CRYPTO_MANAGER=m
-CONFIG_CRYPTO_HMAC=m
-CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_GF128MUL=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_TWOFISH_COMMON=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-CONFIG_CRYPTO_CAMELLIA=m
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+# CONFIG_CRYPTO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-# CONFIG_CRC_CCITT is not set
+CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=m
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=m
-CONFIG_ZLIB_DEFLATE=m
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
