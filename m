Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Oct 2005 18:32:45 +0100 (BST)
Received: from mo01.iij4u.or.jp ([210.130.0.20]:5830 "EHLO mo01.iij4u.or.jp")
	by ftp.linux-mips.org with ESMTP id S3465605AbVJARcV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 1 Oct 2005 18:32:21 +0100
Received: MO(mo01)id j91HWHX6022661; Sun, 2 Oct 2005 02:32:17 +0900 (JST)
Received: MDO(mdo00) id j91HWGxI007258; Sun, 2 Oct 2005 02:32:16 +0900 (JST)
Received: from stratos (h195.p501.iij4u.or.jp [210.149.245.195])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j91HWEDZ013635
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sun, 2 Oct 2005 02:32:15 +0900 (JST)
Date:	Sun, 2 Oct 2005 02:32:13 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: update defconfig
Message-Id: <20051002023213.61de0f26.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I had updated vr41xx machine's defconfig.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/configs/capcella_defconfig a/arch/mips/configs/capcella_defconfig
--- a-orig/arch/mips/configs/capcella_defconfig	2005-10-01 00:31:06.000000000 +0900
+++ a/arch/mips/configs/capcella_defconfig	2005-10-02 01:10:01.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.14-rc2
-# Thu Sep 22 02:15:28 2005
+# Sun Oct  2 00:59:18 2005
 #
 CONFIG_MIPS=y
 
@@ -119,7 +119,7 @@
 # CONFIG_VICTOR_MPC30X is not set
 CONFIG_ZAO_CAPCELLA=y
 CONFIG_PCI_VR41XX=y
-CONFIG_VRC4173=y
+# CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_DMA_NONCOHERENT=y
@@ -327,9 +327,7 @@
 # CONFIG_BLK_DEV_RAM is not set
 CONFIG_BLK_DEV_RAM_COUNT=16
 # CONFIG_LBD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
+# CONFIG_CDROM_PKTCDVD is not set
 
 #
 # IO Schedulers
@@ -370,7 +368,7 @@
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 
 #
@@ -426,7 +424,7 @@
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=y
 # CONFIG_HAPPYMEAL is not set
 # CONFIG_SUNGEM is not set
 # CONFIG_NET_VENDOR_3COM is not set
@@ -436,7 +434,30 @@
 #
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
-# CONFIG_NET_PCI is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
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
+# CONFIG_VIA_RHINE is not set
+# CONFIG_LAN_SAA9730 is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -451,6 +472,7 @@
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 
@@ -504,10 +526,7 @@
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
@@ -525,12 +544,7 @@
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_PCIPS2 is not set
-CONFIG_SERIO_LIBPS2=m
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -544,17 +558,15 @@
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
@@ -568,19 +580,7 @@
 #
 # Watchdog Cards
 #
-CONFIG_WATCHDOG=y
-# CONFIG_WATCHDOG_NOWAYOUT is not set
-
-#
-# Watchdog Device Drivers
-#
-# CONFIG_SOFT_WATCHDOG is not set
-
-#
-# PCI-based Watchdog Cards
-#
-# CONFIG_PCIPCWATCHDOG is not set
-# CONFIG_WDTPCI is not set
+# CONFIG_WATCHDOG is not set
 # CONFIG_RTC is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
@@ -591,7 +591,7 @@
 # Ftape, the floppy tape device driver
 #
 # CONFIG_DRM is not set
-# CONFIG_GPIO_VR41XX is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -784,7 +784,7 @@
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE=""
+CONFIG_CMDLINE="mem=32M console=ttyVR0,38400"
 
 #
 # Security options
@@ -831,7 +831,7 @@
 #
 # CONFIG_CRC_CCITT is not set
 CONFIG_CRC16=m
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
diff -urN -X dontdiff a-orig/arch/mips/configs/e55_defconfig a/arch/mips/configs/e55_defconfig
--- a-orig/arch/mips/configs/e55_defconfig	2005-10-01 00:31:16.000000000 +0900
+++ a/arch/mips/configs/e55_defconfig	2005-10-02 00:48:50.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.14-rc2
-# Thu Sep 22 02:16:01 2005
+# Sun Oct  2 00:48:30 2005
 #
 CONFIG_MIPS=y
 
