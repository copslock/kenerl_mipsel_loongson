Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2007 18:14:10 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:56077 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022941AbXFAROG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2007 18:14:06 +0100
Received: by mo.po.2iij.net (mo31) id l51HClqD037337; Sat, 2 Jun 2007 02:12:47 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox33) id l51HCgwS002020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 2 Jun 2007 02:12:42 +0900 (JST)
Date:	Sat, 2 Jun 2007 02:12:41 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] update cobalt_defconfig
Message-Id: <20070602021241.2147f7ee.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated cobalt_defconfig.
Cobalt button support has added to it.
Also ATA driver has changed BLK_DEV_VIA82CXXX to PATA_VIA.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/configs/cobalt_defconfig mips/arch/mips/configs/cobalt_defconfig
--- mips-orig/arch/mips/configs/cobalt_defconfig	2007-05-24 22:44:52.504133500 +0900
+++ mips/arch/mips/configs/cobalt_defconfig	2007-05-25 12:33:37.123381000 +0900
@@ -1,27 +1,14 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc7
-# Wed Apr 18 14:25:45 2007
+# Linux kernel version: 2.6.22-rc2
+# Fri May 25 11:17:29 2007
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
 CONFIG_MIPS_COBALT=y
 # CONFIG_MACH_DECSTATION is not set
@@ -33,12 +20,9 @@ CONFIG_MIPS_COBALT=y
 # CONFIG_MIPS_SEAD is not set
 # CONFIG_WR_PPMC is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MOMENCO_JAGUAR_ATX is not set
 # CONFIG_MOMENCO_OCELOT is not set
 # CONFIG_MOMENCO_OCELOT_3 is not set
 # CONFIG_MOMENCO_OCELOT_C is not set
-# CONFIG_MOMENCO_OCELOT_G is not set
-# CONFIG_MIPS_XXS1500 is not set
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
 # CONFIG_DDB5477 is not set
@@ -138,7 +122,7 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=1
+CONFIG_ZONE_DMA_FLAG=0
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
 # CONFIG_HZ_128 is not set
@@ -178,6 +162,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_RELAY=y
 # CONFIG_BLK_DEV_INITRD is not set
@@ -193,14 +178,19 @@ CONFIG_BUG=y
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
 
 #
 # Loadable module support
@@ -233,16 +223,13 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_HW_HAS_PCI=y
 CONFIG_PCI=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
 # CONFIG_PCCARD is not set
-
-#
-# PCI Hotplug Support
-#
 # CONFIG_HOTPLUG_PCI is not set
 
 #
@@ -268,7 +255,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -300,11 +286,11 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
-CONFIG_NETWORK_SECMARK=y
+# CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -345,13 +331,16 @@ CONFIG_NETWORK_SECMARK=y
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-CONFIG_IEEE80211=y
-# CONFIG_IEEE80211_DEBUG is not set
-CONFIG_IEEE80211_CRYPT_WEP=y
-CONFIG_IEEE80211_CRYPT_CCMP=y
-CONFIG_IEEE80211_SOFTMAC=y
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
-CONFIG_WIRELESS_EXT=y
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
 
 #
 # Device Drivers
@@ -370,10 +359,6 @@ CONFIG_FW_LOADER=y
 #
 CONFIG_CONNECTOR=y
 CONFIG_PROC_EVENTS=y
-
-#
-# Memory Technology Devices (MTD)
-#
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 # CONFIG_MTD_CONCAT is not set
@@ -418,7 +403,6 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
 
 #
 # Mapping drivers for chip access
@@ -445,16 +429,13 @@ CONFIG_MTD_PHYSMAP_BANKWIDTH=0
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
 
 #
-# OneNAND Flash Device Drivers
+# UBI - Unsorted block images
 #
-# CONFIG_MTD_ONENAND is not set
+# CONFIG_MTD_UBI is not set
 
 #
 # Parallel port support
@@ -479,87 +460,145 @@ CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_RAM is not set
-CONFIG_CDROM_PKTCDVD=y
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
-CONFIG_ATA_OVER_ETH=y
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # Misc devices
 #
