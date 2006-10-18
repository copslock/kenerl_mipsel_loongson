Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 15:48:46 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:27202 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038517AbWJROsk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2006 15:48:40 +0100
Received: by mo.po.2iij.net (mo30) id k9IEmZqF034841; Wed, 18 Oct 2006 23:48:35 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox30) id k9IEmVDb013936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Oct 2006 23:48:31 +0900 (JST)
Date:	Wed, 18 Oct 2006 23:48:31 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] [MIPS] update tb0287_defconfig
Message-Id: <20061018234831.14476dca.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated tb0287_defconfig.
The TB0287 has no problem with this config.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/tb0287_defconfig mips/arch/mips/configs/tb0287_defconfig
--- mips-orig/arch/mips/configs/tb0287_defconfig	2006-10-18 10:20:24.373572500 +0900
+++ mips/arch/mips/configs/tb0287_defconfig	2006-10-18 13:56:44.806634750 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc1
-# Thu Jul  6 10:04:21 2006
+# Linux kernel version: 2.6.19-rc2
+# Wed Oct 18 12:57:11 2006
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
@@ -72,11 +70,11 @@ CONFIG_TANBAC_TB0287=y
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_PCI_VR41XX=y
-# CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_TIME=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
@@ -123,8 +121,8 @@ CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_MIPS_MT_DISABLED=y
-# CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_MT_SMP is not set
+# CONFIG_MIPS_MT_SMTC is not set
 # CONFIG_MIPS_VPE_LOADER is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -169,15 +167,19 @@ CONFIG_LOCALVERSION=""
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
 # CONFIG_IKCONFIG is not set
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 # CONFIG_HOTPLUG is not set
@@ -185,12 +187,12 @@ CONFIG_PRINTK=y
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
@@ -208,6 +210,7 @@ CONFIG_KMOD=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
@@ -230,17 +233,16 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 CONFIG_MMU=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCCARD is not set
 
 #
 # PCI Hotplug Support
 #
-# CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
@@ -263,6 +265,7 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -291,13 +294,10 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_TUNNEL=m
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
+CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 CONFIG_TCP_CONG_ADVANCED=y
-
-#
-# TCP congestion control
-#
 CONFIG_TCP_CONG_BIC=y
 CONFIG_TCP_CONG_CUBIC=m
 CONFIG_TCP_CONG_WESTWOOD=m
@@ -308,7 +308,13 @@ CONFIG_TCP_CONG_HTCP=m
 # CONFIG_TCP_CONG_SCALABLE is not set
 # CONFIG_TCP_CONG_LP is not set
 # CONFIG_TCP_CONG_VENO is not set
-# CONFIG_TCP_CONG_COMPOUND is not set
+CONFIG_DEFAULT_BIC=y
+# CONFIG_DEFAULT_CUBIC is not set
+# CONFIG_DEFAULT_HTCP is not set
+# CONFIG_DEFAULT_VEGAS is not set
+# CONFIG_DEFAULT_WESTWOOD is not set
+# CONFIG_DEFAULT_RENO is not set
+CONFIG_DEFAULT_TCP_CONG="bic"
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -338,7 +344,6 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -355,6 +360,7 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_IEEE80211 is not set
+CONFIG_FIB_RULES=y
 
 #
 # Device Drivers