@@ -315,9 +315,7 @@
 # CONFIG_BLK_DEV_RAM is not set
 CONFIG_BLK_DEV_RAM_COUNT=16
 # CONFIG_LBD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
+# CONFIG_CDROM_PKTCDVD is not set
 
 #
 # IO Schedulers
@@ -326,7 +324,7 @@
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
-CONFIG_ATA_OVER_ETH=m
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -358,7 +356,7 @@
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 
 #
@@ -477,8 +475,8 @@
 #
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=320
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=240
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
@@ -497,7 +495,7 @@
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
+# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=m
@@ -514,17 +512,15 @@
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -559,7 +555,7 @@
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_GPIO_VR41XX is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -706,17 +702,17 @@
 #
 # Network File Systems
 #
-CONFIG_NFS_FS=y
+CONFIG_NFS_FS=m
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
-CONFIG_NFSD=y
+CONFIG_NFSD=m
 # CONFIG_NFSD_V3 is not set
 # CONFIG_NFSD_TCP is not set
-CONFIG_LOCKD=y
-CONFIG_EXPORTFS=y
+CONFIG_LOCKD=m
+CONFIG_EXPORTFS=m
 CONFIG_NFS_COMMON=y
-CONFIG_SUNRPC=y
+CONFIG_SUNRPC=m
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -749,7 +745,7 @@
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE=""
+CONFIG_CMDLINE="console=ttyVR0,19200 mem=8M"
 
 #
 # Security options
diff -urN -X dontdiff a-orig/arch/mips/configs/mpc30x_defconfig a/arch/mips/configs/mpc30x_defconfig
--- a-orig/arch/mips/configs/mpc30x_defconfig	2005-10-01 00:31:23.000000000 +0900
+++ a/arch/mips/configs/mpc30x_defconfig	2005-10-02 01:17:36.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.14-rc2
-# Thu Sep 22 02:16:38 2005
+# Sun Oct  2 01:17:03 2005
 #
 CONFIG_MIPS=y
 
@@ -194,7 +194,21 @@
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCCARD is not set
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_IOCTL=y
+# CONFIG_CARDBUS is not set
+
+#
+# PC-card bridges
+#
+# CONFIG_YENTA is not set
+# CONFIG_PD6729 is not set
+# CONFIG_I82092 is not set
+# CONFIG_TCIC is not set
+CONFIG_PCMCIA_VRC4173=y
 
 #
 # PCI Hotplug Support
@@ -226,10 +240,7 @@
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_FIB_HASH=y
-CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
+# CONFIG_IP_PNP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -292,7 +303,7 @@
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-CONFIG_FW_LOADER=m
+CONFIG_FW_LOADER=y
 
 #
 # Connector - unified userspace <-> kernelspace linker
@@ -324,12 +335,11 @@
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 # CONFIG_BLK_DEV_RAM is not set
 CONFIG_BLK_DEV_RAM_COUNT=16
 # CONFIG_LBD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
+# CONFIG_CDROM_PKTCDVD is not set
 
 #
 # IO Schedulers
@@ -343,12 +353,35 @@
 #
 # ATA/ATAPI/MFM/RLL support
 #
-# CONFIG_IDE is not set
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+CONFIG_BLK_DEV_IDECS=m
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+# CONFIG_BLK_DEV_IDEPCI is not set
+# CONFIG_IDE_ARM is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 
 #
@@ -388,33 +421,12 @@
 #
 # PHY device support
 #
-CONFIG_PHYLIB=m
-CONFIG_PHYCONTROL=y
-
-#
-# MII PHY device drivers
-#
-CONFIG_MARVELL_PHY=m
-CONFIG_DAVICOM_PHY=m
-CONFIG_QSEMI_PHY=m
-CONFIG_LXT_PHY=m
-CONFIG_CICADA_PHY=m
 
 #
 # Ethernet (10 or 100Mbit)
 #
-CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
-# CONFIG_HAPPYMEAL is not set
-# CONFIG_SUNGEM is not set
-# CONFIG_NET_VENDOR_3COM is not set
-
-#
-# Tulip family network device support
-#
-# CONFIG_NET_TULIP is not set
-# CONFIG_HP100 is not set
-# CONFIG_NET_PCI is not set
+# CONFIG_NET_ETHERNET is not set
+CONFIG_MII=m
 
 #
 # Ethernet (1000 Mbit)