-CONFIG_SGI_IOC4=y
+# CONFIG_PHANTOM is not set
+# CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
-CONFIG_IDE=y
-CONFIG_IDE_MAX_HWIFS=4
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
-# CONFIG_IDEDMA_ONLYDISK is not set
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
-# CONFIG_BLK_DEV_JMICRON is not set
-# CONFIG_BLK_DEV_SC1200 is not set
-# CONFIG_BLK_DEV_PIIX is not set
-CONFIG_BLK_DEV_IT8213=y
-# CONFIG_BLK_DEV_IT821X is not set
-# CONFIG_BLK_DEV_NS87415 is not set
-# CONFIG_BLK_DEV_PDC202XX_OLD is not set
-# CONFIG_BLK_DEV_PDC202XX_NEW is not set
-# CONFIG_BLK_DEV_SVWKS is not set
-# CONFIG_BLK_DEV_SIIMAGE is not set
-# CONFIG_BLK_DEV_SLC90E66 is not set
-# CONFIG_BLK_DEV_TRM290 is not set
-CONFIG_BLK_DEV_VIA82CXXX=y
-CONFIG_BLK_DEV_TC86C001=y
-# CONFIG_IDE_ARM is not set
-CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_IVB is not set
-# CONFIG_BLK_DEV_HD is not set
+# CONFIG_BLINK is not set
+# CONFIG_IDE is not set
 
 #
 # SCSI device support
 #
 CONFIG_RAID_ATTRS=y
-# CONFIG_SCSI is not set
+CONFIG_SCSI=y
+# CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
 
 #
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
+# SCSI support type (disk, tape, CD-ROM)
 #
-# CONFIG_ATA is not set
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
+# CONFIG_SCSI_SCAN_ASYNC is not set
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_ESP_CORE is not set
+# CONFIG_SCSI_SRP is not set
+CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
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
+# CONFIG_SATA_INIC162X is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
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
+# CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
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
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+CONFIG_PATA_VIA=y
+# CONFIG_PATA_WINBOND is not set
+# CONFIG_PATA_PLATFORM is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -570,10 +609,14 @@ CONFIG_RAID_ATTRS=y
 # Fusion MPT device support
 #
 # CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+# CONFIG_FUSION_SAS is not set
 
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
 # CONFIG_IEEE1394 is not set
 
 #
@@ -594,24 +637,7 @@ CONFIG_NETDEVICES=y
 # ARCnet devices
 #
 # CONFIG_ARCNET is not set
-
-#
-# PHY device support
-#
-CONFIG_PHYLIB=y
-
-#
-# MII PHY device drivers
-#
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
-# CONFIG_BROADCOM_PHY is not set
-# CONFIG_FIXED_PHY is not set
+# CONFIG_PHYLIB is not set
 
 #
 # Ethernet (10 or 100Mbit)
@@ -639,35 +665,8 @@ CONFIG_TULIP=y
 # CONFIG_ULI526X is not set
 # CONFIG_HP100 is not set
 # CONFIG_NET_PCI is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-# CONFIG_ACENIC is not set
-# CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
-# CONFIG_NS83820 is not set
-# CONFIG_HAMACHI is not set
-# CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
-# CONFIG_SKGE is not set
-# CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
-# CONFIG_TIGON3 is not set
-# CONFIG_BNX2 is not set
-CONFIG_QLA3XXX=y
-# CONFIG_ATL1 is not set
-
-#
-# Ethernet (10000 Mbit)
-#
-# CONFIG_CHELSIO_T1 is not set
-CONFIG_CHELSIO_T3=y
-# CONFIG_IXGB is not set
-# CONFIG_S2IO is not set
-# CONFIG_MYRI10GE is not set
-CONFIG_NETXEN_NIC=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 
 #
 # Token Ring devices
@@ -675,18 +674,16 @@ CONFIG_NETXEN_NIC=y
 # CONFIG_TR is not set
 
 #
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -711,10 +708,7 @@ CONFIG_INPUT=y
 #
 # Userland interfaces
 #
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
@@ -726,18 +720,23 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
+CONFIG_INPUT_MISC=y
+# CONFIG_INPUT_PCSPKR is not set
+CONFIG_INPUT_COBALT_BTNS=y
+# CONFIG_INPUT_ATI_REMOTE is not set
+# CONFIG_INPUT_ATI_REMOTE2 is not set
+# CONFIG_INPUT_KEYSPAN_REMOTE is not set
+# CONFIG_INPUT_POWERMATE is not set
+# CONFIG_INPUT_YEALINK is not set
+# CONFIG_INPUT_UINPUT is not set
+CONFIG_INPUT_POLLDEV=y
 
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_PCIPS2 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=y
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -754,7 +753,7 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_PCI=y
+# CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -773,16 +772,11 @@ CONFIG_LEGACY_PTY_COUNT=256
 # IPMI
 #
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
 CONFIG_COBALT_LCD=y
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_DRM is not set
@@ -792,10 +786,7 @@ CONFIG_COBALT_LCD=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -808,12 +799,7 @@ CONFIG_COBALT_LCD=y
 # Dallas's 1-wire bus
 #
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
 
 #
 # Multifunction device drivers