@@ -365,7 +371,6 @@ CONFIG_NETWORK_SECMARK=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -403,6 +408,7 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -410,65 +416,14 @@ CONFIG_BLK_DEV_RAM_SIZE=4096
 #
 # ATA/ATAPI/MFM/RLL support
 #
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDE=y
-
-#
-# Please see Documentation/ide.txt for help/info on IDE drives
-#
-# CONFIG_BLK_DEV_IDE_SATA is not set
-CONFIG_BLK_DEV_IDEDISK=y
-# CONFIG_IDEDISK_MULTI_MODE is not set
-# CONFIG_BLK_DEV_IDECD is not set
-# CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_BLK_DEV_IDESCSI is not set
-# CONFIG_IDE_TASK_IOCTL is not set
-
-#
-# IDE chipset support/bugfixes
-#
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_IDEPCI=y
-# CONFIG_IDEPCI_SHARE_IRQ is not set
-# CONFIG_BLK_DEV_OFFBOARD is not set
-# CONFIG_BLK_DEV_GENERIC is not set
-# CONFIG_BLK_DEV_OPTI621 is not set
-CONFIG_BLK_DEV_IDEDMA_PCI=y
-# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
-# CONFIG_IDEDMA_PCI_AUTO is not set
-# CONFIG_BLK_DEV_AEC62XX is not set
-# CONFIG_BLK_DEV_ALI15X3 is not set
-# CONFIG_BLK_DEV_AMD74XX is not set
-# CONFIG_BLK_DEV_CMD64X is not set
-# CONFIG_BLK_DEV_TRIFLEX is not set
-# CONFIG_BLK_DEV_CY82C693 is not set
-# CONFIG_BLK_DEV_CS5520 is not set
-# CONFIG_BLK_DEV_CS5530 is not set
-# CONFIG_BLK_DEV_HPT34X is not set
-# CONFIG_BLK_DEV_HPT366 is not set
-# CONFIG_BLK_DEV_SC1200 is not set
-# CONFIG_BLK_DEV_PIIX is not set
-# CONFIG_BLK_DEV_IT821X is not set
-# CONFIG_BLK_DEV_NS87415 is not set
-# CONFIG_BLK_DEV_PDC202XX_OLD is not set
-# CONFIG_BLK_DEV_PDC202XX_NEW is not set
-# CONFIG_BLK_DEV_SVWKS is not set
-CONFIG_BLK_DEV_SIIMAGE=y
-# CONFIG_BLK_DEV_SLC90E66 is not set
-# CONFIG_BLK_DEV_TRM290 is not set
-# CONFIG_BLK_DEV_VIA82CXXX is not set
-# CONFIG_IDE_ARM is not set
-CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_IVB is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
+# CONFIG_IDE is not set
 
 #
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+# CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -489,12 +444,13 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOGGING is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
 
 #
 # SCSI low-level drivers
@@ -507,21 +463,24 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
 # CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_DMX3191D is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
 # CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
@@ -529,6 +488,59 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_DEBUG is not set
 
 #
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+CONFIG_ATA=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+CONFIG_PATA_SIL680=y
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
+
+#
 # Multi-device support (RAID and LVM)
 #
 # CONFIG_MD is not set
@@ -632,6 +644,7 @@ CONFIG_R8169=y
 # CONFIG_SK98LIN is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -679,6 +692,7 @@ CONFIG_R8169=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -758,7 +772,6 @@ CONFIG_GPIO_VR41XX=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
 
 #
 # I2C support
@@ -784,12 +797,12 @@ CONFIG_GPIO_VR41XX=y
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
@@ -897,13 +910,13 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
-# CONFIG_USB_STORAGE_ISD200 is not set
 # CONFIG_USB_STORAGE_DPCM is not set
 # CONFIG_USB_STORAGE_USBAT is not set
 # CONFIG_USB_STORAGE_SDDR09 is not set
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
@@ -932,6 +945,7 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 
 #
 # USB Imaging devices
@@ -963,16 +977,17 @@ CONFIG_USB_MON=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
-# CONFIG_USB_CY7C63 is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
@@ -1041,6 +1056,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -1052,6 +1068,7 @@ CONFIG_XFS_QUOTA=y
 # CONFIG_XFS_SECURITY is not set
 CONFIG_XFS_POSIX_ACL=y
 # CONFIG_XFS_RT is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=m
@@ -1082,8 +1099,10 @@ CONFIG_AUTOFS4_FS=y
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -1123,7 +1142,6 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -1150,11 +1168,13 @@ CONFIG_MSDOS_PARTITION=y
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE="mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
 
@@ -1170,10 +1190,6 @@ CONFIG_CMDLINE="mem=64M console=ttyVR0,1
 # CONFIG_CRYPTO is not set
 
 #
-# Hardware crypto devices
-#
-
-#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