@@ -447,9 +459,59 @@
 #
 # Wireless LAN (non-hamradio)
 #
-# CONFIG_NET_RADIO is not set
-# CONFIG_IPW_DEBUG is not set
-CONFIG_IPW2200=m
+CONFIG_NET_RADIO=y
+
+#
+# Obsolete Wireless cards support (pre-802.11)
+#
+# CONFIG_STRIP is not set
+# CONFIG_PCMCIA_WAVELAN is not set
+# CONFIG_PCMCIA_NETWAVE is not set
+
+#
+# Wireless 802.11 Frequency Hopping cards support
+#
+# CONFIG_PCMCIA_RAYCS is not set
+
+#
+# Wireless 802.11b ISA/PCI cards support
+#
+# CONFIG_IPW2100 is not set
+# CONFIG_IPW2200 is not set
+CONFIG_HERMES=m
+# CONFIG_PLX_HERMES is not set
+# CONFIG_TMD_HERMES is not set
+# CONFIG_NORTEL_HERMES is not set
+# CONFIG_PCI_HERMES is not set
+# CONFIG_ATMEL is not set
+
+#
+# Wireless 802.11b Pcmcia/Cardbus cards support
+#
+CONFIG_PCMCIA_HERMES=m
+# CONFIG_PCMCIA_SPECTRUM is not set
+# CONFIG_AIRO_CS is not set
+# CONFIG_PCMCIA_WL3501 is not set
+
+#
+# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
+#
+# CONFIG_PRISM54 is not set
+# CONFIG_HOSTAP is not set
+CONFIG_NET_WIRELESS=y
+
+#
+# PCMCIA network device support
+#
+CONFIG_NET_PCMCIA=y
+CONFIG_PCMCIA_3C589=m
+CONFIG_PCMCIA_3C574=m
+CONFIG_PCMCIA_FMVJ18X=m
+CONFIG_PCMCIA_PCNET=m
+CONFIG_PCMCIA_NMCLAN=m
+CONFIG_PCMCIA_SMC91C92=m
+CONFIG_PCMCIA_XIRC2PS=m
+CONFIG_PCMCIA_AXNET=m
 
 #
 # Wan interfaces
@@ -504,7 +566,7 @@
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
+# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_PCIPS2 is not set
 # CONFIG_SERIO_LIBPS2 is not set
@@ -522,17 +584,15 @@
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
@@ -557,7 +617,12 @@
 # Ftape, the floppy tape device driver
 #
 # CONFIG_DRM is not set
-# CONFIG_GPIO_VR41XX is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -620,7 +685,118 @@
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=m
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=m
+# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
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
+# CONFIG_USB_HID is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_ITMTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
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
+CONFIG_USB_PEGASUS=m
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_USB_MON is not set
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
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB DSL modem support
+#
 
 #
 # USB Gadget Support
@@ -711,7 +887,6 @@
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
-CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
@@ -747,7 +922,7 @@
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE=""
+CONFIG_CMDLINE="mem=32M console=ttyVR0,19200"
 
 #
 # Security options
@@ -794,7 +969,7 @@
 #
 # CONFIG_CRC_CCITT is not set
 CONFIG_CRC16=m
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
diff -urN -X dontdiff a-orig/arch/mips/configs/tb0226_defconfig a/arch/mips/configs/tb0226_defconfig
--- a-orig/arch/mips/configs/tb0226_defconfig	2005-10-01 00:31:35.000000000 +0900
+++ a/arch/mips/configs/tb0226_defconfig	2005-10-02 01:40:41.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.14-rc2
-# Thu Sep 22 02:17:33 2005
+# Sun Oct  2 01:23:35 2005
 #
 CONFIG_MIPS=y
 
@@ -115,13 +115,20 @@
 # CONFIG_NEC_CMBVR4133 is not set
 # CONFIG_CASIO_E55 is not set
 # CONFIG_IBM_WORKPAD is not set
-# CONFIG_TANBAC_TB022X is not set
+CONFIG_TANBAC_TB022X=y
+CONFIG_TANBAC_TB0226=y
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
+CONFIG_PCI_VR41XX=y
+# CONFIG_VRC4173 is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_DMA_NONCOHERENT=y
+CONFIG_DMA_NEED_PCI_MAP_STATE=y
 # CONFIG_CPU_BIG_ENDIAN is not set