@@ -824,16 +810,19 @@ CONFIG_COBALT_LCD=y
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
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
 # CONFIG_FB is not set
 
 #
@@ -868,10 +857,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
-
-#
-# MMC/SD Card support
-#
 # CONFIG_MMC is not set
 
 #
@@ -912,18 +897,30 @@ CONFIG_RTC_INTF_SYSFS=y
 CONFIG_RTC_INTF_PROC=y
 CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
 
 #
-# RTC drivers
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
 #
 CONFIG_RTC_DRV_CMOS=y
 # CONFIG_RTC_DRV_DS1553 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
-# CONFIG_RTC_DRV_TEST is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
+# on-CPU RTC drivers
+#
+
+#
 # DMA Engine support
 #
 # CONFIG_DMA_ENGINE is not set
@@ -937,14 +934,6 @@ CONFIG_RTC_DRV_CMOS=y
 #
 
 #
-# Auxiliary Display support
-#
-
-#
-# Virtualization
-#
-
-#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -952,8 +941,13 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 # CONFIG_EXT2_FS_XIP is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
 # CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -969,7 +963,7 @@ CONFIG_INOTIFY_USER=y
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
-CONFIG_FUSE_FS=y
+# CONFIG_FUSE_FS is not set
 CONFIG_GENERIC_ACL=y
 
 #
@@ -1003,7 +997,6 @@ CONFIG_CONFIGFS_FS=y
 #
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
@@ -1021,13 +1014,23 @@ CONFIG_CONFIGFS_FS=y
 # Network File Systems
 #
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
-# CONFIG_NFSD is not set
+CONFIG_NFSD=y
+CONFIG_NFSD_V2_ACL=y
+CONFIG_NFSD_V3=y
+CONFIG_NFSD_V3_ACL=y
+# CONFIG_NFSD_V4 is not set
+CONFIG_NFSD_TCP=y
 CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
+CONFIG_NFS_ACL_SUPPORT=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1051,10 +1054,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Distributed Lock Manager
 #
-CONFIG_DLM=y
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
-# CONFIG_DLM_DEBUG is not set
+# CONFIG_DLM is not set
 
 #
 # Profiling support
@@ -1072,72 +1072,30 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
 CONFIG_CMDLINE=""
 
 #
 # Security options
 #
-CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
+# CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 
 #
 # Cryptographic options
 #
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=y
-CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_MANAGER=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_XCBC=y
-CONFIG_CRYPTO_NULL=y
-CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_WP512=y
-CONFIG_CRYPTO_TGR192=y
-CONFIG_CRYPTO_GF128MUL=y
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=y
-CONFIG_CRYPTO_LRW=y
-CONFIG_CRYPTO_DES=y
-CONFIG_CRYPTO_FCRYPT=y
-CONFIG_CRYPTO_BLOWFISH=y
-CONFIG_CRYPTO_TWOFISH=y
-CONFIG_CRYPTO_TWOFISH_COMMON=y
-CONFIG_CRYPTO_SERPENT=y
-CONFIG_CRYPTO_AES=y
-CONFIG_CRYPTO_CAST5=y
-CONFIG_CRYPTO_CAST6=y
-CONFIG_CRYPTO_TEA=y
-CONFIG_CRYPTO_ARC4=y
-CONFIG_CRYPTO_KHAZAD=y
-CONFIG_CRYPTO_ANUBIS=y
-CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRYPTO_MICHAEL_MIC=y
-CONFIG_CRYPTO_CRC32C=y
-CONFIG_CRYPTO_CAMELLIA=y
-
-#
-# Hardware crypto devices
-#
+# CONFIG_CRYPTO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
 # CONFIG_CRC_CCITT is not set
-CONFIG_CRC16=y
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 CONFIG_LIBCRC32C=y
-CONFIG_ZLIB_INFLATE=y
-CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