-# CONFIG_CPU_LITTLE_ENDIAN is not set
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
@@ -146,19 +153,22 @@
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_SYS_SUPPORTS_64BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_64BIT_KERNEL=y
 
 #
 # Kernel type
 #
-# CONFIG_32BIT is not set
+CONFIG_32BIT=y
 # CONFIG_64BIT is not set
 CONFIG_PAGE_SIZE_4KB=y
 # CONFIG_PAGE_SIZE_8KB is not set
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 # CONFIG_MIPS_MT is not set
+# CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_SYNC=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -177,6 +187,9 @@
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
+CONFIG_HW_HAS_PCI=y
+CONFIG_PCI=y
+# CONFIG_PCI_LEGACY_PROC is not set
 CONFIG_MMU=y
 
 #
@@ -187,12 +200,14 @@
 #
 # PCI Hotplug Support
 #
+# CONFIG_HOTPLUG_PCI is not set
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
 
 #
 # Networking
@@ -308,16 +323,21 @@
 #
 # Block devices
 #
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
+# CONFIG_LBD is not set
+# CONFIG_CDROM_PKTCDVD is not set
 
 #
 # IO Schedulers
@@ -331,34 +351,12 @@
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
-CONFIG_IDEDISK_MULTI_MODE=y
-# CONFIG_BLK_DEV_IDECD is not set
-# CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-CONFIG_BLK_DEV_IDESCSI=y
-# CONFIG_IDE_TASK_IOCTL is not set
-
-#
-# IDE chipset support/bugfixes
-#
-CONFIG_IDE_GENERIC=y
-# CONFIG_IDE_ARM is not set
-# CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
+# CONFIG_IDE is not set
 
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
 CONFIG_SCSI_PROC_FS=y
 
@@ -368,16 +366,15 @@
 CONFIG_BLK_DEV_SD=y
 # CONFIG_CHR_DEV_ST is not set
 # CONFIG_CHR_DEV_OSST is not set
-CONFIG_BLK_DEV_SR=y
-# CONFIG_BLK_DEV_SR_VENDOR is not set
-CONFIG_CHR_DEV_SG=y
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
 # CONFIG_CHR_DEV_SCH is not set
 
 #
 # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
 #
 CONFIG_SCSI_MULTI_LUN=y
-CONFIG_SCSI_CONSTANTS=y
+# CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 
 #
@@ -386,12 +383,42 @@
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
-CONFIG_SCSI_SAS_ATTRS=m
+# CONFIG_SCSI_SAS_ATTRS is not set
 
 #
 # SCSI low-level drivers
 #
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_SCSI_SATA is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_FC is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+CONFIG_SCSI_QLA2XXX=y
+# CONFIG_SCSI_QLA21XX is not set
+# CONFIG_SCSI_QLA22XX is not set
+# CONFIG_SCSI_QLA2300 is not set
+# CONFIG_SCSI_QLA2322 is not set
+# CONFIG_SCSI_QLA6312 is not set
+# CONFIG_SCSI_QLA24XX is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -403,14 +430,18 @@
 # Fusion MPT device support
 #
 # CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
 
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
 #
+# CONFIG_I2O is not set
 
 #
 # Network device support
@@ -422,6 +453,11 @@
 # CONFIG_TUN is not set
 
 #
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
 # PHY device support
 #
 CONFIG_PHYLIB=m
@@ -440,38 +476,81 @@
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
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
+CONFIG_EEPRO100=y
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
 
 #
 # Ethernet (1000 Mbit)
 #
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
 
 #
 # Ethernet (10000 Mbit)
 #
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
 
 #
 # Token Ring devices
 #
+# CONFIG_TR is not set
 
 #
 # Wireless LAN (non-hamradio)
 #
 # CONFIG_NET_RADIO is not set
+# CONFIG_IPW2200 is not set
 
 #
 # Wan interfaces
 #
 # CONFIG_WAN is not set
-CONFIG_PPP=m
-CONFIG_PPP_MULTILINK=y
-# CONFIG_PPP_FILTER is not set
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPPOE=m
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
 # CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -495,10 +574,7 @@
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
@@ -516,11 +592,7 @@
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -534,17 +606,16 @@
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -562,16 +633,20 @@
 # CONFIG_GEN_RTC is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_TANBAC_TB0219 is not set
 
 #
 # Ftape, the floppy tape device driver
 #
-# CONFIG_GPIO_VR41XX is not set
+# CONFIG_DRM is not set
+CONFIG_GPIO_VR41XX=y
 # CONFIG_RAW_DRIVER is not set
 
 #
 # TPM devices
 #
+# CONFIG_TCG_TPM is not set
 
 #
 # I2C support
@@ -610,50 +685,147 @@
 #
 # Graphics support
 #
-CONFIG_FB=y
-# CONFIG_FB_CFB_FILLRECT is not set
-# CONFIG_FB_CFB_COPYAREA is not set
-# CONFIG_FB_CFB_IMAGEBLIT is not set
-# CONFIG_FB_SOFT_CURSOR is not set
-# CONFIG_FB_MACMODES is not set
-# CONFIG_FB_MODE_HELPERS is not set
-# CONFIG_FB_TILEBLITTING is not set
-# CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE is not set
 
 #
-# Logo configuration
+# Sound
 #
-# CONFIG_LOGO is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_SOUND is not set
 
 #
-# Sound
+# USB support
 #
-CONFIG_SOUND=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
 
 #
-# Advanced Linux Sound Architecture
+# Miscellaneous USB options
 #
-# CONFIG_SND is not set
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
 
 #
-# Open Sound System
+# USB Host Controller Drivers
 #
-# CONFIG_SOUND_PRIME is not set
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
 
 #
-# USB support
+# USB Device Class drivers
+#
+# CONFIG_USB_BLUETOOTH_TTY is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+
+#
+# USB Input Devices
+#
+# CONFIG_USB_HID is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_ITMTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
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
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB DSL modem support
 #
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -668,6 +840,7 @@
 #
 # InfiniBand support
 #
+# CONFIG_INFINIBAND is not set
 
 #
 # SN Devices
@@ -697,20 +870,14 @@
 #
 # CD-ROM/DVD Filesystems
 #
-CONFIG_ISO9660_FS=y
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_ZISOFS_FS=y
+# CONFIG_ISO9660_FS is not set
 # CONFIG_UDF_FS is not set
 
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_FAT_DEFAULT_CODEPAGE=437
-CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
 # CONFIG_NTFS_FS is not set
 
 #
@@ -833,7 +1000,7 @@
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE=""
+CONFIG_CMDLINE="mem=32M console=ttyVR0,115200"
 
 #
 # Security options
@@ -882,5 +1049,5 @@
 CONFIG_CRC16=m
 CONFIG_CRC32=m
 CONFIG_LIBCRC32C=m
-CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
diff -urN -X dontdiff a-orig/arch/mips/configs/tb0229_defconfig a/arch/mips/configs/tb0229_defconfig
--- a-orig/arch/mips/configs/tb0229_defconfig	2005-10-01 00:31:36.000000000 +0900
+++ a/arch/mips/configs/tb0229_defconfig	2005-10-02 01:55:33.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.14-rc2
-# Thu Sep 22 02:17:36 2005
+# Sun Oct  2 01:45:15 2005
 #
 CONFIG_MIPS=y
 
@@ -116,7 +116,7 @@
 # CONFIG_CASIO_E55 is not set
 # CONFIG_IBM_WORKPAD is not set
 CONFIG_TANBAC_TB022X=y
-CONFIG_TANBAC_TB0226=y
+# CONFIG_TANBAC_TB0226 is not set
 # CONFIG_VICTOR_MPC30X is not set
 # CONFIG_ZAO_CAPCELLA is not set
 CONFIG_PCI_VR41XX=y
@@ -333,6 +333,7 @@
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
 # CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
@@ -359,7 +360,7 @@
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 
 #
@@ -425,7 +426,30 @@
 #
 # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
-# CONFIG_NET_PCI is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+CONFIG_EEPRO100=y
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
+# CONFIG_VIA_RHINE is not set
+# CONFIG_LAN_SAA9730 is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -436,10 +460,12 @@
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
-# CONFIG_R8169 is not set
+CONFIG_R8169=y
+# CONFIG_R8169_NAPI is not set
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 
@@ -503,10 +529,7 @@
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
@@ -524,12 +547,7 @@
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_PCIPS2 is not set
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=m
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -543,17 +561,15 @@
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
@@ -573,7 +589,7 @@
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_TANBAC_TB0219 is not set
+CONFIG_TANBAC_TB0219=y
 
 #
 # Ftape, the floppy tape device driver
@@ -642,7 +658,120 @@
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-# CONFIG_USB is not set
+CONFIG_USB=m
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=m
+# CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=m
+# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
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
+# CONFIG_USB_HID is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_ITMTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
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
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB DSL modem support
+#
 
 #
 # USB Gadget Support
@@ -838,7 +967,7 @@
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE="mem=64M console=ttyS0,38400 ip=bootp root=/dev/nfs"
+CONFIG_CMDLINE="mem=64M console=ttyVR0,115200 ip=any root=/dev/nfs"
 
 #
 # Security options
diff -urN -X dontdiff a-orig/arch/mips/configs/workpad_defconfig a/arch/mips/configs/workpad_defconfig
--- a-orig/arch/mips/configs/workpad_defconfig	2005-10-01 00:31:37.000000000 +0900
+++ a/arch/mips/configs/workpad_defconfig	2005-10-02 02:04:49.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.14-rc2
-# Thu Sep 22 02:17:39 2005
+# Sun Oct  2 01:59:15 2005
 #
 CONFIG_MIPS=y
 
@@ -24,7 +24,7 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 CONFIG_INITRAMFS_SOURCE=""
@@ -190,7 +190,18 @@
 #
 # PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCCARD is not set
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_IOCTL=y
+
+#
+# PC-card bridges
+#
+# CONFIG_I82365 is not set
+# CONFIG_TCIC is not set
+CONFIG_PCMCIA_PROBE=y
 
 #
 # PCI Hotplug Support
@@ -284,7 +295,7 @@
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=y
 
 #
 # Connector - unified userspace <-> kernelspace linker
@@ -315,9 +326,7 @@
 # CONFIG_BLK_DEV_RAM is not set
 CONFIG_BLK_DEV_RAM_COUNT=16
 # CONFIG_LBD is not set
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_BUFFERS=8
-# CONFIG_CDROM_PKTCDVD_WCACHE is not set
+# CONFIG_CDROM_PKTCDVD is not set
 
 #
 # IO Schedulers
@@ -340,6 +349,7 @@
 # CONFIG_BLK_DEV_IDE_SATA is not set
 CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_IDEDISK_MULTI_MODE is not set
+CONFIG_BLK_DEV_IDECS=m
 # CONFIG_BLK_DEV_IDECD is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
@@ -358,7 +368,7 @@
 #
 # SCSI device support
 #
-CONFIG_RAID_ATTRS=m
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 
 #
@@ -417,7 +427,7 @@
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
-# CONFIG_MII is not set
+CONFIG_MII=m
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_NET_VENDOR_SMC is not set
 # CONFIG_NET_VENDOR_RACAL is not set
@@ -447,6 +457,19 @@
 # CONFIG_NET_RADIO is not set
 
 #
+# PCMCIA network device support
+#
+CONFIG_NET_PCMCIA=y
+CONFIG_PCMCIA_3C589=m
+CONFIG_PCMCIA_3C574=m
+CONFIG_PCMCIA_FMVJ18X=m
+CONFIG_PCMCIA_PCNET=m
+CONFIG_PCMCIA_NMCLAN=m
+CONFIG_PCMCIA_SMC91C92=m
+CONFIG_PCMCIA_XIRC2PS=m
+CONFIG_PCMCIA_AXNET=m
+
+#
 # Wan interfaces
 #
 # CONFIG_WAN is not set
@@ -497,7 +520,7 @@
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
+# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_LIBPS2 is not set
 CONFIG_SERIO_RAW=m
@@ -514,17 +537,15 @@
 #
 # Serial drivers
 #
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+# CONFIG_SERIAL_8250 is not set
 
 #
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_VR41XX is not set
+CONFIG_SERIAL_VR41XX=y
+CONFIG_SERIAL_VR41XX_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -559,6 +580,11 @@
 #
 # Ftape, the floppy tape device driver
 #
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
 # CONFIG_GPIO_VR41XX is not set
 # CONFIG_RAW_DRIVER is not set
 
@@ -752,7 +778,7 @@
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE=""
+CONFIG_CMDLINE="console=ttyVR0,19200 mem=16M"
 
 #
 # Security options
@@ -799,7 +825,7 @@
 #
 # CONFIG_CRC_CCITT is not set
 CONFIG_CRC16=m
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
