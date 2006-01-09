Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 17:56:16 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:12673 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8134429AbWAIRyt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2006 17:54:49 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k09HsquB029478;
	Mon, 9 Jan 2006 11:55:33 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 09 Jan 2006 11:55:22 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k09HtLh5024379; Mon,
 9 Jan 2006 11:55:21 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id D33852028; Mon, 9 Jan 2006
 10:55:20 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k09I3vb9009795; Mon, 9 Jan 2006 11:03:57
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k09I3uMN009794; Mon, 9 Jan 2006 11:03:56 -0700
Date:	Mon, 9 Jan 2006 11:03:56 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-usb-devel@lists.sourceforge.net
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	info-linux@ldcmail.amd.com, thomas.dahlmann@amd.com
Subject: [PATCH] UDC support for MIPS/AU1200 and Geode/CS5536
Message-ID: <20060109180356.GA8855@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FDC7C003982713031-01-01
Content-Type: multipart/mixed;
 boundary=3MwIy2ne0vdjdPXF
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--3MwIy2ne0vdjdPXF
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

From the "two-birds-one-stone" department, I am pleased to present USB UDC
support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
Also, coming soon (in the next few days), OTG, which has been removed from
the usb_host patch, and put into its own patch (as per David's comments).

This patch is against current linux-mips git, but it should apply for Linus's
tree as well.

Regards,
Jordan

--3MwIy2ne0vdjdPXF
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=udc.patch
Content-Transfer-Encoding: 7bit

PATCH:  Add UDC support for MIPS/AU1200 and Geode/CS5536

This patch adds UDC support for the AU1200 processor and the Geode CS5536
southbridge.  

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 Documentation/usb/au1200udc.txt   |  185 +
 drivers/usb/gadget/Kconfig        |   86 +
 drivers/usb/gadget/Makefile       |    9 
 drivers/usb/gadget/au1200otg.h    |  147 +
 drivers/usb/gadget/au1200udc.c    | 4880 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/au1200udc.h    |  936 +++++++
 drivers/usb/gadget/au1200uoc.c    | 2015 +++++++++++++++
 drivers/usb/gadget/au1200uoc.h    | 1338 ++++++++++
 drivers/usb/gadget/ether.c        |   65 
 drivers/usb/gadget/file_storage.c |    8 
 drivers/usb/gadget/gadget_chips.h |    8 
 drivers/usb/gadget/zero.c         |   10 
 12 files changed, 9684 insertions(+), 3 deletions(-)

diff --git a/Documentation/usb/au1200udc.txt b/Documentation/usb/au1200udc.txt
new file mode 100644
index 0000000..20f4d58
--- /dev/null
+++ b/Documentation/usb/au1200udc.txt
@@ -0,0 +1,185 @@
+-------------------------------------------------------------------------------
+Howto for Linux device driver for the AU1200 USB Device Controller (UDC)
+for gadget driver stack
+-------------------------------------------------------------------------------
+
+Author: Thomas Dahlmann
+
+INTRODUCTION:
+
+The AU1200 UDC is part of AMD MIPS CPU Au1200 and AMD5536 chip (south-
+bridge of AMD Geode LX Processor).
+It is a DMA capable usb device controller. The usb port is shared
+between host and UDC. The Au1200 on-chip OTG controller is used to switch the
+usb port between host, UDC and neutral. So au1200otg driver is needed
+to get the UDC operating.
+
+Current gadget support: file_storage, ether, zero
+
+-------------------------------------------------------------------------------
+WHAT YOU NEED:
+-------------------------------------------------------------------------------
+
+copy/replace following files to /usr/src/linux/drivers/usb/gadget
+        au1200udc.c
+        au1200udc.h
+        au1200otg.h
+        au1200uoc.c
+        au1200uoc.h
+        ether.c
+        file_storage.c
+        zero.c
+        gadget_chips.h
+        Makefile
+        Kconfig 
+
+-------------------------------------------------------------------------------
+HOW TO INSTALL IT:
+-------------------------------------------------------------------------------
+
+change to directory /usr/src/linux
+
+configure gadget as module:
+        "make menuconfig"
+        under "Code maturity level options" choose "Prompt for development ..."
+        goto "Device Drivers"
+        goto "USB support" -> "USB Gadget support"
+        choose "Support for USB Gadgets" as module
+        under choice "USB Peripheral Controller" choose "AU1200UDC"
+        under "USB Gadget Drivers"
+        choose "Gadget Zero" as module or
+        choose "Ethernet Gagdet" as module or
+        choose "File-backed Storage Gadget" as module
+        choose "AU1200 USB portmux control (On-The-Go support)"
+        under choice "OTG port functionality" choose "Gadget only"
+        exit and save config
+
+compile and install modules:
+        "make modules modules_install"
+
+-------------------------------------------------------------------------------
+HOW TO USE IT:
+-------------------------------------------------------------------------------
+
+*** How to load FILE-BACKED STORAGE gadget driver - mass storage ***
+enable USB mass storage support for linux host:
+        change to directory /usr/src/linux
+        "make menuconfig"
+        under "File systems" choose "DOS/FAT/NT filesystems"
+        choose "MSDOS fs support"
+        under "Device Drivers" under "SCSI device support"
+                choose "SCSI device support"
+                choose "SCSI generic support"
+        under "Device Drivers" under "USB support" in section 
+                "USB Device Class drivers" choose
+                "USB Mass Storage support"
+        compile new kernel
+create disk file:
+        "dd bs=1M count=128 if=/dev/zero of=/tmp/disk"
+        => creates a 128Mbyte image file /tmp/disk
+load modules:
+        "modprobe au1200udc"  
+        "modprobe g_file_storage file=/tmp/disk"
+        "modprobe au1200otg"
+create a primary FAT16 disk partition via linux host site:
+        "fdisk /dev/sda", make FAT16 prim. partition
+        => "n", "p", "1", "<RETURN>", "<RETURN>", "t", "6", "w",
+        "mkdosfs /dev/sda1"
+        "sync"
+create primary disk partition via Windows XP host site:
+        right click on "My Computer"
+        choose "Manage" => "Disk Management"
+        choose usb disk and follow instructions of partition menu
+mount usb mass storage device on linux host:
+        make directory "/mnt/gadget/"
+        "mount -t msdos /dev/sda1 /mnt/gadget"
+
+***  How to access files of disk image on UDC side ***
+When files were copied from host to UDC mass storage device then files
+are inside the monolitic disk image (see above) on UDC side. This
+disk image can be mounted via the loopback device driver to a 
+directory on UDC side to access these files.
+Steps on UDC side:
+        enable kernel support for loopback device
+        change to directory /usr/src/linux
+        "make menuconfig"
+        under "Block devices" choose "Loopback device support"
+                and recompile the kernel
+        determine offset inside disk image:
+        "fdisk -l -u disk_image", output is like:
+>> You must set cylinders.
+>> You can do this from the extra functions menu.
+>>
+>> Disk /tmp/disk128: 5 heads, 52 sectors, 0 cylinders
+>> Units = sectors of 1 * 512 bytes
+>>
+>>         Device Boot    Start       End    Blocks   Id  System
+>> /tmp/disk128p1            52    262079    131014    6  FAT16
+
+        get offset my multiplying start value by sector size:
+        52 * 512 = 26624
+        mount disk image:
+        "mount -o loop,offset=26624 -t msdos disk_image /mnt"
+
+
+*** How to load ZERO gadget driver - simple BULK loop back ***
+load modules:
+UDC driver:
+        (a) Slave/Fifo mode:       "modprobe au1200udc use_dma=0"
+        (b) DMA Buffer Fill mode:  "modprobe au1200udc use_dma=1" 
+        default:
+        (c) DMA PPBNDU mode:       "modprobe au1200udc"  
+        (d) DMA PPBDU mode:        "modprobe au1200udc use_dma=1 use_dma_ppb=1 use_dma_ppb_du=1"  
+        (e) fullspeed mode:        "modprobe au1200udc use_fullspeed=1", can be combined
+                                    with all dma modes  
+        (f) special higspeed
+            tx buffer size:        "modprobe au1200udc hs_tx_buf=<buf_size in dwords>"
+                                   example: "modprobe au1200udc use_dma=1 hs_tx_buf=128"
+                                            => buffer size = 512 bytes (=bulk max packet)
+Gadget Zero driver:
+        (a) Bulk loop:             "modprobe g_zero"
+        (b) Int loop:              "modprobe g_zero use_interrupt_traffic=1"
+        (c) Source/Sink            "modprobe g_zero loopdefault=0"
+                                   OUT data must all be zero's
+        (d) Source/Sink count      "modprobe g_zero loopdefault=0 pattern=1"
+                                   each OUT packet must count modulo63 (0,1,..,62,0,1,..) 
+OTG driver:                        "modprobe au1200otg"
+example:
+        "modprobe au1200udc"
+        "modprobe g_zero"
+        "modprobe au1200otg"
+        => loads driver for DMA PPBNDU mode and Bulk loop  
+
+
+*** How to use ETHERNET gadget driver (CDC protocol) ***
+                   with Linux Host
+UDC side bringup: 
+        load gadget modules
+        "modprobe au1200udc"  
+        "modprobe g_ether"
+        "modprobe au1200otg"
+        "ifconfig usb0 192.168.0.2"  
+Host side bringup: 
+        install support for CDC Ethernet:
+        change to directory /usr/src/linux
+        "make menuconfig"
+        under "Device Drivers" under "USB support" under
+        "USB Network adapters" choose
+        "Multi-purpose USB Networking Framework"
+        choose "CDC Ethernet support"
+        compile mew kernel
+        "modprobe CDCEther"
+        "ifconfig eth1 192.168.0.1"
+        note: assuming there is one network card assigned to eth0,
+                otherwise kernel messages of CDC Ethernet module show
+                which interface (ethX) is used 
+Use network connection: 
+        after bringup of host and UDC side it behaves like a normal
+                ethernet connection between host and UDC
+        test the connection:
+        host side: "ping -I eth1 192.168.0.2"
+        UDC side : "ping -I usb0 192.168.0.1"
+        note: the "-I" option assures that the USB cable is used, the
+                option can be omitted when the routing table is setup to avoid
+                using other network interfaces as eth0
+
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index ff075a5..2a3b652 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -89,7 +89,27 @@ config USB_NET2280
 	depends on USB_GADGET_NET2280
 	default USB_GADGET
 	select USB_GADGET_SELECTED
+config USB_GADGET_AU1200UDC
+	boolean "AU1200UDC"
+	depends on PCI || SOC_AU1200
+	select USB_GADGET_DUALSPEED
+	help
+	   AU1200 UDC is a PCI based USB peripheral controller which
+	   supports both full and high speed USB 2.0 data transfers.  
+	   
+	   It has four configurable endpoints, as well as endpoint zero
+	   (for control transfers).
+
+	   Say "y" to link the driver statically, or "m" to build a
+	   dynamically linked module called "au1200udc" and force all
+	   gadget drivers to also be dynamically linked.
 
+config USB_AU1200UDC
+	tristate
+	depends on USB_GADGET_AU1200UDC
+	default USB_GADGET
+	select USB_GADGET_SELECTED
+        select USB_PORT_AU1200OTG
 config USB_GADGET_PXA2XX
 	boolean "PXA 25x or IXP 4xx"
 	depends on (ARCH_PXA && PXA25x) || ARCH_IXP4XX
@@ -322,7 +342,7 @@ config USB_ETH
 
 config USB_ETH_RNDIS
 	bool "RNDIS support (EXPERIMENTAL)"
-	depends on USB_ETH && EXPERIMENTAL
+	depends on USB_ETH && EXPERIMENTAL && !(USB_GADGET_AU1200UDC)
 	default y
 	help
 	   Microsoft Windows XP bundles the "Remote NDIS" (RNDIS) protocol,
@@ -395,4 +415,68 @@ config USB_G_SERIAL
 
 endchoice
 
+#
+# AU1200 USB OTG options
+#
+config USB_PORT_AU1200OTG
+	boolean "AU1200 USB portmux control (On-The-Go support)"
+	depends on USB_GADGET_AU1200UDC || USB_EHCI_HCD || USB_OHCI_HCD
+	default n
+	help
+	   The AU1200 and Au1200 USB device port can be used as
+	   either a host port or a device port.
+	   Say "y" here if you want to use both or if you want to
+	   setup this port to fit into your board configuration.
+
+	   If the AU1200UDC driver is configured to be statically
+	   linked this module will be linked into the kernel image
+	   as well otherwise an additional module called
+	   "au1200otg" will be built.
+
+config USB_AU1200OTG
+	tristate
+	depends on USB_PORT_AU1200OTG
+	default USB_AU1200UDC
+
+choice
+	prompt "OTG port functionality"
+	depends on USB_PORT_AU1200OTG
+	default USB_OTGMUX_GADGET
+
+config USB_OTGMUX_HOST
+	boolean "Host only"
+	depends on !USB_GADGET_AU1200UDC && (USB_EHCI_HCD || USB_OHCI_HCD)
+	help
+	   Select this if your device port is connected to a
+	   Standard-A or a Mini-A connector.
+	   It is possible to choose this with a Mini-AB connector
+	   if the device controller is not to be used.
+
+config USB_OTGMUX_GADGET
+	boolean "Gadget only"
+	depends on USB_GADGET_AU1200UDC
+	help
+	   Select this if your device port is connected to a
+	   Standard-B or a Mini-B connector.
+	   It is possible to choose this with a Mini-AB connector
+	   if the host controller is not to be used at this port.
+
+config USB_OTGMUX_IDPIN
+	boolean "Cable select"
+	depends on USB_GADGET_AU1200UDC && (USB_EHCI_HCD || USB_OHCI_HCD)
+	help
+	   Choose this if you want to use both host and device at
+	   this port. The port multiplexer is controlled by the
+	   connectors ID pin. If an A-plug is connected the port
+	   it is routed to the host otherwise it's routed to the
+	   device controller. 
+
+           This is useful for validation platforms which use AB
+           receptacle in order to share one port between host and device.
+           It is not a USB compliant option.
+
+	   Select this only if your device port is connected to
+	   a Mini-AB connector.
+
+endchoice
 endmenu
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index d5fd04d..0298250 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -3,6 +3,7 @@
 #
 obj-$(CONFIG_USB_DUMMY_HCD)	+= dummy_hcd.o
 obj-$(CONFIG_USB_NET2280)	+= net2280.o
+obj-$(CONFIG_USB_AU1200UDC)	+= au1200udc.o
 obj-$(CONFIG_USB_PXA2XX)	+= pxa2xx_udc.o
 obj-$(CONFIG_USB_GOKU)		+= goku_udc.o
 obj-$(CONFIG_USB_OMAP)		+= omap_udc.o
@@ -28,3 +29,11 @@ obj-$(CONFIG_USB_GADGETFS)	+= gadgetfs.o
 obj-$(CONFIG_USB_FILE_STORAGE)	+= g_file_storage.o
 obj-$(CONFIG_USB_G_SERIAL)	+= g_serial.o
 
+#
+# AU1200 USB OTG options
+#
+ifeq ($(CONFIG_USB_PORT_AU1200OTG),y)
+obj-$(CONFIG_USB_AU1200OTG)	+= au1200otg.o
+
+au1200otg-objs			:= au1200uoc.o
+endif
diff --git a/drivers/usb/gadget/au1200otg.h b/drivers/usb/gadget/au1200otg.h
new file mode 100644
index 0000000..2b05703
--- /dev/null
+++ b/drivers/usb/gadget/au1200otg.h
@@ -0,0 +1,147 @@
+/*
+ * AMD Au1200 USB OTG driver
+ */
+
+/*
+ * Copyright (C) 2005 AMD (http://www.amd.com)
+ * Author: Karsten Boge 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef AU1200OTG_H
+#define AU1200OTG_H
+
+/* log Bug 5395 */
+#define OTG_HNP_ERR_LOG
+
+/*****************************************************************************
+*  Constants
+*****************************************************************************/
+
+
+/**********************************
+ * OTG sub-state definitions
+***********************************/
+
+#define OTG_STATE_MASK                  0x0F
+
+#define OTG_STATE_B_HOST_WT             (0x10 | OTG_STATE_B_HOST)
+#define OTG_STATE_B_PERIPHERAL_WT       (0x10 | OTG_STATE_B_PERIPHERAL)
+#define OTG_STATE_B_PERIPHERAL_DC       (0x20 | OTG_STATE_B_PERIPHERAL)
+#define OTG_STATE_B_SRP_WAIT_SE0        (0x10 | OTG_STATE_B_SRP_INIT)
+#define OTG_STATE_B_SRP_D_PULSE         (0x20 | OTG_STATE_B_SRP_INIT)
+#define OTG_STATE_B_SRP_V_PULSE         (0x30 | OTG_STATE_B_SRP_INIT)
+#define OTG_STATE_B_SRP_V_DCHRG         (0x40 | OTG_STATE_B_SRP_INIT)
+#define OTG_STATE_B_SRP_WAIT_VBUS       (0x50 | OTG_STATE_B_SRP_INIT)
+
+#define OTG_STATE_A_IDLE_WAIT_DP        (0x10 | OTG_STATE_A_IDLE)
+#define OTG_STATE_A_IDLE_WAIT_VP        (0x20 | OTG_STATE_A_IDLE)
+#define OTG_STATE_A_IDLE_WAIT_MP        (0x30 | OTG_STATE_A_IDLE)
+#define OTG_STATE_A_IDLE_WAIT_DV        (0x40 | OTG_STATE_A_IDLE)
+#define OTG_STATE_A_WAIT_BCON_VB        (0x10 | OTG_STATE_A_WAIT_BCON)
+#define OTG_STATE_A_WAIT_VFALL_DN       (0x10 | OTG_STATE_A_WAIT_VFALL)
+
+
+/**********************************
+*  typical timer values
+**********************************/
+
+#define OTG_TMR_WAIT_VFALL     10   /* (  ) A waits for VBus                 */
+#define OTG_TMR_A_WAIT_VRISE   100  /* (  ) A waits for VBus                 */
+#define OTG_TMR_A_WAIT_BCON    200  /* (  ) A waits for B-connect (1.. s)    */
+#define OTG_TMR_A_IDLE_BDIS    250  /* (ms) A waits for B-disc (200.. ms)    */
+#define OTG_TMR_B_WAIT_ADISCON 600  /* (us) B waits for A to disconnect <1ms */
+#define OTG_TMR_B_ACON_BRST    200  /* (us) B waits before starting reset    */
+#define OTG_TMR_B_ASE0_BRST    5    /* (ms) B waits for A-conn (3.125.. ms)  */
+#define OTG_TMR_B_AIDL_BDIS    50   /* (ms) B waits before dc (5..150ms)     */
+#define OTG_TMR_SRP_WAIT_SE0   2    /* (  ) B SRP idle wait                  */
+#define OTG_TMR_SRP_WAIT_DP    7    /* (ms) B SRP D_PULSE (5..10ms)          */
+#define OTG_TMR_SRP_WAIT_VP    80   /* (ms) B SRP V_PULSE (5..100ms)         */
+#define OTG_TMR_SRP_DCHRG_V    30   /* (  ) B SRP VBus discharge             */
+#define OTG_TMR_SRP_WAIT_VRS   5800 /* (ms) B SRP waits for VBus (5..6s)     */
+#define OTG_TMR_ASRP_WAIT_MP   4    /* (  ) A SRP min. pulse                 */
+#define OTG_TMR_ASRP_WAIT_DP   10   /* (ms) A SRP D_PULSE TO                 */
+#define OTG_TMR_ASRP_WAIT_VP   200  /* (ms) A SRP V_PULSE TO                 */
+#define OTG_TMR_ASRP_WAIT_DV   200  /* (  ) A SRP waits for V_PULSE          */
+#define OTG_TMR_A_BCON_VB      50   /* (  ) A waits for VBus after connect   */
+
+#define OTG_TMR_IDSNS_WAIT     10   /* (ms) ID sense wait                    */
+
+/*********************************/
+
+#define TIMER_PERIOD           1000      /* 10 ms, if longer than 10ms       */
+
+/**********************************
+ * OTG state parameters
+ **********************************/
+
+#define OTG_HOST_READY         (1<<20)   /* indicates a USB host driver is   */
+                                         /* running                          */
+#define OTG_GADGET_READY       (1<<21)   /* indicates a USB gadget driver is */
+                                         /* running                          */
+#define OTG_A_BUS_REQ          (1<<22)   /* used by appl-SW to request a     */
+                                         /* VBus rise, auto-reset by driver  */
+#define OTG_A_BUS_DROP         (1<<23)   /* used by appl-SW to request a     */
+                                         /* VBus drop, auto-reset by driver  */
+#define OTG_A_CLR_ERR          (1<<24)   /* used by appl-SW to request VBerr */
+                                         /* clean-up, auto-reset by driver   */
+#define OTG_AB_HNP_REQ         (1<<25)   /* used by appl-SW to initiate      */
+                                         /* HNP, auto-reset by driver        */
+#define OTG_B_BUS_REQ          (1<<26)   /* used by appl-SW to request       */
+                                         /* B-device functionality, ...      */
+#define OTG_B_BUS_DIS          (1<<27)   /* used by appl-SW to request       */
+                                         /* disable B-device functionality   */
+#define OTG_B_aSSN_REQ         (1<<28)   /* used by appl-SW to initiate SRP, */
+                                         /* auto-reset by the driver         */
+#define OTG_B_SRP_ERROR        (1<<29)   /* indicates invalid HW conditions  */
+                                         /* during SRP, reset by writing "1" */
+#define OTG_A_VBUS_FAILED      (1<<30)   /* indicates a VBus error, reset by */
+                                         /* writing "1", when setting        */
+                                         /* CLR_ERR or when leaving A-states */
+#define OTG_UDC_RWK_REQ        (1<<31)   /* call UDC function to force a     */
+                                         /* remote wake-up                   */
+
+#define SW_REQUEST_MASK        (OTG_A_BUS_REQ | OTG_A_BUS_DROP | \
+                                OTG_A_CLR_ERR | OTG_B_aSSN_REQ | \
+                                OTG_B_BUS_REQ | OTG_B_BUS_DIS | \
+                                OTG_UDC_RWK_REQ)
+
+/*********************************************************************/
+
+/*
+ * gadget events for notify function
+ */
+#define OTG_GADGET_EVT_SVDROP  (1<<0)    /* Session valid drop       */
+#define OTG_GADGET_EVT_SVALID  (1<<1)    /* Session valid            */
+#define OTG_GADGET_REQ_WAKE    (1<<2)    /* Request remote wake-up   */
+
+/*** HS-A0 WA: gadget phy suspend issue                            ***/
+#define OTG_FLAGS_UDC_SUSP     (1<<17)   /* gadget phy suspended     */
+
+#ifdef OTG_HNP_ERR_LOG
+#define OTG_FLAGS_HNP_ERR     (1<<18)   /* HNP error bug 5395 occured  */
+#endif
+
+/*****************************************************************************
+*  Data
+*****************************************************************************/
+
+struct usb_otg_gadget_extension {
+	int (*request) (u32);	/* function call for state change requests */
+	u32 (*query) (int);	/* function call to query state            */
+	void (*notify) (u32);   /* filled in by gadget for notification    */
+};
+
+#endif /* AU1200OTG_H */
diff --git a/drivers/usb/gadget/au1200udc.c b/drivers/usb/gadget/au1200udc.c
new file mode 100644
index 0000000..7153902
--- /dev/null
+++ b/drivers/usb/gadget/au1200udc.c
@@ -0,0 +1,4880 @@
+/*
+ * AMD Au1200 UDC high/full speed USB device controller driver.
+ *
+ * Note: Driver also works with AMD Geode LX southbridge AMD5536 
+ */
+
+/*
+ * Copyright (C) 2005 AMD (http://www.amd.com)
+ * Author: Thomas Dahlmann 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*****************************************************************************
+ * Defines
+ *****************************************************************************/
+
+/* debug control */
+#undef UDC_DEBUG
+/* #define UDC_DEBUG     1 */
+#undef UDC_VERBOSE
+/* #define UDC_VERBOSE */        
+/* #define UDC_REGISTER_DUMP */
+
+/* Driver strings */
+#define UDC_MOD_DESCRIPTION         "AMD Au1200 UDC - USB Device Controller"
+#define UDC_DRIVER_VERSION_STRING   "01.00.0204 - $Revision: #4 $"
+
+/*****************************************************************************
+ *  Includes
+ *****************************************************************************/
+
+/* system */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/ioctl.h>
+#include <linux/fs.h>
+#include <linux/dmapool.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/unaligned.h>
+
+/* MIPS config */
+#ifdef CONFIG_SOC_AU1200
+#include <asm/mach-au1x00/au1000.h>
+#include <linux/platform_device.h>
+#endif
+
+/* gadget stack */
+#include <linux/usb_ch9.h>
+#include <linux/usb_gadget.h>
+#include <linux/usb_otg.h>
+
+/* udc/uoc specific */
+#include "au1200udc.h"
+#include "au1200uoc.h"
+
+
+/* use RDE timer for new kernel only */
+#define UDC_USE_TIMER
+/*****************************************************************************
+ *  Static Function Declarations
+ *****************************************************************************/
+
+void udc_tasklet_disconnect(unsigned long);
+#ifdef UDC_USE_TIMER
+void udc_timer_function(unsigned long v);
+void udc_pollstall_timer_function(unsigned long v);
+#endif
+static int udc_rxfifo_read_dwords(struct udc* dev, u32* buf, int dwords);
+static void empty_req_queue (struct udc_ep *);
+static int udc_probe (struct udc* dev);
+static void udc_basic_init (struct udc *dev);
+static void udc_setup_endpoints (struct udc *dev);
+static void udc_soft_reset(struct udc* dev);
+#ifdef UDC_DEBUG
+static void dump_buffer(u8* buf, u32 bytes);
+static int udc_ioctl (struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
+static int udc_open (struct inode *inode, struct file *file);
+static int udc_release (struct inode *inode, struct file *file);
+#endif
+static struct udc_data_dma* udc_get_last_dma_desc(struct udc_request* req);
+static u32 udc_get_ppbdu_rxbytes(struct udc_request* req);
+static int udc_free_dma_chain(struct udc* dev, struct udc_request* req);
+static int udc_create_dma_chain(struct udc_ep* ep, struct udc_request* req, unsigned long buf_len, int gfp_flags);
+static inline int startup_registers(struct udc* dev);
+#ifdef CONFIG_SOC_AU1200
+void au1200_sync(void);
+#endif
+static int udc_remote_wakeup(struct udc* dev);
+#if   defined(CONFIG_SOC_AU1200)
+static int udc_suspend(struct udc* dev);
+static int udc_resume(struct udc* dev);
+#else
+static int udc_pci_probe (struct pci_dev *pdev, const struct pci_device_id *id);
+static void udc_pci_remove (struct pci_dev *pdev);
+#endif
+
+/*****************************************************************************
+ *  Data
+ *****************************************************************************/
+
+/* description */
+static const char mod_desc [] = UDC_MOD_DESCRIPTION;
+static const char name [] =     DRIVER_NAME_FOR_PRINT; 
+
+/* structure to hold endpoint function pointers */
+static struct usb_ep_ops udc_ep_ops;
+
+/* received setup data */
+static union udc_setup_data setup_data;
+
+/* pointer to device object */      
+static struct udc       *udc;
+
+/* irq spin lock for soft reset */
+spinlock_t udc_irq_spinlock;
+/* stall spin lock */
+spinlock_t udc_stall_spinlock;
+
+/* this is used for dma chaining */
+static int udc_gfp_flags = 0;
+        
+/* slave mode: pending bytes in rx fifo after nyet,
+used if EPIN irq came but no req was available */
+static unsigned int udc_rxfifo_pending = 0;
+
+/* count soft resets after suspend to avoid loop */
+static int soft_reset_occured = 0;
+#ifdef UDC_IPBUG_3958_WORKAROUND
+static int soft_reset_after_usbreset_occured = 0;
+#endif
+
+#ifdef UDC_USE_TIMER
+/* timer */
+static struct timer_list udc_timer;
+static int stop_timer = 0;
+int set_rde = -1;
+DECLARE_COMPLETION(on_exit);
+static struct timer_list udc_pollstall_timer;
+static int stop_pollstall_timer = 0;
+DECLARE_COMPLETION(on_pollstall_exit);
+#endif
+
+/* tasklet for usb disconnect */
+DECLARE_TASKLET(disconnect_tasklet, udc_tasklet_disconnect, (unsigned long) &udc);
+
+#ifdef USE_AU1200_PCI_DUMMY
+static struct pci_dev pdev_dummy;
+static struct pci_dev* pdev = &pdev_dummy;
+#endif
+
+#ifdef UDC_IPBUG_3958_WORKAROUND
+/* CNAK pending field: bit0 = ep0in, bit16 = ep0out */
+static u32 cnak_pending = 0;
+#define UDC_QUEUE_CNAK(ep, num) \
+        if (readl(&((ep)->regs->ctl)) & AMD_BIT(UDC_EPCTL_NAK)) { \
+                DBG("NAK could not be cleared for ep%d\n", num); \
+                cnak_pending |= 1 << (num); \
+                (ep)->naking = 1; \
+        } \
+        else \
+                cnak_pending = cnak_pending & (~(1<<(num))); 
+#else
+#define UDC_QUEUE_CNAK(ep, num) {} 
+#endif
+
+#ifdef UDC_IPBUG_3943_WORKAROUND
+/* otg registering count */
+static u32 otg_reg_count = 0;
+#endif
+/* gadget registering count */
+static u32 gadget_bind_count = 0;
+
+/* endpoint names used for print */
+static const char ep0_string[] = "ep0in";
+static const char *ep_string[] = {
+        ep0_string,
+        "ep1in-int", "ep2in-bulk", "ep3in-bulk", "ep4in-bulk", "ep5in-bulk", "ep6in-bulk", "ep7in-bulk", "ep8in-bulk",
+        "ep9in-bulk", "ep10in-bulk", "ep11in-bulk", "ep12in-bulk", "ep13in-bulk", "ep14in-bulk", "ep15in-bulk", "ep0out",
+        "ep1out-bulk", "ep2out-bulk", "ep3out-bulk", "ep4out-bulk", "ep5out-bulk", "ep6out-bulk", "ep7out-bulk", "ep8out-bulk",
+        "ep9out-bulk", "ep10out-bulk", "ep11out-bulk", "ep12out-bulk", "ep13out-bulk", "ep14out-bulk", "ep15out-bulk" 
+};
+
+#ifdef UDC_DEBUG
+/* driver callback functions */
+static struct file_operations udc_fops = {
+        owner:          THIS_MODULE,
+
+        read:           NULL,
+        write:          NULL,
+        ioctl:          udc_ioctl,
+        open:           udc_open,
+        release:        udc_release,
+};
+#endif
+
+/* PCI device parameters */
+static struct pci_device_id pci_id[] = {{
+        .vendor =       UDC_PCI_VENID,
+        .device =       UDC_PCI_DEVID,
+        .class =        UDC_PCI_CLASS,
+        .class_mask =   UDC_PCI_CLASS_MASK,
+        .subvendor =    PCI_ANY_ID,
+        .subdevice =    PCI_ANY_ID,
+},
+{}
+};
+
+#if  !defined(CONFIG_SOC_AU1200)
+/* PCI functions */
+static struct pci_driver udc_pci_driver = {
+        .name =         (char *) name,
+        .id_table =     pci_id,
+        .probe =        udc_pci_probe,
+        .remove =       udc_pci_remove,
+};
+#endif
+
+#ifdef UDC_DEBUG
+/* data for debuging only */
+static unsigned long no_pref_req = 0;
+static unsigned long no_req = 0;
+static u32 same_cfg = 0;
+static u32 num_enums = 0;
+#endif
+
+/****** following flags can be set by module parameters */
+/* DMA usage flag */
+static int use_dma = 1;
+/* packet per buffer dma */
+static int use_dma_ppb = 1;
+/* with per descr. update */
+static int use_dma_ppb_du = 0;
+/* buffer fill mode */
+static int use_dma_bufferfill_mode = 0;
+/* full speed only mode */
+static int use_fullspeed = 0;
+/* tx buffer size for high speed */
+static unsigned long hs_tx_buf = UDC_EPIN_BUFF_SIZE;
+
+/* module parameters */
+MODULE_PARM (use_dma, "i");
+MODULE_PARM_DESC (use_dma, "true for DMA");
+MODULE_PARM (use_dma_ppb, "i");
+MODULE_PARM_DESC (use_dma_ppb, "true for DMA in packet per buffer mode");
+MODULE_PARM (use_dma_ppb_du, "i");
+MODULE_PARM_DESC (use_dma_ppb_du, "true for DMA in packet per buffer mode with descriptor update");
+MODULE_PARM (use_fullspeed, "i");
+MODULE_PARM_DESC (use_fullspeed, "true for fullspeed only");
+MODULE_PARM (hs_tx_buf, "l");
+MODULE_PARM_DESC (hs_tx_buf, "high speed tx buffer size for data endpoints in dwords");
+
+MODULE_DESCRIPTION (UDC_MOD_DESCRIPTION);
+MODULE_AUTHOR ("Thomas Dahlmann");
+MODULE_LICENSE("GPL");
+
+#ifndef USE_AU1200_PCI_DUMMY
+MODULE_DEVICE_TABLE (pci, pci_id);
+#endif
+
+/*****************************************************************************
+ *  Function Definitions
+ *****************************************************************************/
+
+/* AU specific */
+#ifdef CONFIG_SOC_AU1200
+void au1200_sync(void)
+{
+        au1200_sync_delay();
+}
+#endif
+
+#ifdef UDC_DEBUG
+/**
+ * Dumps byte read access
+ * 
+ * \param a address pointer
+ * \return read byte
+ */
+static void print_td(struct udc_data_dma *p)
+{
+        INFO("td = %08lx: status=%08lx bufptr=%08lx next=%08lx\n", 
+             (unsigned long) p,
+             (unsigned long) p->status,
+             (unsigned long) p->bufptr,
+             (unsigned long) p->next);
+}
+#endif
+
+/* printing registers --------------------------------------------------------*/
+/**
+ * Prints UDC device registers and endpoint irq registers
+ * 
+ * \param dev pointer to device struct 
+ */
+static void print_regs(struct udc* dev)
+{
+#ifndef UDC_IPBUG_3943_WORKAROUND
+        DBG( "------- Device registers -------\n");
+        DBG( "dev config     = %08lx\n", (unsigned long) dev->regs->cfg);
+        DBG( "dev control    = %08lx\n", (unsigned long) dev->regs->ctl);
+        DBG( "dev status     = %08lx\n", (unsigned long) dev->regs->sts);
+        DBG( "\n");
+        DBG( "dev int's      = %08lx\n", (unsigned long) dev->regs->irqsts);
+        DBG( "dev intmask    = %08lx\n", (unsigned long) dev->regs->irqmsk);
+        DBG( "\n");
+        DBG( "dev ep int's   = %08lx\n", (unsigned long) dev->regs->ep_irqsts);
+        DBG( "dev ep intmask = %08lx\n", (unsigned long) dev->regs->ep_irqmsk);
+        DBG( "\n");
+#endif
+        DBG( "USE DMA        = %d\n", use_dma);
+        if (use_dma && use_dma_ppb && !use_dma_ppb_du) {
+                DBG( "DMA mode       = PPBNDU (packet per buffer WITHOUT desc. update)\n");
+#ifndef UDC_DEBUG
+                INFO( "DMA mode (PPBNDU)\n");
+#endif
+        } 
+        else if (use_dma && use_dma_ppb_du && use_dma_ppb_du) {
+                DBG( "DMA mode       = PPBDU (packet per buffer WITH desc. update)\n");
+#ifndef UDC_DEBUG
+                INFO( "DMA mode (PPBDU)\n");
+#endif
+        } 
+        if (use_dma && use_dma_bufferfill_mode) {
+                DBG( "DMA mode       = BF (buffer fill mode)\n");
+#ifndef UDC_DEBUG
+                INFO( "DMA mode (BF)\n");
+#endif
+        } 
+#ifndef UDC_DEBUG
+        if (!use_dma) {
+                INFO( "FIFO mode\n");
+        } 
+#endif
+#ifdef UDC_USE_TIMER
+        INFO("RDE timer is used\n");
+#endif
+        DBG("-------------------------------------------------------\n");       
+}
+
+/**
+ * Prints snapshot of ep registers
+ * 
+ * \param dev   pointer to device struct
+ */
+#ifdef UDC_DEBUG
+static void print_ep_regs(struct udc* dev, struct udc_ep_regs* ep_regs)
+{
+        INFO( "ep control  = %08lx\n", (unsigned long) ep_regs->ctl);
+        INFO( "ep status   = %08lx\n", (unsigned long) ep_regs->sts);
+        INFO( "--------------------------------\n");
+}
+
+/**
+ * Prints misc information, to be removed
+ * 
+ * \param dev           pointer to device struct
+ */
+static void print_misc(struct udc* dev)
+{
+        print_regs(dev);
+ 
+        if (use_dma) {
+
+                INFO("no_req=%ld no_pref_req=%ld\n", no_req, no_pref_req);
+        }
+}
+#endif
+
+/* driver functions ----------------------------------------------------------*/
+/**
+ * Called by OS for insmod 
+ * 
+ * \param inode         file node
+ * \param               file struct
+ * \return read byte
+ */
+#ifdef UDC_DEBUG
+static int udc_open (struct inode *inode, struct file *file)
+{
+        int retval = 0;
+        return retval;
+}
+
+/**
+ * Called by OS for rmmod 
+ * 
+ * \param inode         file node
+ * \param file          file struct
+ * \return read byte
+ */
+static int udc_release (struct inode *inode, struct file *file)
+{
+        int retval = 0;
+        return retval;
+}
+
+/**
+ * Called by OS for ioctl() from user space
+ * 
+ * \param inode         file node
+ * \param file          file struct
+ * \param command       ioctl command code
+ * \param argument      ioctl argument
+ * \return 0 if success 
+ */
+static int udc_ioctl (struct inode *inode, 
+                      struct file *file, 
+                      unsigned int command,
+                      unsigned long argument)
+{
+        struct udc* dev = udc;
+        
+        if (!dev)
+                return -EINVAL;
+     
+        /* for testing PM */ 
+        switch (command)
+        {
+                case 1:
+                        udc_remote_wakeup(udc);
+                        break;
+                case 5:
+                        udc_suspend(udc);
+                        break;
+                case 6:
+                        udc_resume(udc);
+                        break;
+        }
+ 
+        INFO( "ioctl called\n");
+
+        return 0;
+}
+
+/**
+ *  Prints a buffers contents 
+ *  \param buf          pointer to buffer
+ *  \param bytes        number bytes to print
+ */
+static void dump_buffer(u8* buf, u32 bytes)
+{
+        int i;
+
+        printk("\nbuffer %lx = %d bytes:\n", (unsigned long) buf, bytes);
+        for (i = 0; i < bytes; i++) {
+                printk("%02x", *(buf + i));
+                if ((i+1)%16 == 0)
+                        printk("\n");
+        }
+        printk("\n");
+}
+#endif
+
+/**
+ * Masks unused interrupts 
+ * 
+ * \param dev           pointer to device struct
+ * \return 0 if success 
+ */
+static int udc_mask_unused_interrupts(struct udc* dev)
+{
+        u32 tmp;
+
+        /* mask all dev interrupts */
+        tmp =   AMD_BIT(UDC_DEVINT_SVC) |
+                AMD_BIT(UDC_DEVINT_ENUM) |
+                AMD_BIT(UDC_DEVINT_US) |
+                AMD_BIT(UDC_DEVINT_UR) |
+                AMD_BIT(UDC_DEVINT_ES) |
+                AMD_BIT(UDC_DEVINT_SI) |
+                AMD_BIT(UDC_DEVINT_SOF)|
+                AMD_BIT(UDC_DEVINT_SC);
+        writel(tmp, &dev->regs->irqmsk);        
+        
+        /* mask all ep interrupts */
+        writel(UDC_EPINT_MSK_DISABLE_ALL, &dev->regs->ep_irqmsk);        
+
+        return 0;
+}
+
+/**
+ * Enables endpoint 0 interrupts 
+ * 
+ * \param dev           pointer to device struct
+ * \return 0 if success 
+ */
+static int udc_enable_ep0_interrupts(struct udc* dev)
+{
+        u32 tmp;
+
+        DBG("udc_enable_ep0_interrupts()\n");
+
+        /* read irq mask */
+        tmp = readl(&dev->regs->ep_irqmsk);
+        /* enable ep0 irq's */
+        tmp &= AMD_UNMASK_BIT(UDC_EPINT_IN_EP0)
+               & AMD_UNMASK_BIT(UDC_EPINT_OUT_EP0);  
+        writel(tmp, &dev->regs->ep_irqmsk);        
+
+        return 0;
+}
+
+/**
+ * Enables device interrupts for SET_INTF and SET_CONFIG
+ * 
+ * \param dev           pointer to device struct
+ * \return 0 if success 
+ */
+static int udc_enable_dev_setup_interrupts(struct udc* dev)
+{
+        u32 tmp;
+
+        DBG("enable device interrupts for setup data\n");
+
+        /* read irq mask */
+        tmp = readl(&dev->regs->irqmsk);
+       
+        /* enable SET_INTERFACE, SET_CONFIG and other needed irq's */
+        tmp &= AMD_UNMASK_BIT(UDC_DEVINT_SI)
+               & AMD_UNMASK_BIT(UDC_DEVINT_SC)  
+               & AMD_UNMASK_BIT(UDC_DEVINT_UR)  
+#ifndef UDC_IPBUG_3943_WORKAROUND
+               & AMD_UNMASK_BIT(UDC_DEVINT_US)  
+#endif
+#ifndef UDC_IPBUG_3950_WORKAROUND
+               & AMD_UNMASK_BIT(UDC_DEVINT_SVC)
+#endif
+               & AMD_UNMASK_BIT(UDC_DEVINT_ENUM);
+        writel(tmp, &dev->regs->irqmsk);        
+
+        return 0;
+}
+
+/**
+ * Calculates fifo start of endpoint based on preceeding endpoints
+ * 
+ * \param ep           pointer to ep struct
+ * \return 0 if success 
+ */
+static int udc_set_txfifo_addr(struct udc_ep *ep)
+{
+        struct udc      *dev;
+        u32 tmp;
+        int i;
+
+        if (!ep || !(ep->in))
+                return -EINVAL;
+        
+        dev = ep->dev;
+        ep->txfifo = dev->txfifo;
+
+        /* traverse ep's */
+        for (i = 0; i < ep->num; i++) {
+                if (dev->ep[i].regs) {
+                        /* read fifo size */
+                        tmp = readl(&dev->ep[i].regs->bufin_framenum);
+                        tmp = AMD_GETBITS(tmp, UDC_EPIN_BUFF_SIZE);
+                        ep->txfifo+= tmp;
+                }
+        }
+        return 0;
+}
+
+/**
+ * Enables endpoint, is called by gadget driver
+ * 
+ * \param usbep         pointer to ep struct
+ * \param desc          pointer to endpoint descriptor
+ * \return 0 if success 
+ */
+static int
+udc_enable (struct usb_ep *usbep, const struct usb_endpoint_descriptor *desc)
+{
+        struct udc_ep           *ep;
+        struct udc              *dev;
+        u32                     tmp;
+        unsigned long           iflags;
+        u8 udc_csr_epix;
+
+        VDBG("udc_enable()\n");        
+        
+        ep = container_of (usbep, struct udc_ep, ep);
+        if (!usbep 
+            || usbep->name == ep0_string
+            || !desc 
+            || desc->bDescriptorType != USB_DT_ENDPOINT) {
+                ERR("udc_enable: !usbep=%d !desc=%d ep->desc!=NULL=%d usbep->name==ep0_string=%d desc->bDescriptorType!=USB_DT_ENDPOINT=%d\n",
+                     !usbep, !desc, ep->desc != NULL, usbep->name == ep0_string, desc->bDescriptorType != USB_DT_ENDPOINT);
+                return -EINVAL;
+        }
+        
+        DBG("udc_enable() ep %d\n", ep->num);
+
+        dev = ep->dev;
+
+        /* exit on suspend */
+        if (dev->sys_suspended) 
+              return -ESHUTDOWN;
+
+        if (!dev->driver
+            || dev->gadget.speed == USB_SPEED_UNKNOWN)
+                return -ESHUTDOWN;
+
+        spin_lock_irqsave (&dev->lock, iflags);
+        ep->desc = desc;
+
+        ep->halted = 0;
+
+        /* set traffic type */
+        tmp = readl(&dev->ep[ep->num].regs->ctl);
+        tmp = AMD_ADDBITS(tmp, desc->bmAttributes, UDC_EPCTL_ET);
+        writel(tmp, &dev->ep[ep->num].regs->ctl);
+
+        /* set max packet size */
+        tmp = readl(&dev->ep[ep->num].regs->bufout_maxpkt);
+        tmp = AMD_ADDBITS(tmp, desc->wMaxPacketSize, UDC_EP_MAX_PKT_SIZE);
+        ep->ep.maxpacket = desc->wMaxPacketSize;
+        writel(tmp, &dev->ep[ep->num].regs->bufout_maxpkt);
+
+        /* IN ep */
+        if (ep->in) {
+                
+                /* ep ix in UDC CSR register space */
+                udc_csr_epix = ep->num;
+                
+                /* set buffer size (tx fifo entries) */
+                tmp = readl(&dev->ep[ep->num].regs->bufin_framenum);
+                /* double buffering: fifo size = 2 x max packet size */
+                tmp = AMD_ADDBITS(
+                              tmp,
+                              desc->wMaxPacketSize * UDC_EPIN_BUFF_SIZE_MULT /
+                                                     UDC_DWORD_BYTES,
+                              UDC_EPIN_BUFF_SIZE);                 
+                writel(tmp, &dev->ep[ep->num].regs->bufin_framenum);
+
+                /* calc. tx fifo base addr */
+                udc_set_txfifo_addr(ep); 
+
+                /* flush fifo */
+                tmp = readl(&ep->regs->ctl);
+                tmp |= AMD_BIT(UDC_EPCTL_F); 
+                writel(tmp, &ep->regs->ctl);
+                
+        } /* OUT ep */
+        else {
+                /* ep ix in UDC CSR register space */
+                udc_csr_epix = ep->num - UDC_CSR_EP_OUT_IX_OFS;
+
+                /* set max packet size UDC CSR  */
+                tmp = readl(&dev->csr->ne[ep->num - UDC_CSR_EP_OUT_IX_OFS]);
+                tmp = AMD_ADDBITS(tmp, desc->wMaxPacketSize, UDC_CSR_NE_MAX_PKT);
+                writel(tmp, &dev->csr->ne[ep->num - UDC_CSR_EP_OUT_IX_OFS]);
+
+                if (ep->num != UDC_EP0OUT_IX) 
+                        dev->data_ep_enabled = 1;
+        }
+
+        /***** UDC CSR reg ****************************/
+        /* set ep values  */
+        tmp = readl(&dev->csr->ne[udc_csr_epix]);
+        /* max packet */
+        tmp = AMD_ADDBITS(tmp, desc->wMaxPacketSize, UDC_CSR_NE_MAX_PKT);
+        /* ep number */
+        tmp = AMD_ADDBITS(tmp, desc->bEndpointAddress, UDC_CSR_NE_NUM);
+        /* ep direction */
+        tmp = AMD_ADDBITS(tmp, ep->in, UDC_CSR_NE_DIR);
+        /* ep type */
+        tmp = AMD_ADDBITS(tmp, desc->bmAttributes, UDC_CSR_NE_TYPE);
+        /* ep config */
+        tmp = AMD_ADDBITS(tmp, ep->dev->cur_config, UDC_CSR_NE_CFG);
+        /* ep interface */
+        tmp = AMD_ADDBITS(tmp, ep->dev->cur_intf, UDC_CSR_NE_INTF);
+        /* ep alt */
+        tmp = AMD_ADDBITS(tmp, ep->dev->cur_alt, UDC_CSR_NE_ALT);
+        /* write reg */
+        writel(tmp, &dev->csr->ne[udc_csr_epix]);
+        
+        /* enable ep irq */
+        tmp = readl(&dev->regs->ep_irqmsk);
+        tmp &= AMD_UNMASK_BIT(ep->num);
+        writel(tmp, &dev->regs->ep_irqmsk);        
+
+        /* clear NAK by writing CNAK */
+        /* avoid BNA for DMA,  dont clear NAK until DMA desc. written */
+        if (!use_dma) {
+                tmp = readl(&ep->regs->ctl);
+                tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                writel(tmp, &ep->regs->ctl);
+                ep->naking = 0;
+                UDC_QUEUE_CNAK(ep, ep->num);
+        }
+        tmp = desc->bEndpointAddress;
+        DBG( "%s enabled\n",
+                usbep->name);
+
+        spin_unlock_irqrestore (&dev->lock, iflags);
+        return 0;
+}
+/**
+ * Resets endpoint
+ * 
+ * \param regs          pointer to device register struct
+ * \param ep            pointer to endpoint
+ */
+static void ep_init (struct udc_regs *regs, struct udc_ep *ep)
+{
+        u32             tmp;
+
+        VDBG("ep-%d reset\n", ep->num);
+        ep->desc = 0;
+        ep->ep.ops = &udc_ep_ops;
+        INIT_LIST_HEAD (&ep->queue);
+
+        ep->ep.maxpacket = (u16) ~0;
+        if (!(ep->dev->sys_suspended)) {
+                /* set NAK  */
+                tmp = readl(&ep->regs->ctl);
+                tmp |= AMD_BIT(UDC_EPCTL_SNAK); 
+                writel(tmp, &ep->regs->ctl);
+                ep->naking = 1;
+                
+                /* disable interrupt */
+                tmp = readl(&regs->ep_irqmsk);
+                tmp |= AMD_BIT(ep->num);
+                writel(tmp, &regs->ep_irqmsk);        
+
+                if (ep->in) {
+                        /* unset P and IN bit of potential former DMA */
+                        tmp = readl(&ep->regs->ctl);
+                        tmp &= AMD_UNMASK_BIT(UDC_EPCTL_P);
+                        writel(tmp, &ep->regs->ctl);
+
+                        tmp = readl(&ep->regs->sts);
+                        tmp |= AMD_BIT(UDC_EPSTS_IN);
+                        writel(tmp, &ep->regs->sts);
+
+                        /* flush the fifo */
+                        tmp = readl(&ep->regs->ctl);
+                        tmp |= AMD_BIT(UDC_EPCTL_F); 
+                        writel(tmp, &ep->regs->ctl);
+
+                }
+                /* reset desc pointer */
+                writel(0, &ep->regs->desptr);
+        }
+
+
+}
+
+/**
+ * Disables endpoint, is called by gadget driver
+ * 
+ * \param usbep            pointer to ep struct
+ * \return 0 if success 
+ */
+static int udc_disable (struct usb_ep *usbep)
+{
+        struct udc_ep   *ep = NULL;
+        unsigned long           iflags;
+
+        if (!usbep)
+                return -EINVAL;
+ 
+        ep = container_of (usbep, struct udc_ep, ep);
+        if (usbep->name == ep0_string
+            || !ep->desc)
+                return -EINVAL;
+
+        DBG("Disable ep-%d\n", ep->num);
+
+        spin_lock_irqsave(&ep->dev->lock, iflags);
+        empty_req_queue(ep);
+        ep_init(ep->dev->regs, ep);
+        spin_unlock_irqrestore(&ep->dev->lock, iflags);
+
+        return 0;
+}
+
+/**
+ * Allocates request packet, called by gadget driver
+ * 
+ * \param _ep           pointer to usb ep struct
+ * \param gfp_flags     flags for kmalloc
+ * \return allocated request packet, 0 if error
+ */
+static struct usb_request *
+udc_alloc_request (struct usb_ep *usbep, gfp_t gfp)
+{
+        struct udc_request      *req;
+        struct udc_data_dma     *dma_desc;
+        struct udc_ep   *ep;
+
+        VDBG("udc_alloc_req()\n");
+        if (!usbep)
+                return 0;
+
+        ep = container_of (usbep, struct udc_ep, ep);
+        udc_gfp_flags = gfp;
+
+        VDBG("udc_alloc_req(): ep%d\n", ep->num);
+        req = kmalloc (sizeof (struct udc_request), gfp);
+        if (!req)
+                return 0;
+
+        memset (req, 0, sizeof *req);
+        req->req.dma = DMA_DONT_USE;
+        INIT_LIST_HEAD (&req->queue);
+
+        if (ep->dma) {
+
+#if defined(CONFIG_SOC_AU1200)
+                gfp = GFP_ATOMIC | GFP_DMA;
+#endif
+                /* ep0 in requests are allocated from data pool here */
+                dma_desc = dma_pool_alloc (ep->dev->data_requests, gfp,
+                                           &req->td_phys);
+                if (!dma_desc) {
+                        kfree (req);
+                        return 0;
+                }
+
+                VDBG("udc_alloc_req: req = %lx dma_desc = %lx, req->td_phys = %lx\n",
+                     (unsigned long) req, (unsigned long) dma_desc, (unsigned long)req->td_phys);
+                /* prevent from using desc. - set HOST BUSY */
+                dma_desc->status = AMD_ADDBITS(dma_desc->status,
+                                          UDC_DMA_STP_STS_BS_HOST_BUSY,
+                                          UDC_DMA_STP_STS_BS);  
+                dma_desc->bufptr = __constant_cpu_to_le32 (DMA_DONT_USE);
+                req->td_data = dma_desc;
+                req->td_data_last = NULL;
+                req->chain_len = 1;
+        }
+
+        return &req->req;
+}
+
+/**
+ * Frees request packet, called by gadget driver
+ * 
+ * \param usbep   pointer to usb ep struct
+ * \param usbreq  pointer to request packet to be freed
+ */
+static void
+udc_free_request (struct usb_ep *usbep, struct usb_request *usbreq)
+{
+        struct udc_ep   *ep;
+        struct udc_request      *req;
+
+        if (!usbep || !usbreq)
+                return;
+
+        ep = container_of (usbep, struct udc_ep, ep);
+        req = container_of (usbreq, struct udc_request, req);
+        VDBG("free_req req=%lx\n", (unsigned long) req);
+        WARN_ON(!list_empty (&req->queue));
+        if (req->td_data) {
+                VDBG("req->td_data=%lx\n", (unsigned long) req->td_data);
+
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+                /* re-link broken chain  */
+                if (req->td_data_last) {
+                        req->td_data_last->next = req->td_data_last_next;
+                }
+#endif
+                /* free dma chain if created */
+                if (req->chain_len > 1) {
+                        udc_free_dma_chain(ep->dev, req);
+                }
+
+                dma_pool_free (ep->dev->data_requests, req->td_data, req->td_phys);
+        }
+        kfree (req);
+}
+
+/* choose dma buffer allocation method */
+#undef USE_KMALLOC
+#if     defined(CONFIG_X86)
+#define USE_KMALLOC
+#elif   defined(CONFIG_SOC_AU1200)
+#ifdef CONFIG_DMA_COHERENT
+#define USE_KMALLOC
+#endif /* CONFIG_DMA_COHERENT */
+#endif
+
+/**
+ * Allocates data buffer for request packet, called by gadget driver
+ * 
+ * \param usbep         pointer to usb ep struct
+ * \param bytes         number bytes to allocate
+ * \param dma           pointer to dma struct
+ * \param gfp_flags     flags for allocate 
+ * \return pointer to allocated buffer, 0 if error
+ */
+static void *
+udc_alloc_buffer (
+        struct usb_ep           *usbep,
+        unsigned                len,
+        dma_addr_t              *dma,
+        gfp_t                   gfp
+)
+{
+        void            *ptr;
+        struct udc_ep   *ep;
+        VDBG("alloc_buffer(): %s\n", usbep->name);
+
+        ep = container_of (usbep, struct udc_ep, ep);
+        *dma = DMA_DONT_USE;
+
+        if (!usbep)
+                return 0;
+
+        if (ep->dma) {
+#if     defined(USE_KMALLOC)
+
+#if defined(CONFIG_SOC_AU1200)
+                gfp = GFP_ATOMIC | GFP_DMA;
+#endif
+                ptr = kmalloc(len, gfp);
+
+                if (ptr)
+                        *dma = virt_to_phys(ptr);
+
+#else
+                ptr = dma_alloc_coherent (&ep->dev->pdev->dev, len, dma, gfp);
+#endif
+        } else
+                ptr = kmalloc(len, gfp);
+
+        VDBG("alloc_buffer() ptr = %lx dma=%lx\n", (unsigned long) ptr, (unsigned long) *dma);
+        return ptr;
+}
+
+
+/**
+ * Free data buffer for request packet, called by gadget driver
+ * 
+ * \param usbep         pointer to usb ep struct
+ * \param buf           pointer to buffer to be freed
+ * \param dma           pointer to dma struct
+ * \param len           number bytes to be freed 
+ * \return pointer to allocated buffer, 0 if error
+ */
+static void
+udc_free_buffer (
+        struct usb_ep *usbep,
+        void *buf,
+        dma_addr_t dma,
+        unsigned len
+) {
+        struct udc_ep   *ep;
+
+        VDBG ("ep %s - free buffer %lx\n", usbep->name, (unsigned long) buf);
+
+        /* null pointer ? */
+        if (!buf) {
+                return;
+        }
+
+        ep = container_of(usbep, struct udc_ep, ep);
+        if (!ep)
+                return;
+
+#ifndef USE_KMALLOC
+        if (dma != DMA_DONT_USE) {
+                dma_free_coherent (&ep->dev->pdev->dev, len, buf, dma);
+        } else
+#endif
+        {
+                if (!(ep->dma))
+                        kfree (buf);
+        }
+
+}
+
+/**
+ * Write data to TX fifo for IN packets 
+ * 
+ * \param ep            pointer to ep struct
+ * \param req           pointer to request packet
+ * \return allocated request packet, 0 if error
+ */
+static void
+udc_txfifo_write (struct udc_ep *ep, struct usb_request *req)
+{
+        u8                      *req_buf;
+        u32                     *buf;
+        int i,j;
+        unsigned                bytes = 0;
+        unsigned                remaining = 0;
+
+        VDBG("udc_txfifo_write()\n");
+
+        if (!req || !ep)
+                return;
+
+        req_buf = req->buf + req->actual;
+        prefetch (req_buf);
+        remaining = req->length - req->actual;
+       
+        buf = (u32*) req_buf;        
+ 
+        bytes = ep->ep.maxpacket;
+        if (bytes > remaining)
+                bytes = remaining;
+	
+        /* dwords first */
+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
+                writel(*(buf + i), ep->txfifo);
+        }
+
+        /* remaining bytes must be written by byte access */
+        for (j = 0; j < bytes % UDC_DWORD_BYTES; j++) {
+                writeb((u8) (*(buf + i) >> (j << UDC_BITS_PER_BYTE_SHIFT)),
+                       ep->txfifo);
+        }
+
+#ifdef UDC_IPBUG_2253_WORKAROUND
+        {
+                u32 tmp;
+
+                /* NAK if small packet until write confirm completed */
+                if (bytes < UDC_SMALL_PACKET) {
+                        /* set NAK */
+                        tmp = readl(&ep->regs->ctl);
+                        tmp |= AMD_BIT(UDC_EPCTL_SNAK); 
+                        writel(tmp, &ep->regs->ctl);
+                        ep->naking = 1;
+                        wb_flush();
+                }
+
+                /* dummy write confirm */
+                writel(0, &ep->regs->confirm); 
+
+                /* stop NAKing after small packet DMA */
+                if (ep->naking) {
+                        /* clear NAK by writing CNAK */
+                        tmp = readl(&ep->regs->ctl);
+                        tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                        writel(tmp, &ep->regs->ctl);
+                        ep->naking = 0;
+                        UDC_QUEUE_CNAK(ep, ep->num);
+                }
+        }
+#else
+        /* dummy write confirm */
+        writel(0, &ep->regs->confirm); 
+#endif
+}
+
+/**
+ * Read dwords from RX fifo for OUT transfers
+ * 
+ * \param dev           pointer to device struct
+ * \param buf           pointer to buffer to be filled
+ * \param dwords        number of dwords to be read
+ * \return allocated request packet, 0 if error
+ */
+static int udc_rxfifo_read_dwords(struct udc* dev, u32* buf, int dwords)
+{
+        int i;
+        
+        VDBG("udc_read_dwords(): %d dwords\n", dwords);
+
+        for (i = 0; i < dwords; i++)
+        {
+                *(buf + i) = readl(dev->rxfifo);
+        }        
+        return 0;
+}
+
+/**
+ * Read bytes from RX fifo for OUT transfers
+ * 
+ * \param dev           pointer to device struct
+ * \param buf           pointer to buffer to be filled
+ * \param bytes         number of bytes to be read
+ * \return allocated request packet, 0 if error
+ */
+static int udc_rxfifo_read_bytes(struct udc* dev, u8* buf, int bytes)
+{
+        int i,j;
+        u32 tmp;
+        
+        VDBG("udc_read_bytes(): %d bytes\n", bytes);
+
+        /* dwords first */
+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
+               *((u32*) (buf + (i<<2))) = readl(dev->rxfifo); 
+        }
+
+        /* remaining bytes must be read by byte access */
+        if (bytes % UDC_DWORD_BYTES) {
+                tmp = readl(dev->rxfifo);
+                for (j = 0; j < bytes % UDC_DWORD_BYTES; j++) {
+                        *(buf + (i<<2) + j) = (u8) (tmp & UDC_BYTE_MASK);
+                        tmp = tmp >> UDC_BITS_PER_BYTE;
+                }
+        }
+        
+        return 0;
+}
+
+/**
+ * Read data from RX fifo for OUT transfers
+ * 
+ * \param ep            pointer to ep struct
+ * \param req           pointer to request packet
+ * \return true if request completes for short or max packet, false otherwise   
+ */
+static int
+udc_rxfifo_read(struct udc_ep *ep, struct udc_request *req)
+{
+        u8 *buf;
+        unsigned buf_space;
+        unsigned bytes = 0; 
+        unsigned finished = 0;
+
+        /* received number bytes */
+        bytes = readl(&ep->regs->sts);
+        bytes = AMD_GETBITS(bytes, UDC_EPSTS_RX_PKT_SIZE);
+        
+        buf_space = req->req.length - req->req.actual;
+        buf = req->req.buf + req->req.actual;
+        if (bytes > buf_space) {
+                if ((buf_space % ep->ep.maxpacket) != 0) {
+                        ERR( "%s: received %d bytes, rx-buffer space =  %d bytes => buffer overrun\n",
+                                ep->ep.name, bytes, buf_space);
+                        req->req.status = -EOVERFLOW;
+                }
+                bytes = buf_space;
+        }
+        req->req.actual += bytes;
+
+        /* last packet ? */
+        if (((bytes % ep->ep.maxpacket) != 0)
+            || (!bytes)
+            || ((req->req.actual == req->req.length) && !req->req.zero))
+                finished = 1;
+
+        /* read rx fifo bytes */
+        VDBG("ep %s: rxfifo read %d bytes\n", ep->ep.name, bytes);
+        udc_rxfifo_read_bytes(ep->dev, buf, bytes); 
+        
+        return finished;
+}
+
+/**
+ * create/re-init a DMA descriptor or a DMA descriptor chain
+ *
+ * \param ep            pointer to endpoint struct 
+ * \param req           pointer to request packet
+ */
+static int prep_dma (struct udc_ep *ep, struct udc_request *req)
+{
+        int retval = 0;
+        u32                     tmp;
+        VDBG("prep_dma\n");
+        VDBG("prep_dma ep%d req->td_data=%lx\n",
+              ep->num, (unsigned long) req->td_data);
+
+        /* set buffer pointer */
+        req->td_data->bufptr   = req->req.dma;
+
+        /* set last bit */
+        req->td_data->status |= AMD_BIT(UDC_DMA_IN_STS_L);
+       
+        /* build/re-init dma chain if maxpkt scatter mode, not for EP0 */
+        if (use_dma_ppb && ep->num != UDC_EP0OUT_IX && ep->num != UDC_EP0IN_IX) {
+
+                retval = udc_create_dma_chain(ep, req, ep->ep.maxpacket, udc_gfp_flags);
+                if (retval != 0)
+                {
+                        if (retval == -ENOMEM)
+                                INFO("Out of DMA memory (allocation failed)\n");       
+                        return retval;
+                }
+                if (ep->in) {
+                        if (req->req.length == ep->ep.maxpacket) {
+                                /* write tx bytes */
+                                req->td_data->status = AMD_ADDBITS(req->td_data->status,
+                                                ep->ep.maxpacket,
+                                                UDC_DMA_IN_STS_TXBYTES); 
+
+                        }
+                }
+                
+        }
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+        else { /* EP0 */
+                /* point to itself */
+                req->td_data->next = req->td_phys;
+        }
+#endif
+        
+        if (ep->in) {
+                VDBG("IN: use_dma_ppb=%d req->req.length=%d ep->ep.maxpacket=%d ep%d\n",
+                      use_dma_ppb, req->req.length, ep->ep.maxpacket, ep->num);
+                /* if bytes < max packet then tx bytes must */
+                /* be written in packet per buffer mode */
+                if (!use_dma_ppb || req->req.length < ep->ep.maxpacket
+                    || ep->num == UDC_EP0OUT_IX || ep->num == UDC_EP0IN_IX) {
+                        /* write tx bytes */
+                        req->td_data->status = AMD_ADDBITS(req->td_data->status,
+                                                            req->req.length,
+                                                            UDC_DMA_IN_STS_TXBYTES); 
+                        /* reset frame num */
+                        req->td_data->status = AMD_ADDBITS(req->td_data->status,
+                                                            0,
+                                                            UDC_DMA_IN_STS_FRAMENUM); 
+                }
+                /* set HOST BUSY */
+                req->td_data->status 
+                      = AMD_ADDBITS(req->td_data->status,
+                                    UDC_DMA_STP_STS_BS_HOST_BUSY,
+                                    UDC_DMA_STP_STS_BS);
+        }
+        else {
+                VDBG("OUT set host ready\n");
+                /* set HOST READY */
+                req->td_data->status 
+                      = AMD_ADDBITS(req->td_data->status,
+                                    UDC_DMA_STP_STS_BS_HOST_READY,
+                                    UDC_DMA_STP_STS_BS);
+
+ 
+                        /* clear NAK by writing CNAK */
+                        if (ep->naking) {
+                                tmp = readl(&ep->regs->ctl);
+                                tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                                writel(tmp, &ep->regs->ctl);
+                                ep->naking = 0;
+                                UDC_QUEUE_CNAK(ep, ep->num);
+                        }
+
+        }
+
+        return retval;
+}
+
+/**
+ * Completes request packet 
+ * 
+ * \param ep            pointer to ep struct
+ * \param req           pointer to request packet
+ * \param sts           status of request
+ */
+static void
+complete_req(struct udc_ep *ep, struct udc_request *req, int sts)
+{
+        struct udc              *dev;
+        unsigned                halted;
+
+        VDBG("complete_req(): ep%d\n", ep->num);
+
+        dev = ep->dev;
+        /* unmap DMA */
+        if (req->dma_mapping) {
+#if   defined(CONFIG_SOC_AU1200)
+                if (ep->in)
+                        dma_unmap_single(0,
+                                         req->req.dma,
+                                         req->req.length,
+                                         PCI_DMA_TODEVICE);
+                else
+                        dma_unmap_single(0,
+                                         req->req.dma,
+                                         req->req.length,
+                                         PCI_DMA_FROMDEVICE);
+#else
+                if (ep->in)
+                        pci_unmap_single(dev->pdev,
+                                         req->req.dma,
+                                         req->req.length,
+                                         PCI_DMA_TODEVICE);
+                else
+                        pci_unmap_single(dev->pdev,
+                                         req->req.dma,
+                                         req->req.length,
+                                         PCI_DMA_FROMDEVICE);
+#endif
+                req->dma_mapping = 0;
+                req->req.dma = DMA_DONT_USE;
+        }
+
+        halted = ep->halted;
+        ep->halted = 1;
+
+        /* set new status if pending */
+        if (req->req.status == -EINPROGRESS)
+                req->req.status = sts;
+
+        /* remove from ep queue */
+        list_del_init (&req->queue);
+
+        VDBG( "req %p => complete %d bytes at %s with sts %d\n",
+                       &req->req, req->req.length, ep->ep.name, sts);
+        if (spin_is_locked(&dev->lock)) {
+                spin_unlock (&dev->lock);
+                req->req.complete (&ep->ep, &req->req);
+                spin_lock (&dev->lock);
+        }
+        else {
+                req->req.complete (&ep->ep, &req->req);
+        }
+        ep->halted = halted;
+}
+
+/**
+ * frees pci pool descriptors of a DMA chain 
+ * 
+ * \param dev           pointer to device struct
+ * \param req           pointer to request packet
+ * \return 0 if success
+ */
+static int udc_free_dma_chain(struct udc* dev, struct udc_request* req)
+{
+
+        int ret_val = 0;
+        struct udc_data_dma     *td;
+        struct udc_data_dma     *td_last = NULL;
+        unsigned int i;
+
+        DBG("free chain req = %lx\n", (unsigned long) req);
+
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+        /* re-link broken chain  */
+        if (req->td_data_last) {
+                req->td_data_last->next = req->td_data_last_next;
+        }
+#endif
+        /* do not free first desc., will be done by free for request */
+        td_last = req->td_data;
+#if defined (CONFIG_SOC_AU1200) && !defined(CONFIG_DMA_COHERENT)
+        td = UNCAC_ADDR(phys_to_virt(td_last->next));
+#else
+        td = phys_to_virt(td_last->next);
+#endif
+
+        for (i = 1; i < req->chain_len; i++) {
+
+                dma_pool_free (dev->data_requests, td,
+                                (dma_addr_t) td_last->next);
+                td_last = td;
+#if defined (CONFIG_SOC_AU1200) && !defined(CONFIG_DMA_COHERENT)
+                td = UNCAC_ADDR(phys_to_virt(td_last->next));
+#else
+                td = phys_to_virt(td_last->next);
+#endif
+        }
+
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+        req->td_data_last = NULL;
+#endif
+        return ret_val;        
+}
+
+/**
+ * Iterates to the end of a DMA chain and returns last descriptor 
+ * 
+ * \param req           pointer to request packet
+ * \return pointer to last descriptori of chain
+ */
+static struct udc_data_dma* udc_get_last_dma_desc(struct udc_request* req)
+{
+        struct udc_data_dma     *td;
+
+        td = req->td_data;
+        while (td && !(td->status & AMD_BIT(UDC_DMA_IN_STS_L))) {
+#if defined (CONFIG_SOC_AU1200) && !defined(CONFIG_DMA_COHERENT)
+                td = UNCAC_ADDR(phys_to_virt(td->next));
+#else
+                td = phys_to_virt(td->next);
+#endif
+        }
+
+        return td;
+
+}
+
+/**
+ * Iterates to the end of a DMA chain and counts bytes received 
+ * 
+ * \param req           pointer to request packet
+ * \return number of received bytes
+ */
+static u32 udc_get_ppbdu_rxbytes(struct udc_request* req)
+{
+        struct udc_data_dma     *td;
+        u32 count;
+
+        td = req->td_data;
+        /* received number bytes */
+        count = AMD_GETBITS(td->status, UDC_DMA_OUT_STS_RXBYTES); 
+        
+        while (td && !(td->status & AMD_BIT(UDC_DMA_IN_STS_L))) {
+#if defined (CONFIG_SOC_AU1200) && !defined(CONFIG_DMA_COHERENT)
+                td = UNCAC_ADDR(phys_to_virt(td->next));
+#else
+                td = phys_to_virt(td->next);
+#endif
+                /* received number bytes */
+                if (td) {
+                        count += AMD_GETBITS(td->status, UDC_DMA_OUT_STS_RXBYTES);
+                }
+        }
+
+        return count;
+
+}
+
+/**
+ * Creates or re-inits a DMA chain 
+ *
+ * \param ep            pointer to endpoint struct 
+ * \param req           pointer to request packet
+ * \param buf_len       number of buffer bytes per descriptor (except last short)
+ */
+static int udc_create_dma_chain(struct udc_ep* ep, struct udc_request* req, unsigned long buf_len, int gfp_flags)
+{
+        unsigned long bytes = req->req.length;
+        unsigned int i;
+        dma_addr_t dma_addr;
+        struct udc_data_dma     *td = NULL;
+        struct udc_data_dma     *last = NULL;
+        unsigned long txbytes;
+        unsigned create_new_chain = 0;
+        unsigned len;
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+        dma_addr_t last_next = DMA_DONT_USE;
+#endif
+
+        VDBG("udc_create_dma_chain: bytes=%ld buf_len=%ld\n", bytes, buf_len);
+        dma_addr = DMA_DONT_USE;
+
+        /* unset L bit in first desc for OUT */
+        if (!ep->in) {
+                req->td_data->status &= AMD_CLEAR_BIT(UDC_DMA_IN_STS_L);
+        }
+        
+        /* alloc only new desc's if not already available */
+        len = req->req.length / ep->ep.maxpacket;
+        if (req->req.length % ep->ep.maxpacket) {
+                len++;
+        }
+
+        if (len > req->chain_len) {
+                /* shorter chain already allocated before */
+                if (req->chain_len > 1) {
+                        udc_free_dma_chain(ep->dev, req);
+                }
+                req->chain_len = len;
+                create_new_chain = 1;
+        }
+
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+        /* re-link broken chain  */
+        if (req->td_data_last) {
+                req->td_data_last->next = req->td_data_last_next;
+        }
+        /* if only one td then last_next is root td */
+        last_next = req->td_phys;
+#endif
+
+        td = req->td_data; 
+        /* gen. required number of descriptors and buffers */
+        for (i = buf_len; i < bytes; i += buf_len)
+        {
+                /* create or determine next desc. */
+                if (create_new_chain) {
+
+#if defined(CONFIG_SOC_AU1200)
+                        gfp_flags = GFP_ATOMIC | GFP_DMA;
+#endif
+                        td = dma_pool_alloc (ep->dev->data_requests, gfp_flags,
+                                             &dma_addr);
+                        if (!td) 
+                                return -ENOMEM;
+
+                        td->status = 0;
+                }
+                else if (i == buf_len)
+                {
+                        /* first td */
+#if defined (CONFIG_SOC_AU1200) && !defined(CONFIG_DMA_COHERENT)
+                        td = (struct udc_data_dma*) UNCAC_ADDR(phys_to_virt(req->td_data->next));
+#else
+                        td = (struct udc_data_dma*) phys_to_virt(req->td_data->next);
+#endif
+                        td->status = 0;
+                }
+                else {
+#if defined (CONFIG_SOC_AU1200) && !defined(CONFIG_DMA_COHERENT)
+                        td = (struct udc_data_dma*) UNCAC_ADDR(phys_to_virt(last->next));
+#else
+                        td = (struct udc_data_dma*) phys_to_virt(last->next);
+#endif
+                        td->status = 0;
+                }
+                        
+
+                if (td) {
+                        /* assign buffer */
+                       td->bufptr = req->req.dma + i; 
+                }
+                else {
+                        break;
+                }
+
+                /* short packet ? */
+                if ((bytes - i) >= buf_len) {
+                        txbytes = buf_len;
+                }
+                else {
+                        /* short packet */
+                        txbytes = bytes - i;
+                }
+         
+                /* link td and assign tx bytes */
+                if (i == buf_len) {
+                        if (create_new_chain) {
+                                req->td_data->next = dma_addr;
+                        }
+                        else {
+                                /* req->td_data->next = virt_to_phys(td); */
+                        }
+                        /* write tx bytes */
+                        if (ep->in) {
+                                /* first desc */
+                                req->td_data->status = AMD_ADDBITS(req->td_data->status,
+                                                                    ep->ep.maxpacket,
+                                                                    UDC_DMA_IN_STS_TXBYTES);
+                                /* second desc */
+                                td->status = AMD_ADDBITS(td->status,
+                                                          txbytes,
+                                                          UDC_DMA_IN_STS_TXBYTES); 
+                        } 
+
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+                        last_next = req->td_data->next;
+#endif
+                }
+                else {
+                        if (create_new_chain) {
+                                last->next = dma_addr;
+                        }
+                        else { 
+                                /* last->next = virt_to_phys(td); */
+                        }
+                        if (ep->in) {
+                                /* write tx bytes */
+                                td->status = AMD_ADDBITS(td->status,
+                                                          txbytes,
+                                                          UDC_DMA_IN_STS_TXBYTES); 
+                        }
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+                        last_next = last->next;
+#endif
+                }
+                last = td;
+        }
+        /* set last bit */
+        if (td) {
+                td->status |= AMD_BIT(UDC_DMA_IN_STS_L);
+                /* last desc. points to itself */
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+                /* remember broken chain next pointer */
+                req->td_data_last_next = td->next;
+                /* point to itself */
+                td->next = last_next;
+#endif
+                req->td_data_last = td;
+        }
+
+        return 0;
+}
+
+/**
+ * Enabling RX DMA  
+ *
+ * \param dev           pointer to UDC device object    
+ */
+static inline void udc_set_rde(struct udc* dev)
+{
+        u32 tmp;
+
+        VDBG("udc_set_rde()\n");
+#ifdef UDC_USE_TIMER
+        /* stop RDE timer */ 
+        if (timer_pending(&udc_timer)) {
+                set_rde = 0;
+                mod_timer(&udc_timer, jiffies - 1);
+        }
+#endif
+        /* set RDE */
+        tmp = readl(&dev->regs->ctl);
+        tmp |= AMD_BIT(UDC_DEVCTL_RDE);
+        writel(tmp, &dev->regs->ctl);                
+}
+
+/**
+ * Queues a request packet, called by gadget driver
+ * 
+ * \param usbep         pointer to usb ep struct
+ * \param usbreq        pointer to request packet to be freed
+ * \param gfp           flags for alloc
+ * \return 0 if success
+ */
+static int
+udc_queue (struct usb_ep *usbep, struct usb_request *usbreq, gfp_t gfp)
+{
+        int retval = 0;
+        unsigned long           iflags;
+        struct udc_ep   *ep;
+        struct udc_request      *req;
+        struct udc              *dev;
+        u32 tmp;
+        
+        VDBG ("udc_queue()\n");
+
+        /* check the inputs */
+        req = container_of (usbreq, struct udc_request, req);
+        VDBG("!usbep=%d !req=%d !buf=%d !compl=%d !empty_list=%d \n",
+                !usbep, !usbreq, !usbreq->buf, !usbreq->complete,
+                !list_empty(&req->queue));
+
+        if (!usbep || !usbreq || !usbreq->complete || !usbreq->buf
+                        || !list_empty (&req->queue))
+                return -EINVAL;
+
+        ep = container_of (usbep, struct udc_ep, ep);
+        if (!ep->desc && (ep->num != 0 && ep->num != UDC_EP0OUT_IX))
+                return -EINVAL;
+
+        VDBG("udc_queue(): ep%d-in=%d\n", ep->num, ep->in);
+        dev = ep->dev;
+
+        /* exit on suspend */
+        if (dev->sys_suspended) 
+              return -ESHUTDOWN;
+
+        if (!dev->driver || dev->gadget.speed == USB_SPEED_UNKNOWN)
+                return -ESHUTDOWN;
+
+        /* map dma (usally done before) */
+        if (ep->dma && usbreq->length != 0 && usbreq->dma == DMA_DONT_USE) {
+                VDBG("DMA map req %lx\n", (unsigned long) req);
+#if   defined(CONFIG_SOC_AU1200)
+                if (ep->in)
+                        usbreq->dma = dma_map_single(dev->pdev,
+                                                     usbreq->buf,
+                                                     usbreq->length,
+                                                     PCI_DMA_TODEVICE);
+                else
+                        usbreq->dma = dma_map_single(dev->pdev,
+                                                     usbreq->buf,
+                                                     usbreq->length,
+                                                     PCI_DMA_FROMDEVICE);
+#else
+                if (ep->in)
+                        usbreq->dma = pci_map_single(dev->pdev,
+                                                     usbreq->buf,
+                                                     usbreq->length,
+                                                     PCI_DMA_TODEVICE);
+                else
+                        usbreq->dma = pci_map_single(dev->pdev,
+                                                     usbreq->buf,
+                                                     usbreq->length,
+                                                     PCI_DMA_FROMDEVICE);
+#endif
+                req->dma_mapping = 1;
+        }
+
+        VDBG( "%s queue req %p, len %d req->td_data=%lx buf %p\n",
+                        usbep->name, usbreq, usbreq->length, (unsigned long) req->td_data, usbreq->buf);
+
+        spin_lock_irqsave (&dev->lock, iflags);
+        usbreq->actual = 0;
+        usbreq->status = -EINPROGRESS;
+        req->dma_done = 0;
+        
+        /* on empty queue just do first transfer */
+        if (list_empty (&ep->queue)) {
+                /* zlp */
+                if (ep->in && usbreq->length == 0) {
+                        /* IN zlp's are handled by hardware */
+                        complete_req(ep, req, 0);
+                        VDBG( "%s: zlp\n", ep->ep.name);
+                        /* if set_config or set_intf is waiting for ack by zlp
+                           then set CSR_DONE */
+                        if (dev->set_cfg_not_acked) {
+                                tmp = readl(&dev->regs->ctl);
+                                tmp |= AMD_BIT(UDC_DEVCTL_CSR_DONE);
+                                writel(tmp, &dev->regs->ctl);
+                                dev->set_cfg_not_acked = 0;
+                        }
+                        /* setup command is ACK'ed now by zlp */
+                        if (dev->waiting_zlp_ack_ep0in) {
+                                /* clear NAK by writing CNAK in EP0_IN */
+                                tmp = readl(&dev->ep[UDC_EP0IN_IX].regs->ctl);
+                                tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                                writel(tmp, &dev->ep[UDC_EP0IN_IX].regs->ctl);
+                                dev->ep[UDC_EP0IN_IX].naking = 0;
+                                UDC_QUEUE_CNAK(&dev->ep[UDC_EP0IN_IX], UDC_EP0IN_IX);
+                                dev->waiting_zlp_ack_ep0in = 0;
+                        }
+                        goto finished;
+                }
+                if (ep->dma) {
+                        retval = prep_dma(ep, req);
+                        if (retval != 0)
+                                goto finished;
+                        /* write desc pointer to enable DMA */
+                        if (ep->in) {
+                                /* set HOST READY */
+                                req->td_data->status 
+                                      = AMD_ADDBITS(req->td_data->status,
+                                                    UDC_DMA_IN_STS_BS_HOST_READY, 
+                                                    UDC_DMA_IN_STS_BS);
+                        }
+
+                        /* write desc pointer */
+                        writel(req->td_phys, &ep->regs->desptr);
+                        /* clear NAK by writing CNAK */
+                        if (ep->naking) {
+                                tmp = readl(&ep->regs->ctl);
+                                tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                                writel(tmp, &ep->regs->ctl);
+                                ep->naking = 0;
+                                UDC_QUEUE_CNAK(ep, ep->num);
+                        }
+                
+                        if (!ep->in) {
+                                /* enable DMA */
+                                udc_set_rde(dev);
+                                if (ep->num != UDC_EP0OUT_IX) 
+                                        dev->data_ep_queued = 1;
+                        }
+#ifdef UDC_DISABLE_IRQ_IF_EMPTY_IN_QUEUE
+                        else {
+                                /* enable ep irq */
+                                tmp = readl(&dev->regs->ep_irqmsk);
+                                tmp &= AMD_UNMASK_BIT(ep->num);
+                                writel(tmp, &dev->regs->ep_irqmsk);        
+                        }
+#endif
+                }
+
+        } else if (ep->dma) {
+
+                /* prep_dma not used for OUT ep's, this is not possible
+                   for PPB modes, because of chain creation reasons */
+                if (ep->in) {
+                        retval = prep_dma(ep, req);
+                        if (retval != 0)
+                                goto finished;
+                }
+
+        }
+        VDBG("list_add\n");
+        /* add request to ep queue */
+        if (req) {
+        
+                list_add_tail (&req->queue, &ep->queue);
+
+                /* stop OUT naking */
+                if (!ep->in) {
+                        if (!use_dma && udc_rxfifo_pending) {
+                                DBG("udc_queue(): pending bytes in rxfifo after nyet\n");
+                                /* read pending bytes afer nyet: referring to isr */
+                                if (udc_rxfifo_read(ep, req)) {
+                                        /* finish */
+                                        complete_req(ep, req, 0);
+                                }
+                                udc_rxfifo_pending = 0;
+
+                        }
+                }
+
+        }
+
+finished:
+        spin_unlock_irqrestore (&dev->lock, iflags);
+        return retval;
+}
+
+/**
+ * Empty request queue of an endpoint 
+ * 
+ * \param ep            pointer to ep struct
+ */
+static void empty_req_queue(struct udc_ep *ep)
+{
+        struct udc_request      *req;
+
+        ep->halted = 1;
+        while (!list_empty (&ep->queue)) {
+                req = list_entry(ep->queue.next,
+                               struct udc_request,
+                               queue);
+                complete_req(ep, req, -ESHUTDOWN);
+        }
+}
+
+/**
+ * Dequeues a request packet, called by gadget driver
+ * 
+ * \param usbep           pointer to usb ep struct
+ * \param usbreq          pointer to request packet to be freed
+ * \return 0 if success
+ */
+static int udc_dequeue (struct usb_ep *usbep, struct usb_request *usbreq)
+{
+        struct udc_ep   *ep;
+        struct udc_request      *req;
+        unsigned                req_may_used = 0;
+        unsigned                halted;
+        unsigned long           iflags;
+
+        ep = container_of (usbep, struct udc_ep, ep);
+        if (!usbep
+            || !usbreq
+            || (!ep->desc && (ep->num != 0 && ep->num != UDC_EP0OUT_IX)))
+                return -EINVAL;
+
+        req = container_of (usbreq, struct udc_request, req);
+
+        spin_lock_irqsave (&ep->dev->lock, iflags);
+        halted = ep->halted;
+        ep->halted = 1;
+        /* request in processing or next one */
+        if (ep->queue.next == &req->queue) {
+                req_may_used = 1;
+        }
+        complete_req(ep, req, -ECONNRESET);
+        ep->halted = halted;
+
+        spin_unlock_irqrestore (&ep->dev->lock, iflags);
+        if (req_may_used)
+                return -EOPNOTSUPP;
+        else
+                return 0;
+}
+
+/**
+ * Halt or clear halt of endpoint 
+ * 
+ * \param usbe          pointer to ep struct
+ * \param halt          1 - halt, 0 - clear halt
+ * \return 0 if success 
+ */
+static int
+udc_set_halt (struct usb_ep *usbep, int halt)
+{
+        struct udc_ep   *ep;
+        u32 tmp;
+        unsigned long iflags;
+        int retval = 0;
+
+        if (!usbep)
+                return -EINVAL;
+
+        DBG("set_halt %s: halt=%d\n", usbep->name, halt);
+
+        ep = container_of (usbep, struct udc_ep, ep);
+        if (!ep->desc && (ep->num != 0 && ep->num != UDC_EP0OUT_IX))
+                return -EINVAL;
+        if (!ep->dev->driver
+            || ep->dev->gadget.speed == USB_SPEED_UNKNOWN)
+                return -ESHUTDOWN;
+
+        /* exit on suspend */
+        if (ep->dev->sys_suspended) 
+                return -ESHUTDOWN;
+
+        spin_lock_irqsave (&udc_stall_spinlock, iflags);
+        /* halt or clear halt */
+        if (halt) {
+                if (ep->num == 0)
+                        ep->dev->stall_ep0in = 1;
+                else {
+                        /* set STALL */
+                        /* rxfifo empty not taken into acount */
+                        tmp = readl(&ep->regs->ctl);
+                        tmp |= AMD_BIT(UDC_EPCTL_S);
+                        writel(tmp, &ep->regs->ctl);
+                        ep->halted = 1;
+
+#ifdef UDC_USE_TIMER
+                        /* setup poll timer */
+                        if (!timer_pending(&udc_pollstall_timer)) {
+                                udc_pollstall_timer.expires = jiffies + HZ 
+                                        * UDC_POLLSTALL_TIMER_USECONDS
+                                        / (1000 * 1000);
+                                if (!stop_pollstall_timer) {
+                                        DBG("start polltimer\n");
+                                        add_timer(&udc_pollstall_timer);
+                                }
+                        }
+#endif
+                }
+        } else {
+                /* ep is halted by set_halt() before */
+                if (ep->halted) {
+                        tmp = readl(&ep->regs->ctl);
+                        /* clear stall bit */
+                        tmp = tmp & AMD_CLEAR_BIT(UDC_EPCTL_S);
+                        /* clear NAK by writing CNAK */
+                        tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                        writel(tmp, &ep->regs->ctl);
+                        ep->halted = 0;
+                        UDC_QUEUE_CNAK(ep, ep->num);
+                }
+        }
+        spin_unlock_irqrestore (&udc_stall_spinlock, iflags);
+        return retval;
+}
+
+/**
+ * Return fifo fill state (not used, not implemented)
+ * 
+ * \param usbep            pointer to usb ep struct
+ * \return available bytes in fifo 
+ */
+static int
+udc_fifo_status (struct usb_ep *usbep)
+{
+        return 0;
+}
+
+/**
+ * Flush the endpoint fifo (not implemented)
+ * 
+ * \param usbep            pointer to usb ep struct
+ */
+static void
+udc_fifo_flush (struct usb_ep *usbep)
+{
+        return;
+}
+
+/* gadget interface */
+static struct usb_ep_ops udc_ep_ops = {
+        .enable         = udc_enable,
+        .disable        = udc_disable,
+
+        .queue          = udc_queue,
+        .dequeue        = udc_dequeue,
+
+        .alloc_request  = udc_alloc_request,
+        .free_request   = udc_free_request,
+
+        .alloc_buffer   = udc_alloc_buffer,
+        .free_buffer    = udc_free_buffer,
+
+        .set_halt       = udc_set_halt,
+        .fifo_status    = udc_fifo_status,
+        .fifo_flush     = udc_fifo_flush,
+};
+
+/*-------------------------------------------------------------------------*/
+
+/**
+ * Get frame count fifo (not implemented)
+ * 
+ * \param gadget            pointer to gadget struct
+ * \return frame count
+ */
+static int udc_get_frame (struct usb_gadget *gadget)
+{
+        return 0;
+}
+
+/**
+ * Remote wakeup gadget interface
+ * 
+ * \param gadget            pointer to gadget struct
+ * \return 0 if success
+ */
+static int udc_wakeup (struct usb_gadget *gadget)
+{
+        struct udc              *dev;
+
+        if (!gadget)
+                return -EINVAL;
+        dev = container_of (gadget, struct udc, gadget);
+        udc_remote_wakeup(dev);
+
+        return 0;
+}
+
+/**
+ * gadget ioctl, used for OTG support notification
+ * 
+ * \param gadget            pointer to gadget struct
+ * \param cmd               command
+ * \param par               parmater
+ * \return 1 if OTG supported, else 0
+ */
+static int udc_gadget_ioctl (struct usb_gadget *gadget, unsigned cmd, unsigned long par)
+{
+        struct udc              *dev;
+        int                     retval = 0;
+        unsigned long           iflags;
+        u32 tmp;
+
+        if (!gadget)
+                return -ENODEV;
+        dev = container_of (gadget, struct udc, gadget);
+        spin_lock_irqsave (&dev->lock, iflags);
+        tmp = readl(&dev->regs->cfg);
+        
+        if (tmp & AMD_BIT(UDC_DEVCFG_HNPSFEN))
+                retval = 1;
+        else
+                retval = 0;
+        spin_unlock_irqrestore (&dev->lock, iflags);
+        return retval;
+}
+
+/* gadget operations */
+static const struct usb_gadget_ops udc_ops = {
+        .wakeup         = udc_wakeup,
+        .get_frame      = udc_get_frame,
+        .ioctl          = udc_gadget_ioctl, 
+};
+
+/**
+ * Setups endpoint parameters, adds endpoints to linked list
+ * 
+ * \param dev           pointer to dev struct
+ */
+static void make_ep_lists(struct udc *dev)
+{
+        /* make gadget ep lists */
+        INIT_LIST_HEAD (&dev->gadget.ep_list);
+        list_add_tail (&dev->ep [UDC_EPIN_STATUS_IX].ep.ep_list, &dev->gadget.ep_list);
+        list_add_tail (&dev->ep [UDC_EPIN_IX].ep.ep_list, &dev->gadget.ep_list);
+        list_add_tail (&dev->ep [UDC_EPOUT_IX].ep.ep_list, &dev->gadget.ep_list);
+        
+        /* fifo config */
+        dev->ep [UDC_EPIN_STATUS_IX].fifo_depth = UDC_EPIN_SMALLINT_BUFF_SIZE;
+        if (dev->gadget.speed == USB_SPEED_FULL)
+                dev->ep [UDC_EPIN_IX].fifo_depth = UDC_FS_EPIN_BUFF_SIZE; 
+        else if (dev->gadget.speed == USB_SPEED_HIGH)
+                dev->ep [UDC_EPIN_IX].fifo_depth = hs_tx_buf; 
+        dev->ep [UDC_EPOUT_IX].fifo_depth = UDC_RXFIFO_SIZE;
+}
+
+/**
+ * Sets fifo mode, called by gadget driver
+ * 
+ * \param gadget        pointer to gadget struct
+ * \param md            not used
+ * \return 0 if success 
+ */
+int au1200udc_set_fifo_mode (struct usb_gadget *gadget, int md)
+{
+        struct udc              *dev;
+        unsigned long           iflags;
+
+        if (!gadget)
+                return -ENODEV;
+
+        dev = container_of (gadget, struct udc, gadget);
+
+        spin_lock_irqsave (&dev->lock, iflags);
+        make_ep_lists(dev);
+        spin_unlock_irqrestore (&dev->lock, iflags);
+
+        return 0;
+}
+EXPORT_SYMBOL (au1200udc_set_fifo_mode);
+
+/**
+ * \brief
+ * init registers at driver load time 
+ *
+ * \param dev        pointer to device struc
+ * \return 0 if success
+ */
+static int startup_registers(struct udc* dev)
+{
+        u32 tmp;
+
+        /* init controller by soft reset */
+        udc_soft_reset(dev);
+
+        /* mask not needed interrupts */
+        udc_mask_unused_interrupts(dev);
+
+        /* put into initial config */
+        udc_basic_init (dev);
+        /* link up all endpoints */
+        udc_setup_endpoints (dev);
+       
+        /* program speed */
+        tmp = readl(&dev->regs->cfg);
+        if (use_fullspeed) {
+                tmp = AMD_ADDBITS(tmp, UDC_DEVCFG_SPD_FS, UDC_DEVCFG_SPD);
+        }
+        else {
+                tmp = AMD_ADDBITS(tmp, UDC_DEVCFG_SPD_HS, UDC_DEVCFG_SPD);
+        }
+        writel(tmp, &dev->regs->cfg);
+
+        return 0;
+}
+
+/**
+ * Inits UDC context 
+ * 
+ * \param dev           pointer to device struct
+ */
+static void udc_basic_init (struct udc *dev)
+{
+        u32     tmp;
+
+        DBG("udc_basic_init()\n");        
+        
+        dev->gadget.speed = USB_SPEED_UNKNOWN;
+
+#ifdef UDC_USE_TIMER
+        /* stop RDE timer */ 
+        if (timer_pending(&udc_timer)) {
+                set_rde = 0;
+                mod_timer(&udc_timer, jiffies - 1);
+        }
+        /* stop poll stall timer */ 
+        if (timer_pending(&udc_pollstall_timer)) {
+                mod_timer(&udc_pollstall_timer, jiffies - 1);
+        }
+#endif
+        /* disable DMA */
+        tmp = readl(&dev->regs->ctl);
+        tmp &= AMD_UNMASK_BIT(UDC_DEVCTL_RDE);
+        tmp &= AMD_UNMASK_BIT(UDC_DEVCTL_TDE);
+        writel(tmp, &dev->regs->ctl);                
+
+        /* enable dynamic CSR programming */
+        tmp =  readl(&dev->regs->cfg);
+        tmp |= AMD_BIT(UDC_DEVCFG_CSR_PRG);
+        /* set self powered */
+        tmp |= AMD_BIT(UDC_DEVCFG_SP);
+        /* set remote wakeupable */
+        tmp |= AMD_BIT(UDC_DEVCFG_RWKP);
+        writel(tmp, &dev->regs->cfg);                     
+
+        make_ep_lists(dev);
+
+        dev->data_ep_enabled = 0;
+        dev->data_ep_queued = 0;
+}
+
+/**
+ * Sets initial endpoint parameters
+ * 
+ * \param dev           pointer to device struct
+ */
+static void udc_setup_endpoints(struct udc *dev)
+{
+        struct udc_ep   *ep;
+        u32     tmp;
+        u32     reg;
+
+        DBG("udc_setup_endpoints()\n");
+
+        /* read enum speed */
+        tmp = readl(&dev->regs->sts);
+        tmp = AMD_GETBITS(tmp, UDC_DEVSTS_ENUM_SPEED);        
+        if (tmp ==  UDC_DEVSTS_ENUM_SPEED_HIGH) {
+                dev->gadget.speed = USB_SPEED_HIGH;
+        }
+        else if (tmp ==  UDC_DEVSTS_ENUM_SPEED_FULL) {
+                dev->gadget.speed = USB_SPEED_FULL;
+        }
+        
+        /* set basic ep parameters */
+        for (tmp = 0; tmp < UDC_EP_NUM; tmp++) {
+                ep = &dev->ep[tmp];
+                ep->dev = dev;
+                ep->ep.name = ep_string [tmp];
+                ep->num = tmp;
+                /* txfifo size is calculated at enable time */
+                ep->txfifo = dev->txfifo;
+
+                /* fifo size */
+                if (tmp < UDC_EPIN_NUM) {
+                        ep->fifo_depth = UDC_TXFIFO_SIZE;
+                        ep->in = 1;
+                }
+                else {
+                        ep->fifo_depth = UDC_RXFIFO_SIZE;
+                        ep->in = 0;
+
+                }
+                ep->regs = &dev->ep_regs[tmp];
+                /* ep will be reset only if ep was not enabled before to avoid
+                   disabling ep interrupts when ENUM interrupt occurs but ep is
+                   not enabled by gadget driver  */
+                if (!ep->desc) {
+                        ep_init (dev->regs, ep);
+                }
+
+                if (use_dma) {
+                        /* ep->dma is not really used, just to indicate that */
+                        /* DMA is active: remove this */
+                        /* dma regs = dev control regs */        
+                        ep->dma = (u32*) &dev->regs->ctl;       
+
+                        /* nak OUT endpoints until enable - not for ep0*/
+                        if (tmp != UDC_EP0IN_IX
+                            && tmp != UDC_EP0OUT_IX
+                            && tmp > UDC_EPIN_NUM) {
+                                /* set NAK  */
+                                reg = readl(&dev->ep[tmp].regs->ctl);
+                                reg |= AMD_BIT(UDC_EPCTL_SNAK); 
+                                writel(reg, &dev->ep[tmp].regs->ctl);
+                                dev->ep[tmp].naking = 1;
+                                       
+                        }
+                }
+        }
+        /* EP0 max packet */
+        if (dev->gadget.speed == USB_SPEED_FULL) {
+                dev->ep [UDC_EP0IN_IX].ep.maxpacket = UDC_FS_EP0IN_MAX_PKT_SIZE;
+                dev->ep [UDC_EP0OUT_IX].ep.maxpacket = UDC_FS_EP0OUT_MAX_PKT_SIZE;
+        }
+        else if (dev->gadget.speed == USB_SPEED_HIGH) {
+                dev->ep [UDC_EP0IN_IX].ep.maxpacket = UDC_EP0IN_MAX_PKT_SIZE;
+                dev->ep [UDC_EP0OUT_IX].ep.maxpacket = UDC_EP0OUT_MAX_PKT_SIZE;
+        }
+
+        /* with suspend bug workaround, ep0 params for gadget driver
+        are set at gadget driver bind() call */
+        dev->gadget.ep0 = &dev->ep [UDC_EP0IN_IX].ep;
+        dev->ep [UDC_EP0IN_IX].halted = 0;
+        INIT_LIST_HEAD (&dev->gadget.ep0->ep_list);
+
+        /* init cfg/alt/int */
+        dev->cur_config = 0;
+        dev->cur_intf = 0;
+        dev->cur_alt = 0;
+}
+
+/**
+ * Bringup after Connect event,
+ * initial bringup to be ready for ep0 events 
+ * 
+ * \param dev           pointer to device struct
+ */
+static void usb_connect (struct udc *dev) {
+
+                INFO("USB Connect\n");
+
+                dev->connected = 1;
+
+                /* put into initial config */
+                udc_basic_init (dev);
+
+                /* enable device setup interrupts */
+                udc_enable_dev_setup_interrupts(dev);
+}
+
+/**
+ * Calls gadget with disconnect event and resets the UDC and makes
+ * initial bringup to be ready for ep0 events 
+ * 
+ * \param dev           pointer to device struct
+ */
+static void usb_disconnect (struct udc *dev) {
+
+                INFO("USB Disconnect\n");
+
+                dev->connected = 0;
+
+                /* mask interrupts */
+                udc_mask_unused_interrupts(dev);
+
+                tasklet_schedule(&disconnect_tasklet);
+}
+
+/**
+ * Tasklet for disconnect to be outside of interrupt 
+ * context 
+ * 
+ * \param par   pointer to device struct pointer
+ */
+void udc_tasklet_disconnect(unsigned long par)
+{
+        struct udc* dev = (struct udc*) (*((struct udc**) par));
+        u32 tmp;
+
+        DBG("Tasklet disconnect\n");
+
+        if (dev->driver) {
+                /* call gadget to reset configs etc. */
+                if (spin_is_locked(&dev->lock)) {
+                        spin_unlock(&dev->lock);
+                        dev->driver->disconnect (&dev->gadget);
+                        spin_lock(&dev->lock);
+                }
+                else
+                        dev->driver->disconnect (&dev->gadget);
+
+                /* empty queues */
+                for (tmp = 0; tmp < UDC_EP_NUM; tmp++) {
+                        empty_req_queue (&dev->ep [tmp]);
+                }
+        }	
+
+        /* disable ep0 */
+        ep_init (dev->regs,
+                        &dev->ep [UDC_EP0IN_IX]);
+        
+
+        if (!soft_reset_occured) {
+                /* init controller by soft reset */
+#ifdef UDC_IPCASE_8000018724_WORKAROUND
+                udc_soft_reset(dev);
+#endif
+                soft_reset_occured++;
+        }
+#ifndef UDC_IPBUG_3950_WORKAROUND
+        /* re-enable dev interrupts */
+        udc_enable_dev_setup_interrupts(dev);
+#endif
+        /* back to full speed ? */
+        if (use_fullspeed) {
+                tmp = readl(&dev->regs->cfg);
+                tmp = AMD_ADDBITS(tmp, UDC_DEVCFG_SPD_FS, UDC_DEVCFG_SPD);
+                writel(tmp, &dev->regs->cfg);
+        }
+}
+
+/**
+ * Reset the UDC core 
+ * 
+ * \param dev           pointer to device struct
+ */
+static void udc_soft_reset(struct udc* dev)
+{
+        DBG("Soft reset\n");
+        /* reset possible waiting interrupts, because int.
+           status is lost after soft reset */
+        /* ep int. status reset */ 
+        writel(UDC_EPINT_MSK_DISABLE_ALL, &dev->regs->ep_irqsts);
+        /* device int. status reset */ 
+        writel(UDC_DEV_MSK_DISABLE, &dev->regs->irqsts);
+
+        spin_lock_irq(&udc_irq_spinlock);
+        writel(AMD_BIT(UDC_DEVCFG_SOFTRESET), &dev->regs->cfg);
+        readl(&dev->regs->cfg);
+        spin_unlock_irq(&udc_irq_spinlock);
+        
+}
+
+#ifdef UDC_USE_TIMER
+/**
+ * RDE timer callback to set RDE bit 
+ * 
+ * \param v           timer callback argument
+ */
+void udc_timer_function(unsigned long v)
+{
+        u32 tmp;
+        unsigned int i;
+        unsigned int bulk_data_arrived;
+        spin_lock_irq(&udc_irq_spinlock);
+        if (set_rde) {
+                /* open the fifo if fifo was filled on last timer call */
+                if (set_rde > 1) {
+                        bulk_data_arrived = 0;
+                        /* check wether OUT bulk data is arrived */
+                        for (i = UDC_EPIN_NUM + 1; i < UDC_EP_NUM; i++) {
+                                tmp = readl(&udc->ep [i].regs->sts);
+                                if (AMD_GETBITS(tmp, UDC_EPSTS_OUT)
+                                    == UDC_EPSTS_OUT_DATA) {
+                                        bulk_data_arrived = 1;
+                                        break;
+                                }
+                        }
+                        /* if OUT bulk data in fifo wait for queueing which
+                           sets RDE, if not open fifo for setup packet */
+                        if (!bulk_data_arrived) {
+                                /* set RDE */
+                                tmp = readl(&udc->regs->ctl);
+                                tmp |= AMD_BIT(UDC_DEVCTL_RDE);
+                                writel(tmp, &udc->regs->ctl);                
+                        }
+                        else 
+                                INFO("ep%d - queueing delay longer than %d second(s)\n",
+                                     i, UDC_RDE_TIMER_SECONDS);
+                        set_rde = -1;
+                }
+                else if (readl(&udc->regs->sts) & 
+                         AMD_BIT(UDC_DEVSTS_RXFIFO_EMPTY)) {
+                        /* if fifo empty setup polling, do not just
+                           open the fifo */
+                        udc_timer.expires = jiffies + HZ/UDC_RDE_TIMER_DIV;
+                        if (!stop_timer) {
+                                add_timer(&udc_timer);
+                        }
+                }
+                else {
+                        /* fifo contains data now, setup timer for opening
+                           the fifo when timer expires to be able to receive
+                           setup packets, when data packets gets queued by
+                           gadget layer then timer will forced to expire with
+                           set_rde=0 (RDE is set in udc_queue()) */
+                        set_rde++;
+                        /* debug: lhadmot_timer_start = 221070 */
+                        udc_timer.expires = jiffies + HZ*UDC_RDE_TIMER_SECONDS;
+                        if (!stop_timer) {
+                                add_timer(&udc_timer);
+                        }
+                }
+                        
+        }
+        else
+                set_rde = -1; /* RDE was set by udc_queue() */
+        spin_unlock_irq(&udc_irq_spinlock);
+        if (stop_timer)
+                complete(&on_exit);
+        
+}
+
+/**
+ *  Handle halt state, used in stall poll timer 
+ * 
+ * \param ep    pointer to endpoint struct           
+ */
+static inline void udc_handle_halt_state(struct udc_ep* ep)
+{
+        u32 tmp;
+        /* set stall as long not halted */
+        if (ep->halted == 1) {
+                tmp = readl(&ep->regs->ctl);
+                /* STALL cleared ? */
+                if (!(tmp & AMD_BIT(UDC_EPCTL_S))) {
+                        DBG("ep %d: set STALL again\n", ep->num);
+                        /* set STALL again */
+                        tmp |= AMD_BIT(UDC_EPCTL_S);
+                        writel(tmp, &ep->regs->ctl);
+                }
+        } 
+}
+
+/**
+ *  Stall timer callback to poll S bit and set it again after
+ *  CLEAR_FEATURE 
+ * 
+ * \param v           timer callback argument
+ */
+void udc_pollstall_timer_function(unsigned long v)
+{
+        struct udc_ep *ep;
+        int halted = 0;
+        unsigned long iflags;
+
+        spin_lock_irqsave (&udc_stall_spinlock, iflags);
+        /* only one IN and OUT endpoints are handled */
+        /* IN poll stall */ 
+        ep = &udc->ep [UDC_EPIN_IX];
+        udc_handle_halt_state(ep); 
+        if (ep->halted)
+                halted = 1;
+        /* OUT poll stall  */ 
+        ep = &udc->ep [UDC_EPOUT_IX];
+        udc_handle_halt_state(ep); 
+        if (ep->halted)
+                halted = 1;
+
+        /* setup timer again when still halted */
+        if (!stop_pollstall_timer && halted) {
+                udc_pollstall_timer.expires = jiffies + HZ 
+                                              * UDC_POLLSTALL_TIMER_USECONDS
+                                              / (1000 * 1000);
+                add_timer(&udc_pollstall_timer);
+        }
+        spin_unlock_irqrestore (&udc_stall_spinlock, iflags);
+
+        if (stop_pollstall_timer)
+                complete(&on_pollstall_exit);
+}
+#endif
+
+#if defined(UDC_IPBUG_3950_WORKAROUND) \
+    || defined(UDC_IPCASE_8000018724_WORKAROUND) \
+    && !defined(UDC_HSB1)
+/**
+ * Called by OTG driver to notify us regarding an OTG event
+ * 
+ * \param code           notify code
+ */
+void otg_notify(unsigned int code) {
+        VDBG("OTG notify code=%d\n", code);
+        switch (code) {
+                case OTG_GADGET_EVT_SVDROP:
+                        /* disconnect event */
+                        usb_disconnect(udc);
+                        break;
+                case OTG_GADGET_EVT_SVALID:
+                        /* connect event */
+                        usb_connect(udc);
+                        break;
+                case OTG_GADGET_REQ_WAKE:
+                        /* remote wakeup event */
+                        udc_remote_wakeup(udc);
+                        break;
+        }  
+}
+#endif
+
+/**
+ * Inits endpoint 0 so that SETUP packets are processed
+ * 
+ * \param dev           pointer to device struct
+ */
+static void activate_control_endpoints (struct udc *dev)
+{
+        u32 tmp;
+
+        DBG("activate_control_endpoints\n");
+
+        /* flush fifo */
+        tmp = readl(&dev->ep[UDC_EP0IN_IX].regs->ctl);
+        tmp |= AMD_BIT(UDC_EPCTL_F); 
+        writel(tmp, &dev->ep[UDC_EP0IN_IX].regs->ctl);
+
+        /* set ep0 directions */
+        dev->ep[UDC_EP0IN_IX].in = 1;
+        dev->ep[UDC_EP0OUT_IX].in = 0;
+
+        /* set buffer size (tx fifo entries) of EP0_IN */
+        tmp = readl(&dev->ep[UDC_EP0IN_IX].regs->bufin_framenum);
+        if (dev->gadget.speed == USB_SPEED_FULL)
+                tmp = AMD_ADDBITS(tmp, UDC_FS_EPIN0_BUFF_SIZE, UDC_EPIN_BUFF_SIZE);
+        else if (dev->gadget.speed == USB_SPEED_HIGH)
+                tmp = AMD_ADDBITS(tmp, UDC_EPIN0_BUFF_SIZE, UDC_EPIN_BUFF_SIZE);
+        writel(tmp, &dev->ep[UDC_EP0IN_IX].regs->bufin_framenum);
+        
+        /* set max packet size of EP0_IN */
+        tmp = readl(&dev->ep[UDC_EP0IN_IX].regs->bufout_maxpkt);
+        if (dev->gadget.speed == USB_SPEED_FULL)
+                tmp = AMD_ADDBITS(tmp, UDC_FS_EP0IN_MAX_PKT_SIZE, UDC_EP_MAX_PKT_SIZE);
+        else if (dev->gadget.speed == USB_SPEED_HIGH)
+                tmp = AMD_ADDBITS(tmp, UDC_EP0IN_MAX_PKT_SIZE, UDC_EP_MAX_PKT_SIZE);
+        writel(tmp, &dev->ep[UDC_EP0IN_IX].regs->bufout_maxpkt);
+
+        /* set max packet size of EP0_OUT */
+        tmp = readl(&dev->ep[UDC_EP0OUT_IX].regs->bufout_maxpkt);
+        if (dev->gadget.speed == USB_SPEED_FULL)
+                tmp = AMD_ADDBITS(tmp, UDC_FS_EP0OUT_MAX_PKT_SIZE, UDC_EP_MAX_PKT_SIZE);
+        else if (dev->gadget.speed == USB_SPEED_HIGH)
+                tmp = AMD_ADDBITS(tmp, UDC_EP0OUT_MAX_PKT_SIZE, UDC_EP_MAX_PKT_SIZE);
+        writel(tmp, &dev->ep[UDC_EP0OUT_IX].regs->bufout_maxpkt);
+
+        /* set max packet size of EP0 in UDC CSR  */
+        tmp = readl(&dev->csr->ne[0]);
+        if (dev->gadget.speed == USB_SPEED_FULL)
+                tmp = AMD_ADDBITS(tmp, UDC_FS_EP0OUT_MAX_PKT_SIZE, UDC_CSR_NE_MAX_PKT);
+        else if (dev->gadget.speed == USB_SPEED_HIGH)
+                tmp = AMD_ADDBITS(tmp, UDC_EP0OUT_MAX_PKT_SIZE, UDC_CSR_NE_MAX_PKT);
+        writel(tmp, &dev->csr->ne[0]);
+
+        if (use_dma) {
+                dev->ep [UDC_EP0OUT_IX].td->status |= AMD_BIT(UDC_DMA_OUT_STS_L);
+                /* write dma desc address */
+                writel(dev->ep [UDC_EP0OUT_IX].td_stp_dma, &dev->ep[UDC_EP0OUT_IX].regs->subptr);
+                writel(dev->ep [UDC_EP0OUT_IX].td_phys, &dev->ep[UDC_EP0OUT_IX].regs->desptr);
+#ifdef UDC_USE_TIMER
+                /* stop RDE timer */ 
+                if (timer_pending(&udc_timer)) {
+                        set_rde = 0;
+                        mod_timer(&udc_timer, jiffies - 1);
+                }
+                /* stop pollstall timer */ 
+                if (timer_pending(&udc_pollstall_timer)) {
+                        mod_timer(&udc_pollstall_timer, jiffies - 1);
+                }
+#endif
+                /* enable DMA */
+                tmp = readl(&dev->regs->ctl);
+                tmp |= AMD_BIT(UDC_DEVCTL_MODE)
+                                | AMD_BIT(UDC_DEVCTL_RDE)
+                                | AMD_BIT(UDC_DEVCTL_TDE);
+                if (use_dma_bufferfill_mode) {
+                        tmp |= AMD_BIT(UDC_DEVCTL_BF);
+                } 
+                else if (use_dma_ppb_du) {
+                        tmp |= AMD_BIT(UDC_DEVCTL_DU);
+                }
+                writel(tmp, &dev->regs->ctl);                
+        }
+
+        /* clear NAK by writing CNAK for EP0IN */
+        tmp = readl(&dev->ep[UDC_EP0IN_IX].regs->ctl);
+        tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+        writel(tmp, &dev->ep[UDC_EP0IN_IX].regs->ctl);
+        dev->ep[UDC_EP0IN_IX].naking = 0;
+        UDC_QUEUE_CNAK(&dev->ep[UDC_EP0IN_IX], UDC_EP0IN_IX);
+        
+        /* clear NAK by writing CNAK for EP0OUT */
+        tmp = readl(&dev->ep[UDC_EP0OUT_IX].regs->ctl);
+        tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+        writel(tmp, &dev->ep[UDC_EP0OUT_IX].regs->ctl);
+        dev->ep[UDC_EP0OUT_IX].naking = 0;
+        UDC_QUEUE_CNAK(&dev->ep[UDC_EP0OUT_IX], UDC_EP0OUT_IX);
+}
+
+/**
+ * \brief
+ * Make endpoint 0 ready for control traffic
+ *
+ * \param dev        pointer to device struc
+ * \return 0 if success
+ */
+static int setup_ep0(struct udc *dev)
+{
+        activate_control_endpoints (dev);
+        /* enable ep0 interrupts */
+        udc_enable_ep0_interrupts(dev);
+        /* enable device setup interrupts */
+        udc_enable_dev_setup_interrupts(dev);
+
+        return 0;
+}
+
+/**
+ * \brief
+ * Called by gadget driver to register itself
+ *
+ * \param driver        pointer to gadget driver struct
+ * \return 0 if success
+ */
+int usb_gadget_register_driver (struct usb_gadget_driver *driver)
+{
+        struct udc              *dev = udc;
+        int                     retval;
+	u32 tmp;
+
+        if (!driver || !driver->bind
+                    || !driver->unbind
+                    || !driver->setup
+                    || driver->speed != USB_SPEED_HIGH)
+                return -EINVAL;
+        if (!dev)
+                return -ENODEV;
+        if (dev->driver)
+                return -EBUSY;
+
+        driver->driver.bus = 0;
+        dev->driver = driver;
+        dev->gadget.dev.driver = &driver->driver;
+
+#ifndef CONFIG_SOC_AU1200
+        /*device_create_file (&dev->pdev->dev, &dev_attr_function);
+        device_create_file (&dev->pdev->dev, &dev_attr_queues);*/
+#endif
+
+#ifdef CONFIG_USB_OTG
+	dev->gadget.is_otg = 1;
+#endif
+        retval = driver->bind (&dev->gadget);
+        /* e.g. ether gadget needs driver_data on both ep0 endpoints */
+        dev->ep[UDC_EP0OUT_IX].ep.driver_data =
+                dev->ep [UDC_EP0IN_IX].ep.driver_data;
+        
+        gadget_bind_count++;
+        if (retval) {
+                DBG( "binding to  %s returning %d\n",
+                                driver->driver.name, retval);
+                dev->driver = 0;
+                dev->gadget.dev.driver = 0;
+                return retval;
+        }
+
+        /* if otg driver already registered */
+        /* call otg bind() to mux udc to phy */
+        if (dev->otg_transceiver) {
+                dev->otg_transceiver->set_peripheral(
+                        dev->otg_transceiver, &dev->gadget);
+		/* clear SD */
+		tmp = readl(&dev->regs->ctl);
+		tmp = tmp & AMD_CLEAR_BIT(UDC_DEVCTL_SD);
+		writel(tmp, &dev->regs->ctl);
+        }
+#ifndef UDC_IPBUG_3950_WORKAROUND
+        usb_connect(dev);
+#endif
+
+        return 0;
+}
+EXPORT_SYMBOL (usb_gadget_register_driver);
+
+/**
+ * Called by OTG driver to register itself
+ * 
+ *
+ * \param get_transceiver  function pointer to get OTG info
+ * \return 0 if success
+ */
+int usb_gadget_register_otg (struct otg_transceiver * (*get_transceiver)(void))
+{
+        struct udc              *dev = udc;
+        int                     retval;
+	u32 tmp;
+        
+        if (!get_transceiver)
+                return -EINVAL;
+        if (!dev)
+                return -ENODEV;
+        if (dev->otg_transceiver)
+                return -EBUSY;
+
+        dev->otg_transceiver = get_transceiver ();
+
+#if !defined(UDC_HSB1)	
+        if (!(transceiver_to_otg(dev->otg_transceiver)->otg_priv))
+                return -EINVAL;
+        dev->otg_driver = (struct usb_otg_gadget_extension *)
+                          transceiver_to_otg(dev->otg_transceiver)->otg_priv;
+#endif	
+
+#ifdef UDC_IPBUG_3943_WORKAROUND
+        /* init registers here first with suspend bug */
+        if (!otg_reg_count) {
+                startup_registers(dev);
+                otg_reg_count++; 
+        }
+#endif
+
+#ifdef UDC_IPBUG_3950_WORKAROUND
+        /* set notify function */
+        dev->otg_driver->notify = otg_notify;
+#endif
+        /* if gadget driver already registered */
+        /* call gadget bind() to switch to mux udc to phy */
+        if (dev->driver) {
+
+               /* otg driver bind() */
+                retval = dev->otg_transceiver->set_peripheral(
+                                dev->otg_transceiver, &dev->gadget);
+               if (retval) {
+                       DBG( "error bind to uoc driver\n");
+#if !defined(UDC_HSB1)	
+                        dev->otg_driver = NULL;
+#endif			
+                        dev->otg_transceiver = NULL;
+                       return retval;
+               }
+                /* get ready for ep0 traffic */
+                setup_ep0(dev);
+
+		/* clear SD */
+		tmp = readl(&dev->regs->ctl);
+		tmp = tmp & AMD_CLEAR_BIT(UDC_DEVCTL_SD);
+		writel(tmp, &dev->regs->ctl);
+        }
+
+        INFO( "registered uoc driver\n");
+
+        return 0;
+}
+EXPORT_SYMBOL (usb_gadget_register_otg);
+
+/**
+ * Called by OTG driver to unregister itself
+ * 
+ *
+ * \return 0 if success
+ */
+int usb_gadget_unregister_otg (void)
+{
+        struct udc      *dev = udc;
+        unsigned long   flags;
+        u32 tmp;
+
+        if (!dev)
+                return -ENODEV;
+
+        spin_lock_irqsave (&dev->lock, flags);
+
+        /* mask not needed interrupts */
+        udc_mask_unused_interrupts(dev);
+
+        spin_unlock_irqrestore (&dev->lock, flags);
+
+        dev->otg_supported = 0;
+        if (dev->otg_transceiver) {
+                dev->otg_transceiver->set_peripheral(dev->otg_transceiver, NULL);
+                dev->otg_transceiver = NULL;
+        }
+#if !defined(UDC_HSB1)	
+        if (dev->otg_driver) {
+#ifdef UDC_IPBUG_3950_WORKAROUND
+                dev->otg_driver->notify = NULL;
+#endif
+		dev->otg_driver = NULL;
+        }
+#endif	
+
+        /* set SD */
+        tmp = readl(&dev->regs->ctl);
+        tmp |= AMD_BIT(UDC_DEVCTL_SD);
+        writel(tmp, &dev->regs->ctl);
+
+        DBG( "unregistered uoc driver\n");
+        return 0;
+}
+EXPORT_SYMBOL (usb_gadget_unregister_otg);
+
+/**
+ *  shutdown requests and disconnect from gadget 
+ */
+static void
+shutdown(struct udc *dev, struct usb_gadget_driver *driver)
+{
+        int tmp;
+
+        /* empty queues and init hardware */
+        udc_basic_init(dev);
+        for (tmp = 0; tmp < UDC_EP_NUM; tmp++) {
+                empty_req_queue (&dev->ep [tmp]);
+        }
+
+        if (dev->gadget.speed != USB_SPEED_UNKNOWN) {
+                spin_unlock (&dev->lock);
+                driver->disconnect (&dev->gadget);
+                spin_lock (&dev->lock);
+        }
+        /* init */
+        udc_setup_endpoints (dev);
+}
+
+/**
+ * Called by gadget driver to unregister itself
+ *
+ * \param driver        pointer to gadget driver struct
+ * \return 0 if success
+ */
+int usb_gadget_unregister_driver (struct usb_gadget_driver *driver)
+{
+        struct udc      *dev = udc;
+        unsigned long   iflags;
+        u32 tmp;
+
+        if (!dev)
+                return -ENODEV;
+        if (!driver || driver != dev->driver)
+                return -EINVAL;
+        if (gadget_bind_count) {
+                spin_lock_irqsave (&dev->lock, iflags);
+                shutdown(dev, driver);
+                spin_unlock_irqrestore (&dev->lock, iflags);
+        }
+
+        /* unbind from otg driver first */
+        if (dev->otg_transceiver) {
+                dev->otg_transceiver->set_peripheral(
+                        dev->otg_transceiver, NULL);
+        }
+
+        if (gadget_bind_count) {
+                driver->unbind (&dev->gadget);
+        }
+        gadget_bind_count = 0;
+        dev->driver = 0;
+
+        /* set SD */
+        tmp = readl(&dev->regs->ctl);
+        tmp |= AMD_BIT(UDC_DEVCTL_SD);
+        writel(tmp, &dev->regs->ctl);
+
+
+        DBG( "%s: unregistered\n", driver->driver.name);
+
+        return 0;
+}
+EXPORT_SYMBOL (usb_gadget_unregister_driver);
+
+
+#ifdef UDC_IPBUG_3958_WORKAROUND
+/**
+ * Clear pending NAK bits  
+ *
+ * \param dev           pointer to UDC device object    
+ * \return 0 if success
+ */
+static void udc_process_cnak_queue(struct udc* dev)
+{
+        u32 tmp;
+        u32 reg;
+        /* check epin's */
+        DBG("CNAK pending queue processing\n");
+        for (tmp = 0; tmp < UDC_EPIN_NUM_USED; tmp++) {
+                if (cnak_pending & (1 << tmp)) {
+                        DBG("CNAK pending for ep%d\n", tmp);
+                        /* clear NAK by writing CNAK */
+                        reg = readl(&dev->ep[tmp].regs->ctl);
+                        reg |= AMD_BIT(UDC_EPCTL_CNAK); 
+                        writel(reg, &dev->ep[tmp].regs->ctl);
+                        dev->ep[tmp].naking = 0;
+                        UDC_QUEUE_CNAK(&dev->ep[tmp], dev->ep[tmp].num);
+                } 
+        }
+        /* ...  and ep0out */
+        if (cnak_pending & (1 << UDC_EP0OUT_IX)) {
+                DBG("CNAK pending for ep%d\n", UDC_EP0OUT_IX);
+                /* clear NAK by writing CNAK */
+                reg = readl(&dev->ep[UDC_EP0OUT_IX].regs->ctl);
+                reg |= AMD_BIT(UDC_EPCTL_CNAK); 
+                writel(reg, &dev->ep[UDC_EP0OUT_IX].regs->ctl);
+                dev->ep[UDC_EP0OUT_IX].naking = 0;
+                UDC_QUEUE_CNAK(&dev->ep[UDC_EP0OUT_IX], 
+                                dev->ep[UDC_EP0OUT_IX].num);
+        }
+}
+#endif
+
+/**
+ * Enabling RX DMA after setup packet  
+ *
+ * \param dev           pointer to UDC device object    
+ */
+static inline void udc_ep0_set_rde(struct udc* dev)
+{
+        if (use_dma) {
+#ifndef UDC_USE_TIMER
+                udc_set_rde(dev);
+#else
+                /* only enable RXDMA when no data endpoint enabled	
+                   or data is queued */
+                if (!dev->data_ep_enabled || dev->data_ep_queued) {
+                        udc_set_rde(dev);
+                }
+                else {
+                        /* setup timer for enabling RDE (to not enable
+                           RXFIFO DMA for data endpoints to early) */
+                        if (set_rde != 0 && !timer_pending(&udc_timer)) {
+                                udc_timer.expires = jiffies + HZ/UDC_RDE_TIMER_DIV;
+                                set_rde = 1;
+                                if (!stop_timer) {
+                                        add_timer(&udc_timer);
+                                }
+                        }
+                }
+#endif
+        }
+}
+
+
+/**
+ * Interrupt handler for data OUT traffic  
+ *
+ * \param dev           pointer to UDC device object    
+ * \param ep_ix         endpoint index    
+ * \return 0 if success
+ */
+static inline int udc_data_out_isr(struct udc* dev, int ep_ix)
+{
+        int ret_val = 0;
+        u32 tmp;
+        struct udc_ep   *ep;
+        struct udc_request              *req;
+        unsigned int count;
+        struct udc_data_dma     *td = NULL;
+        unsigned dma_done;
+
+        VDBG("ep%d irq\n", ep_ix); 
+        ep = &dev->ep [ep_ix];
+
+        tmp = readl(&ep->regs->sts);
+        if (use_dma) {
+                /* BNA event ? */
+                if (tmp & AMD_BIT(UDC_EPSTS_BNA)) {
+                        ERR("BNA ep%dout occured - DESPTR = %lx \n", ep->num, (unsigned long) readl(&ep->regs->desptr));
+                        
+                        /* clear BNA */
+                        writel(tmp | AMD_BIT(UDC_EPSTS_BNA), &ep->regs->sts); 
+                        return 1;                       
+                } 
+        }
+        /* HE event ? */
+        if (tmp & AMD_BIT(UDC_EPSTS_HE)) {
+                ERR("HE ep%dout occured\n", ep->num);
+                
+                /* clear HE */
+                writel(tmp | AMD_BIT(UDC_EPSTS_HE), &ep->regs->sts); 
+                return 1;                       
+        } 
+
+        if (!list_empty (&ep->queue)) {
+
+                /* next request */ 
+                req = list_entry (ep->queue.next,
+                        struct udc_request, queue);
+        }
+        else
+        {
+                req = 0;
+#ifdef UDC_DEBUG
+                no_req++;
+#endif
+                udc_rxfifo_pending = 1;
+        }
+        VDBG("req = %lx\n", (unsigned long) req);
+        /* fifo mode ****************/
+        if (!use_dma) {
+
+                /* read fifo */
+                if (req && udc_rxfifo_read(ep, req)) {
+                        /* finish */
+                        complete_req (ep, req, 0);
+                        /* next request */
+                        if (!list_empty (&ep->queue) && !ep->halted) {
+                                req = list_entry (ep->queue.next,
+                                        struct udc_request, queue);
+                        } 
+                        else
+                                req = 0;
+                }
+
+        } /* DMA ********************/
+        else if (req) {
+
+                /* check for DMA done */
+                if (!use_dma_ppb) {
+                        dma_done = AMD_GETBITS(req->td_data->status, UDC_DMA_OUT_STS_BS); 
+                } /* packet per buffer mode - rx bytes */
+                else {
+                        td = udc_get_last_dma_desc(req);
+                        dma_done = AMD_GETBITS(td->status, UDC_DMA_OUT_STS_BS); 
+                }
+                if (dma_done == UDC_DMA_OUT_STS_BS_DMA_DONE) {
+                        /* buffer fill mode - rx bytes */
+                        if (!use_dma_ppb) {
+                                /* received number bytes */
+                                count = AMD_GETBITS(req->td_data->status, UDC_DMA_OUT_STS_RXBYTES); 
+                                VDBG("rx bytes=%lx\n", (unsigned long) count);
+                        } /* packet per buffer mode - rx bytes */
+                        else {
+                                VDBG("req->td_data=%lx\n", (unsigned long) req->td_data);
+                                VDBG("last desc = %lx\n", (unsigned long) td);
+                                /* received number bytes */
+                                if (use_dma_ppb_du) {
+                                        /* every desc. counts bytes */
+                                        count = udc_get_ppbdu_rxbytes(req);
+                                }
+                                else {
+                                        /* last desc. counts bytes */
+                                        count = AMD_GETBITS(td->status, UDC_DMA_OUT_STS_RXBYTES);
+                                        if (!count) {
+                                                /* on 64k packets the RXBYTES field is zero */
+                                                if (req->req.length == UDC_DMA_MAXPACKET)
+                                                        count = UDC_DMA_MAXPACKET; 
+                                        }
+                                }
+                                VDBG("last desc rx bytes=%lx\n", (unsigned long) count);
+                        }
+
+                        tmp = req->req.length - req->req.actual;
+                        if (count > tmp) {
+                                if ((tmp % ep->ep.maxpacket) != 0) {
+                                        ERR( "%s: received %d bytes, rx-buffer space =  %d bytes => buffer overrun\n",
+                                                ep->ep.name, count, tmp);
+                                        req->req.status = -EOVERFLOW;
+                                }
+                                count = tmp;
+                        }
+                        req->req.actual += count;
+
+                        /* complete request */ 
+                        complete_req(ep, req, 0);
+                        
+                        /* next request */
+                        if (!list_empty (&ep->queue) && !ep->halted) {
+                                req = list_entry(ep->queue.next,
+                                                 struct udc_request,
+                                                 queue);
+
+                                /* next dma */
+                                ret_val = prep_dma(ep, req);
+                                if (ret_val != 0)
+                                        goto finished;
+                                /* write desc pointer */
+                                writel(req->td_phys, &ep->regs->desptr);
+
+                                /* enable DMA */
+                                udc_set_rde(dev);
+                        }       
+                        else {
+#ifdef UDC_DEBUG
+                                no_pref_req++;
+                                VDBG("OUT queue empty\n");
+#endif
+                                /* schedule timer for setting RDE if queue remains empty
+                                 * to allow ep0 packets pass through */
+#ifdef UDC_USE_TIMER
+                                if (set_rde != 0 && !timer_pending(&udc_timer)) {
+                                        udc_timer.expires = jiffies + HZ*UDC_RDE_TIMER_SECONDS;
+                                        set_rde = 1;
+                                        if (!stop_timer) {
+                                                add_timer(&udc_timer);
+                                        }
+                                }
+#endif
+                                if (ep->num != UDC_EP0OUT_IX) 
+                                        dev->data_ep_queued = 0;
+                        }
+
+               } 
+               else {
+                        /* RX DMA must be reenabled for each desc in PPBDU mode */
+                        if (use_dma_ppb_du) {
+                                udc_set_rde(dev);
+                        }
+               } 
+                
+        }
+
+#ifdef UDC_IPBUG_3958_WORKAROUND
+        /* check pending CNAKS */
+        if (cnak_pending) {
+                /* CNAk processing when rxfifo empty only */
+                if (readl(&dev->regs->sts) & AMD_BIT(UDC_DEVSTS_RXFIFO_EMPTY)) {
+                        udc_process_cnak_queue(dev);
+                }
+        }
+#endif       
+
+        /* clear OUT bits in ep status */
+        writel(UDC_EPSTS_OUT_DATA_CLEAR, &ep->regs->sts);
+finished:
+        return ret_val;
+}
+
+/**
+ * Interrupt handler for data IN traffic  
+ *
+ * \param dev           pointer to UDC device object    
+ * \param ep_ix         endpoint index    
+ * \return 0 if success
+ */
+static inline int udc_data_in_isr(struct udc* dev, int ep_ix)
+{
+        int ret_val = 0;
+        u32 tmp;
+        u32 epsts;
+        struct udc_ep  *ep;
+        struct udc_request *req;
+        struct udc_data_dma *td;
+        unsigned dma_done;
+        unsigned len;
+
+        ep = &dev->ep[ep_ix];
+        
+        epsts = readl(&ep->regs->sts);
+        if (use_dma) {
+                /* BNA ? */
+                if (epsts & AMD_BIT(UDC_EPSTS_BNA)) {
+                        ERR("BNA ep%din occured - DESPTR = %08lx \n",
+                            ep->num, (unsigned long) readl(&ep->regs->desptr));
+                        
+                        /* clear BNA */
+                        writel(epsts, &ep->regs->sts); 
+
+                        return 1;                       
+                } 
+        }
+        /* HE event ? */
+        if (epsts & AMD_BIT(UDC_EPSTS_HE)) {
+                ERR("HE ep%dn occured -  DESPTR = %08lx \n",
+                     ep->num, (unsigned long) readl(&ep->regs->desptr));
+                
+                /* clear HE */
+                writel(epsts | AMD_BIT(UDC_EPSTS_HE), &ep->regs->sts); 
+                return 1;                       
+        } 
+
+        /* DMA completion */
+        if (epsts & AMD_BIT(UDC_EPSTS_TDC)) {
+                VDBG("TDC set- completion\n");
+                if (!list_empty (&ep->queue)) {
+                       req = list_entry (ep->queue.next,
+                                        struct udc_request, queue);
+                       if (req) { 
+                                /* lengh bytes transfered */
+                                /* check dma done of last desc. in PPBDU mode */
+                                if (use_dma_ppb_du) {
+                                        td = udc_get_last_dma_desc(req);
+                                        if (td) {
+                                                dma_done = 
+                                                   AMD_GETBITS(td->status, UDC_DMA_IN_STS_BS); 
+                                                /* don't care DMA done */
+                                                /* if (dma_done == UDC_DMA_IN_STS_BS_DMA_DONE) */
+                                                        req->req.actual = req->req.length;
+                                        }
+                                }
+                                else {
+                                        /* assume all bytes transferred */
+                                        /* TODO check error status */
+                                        req->req.actual = req->req.length;
+                                }
+
+                                if (req->req.actual == req->req.length) { 
+#ifdef UDC_IPBUG_2253_WORKAROUND
+                                        /* stop NAKing after small packet DMA */
+                                        if (ep->naking) {
+                                                /* clear NAK by writing CNAK */
+                                                tmp = readl(&ep->regs->ctl);
+                                                tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                                                writel(tmp, &ep->regs->ctl);
+                                                ep->naking = 0;
+                                                UDC_QUEUE_CNAK(ep, ep->num);
+                                        }
+#endif
+                                        /* complete req */
+                                        complete_req(ep, req, 0);
+                                        req->dma_going = 0;
+#ifdef UDC_DISABLE_IRQ_IF_EMPTY_IN_QUEUE
+                                        /* further request available ? */
+                                        if (list_empty (&ep->queue)) {
+                                                /* disable interrupt */
+                                                tmp = readl(&dev->regs->ep_irqmsk);
+                                                tmp |= AMD_BIT(ep->num);
+                                                writel(tmp, &dev->regs->ep_irqmsk);        
+                                        } 
+#endif
+
+                                }
+                       }
+               }
+                 
+        } /* status reg has IN bit set and TDC not set (if TDC was handled,
+             IN must not be handled (UDC defect) ? */
+        if ((epsts & AMD_BIT(UDC_EPSTS_IN)) && !(epsts & AMD_BIT(UDC_EPSTS_TDC))) {
+                if (!list_empty (&ep->queue))
+                {
+                        /* next request */
+                        req = list_entry (ep->queue.next,
+                                        struct udc_request, queue);
+                        /* FIFO mode ********/ 
+                        if (!use_dma) {
+                                /* write fifo */
+                                udc_txfifo_write(ep, &(req->req));
+                                len = req->req.length - req->req.actual;
+				if (len > ep->ep.maxpacket)
+					len = ep->ep.maxpacket;
+				req->req.actual += len;
+                                if (req->req.actual == req->req.length 
+                                    || (len != ep->ep.maxpacket)) {
+                                    /* && (!req->req.zero || len != ep->ep.maxpacket)) { */
+                                        /* complete req */
+                                        complete_req (ep, req, 0);
+                                }
+                        } /* DMA *****************/
+                        else if (req && !req->dma_going) { 
+                                VDBG("IN DMA : req=%lx req->td_data=%lx\n",
+                                     (unsigned long) req, (unsigned long) req->td_data);
+                                if (req->td_data) {
+
+                                        req->dma_going = 1;
+
+                                        /* unset L bit of first desc. for chain */
+                                        if (use_dma_ppb && req->req.length > ep->ep.maxpacket) {
+                                                req->td_data->status &= AMD_CLEAR_BIT(UDC_DMA_IN_STS_L);
+                                        }
+
+                                        /* write desc pointer */
+                                        writel(req->td_phys, &ep->regs->desptr);
+
+                                        wb_flush();                                        
+                                        /* set HOST READY */
+                                        req->td_data->status 
+                                              = AMD_ADDBITS(req->td_data->status,
+                                                            UDC_DMA_IN_STS_BS_HOST_READY,
+                                                            UDC_DMA_IN_STS_BS);
+
+                                        wb_flush();
+
+#ifdef UDC_IPBUG_2253_WORKAROUND
+                                        /* NAK if small packet until TDC interrupt */
+                                        if (req->req.length < UDC_SMALL_PACKET) {
+                                                /* set NAK */
+                                                tmp = readl(&ep->regs->ctl);
+                                                tmp |= AMD_BIT(UDC_EPCTL_SNAK); 
+                                                writel(tmp, &ep->regs->ctl);
+                                                ep->naking = 1;
+                                                wb_flush();
+                                        }
+#endif
+                                        /* set poll demand bit */
+                                        tmp = readl(&ep->regs->ctl);
+                                        tmp |= AMD_BIT(UDC_EPCTL_P);
+                                        writel(tmp, &ep->regs->ctl);
+                                }
+                        }
+
+                } 
+        }
+        /* clear status bits */
+        writel(epsts, &ep->regs->sts);
+       
+        return ret_val;
+ 
+}
+
+/**
+ * Interrupt handler for Control OUT traffic  
+ *
+ * \param dev           pointer to UDC device object    
+ * \return 0 if success
+ */
+static inline int udc_control_out_isr(struct udc* dev)
+{
+        int ret_val = 0;
+        u32 tmp;
+        int setup_supported;
+        u32 count;
+        int set = 0;       
+        struct udc_ep   *ep;
+        struct udc_ep   *ep_tmp;
+
+        ep = &dev->ep[UDC_EP0OUT_IX];
+ 
+        /* clear irq */
+        writel(AMD_BIT(UDC_EPINT_OUT_EP0), &dev->regs->ep_irqsts);
+
+        tmp = readl(&dev->ep[UDC_EP0OUT_IX].regs->sts);
+        /* check BNA and clear if set */
+        if (tmp & AMD_BIT(UDC_EPSTS_BNA)) {
+                VDBG("BNA set\n");       
+                writel(AMD_BIT(UDC_EPSTS_BNA), &dev->ep[UDC_EP0OUT_IX].regs->sts);
+        }
+        
+        /* type of data: SETUP or DATA 0 bytes */
+        tmp = AMD_GETBITS(tmp, UDC_EPSTS_OUT);
+        VDBG( "data_typ = %lx\n", (unsigned long) tmp);
+        /* setup data */
+        if (tmp == UDC_EPSTS_OUT_SETUP) {
+
+                ep->dev->stall_ep0in = 0;
+                dev->waiting_zlp_ack_ep0in = 0;
+
+                /* set NAK for EP0_IN */
+                tmp = readl(&dev->ep[UDC_EP0IN_IX].regs->ctl);
+                tmp |= AMD_BIT(UDC_EPCTL_SNAK); 
+                writel(tmp, &dev->ep[UDC_EP0IN_IX].regs->ctl);
+                dev->ep[UDC_EP0IN_IX].naking = 1;
+                /* get setup data */
+                if (use_dma) {
+
+                        /* clear OUT bits in ep status */
+                        writel(UDC_EPSTS_OUT_SETUP_CLEAR, &dev->ep[UDC_EP0OUT_IX].regs->sts);
+
+                        setup_data.data[0] = dev->ep[UDC_EP0OUT_IX].td_stp->data12;
+                        setup_data.data[1] = dev->ep[UDC_EP0OUT_IX].td_stp->data34;
+                        /* set HOST READY */
+                        writel(UDC_DMA_STP_STS_BS_HOST_READY,
+                               &dev->ep[UDC_EP0OUT_IX].td_stp->status);
+                }
+                else {
+                        /* read fifo */
+                        udc_rxfifo_read_dwords(dev, setup_data.data, 2);
+                }
+
+                /* determine direction of control data */
+                if ((setup_data.request.bRequestType & USB_DIR_IN) != 0) {
+	                dev->gadget.ep0 = &dev->ep [UDC_EP0IN_IX].ep;
+                        /* enable RDE */
+                        udc_ep0_set_rde(dev);
+                        set = 0;
+                }
+                else {
+	                dev->gadget.ep0 = &dev->ep [UDC_EP0OUT_IX].ep;
+#ifdef UDC_USE_TIMER
+                        set = 1;
+                        dev->ep[UDC_EP0OUT_IX].naking = 1;
+                        /* setup timer for enabling RDE (to not enable
+                           RXFIFO DMA for data to early) */
+                        set_rde = 1;
+                        if (!timer_pending(&udc_timer)) {
+                                udc_timer.expires = jiffies + HZ/UDC_RDE_TIMER_DIV;
+                                if (!stop_timer) {
+                                        add_timer(&udc_timer);
+                                }
+                        }
+#endif
+                }
+                /* mass storage reset must be processed here because
+                   next packet may be a CLEAR_FEATURE HALT which would not
+                   clear the stall bit when no STALL handshale was received before
+                   (autostall can cause this) */
+                if (setup_data.data[0] == UDC_MSCRES_DWORD0 &&
+                    setup_data.data[1] == UDC_MSCRES_DWORD1) {
+                        DBG("MSC Reset\n");
+                        /* clear stall bits */
+                        /* only one IN and OUT endpoints are handled */
+                        ep_tmp = &udc->ep [UDC_EPIN_IX];
+                        udc_set_halt (&ep_tmp->ep, 0);
+                        ep_tmp = &udc->ep [UDC_EPOUT_IX];
+                        udc_set_halt (&ep_tmp->ep, 0);
+                }
+
+                /* call gadget with setup data received */
+                spin_unlock (&dev->lock);
+                setup_supported = dev->driver->setup (&dev->gadget,
+                                                      &setup_data.request);
+                spin_lock (&dev->lock);
+
+                tmp = readl(&dev->ep[UDC_EP0IN_IX].regs->ctl);
+                /* ep0 in returns data (not zlp) on IN phase */
+                if (setup_supported >= 0 && setup_supported < UDC_EP0IN_MAXPACKET) {
+                        /* clear NAK by writing CNAK in EP0_IN */
+                        tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                        writel(tmp, &dev->ep[UDC_EP0IN_IX].regs->ctl);
+                        dev->ep[UDC_EP0IN_IX].naking = 0;
+                        UDC_QUEUE_CNAK(&dev->ep[UDC_EP0IN_IX], UDC_EP0IN_IX);
+                }
+                else if (setup_supported < 0) {
+                /* if unsupported request then stall */
+                        tmp |= AMD_BIT(UDC_EPCTL_S);
+                        writel(tmp, &dev->ep[UDC_EP0IN_IX].regs->ctl);
+                }
+                else
+                        dev->waiting_zlp_ack_ep0in = 1;
+
+
+                /* clear NAK by writing CNAK in EP0_OUT */
+                if (!set) {
+                        tmp = readl(&dev->ep[UDC_EP0OUT_IX].regs->ctl);
+                        tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                        writel(tmp, &dev->ep[UDC_EP0OUT_IX].regs->ctl);
+                        dev->ep[UDC_EP0OUT_IX].naking = 0;
+                        UDC_QUEUE_CNAK(&dev->ep[UDC_EP0OUT_IX], UDC_EP0OUT_IX);
+                }
+               
+                if (!use_dma) { 
+                        /* clear OUT bits in ep status */
+                        writel(UDC_EPSTS_OUT_SETUP_CLEAR, &dev->ep[UDC_EP0OUT_IX].regs->sts);
+                }
+
+        } /* data packet 0 bytes */
+        else if (tmp == UDC_EPSTS_OUT_DATA) {
+                /* clear OUT bits in ep status */
+                writel(UDC_EPSTS_OUT_DATA_CLEAR, &dev->ep[UDC_EP0OUT_IX].regs->sts);
+                
+                /* get setup data: only 0 packet */
+                if (use_dma) {
+                        /* no req if 0 packet, just reactivate */
+                        if (list_empty (&dev->ep[UDC_EP0OUT_IX].queue)) {
+                                VDBG("ZLP\n");
+
+                                /* set HOST READY */
+                                dev->ep[UDC_EP0OUT_IX].td->status =
+                                        AMD_ADDBITS(dev->ep[UDC_EP0OUT_IX].td->status,
+                                                    UDC_DMA_OUT_STS_BS_HOST_READY,
+                                                    UDC_DMA_OUT_STS_BS);
+                                /* enable RDE */
+                                udc_ep0_set_rde(dev);
+                        }
+                        else {
+                                /* control write */
+                                udc_data_out_isr(dev, UDC_EP0OUT_IX);
+                                /* re-program desc. pointer for possible ZLPs */
+                                writel(dev->ep [UDC_EP0OUT_IX].td_phys,
+                                        &dev->ep[UDC_EP0OUT_IX].regs->desptr);
+                                /* enable RDE */
+                                udc_ep0_set_rde(dev);
+                        }
+                }
+                else {
+
+                        /* received number bytes */
+                        count = readl(&dev->ep[UDC_EP0OUT_IX].regs->sts);
+                        count = AMD_GETBITS(count, UDC_EPSTS_RX_PKT_SIZE);
+                        /* out data for fifo mode not working */
+                        count = 0;
+
+                        /* 0 packet or real data ? */
+                        if (count != 0) {
+                                udc_data_out_isr(dev, UDC_EP0OUT_IX);
+                        }
+                        else {
+                                /* dummy read confirm */
+                                readl(&dev->ep[UDC_EP0OUT_IX].regs->confirm);
+                        }
+                }
+        }
+
+#ifdef UDC_IPBUG_3958_WORKAROUND
+        /* check pending CNAKS */
+        if (cnak_pending) {
+                /* CNAk processing when rxfifo empty only */
+                if (readl(&dev->regs->sts) & AMD_BIT(UDC_DEVSTS_RXFIFO_EMPTY)) {
+                        udc_process_cnak_queue(dev);
+                }
+        }
+#endif       
+ 
+        return ret_val;                       
+}
+
+/**
+ * Interrupt handler for Control IN traffic  
+ *
+ * \param dev           pointer to UDC device object    
+ * \return 0 if success
+ */
+static inline int udc_control_in_isr(struct udc* dev)
+{
+        int ret_val = 0;
+        u32 tmp;
+        struct udc_ep *ep;
+        struct udc_request *req;
+        unsigned len;
+
+        ep = &dev->ep [UDC_EP0IN_IX];
+
+        /* clear irq */
+        writel(AMD_BIT(UDC_EPINT_IN_EP0), &dev->regs->ep_irqsts);
+        
+        tmp= readl(&dev->ep[UDC_EP0IN_IX].regs->sts);
+        /* DMA completion */
+        if (tmp & AMD_BIT(UDC_EPSTS_TDC)) {
+                VDBG("isr: TDC clear \n");
+#ifdef UDC_IPBUG_2253_WORKAROUND
+                /* stop NAKing after small packet DMA */
+                if (ep->naking) {
+                        /* clear NAK by writing CNAK */
+                        tmp = readl(&ep->regs->ctl);
+                        tmp |= AMD_BIT(UDC_EPCTL_CNAK); 
+                        writel(tmp, &ep->regs->ctl);
+                        ep->naking = 0;
+                        UDC_QUEUE_CNAK(ep, ep->num);
+                }
+#endif
+                /* clear TDC bit */
+                writel(AMD_BIT(UDC_EPSTS_TDC),&dev->ep[UDC_EP0IN_IX].regs->sts);
+        } /* status reg has IN bit set ? */
+        else if (tmp & AMD_BIT(UDC_EPSTS_IN)) {
+                if (ep->dma) {
+                        /* clear IN bit */
+                        writel(AMD_BIT(UDC_EPSTS_IN),&dev->ep[UDC_EP0IN_IX].regs->sts);
+                }
+                if (dev->stall_ep0in) {
+                        DBG("stall ep0in\n");
+                        /* halt ep0in */ 
+                        tmp = readl(&ep->regs->ctl);
+                        tmp |= AMD_BIT(UDC_EPCTL_S);
+                        writel(tmp, &ep->regs->ctl);
+                }
+                else {
+                        if (!list_empty (&ep->queue))
+                        {
+                                /* next request */
+                                req = list_entry (ep->queue.next,
+                                                struct udc_request, queue);
+
+                                if (ep->dma) {
+                                        /* write desc pointer */
+                                        writel(req->td_phys, &ep->regs->desptr);
+                                        /* set HOST READY */
+                                        req->td_data->status 
+                                                = AMD_ADDBITS(req->td_data->status,
+                                                                UDC_DMA_STP_STS_BS_HOST_READY,
+                                                                UDC_DMA_STP_STS_BS);
+                                        wb_flush();
+
+#ifdef UDC_IPBUG_2253_WORKAROUND
+                                        /* NAK if small packet until TDC interrupt */
+                                        if (req->req.length < UDC_SMALL_PACKET) {
+                                                /* set NAK */
+                                                tmp = readl(&ep->regs->ctl);
+                                                tmp |= AMD_BIT(UDC_EPCTL_SNAK); 
+                                                writel(tmp, &ep->regs->ctl);
+                                                ep->naking = 1;
+                                                wb_flush();
+                                        }
+#endif
+                                        /* set poll demand bit */
+                                        tmp = readl(&dev->ep[UDC_EP0IN_IX].regs->ctl);
+                                        tmp |= AMD_BIT(UDC_EPCTL_P);
+                                        writel(tmp, &dev->ep[UDC_EP0IN_IX].regs->ctl);
+
+                                        /* all bytes will be transferred */
+                                        req->req.actual = req->req.length;
+
+                                        /* complete req */
+                                        complete_req(ep, req, 0);
+
+                                }
+                                else {
+                                        /* write fifo */
+                                        udc_txfifo_write(ep, &(req->req));
+
+                                        /* lengh bytes transfered */
+                                        len = req->req.length - req->req.actual;
+                                        if (len > ep->ep.maxpacket)
+                                                len = ep->ep.maxpacket;
+
+                                        req->req.actual += len;
+                                        if (req->req.actual == req->req.length
+                                                        || (len != ep->ep.maxpacket)) {
+                                                /* && (!req->req.zero || len != ep->ep.maxpacket)) { */
+                                                /* complete req */
+                                                complete_req(ep, req, 0);
+                                        }
+                                        }
+
+                                }
+                } 
+                ep->halted = 0;
+                dev->stall_ep0in = 0;
+                if (!ep->dma) {
+                        /* clear IN bit */
+                        writel(AMD_BIT(UDC_EPSTS_IN),&dev->ep[UDC_EP0IN_IX].regs->sts);
+                }
+        }
+
+        return ret_val;
+}
+
+
+/**
+ * Interrupt handler for global device events  
+ *
+ * \param dev           pointer to UDC device object    
+ * \param dev_irq       device interrupt bit of DEVINT register    
+ * \return 0 if success
+ */
+static inline int udc_dev_isr(struct udc* dev, u32 dev_irq)
+{
+        int ret_val = 0;
+        u32 tmp;
+        u32 cfg;
+        struct udc_ep *ep;
+        u16 i;
+        u8 udc_csr_epix;
+
+        /* SET_CONFIG irq ? */
+        if (dev_irq & AMD_BIT(UDC_DEVINT_SC)) {
+
+                /* read config value */
+                tmp = readl(&dev->regs->sts);
+                cfg = AMD_GETBITS(tmp, UDC_DEVSTS_CFG);
+#ifdef UDC_DEBUG
+                /* this is needed for debug only */
+                if (cfg == dev->cur_config) {
+                        same_cfg = 1;
+                }
+                else {
+                        same_cfg = 0;
+                }
+                VDBG("same_cfg=%d\n", same_cfg);
+#endif
+                DBG("SET_CONFIG interrupt: config=%d\n", cfg);
+                dev->cur_config = cfg;
+                dev->set_cfg_not_acked = 1;
+
+                /* make usb request for gadget driver */
+                memset(&setup_data, 0 , sizeof(union udc_setup_data));
+                setup_data.request.bRequest = USB_REQ_SET_CONFIGURATION;
+                setup_data.request.wValue = dev->cur_config;
+
+                /* programm the NE registers */
+                /* TODO - put this to extra function or use udc_setup_endpoints() or udc_enable() */
+                for (i = 0; i < UDC_EP_NUM; i++) {
+                        ep = &dev->ep[i];
+                        if (ep->in) {
+                                
+                                /* ep ix in UDC CSR register space */
+                                udc_csr_epix = ep->num;
+
+                                
+                        } /* OUT ep */
+                        else {
+                                /* ep ix in UDC CSR register space */
+                                udc_csr_epix = ep->num - UDC_CSR_EP_OUT_IX_OFS;
+                        }
+
+                        tmp = readl(&dev->csr->ne[udc_csr_epix]);
+                        /* ep cfg */
+                        tmp = AMD_ADDBITS(tmp, ep->dev->cur_config, UDC_CSR_NE_CFG);
+                        /* write reg */
+                        writel(tmp, &dev->csr->ne[udc_csr_epix]);
+
+                        /* clear stall bits */
+                        ep->halted = 0;
+                        tmp = readl(&ep->regs->ctl);
+                        tmp = tmp & AMD_CLEAR_BIT(UDC_EPCTL_S);
+                        writel(tmp, &ep->regs->ctl);
+                }
+                /* call gadget zero with setup data received */
+                spin_unlock (&dev->lock);
+                tmp = dev->driver->setup (&dev->gadget, &setup_data.request);
+                spin_lock (&dev->lock);
+
+        } /* SET_INTERFACE ? */
+        if (dev_irq & AMD_BIT(UDC_DEVINT_SI)) {
+                dev->set_cfg_not_acked = 1;
+                /* read interface and alt setting values */
+                tmp = readl(&dev->regs->sts);
+                dev->cur_alt = AMD_GETBITS(tmp, UDC_DEVSTS_ALT);
+                dev->cur_intf = AMD_GETBITS(tmp, UDC_DEVSTS_INTF);
+                                      
+                /* make usb request for gadget driver */
+                memset(&setup_data, 0 , sizeof(union udc_setup_data));
+                setup_data.request.bRequest = USB_REQ_SET_INTERFACE;
+                setup_data.request.bRequestType = USB_RECIP_INTERFACE;
+                setup_data.request.wValue = dev->cur_alt;
+                setup_data.request.wIndex = dev->cur_intf;
+                
+                DBG("SET_INTERFACE interrupt: alt=%d intf=%d\n", dev->cur_alt, dev->cur_intf);
+
+                /* programm the NE registers */
+                /* TODO - put this to extra function or use udc_setup_endpoints() or udc_enable() */
+                for (i = 0; i < UDC_EP_NUM; i++) {
+                        ep = &dev->ep[i];
+                        if (ep->in) {
+                                
+                                /* ep ix in UDC CSR register space */
+                                udc_csr_epix = ep->num;
+
+                                
+                        } /* OUT ep */
+                        else {
+                                /* ep ix in UDC CSR register space */
+                                udc_csr_epix = ep->num - UDC_CSR_EP_OUT_IX_OFS;
+                        }
+
+                        /***** UDC CSR reg ****************************/
+                        /* set ep values  */
+                        tmp = readl(&dev->csr->ne[udc_csr_epix]);
+                        /* ep interface */
+                        tmp = AMD_ADDBITS(tmp, ep->dev->cur_intf, UDC_CSR_NE_INTF);
+                        /* tmp = AMD_ADDBITS(tmp, 2, UDC_CSR_NE_INTF); */
+                        /* ep alt */
+                        tmp = AMD_ADDBITS(tmp, ep->dev->cur_alt, UDC_CSR_NE_ALT);
+                        /* tmp = AMD_ADDBITS(tmp, 1, UDC_CSR_NE_ALT); */
+                        /* write reg */
+                        writel(tmp, &dev->csr->ne[udc_csr_epix]);
+
+                        /* clear stall bits */
+                        ep->halted = 0;
+                        tmp = readl(&ep->regs->ctl);
+                        tmp = tmp & AMD_CLEAR_BIT(UDC_EPCTL_S);
+                        writel(tmp, &ep->regs->ctl);
+                }
+
+                /* call gadget zero with setup data received */
+                spin_unlock (&dev->lock);
+                tmp = dev->driver->setup (&dev->gadget, &setup_data.request);
+                spin_lock (&dev->lock);
+
+        } /* USB reset */
+        if (dev_irq & AMD_BIT(UDC_DEVINT_UR)) {
+                DBG("USB Reset interrupt\n");
+
+                /* allow soft reset when suspend occurs */
+                soft_reset_occured = 0;
+
+                dev->waiting_zlp_ack_ep0in = 0;
+                dev->set_cfg_not_acked = 0;
+
+                /* mask not needed interrupts */
+                udc_mask_unused_interrupts(dev);
+
+                /* call gadget to reset configs etc. */
+                spin_unlock(&dev->lock);
+                dev->driver->disconnect(&dev->gadget);
+                spin_lock(&dev->lock);
+
+                /* disable ep0 to empty req queue */
+                empty_req_queue (&dev->ep [UDC_EP0IN_IX]);
+                ep_init(dev->regs,
+                          &dev->ep [UDC_EP0IN_IX]);
+
+#ifdef UDC_IPBUG_3958_WORKAROUND_SOFT_RESET_ON_USBRESET
+                /* soft reset when rxfifo not empty */
+                tmp = readl(&dev->regs->sts);
+                if (!(tmp & AMD_BIT(UDC_DEVSTS_RXFIFO_EMPTY)) && 
+                    !soft_reset_after_usbreset_occured) {
+                        udc_soft_reset(dev);
+                        soft_reset_after_usbreset_occured++;
+                } 
+#endif
+
+                /* DMA reset to kill potential old DMA hw hang, */
+                /* POLL bit is already reset by ep_init() through */
+                /* disconnect() */
+                UDC_DMARST(tmp,dev);
+                
+                /* put into initial config */
+                udc_basic_init (dev);
+
+                /* enable device setup interrupts */
+                udc_enable_dev_setup_interrupts(dev);
+
+        } /* USB suspend */
+#ifndef UDC_IPBUG_3943_WORKAROUND
+        if (dev_irq & AMD_BIT(UDC_DEVINT_US)) {
+                DBG("USB Suspend interrupt\n");
+
+        } /* new speed ? */
+#endif
+        if (dev_irq & AMD_BIT(UDC_DEVINT_ENUM)) {
+                DBG("ENUM interrupt\n");
+#ifdef UDC_DEBUG
+                num_enums++;
+                DBG("%d enumerations !\n", num_enums);
+#endif
+                soft_reset_after_usbreset_occured = 0;
+
+                /* disable ep0 to empty req queue */
+                empty_req_queue (&dev->ep [UDC_EP0IN_IX]);
+                ep_init (dev->regs,
+                          &dev->ep [UDC_EP0IN_IX]);
+
+                /* link up all endpoints */
+                udc_setup_endpoints (dev);
+                if (dev->gadget.speed == USB_SPEED_HIGH) {
+                        INFO("Connect: Speed = HIGH_SPEED\n");
+                }
+                else if (dev->gadget.speed == USB_SPEED_FULL) {
+                        INFO("Connect: Speed = FULL_SPEED\n");
+                }
+
+                /* init ep 0 */
+                activate_control_endpoints(dev);
+
+                /* enable ep0 interrupts */
+                udc_enable_ep0_interrupts(dev);
+        }
+#ifndef UDC_IPBUG_3950_WORKAROUND 
+        /* session valid change interrupt */
+        if (dev_irq & AMD_BIT(UDC_DEVINT_SVC)) {
+                DBG("USB SVC interrupt\n");
+
+                /* check that session is not valid to detect disconnect */
+                tmp = readl(&dev->regs->sts);
+                if (!(tmp & AMD_BIT(UDC_DEVSTS_SESSVLD))) {
+                        DBG("USB Disconnect (session valid low)\n");
+                        /* cleanup on disconnect */
+                        usb_disconnect(udc);
+                }
+
+        }
+#endif
+
+        return ret_val;
+}
+
+/**
+ * Interrupt Service Routine, see Linux Kernel Doc for parameters  
+ *
+ * \param irq           irq number
+ * \param pdev          pointer to device object
+ * \param ptregs        don't used
+ */
+static irqreturn_t udc_irq (int irq, void *pdev, struct pt_regs * ptregs)
+{
+        struct udc *dev = pdev;
+        u32 reg;
+        u16 i;
+        u32 ep_irq;
+
+
+#ifdef UDC_IPBUG_3943_WORKAROUND
+        /* If UDC is suspended, then don't touch any register, otherwise
+           system hangs in endless retry => possibly hang !!! */
+        if (dev->otg_driver && dev->otg_driver->query) {
+                if (dev->otg_driver->query(0) & OTG_FLAGS_UDC_SUSP) {
+                        return IRQ_HANDLED;
+                }     
+        }
+        else
+                return IRQ_HANDLED;
+#endif 
+       
+        if (dev->sys_suspended)
+                return IRQ_HANDLED;
+
+        spin_lock (&dev->lock);
+
+
+        /* check for ep irq */
+        reg = readl(&dev->regs->ep_irqsts);
+        if (reg)
+        {
+                /* EP0 OUT */
+                if (reg & AMD_BIT(UDC_EPINT_OUT_EP0))
+                {
+                        udc_control_out_isr(dev);
+                } /* EP0 IN */
+                if (reg & AMD_BIT(UDC_EPINT_IN_EP0)) {
+                        udc_control_in_isr(dev);
+                        
+                } 
+
+                /* data endpoint */
+                /* iterate ep's */
+                for (i = 1; i < UDC_EP_NUM; i++) {
+                        ep_irq = 1 << i;
+                        /* irq for out ep ? */
+                        if ((reg & ep_irq) && i > UDC_EPIN_NUM) {      
+                                /* clear irq */
+                                writel(ep_irq, &dev->regs->ep_irqsts);
+                                udc_data_out_isr(dev,i);
+                        } /* irq for in ep ? */
+                        if ((reg & ep_irq) && i < UDC_EPIN_NUM && i > 0) {      
+                                /* clear irq */
+                                writel(ep_irq, &dev->regs->ep_irqsts);
+                                udc_data_in_isr(dev,i);
+                        }
+                        
+                }
+                                          
+        }
+
+
+        /* check for dev irq */
+        reg = readl(&dev->regs->irqsts);
+        if (reg) {
+                /* clear irq */
+                writel(reg, &dev->regs->irqsts);
+                udc_dev_isr(dev, reg);
+        }
+  
+
+        spin_unlock (&dev->lock);
+        return IRQ_HANDLED;
+}
+
+/**
+ * Tears down device 
+ *
+ * \param pdev        pointer to device struct
+ */
+static void gadget_release (struct device *pdev)
+{
+        struct au1200udc *dev = dev_get_drvdata(pdev);
+        kfree (dev);
+}
+
+/**
+ * Cleanup on device remove
+ *
+ * \param dev        pointer to udc struct
+ */
+static void udc_remove(struct udc* dev)
+{
+#ifdef CONFIG_SOC_AU1200 
+        {
+                u32 tmp;
+                /* disable UDC memory, DMA and clock */
+                tmp = readl((u32*) (USB_MSR_BASE + USB_MSR_MCFG));
+                tmp &= AMD_CLEAR_BIT(USBMSRMCFG_DMEMEN)
+                       & AMD_CLEAR_BIT(USBMSRMCFG_DBMEN) 
+                       & AMD_CLEAR_BIT(USBMSRMCFG_UDCCLKEN);
+                writel(tmp, USB_MSR_BASE + USB_MSR_MCFG); 
+        }
+#endif
+
+#if     defined(CONFIG_SOC_AU1200)
+        /* done by gadget.dev.release() in kernel 2.6.x 
+         * TMP26: device registration currently disabled for Au1200 */
+        kfree (dev);
+#endif
+#ifdef UDC_USE_TIMER
+        /* remove timer */
+        stop_timer++;
+        if (timer_pending(&udc_timer))
+                wait_for_completion(&on_exit);
+	if (udc_timer.data)
+		del_timer_sync(&udc_timer);
+        /* remove pollstall timer */
+        stop_pollstall_timer++;
+        if (timer_pending(&udc_pollstall_timer))
+                wait_for_completion(&on_pollstall_exit);
+	if (udc_pollstall_timer.data)
+		del_timer_sync(&udc_pollstall_timer);
+#endif
+        udc = 0;
+}
+
+#if   defined(CONFIG_SOC_AU1200)
+/**
+ * Reset all context
+ *
+ * \param pdev        pointer to device struct
+ */
+static void udc_drv_remove (struct device *_dev)
+{
+	struct platform_device *pdev = to_platform_device(_dev);
+	struct udc *dev = dev_get_drvdata (_dev);
+
+#ifdef UDC_DEBUG
+        /* debug */
+        print_misc(dev);
+#endif
+        /* gadget driver registered ? */
+        if (dev->driver) {
+                WARN( "unregistering %s on driver remove\n", dev->driver->driver.name);
+                usb_gadget_unregister_driver (dev->driver);
+        }
+        /* otg driver registered ? */
+        if (dev->otg_transceiver) {
+                /* should have been done already by driver model core */
+                WARN( "uoc driver is still registered\n");
+        }
+        /* dma pool cleanup */
+        if (dev->data_requests) {
+                dma_pool_destroy (dev->data_requests);
+        }
+        if (dev->stp_requests) {
+                /* cleanup DMA desc's for ep0in */
+                dma_pool_free (dev->stp_requests,
+                               dev->ep [UDC_EP0OUT_IX].td_stp,
+                               dev->ep [UDC_EP0OUT_IX].td_stp_dma);
+                dma_pool_free (dev->stp_requests,
+                               dev->ep [UDC_EP0OUT_IX].td,
+                               dev->ep [UDC_EP0OUT_IX].td_phys);
+
+                dma_pool_destroy (dev->stp_requests);
+        }
+
+        /* init controller by soft reset */
+        writel(AMD_BIT(UDC_DEVCFG_SOFTRESET), &dev->regs->cfg);
+
+        if (dev->irq_registered)
+                free_irq (pdev->resource[1].start, dev);
+        if (dev->regs)
+                iounmap (dev->regs);
+        if (dev->mem_region)
+                release_mem_region (pdev->resource[0].start,
+                                    pdev->resource[0].end + 1
+                                    - pdev->resource[0].start);
+
+        device_unregister (&dev->gadget.dev);
+        /* device_remove_file (&pdev->dev, &dev_attr_registers); */
+        dev_set_drvdata (_dev, 0);
+
+        udc_remove(dev);
+}
+#endif
+
+#if   !defined(CONFIG_SOC_AU1200)
+/**
+ * Reset all pci context
+ *
+ * \param pdev        pointer to pci device struct
+ */
+static void udc_pci_remove (struct pci_dev *pdev)
+{
+        struct udc              *dev;
+
+        dev = pci_get_drvdata(pdev);
+#ifdef UDC_DEBUG
+        /* debug */
+        print_misc(dev);
+#endif
+        /* gadget driver registered ? */
+        if (dev->driver) {
+                WARN( "unregistering %s on pci remove\n", dev->driver->driver.name);
+                usb_gadget_unregister_driver (dev->driver);
+        }
+        /* otg driver registered ? */
+        if (dev->otg_transceiver) {
+                /* should have been done already by driver model core */
+                WARN( "uoc driver is still registered\n");
+        }
+        /* dma pool cleanup */
+        if (dev->data_requests) {
+                dma_pool_destroy (dev->data_requests);
+        }
+        if (dev->stp_requests) {
+                /* cleanup DMA desc's for ep0in */
+                dma_pool_free (dev->stp_requests,
+                               dev->ep [UDC_EP0OUT_IX].td_stp,
+                               dev->ep [UDC_EP0OUT_IX].td_stp_dma);
+                dma_pool_free (dev->stp_requests,
+                               dev->ep [UDC_EP0OUT_IX].td,
+                               dev->ep [UDC_EP0OUT_IX].td_phys);
+
+                dma_pool_destroy (dev->stp_requests);
+        }
+
+        /* init controller by soft reset */
+        writel(AMD_BIT(UDC_DEVCFG_SOFTRESET), &dev->regs->cfg);
+        if (dev->irq_registered)
+                free_irq (pdev->irq, dev);
+        if (dev->regs)
+                iounmap (dev->regs);
+        if (dev->mem_region)
+                release_mem_region (pci_resource_start (pdev, 0),
+                                pci_resource_len (pdev, 0));
+#ifndef USE_AU1200_PCI_DUMMY
+        if (dev->active)
+                pci_disable_device (pdev);
+#endif
+
+        /* device file system not working for Au1200 */
+        device_unregister (&dev->gadget.dev);
+        /* device_remove_file (&pdev->dev, &dev_attr_registers); */
+        pci_set_drvdata (pdev,0);
+
+        udc_remove(dev);
+}
+#endif
+
+/**
+ * create dma pools on init  
+ *
+ * \param dev   pointer to udc device struct
+ * \return 0 if success
+ */
+__init static int init_dma_pools(struct udc* dev)
+{
+        struct udc_stp_dma      *td_stp;
+        struct udc_data_dma     *td_data;
+        int retval;
+
+        /* consistent DMA mode setting ? */
+        if (use_dma_ppb) {
+                use_dma_bufferfill_mode = 0;
+        }
+        else {
+                use_dma_ppb_du = 0;
+                use_dma_bufferfill_mode = 1;
+        }
+
+        /* DMA setup */
+        dev->data_requests = dma_pool_create ("data_requests", NULL,
+                sizeof (struct udc_data_dma),
+                UDC_PCIPOOL_ALIGN,
+                UDC_PCIPOOL_CROSS);
+        if (!dev->data_requests) {
+                DBG( "can't get request data pool\n");
+                retval = -ENOMEM;
+                goto finished;
+        }
+
+        /* EP0 in dma regs = dev control regs */        
+        dev->ep[UDC_EP0IN_IX].dma = &dev->regs->ctl;       
+
+        /* dma desc for setup data */
+        dev->stp_requests = dma_pool_create ("setup requests", NULL,
+                sizeof (struct udc_stp_dma),
+                UDC_PCIPOOL_ALIGN,
+                UDC_PCIPOOL_CROSS);
+        if (!dev->stp_requests) {
+                DBG( "can't get stp request pool\n");
+                retval = -ENOMEM;
+                goto finished;
+        }
+        /* setup */
+        td_stp = dma_pool_alloc (dev->stp_requests, UDC_PCIPOOL_GFP_STP,
+                                &dev->ep [UDC_EP0OUT_IX].td_stp_dma);
+        if (td_stp == NULL){
+                retval = -ENOMEM;
+                goto finished;
+        }
+        dev->ep [UDC_EP0OUT_IX].td_stp = td_stp;
+        /* data: 0 packets !? */
+        td_data = dma_pool_alloc (dev->stp_requests, UDC_PCIPOOL_GFP_STP,
+                                &dev->ep [UDC_EP0OUT_IX].td_phys);
+        if (td_data == NULL){
+                retval = -ENOMEM;
+                goto finished;
+        }
+        dev->ep [UDC_EP0OUT_IX].td = td_data;
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+        /* point to itself */
+        dev->ep [UDC_EP0OUT_IX].td->next = dev->ep [UDC_EP0OUT_IX].td_phys;
+#endif
+        return 0;
+
+finished:
+        return retval;
+}
+
+#if   defined(CONFIG_SOC_AU1200)
+/**
+ * Called by kernel  init device context
+ *
+ * \param dev        pointer to device struct
+ * \return 0 if success
+ */
+static int udc_drv_probe (struct device* _dev)
+{
+        char                    tmp[8];
+        struct udc              *dev;
+	struct platform_device *pdev = to_platform_device(_dev);
+	u32                     resource;
+        u32                     len;
+        u32                     irq;
+        int                     retval = 0;
+#ifdef CONFIG_SOC_AU1200
+        u32                     reg;
+
+        /* basic init */
+        reg = readl((u32*) (USB_MSR_BASE + USB_MSR_MCFG));
+        if (reg == 0) {
+                /* default value */
+                reg = USBMSRMCFG_DEFAULT;        
+                writel(reg, USB_MSR_BASE + USB_MSR_MCFG); 
+                readl((u32*) USB_MSR_BASE + USB_MSR_MCFG); 
+                udelay(1000);
+        }
+        /* enable UDC memory, DMA, clock, cacheable memory,
+         * read combining and prefetch enable */
+        reg |= AMD_BIT(USBMSRMCFG_DMEMEN) | AMD_BIT(USBMSRMCFG_DBMEN)
+                | AMD_BIT(USBMSRMCFG_UDCCLKEN)
+                | AMD_BIT(USBMSRMCFG_PHYPLLEN)
+#ifdef CONFIG_DMA_COHERENT
+                | AMD_BIT(USBMSRMCFG_UCAM)
+#endif
+                | AMD_BIT(USBMSRMCFG_RDCOMB)
+                | AMD_BIT(USBMSRMCFG_PFEN);
+        writel(reg, USB_MSR_BASE + USB_MSR_MCFG); 
+#endif
+
+        /* one udc only */
+        if (udc) {
+                WARN("already probed: %04x/%04x\n", UDC_PCI_VENID, UDC_PCI_DEVID);
+                return -EBUSY;
+        }
+
+        /* init */
+        dev = kmalloc (sizeof (struct udc), SLAB_KERNEL);
+        if (!dev) {
+                retval = -ENOMEM;
+                goto finished;
+        }
+        memset (dev, 0, sizeof(struct udc));
+
+	dev->pdev = _dev;
+
+        /* check platform resources */
+	if (pdev->resource[0].flags != IORESOURCE_MEM) {
+		ERR ("resource[0] must be IORESOURCE_MEM\n");
+		retval = -ENOMEM;
+		goto finished;
+	}
+	resource = pdev->resource[0].start;
+	len = pdev->resource[0].end + 1 - pdev->resource[0].start;
+	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+		ERR ("resource[1] must be IORESOURCE_IRQ\n");
+		retval = -ENOMEM;
+		goto finished;
+	}
+	irq = pdev->resource[1].start;
+
+        /* platform device resource allocation */
+        /* mem */
+	if (!request_mem_region (resource, len, name)) {
+		ERR ("controller already in use\n");
+		retval = -EBUSY;
+		goto finished;
+	}
+	dev->mem_region = 1;
+
+        dev->virt_addr = ioremap_nocache(resource, len);
+        if (dev->virt_addr == NULL) {
+                DBG( "start address cannot be mapped\n");
+                retval = -EFAULT;
+                goto finished;
+        }
+
+        /* irq */
+        if (!irq) {
+                ERR( "irq not set\n");
+                retval = -ENODEV;
+                goto finished;
+        }
+        snprintf (tmp, sizeof tmp, "%d", irq);
+        if (request_irq (irq, udc_irq, SA_SHIRQ, name, dev) != 0) {
+                ERR( "error on request_irq() with %s\n", tmp);
+                retval = -EBUSY;
+                goto finished;
+        }
+        dev->irq_registered = 1;
+
+        dev_set_drvdata (_dev, dev);
+
+        /* chip revision */
+        dev->chiprev = 0;
+
+        /* chip rev for Au1200 */
+        dev->chiprev = (u16) read_c0_prid() & 0xff;
+
+        /* init dma pools */
+        if (use_dma) {
+                retval = init_dma_pools(dev);
+                if (retval != 0)
+                        goto finished; 
+        }
+
+        dev->phys_addr = resource;
+        dev->irq = irq;
+        dev->gadget.dev.parent = _dev;
+        dev->gadget.dev.dma_mask = _dev->dma_mask;
+        /* general probing */
+        if (udc_probe(dev) != 0)
+                goto finished;
+        return retval;        
+
+finished:
+        if (dev)
+                udc_drv_remove (_dev);
+        return retval;
+}
+#endif
+
+#if  !defined(CONFIG_SOC_AU1200)
+/**
+ * Called by pci bus driver to init pci context
+ *
+ * \param pdev        pointer to pci device struct
+ * \param id          pointer to pci device id
+ * \return 0 if success
+ */
+static int udc_pci_probe (struct pci_dev *pdev, const struct pci_device_id *id)
+{
+        char                    tmp[8];
+        struct udc              *dev;
+        unsigned long           resource;
+        unsigned long           len;
+        int retval = 0;;
+
+        VDBG("udc_pci_probe()\n");
+
+#ifdef CONFIG_SOC_AU1200
+        {
+                u32     tmp;
+                /*
+                 * Fill in the dummy pci_dev
+                 */
+                memset(pdev, 0, sizeof(struct pci_dev));
+                pdev->resource[0].name = "UDC Registers";
+                pdev->resource[0].start = USB_UDC_BASE;
+                pdev->resource[0].end = USB_UDC_BASE + USB_UDC_LEN - 1;
+                pdev->resource[0].flags = 0;
+                pdev->irq = AU1200_USB_INT;
+
+                tmp = readl((u32*) (USB_MSR_BASE + USB_MSR_MCFG));
+                if (tmp == 0) {
+                        /* default value */
+                        tmp = USBMSRMCFG_DEFAULT;        
+                        writel(tmp, USB_MSR_BASE + USB_MSR_MCFG); 
+                        readl((u32*) USB_MSR_BASE + USB_MSR_MCFG); 
+                        udelay(1000);
+                }
+                /* enable UDC memory, DMA, clock, cacheable memory,
+                 * read combining and prefetch enable */
+                tmp |= AMD_BIT(USBMSRMCFG_DMEMEN) | AMD_BIT(USBMSRMCFG_DBMEN)
+                        | AMD_BIT(USBMSRMCFG_UDCCLKEN)
+                        | AMD_BIT(USBMSRMCFG_PHYPLLEN)
+#ifdef CONFIG_DMA_COHERENT
+                        | AMD_BIT(USBMSRMCFG_UCAM)
+#endif
+                        | AMD_BIT(USBMSRMCFG_RDCOMB)
+                        | AMD_BIT(USBMSRMCFG_PFEN);
+                writel(tmp, USB_MSR_BASE + USB_MSR_MCFG); 
+        }
+#endif
+        /* one udc only */
+        if (udc) {
+                WARN("already probed: %04x/%04x\n", UDC_PCI_VENID, UDC_PCI_DEVID);
+                return -EBUSY;
+        }
+
+        /* init */
+        dev = kmalloc (sizeof (struct udc), SLAB_KERNEL);
+        if (!dev) {
+                retval = -ENOMEM;
+                goto finished;
+        }
+        memset (dev, 0, sizeof(struct udc));
+
+        /* pci setup */
+#ifndef USE_AU1200_PCI_DUMMY
+        if (pci_enable_device (pdev) < 0) {
+                retval = -ENODEV;
+                goto finished;
+        }
+#endif
+        dev->active = 1;
+
+        /* PCI resource allocation */
+        resource = pci_resource_start(pdev, 0);
+        len = pci_resource_len (pdev, 0);
+
+        if (!request_mem_region (resource, len, name)) {
+                DBG( "pci device used already\n");
+                retval = -EBUSY;
+                goto finished;
+        }
+        dev->mem_region = 1;
+
+        dev->virt_addr = ioremap_nocache(resource, len);
+        if (dev->virt_addr == NULL) {
+                DBG( "start address cannot be mapped\n");
+                retval = -EFAULT;
+                goto finished;
+        }
+
+        if (!pdev->irq) {
+                ERR( "pdev->irq not set\n");
+                retval = -ENODEV;
+                goto finished;
+        }
+
+        snprintf (tmp, sizeof tmp, "%d", pdev->irq);
+
+        if (request_irq (pdev->irq, udc_irq, SA_SHIRQ, name, dev) != 0) {
+                ERR( "error on request_irq() with %s\n", tmp);
+                retval = -EBUSY;
+                goto finished;
+        }
+        dev->irq_registered = 1;
+
+        pci_set_drvdata (pdev, dev);
+
+        /* chip revision */
+        dev->chiprev = 0;
+
+#ifndef CONFIG_SOC_AU1200 
+        pci_set_master (pdev);
+#ifdef  HAVE_PCI_SET_MWI
+        pci_set_mwi (pdev);
+#endif
+        /* chip rev for Hs AU1200 */
+        pci_read_config_byte(pdev, PCI_REVISION_ID, (u8*) &dev->chiprev);
+#else
+        /* chip rev for Au1200 */
+        dev->chiprev = (u16) read_c0_prid() & 0xff;
+#endif
+        /* init dma pools */
+        if (use_dma) {
+                retval = init_dma_pools(dev);
+                if (retval != 0)
+                        goto finished; 
+        }
+
+        dev->phys_addr = resource;
+        dev->irq = pdev->irq;
+        dev->pdev = pdev;
+        dev->gadget.dev.parent = &pdev->dev;
+        dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
+
+        /* general probing */
+        if (udc_probe(dev) != 0)
+                goto finished;
+        return retval;        
+
+finished:
+        if (dev)
+                udc_pci_remove (pdev);
+        return retval;
+}
+#endif
+
+/**
+ * general probe
+ *
+ * \param dev   pointer to udc device struct
+ * \return 0 if success
+ */
+__init int udc_probe(struct udc* dev)
+{
+        char                    tmp[128];
+	u32 reg;
+        int retval;
+
+	/* mark timer as not initialized */
+        udc_timer.data = 0;
+        udc_pollstall_timer.data = 0;
+	
+        /* device struct setup */
+        spin_lock_init(&dev->lock);
+        spin_lock_init(&udc_irq_spinlock);
+        spin_lock_init(&udc_stall_spinlock);
+        dev->gadget.ops = &udc_ops;
+
+        strcpy(dev->gadget.dev.bus_id, "gadget");
+        dev->gadget.dev.release = gadget_release;
+        dev->gadget.name = name;
+	dev->gadget.is_dualspeed = 1;
+
+        /* udc csr registers base */
+        dev->csr = (struct udc_csrs*) (dev->virt_addr + UDC_CSR_ADDR);
+        /* dev registers base */
+        dev->regs = (struct udc_regs *) (dev->virt_addr + UDC_DEVCFG_ADDR);                
+        /* ep registers base */
+        dev->ep_regs = (struct udc_ep_regs *) (dev->virt_addr + UDC_EPREGS_ADDR);                
+        /* fifo's base */
+        dev->rxfifo = (u32*) (dev->virt_addr + UDC_RXFIFO_ADDR);                
+        dev->txfifo = (u32*) (dev->virt_addr + UDC_TXFIFO_ADDR);                
+
+        /* init registers, interrupts, ... */
+#ifndef UDC_IPBUG_3943_WORKAROUND
+        startup_registers(dev);
+#else
+        {
+                u32 tmp;
+
+                /* TODO put this to extra function,
+                 * this all is extracted from usb_init() and
+                 * udc_basic_init() but without register access */
+                dev->gadget.ep0 = &dev->ep [UDC_EP0IN_IX].ep;
+                dev->ep [UDC_EP0IN_IX].halted = 0;
+                INIT_LIST_HEAD (&dev->gadget.ep0->ep_list);
+                dev->gadget.speed = USB_SPEED_HIGH;
+                make_ep_lists(dev);
+                /* basic endpoint init */
+                for (tmp = 0; tmp < UDC_EP_NUM; tmp++) {
+                        struct udc_ep   *ep = &dev->ep[tmp];
+
+                        ep->ep.name = ep_string[tmp];
+                        ep->dev = dev;
+                        ep->num = tmp;
+                        /* txfifo size is calculated at enable time */
+                        ep->txfifo = dev->txfifo;
+
+                        /* fifo size */
+                        if (tmp < UDC_EPIN_NUM) {
+                                ep->fifo_depth = UDC_TXFIFO_SIZE;
+                                ep->in = 1;
+                        }
+                        else {
+                                ep->fifo_depth = UDC_RXFIFO_SIZE;
+                                ep->in = 0;
+
+                        }
+
+                        ep->regs = &dev->ep_regs [tmp];
+                        if (!ep->desc) {
+                                ep->desc = 0;
+                                INIT_LIST_HEAD (&ep->queue);
+
+                                ep->ep.maxpacket = ~0;
+                                ep->ep.ops = &udc_ep_ops;
+                        }
+                        if (use_dma) {
+                                /* ep->dma is not really used, just to indicate that */
+                                /* DMA is active */
+                                /* dma regs = dev control regs */        
+                                ep->dma = (u32*) &dev->regs->ctl;       
+                        }
+                }
+                dev->ep [UDC_EP0IN_IX].ep.maxpacket = UDC_EP0IN_MAX_PKT_SIZE;
+                dev->ep [UDC_EP0OUT_IX].ep.maxpacket = UDC_EP0OUT_MAX_PKT_SIZE;
+        }
+#endif
+
+
+        INFO( "%s\n", mod_desc);
+
+        snprintf (tmp, sizeof tmp, "%d", dev->irq);
+#ifdef CONFIG_SOC_AU1200
+        INFO( "irq %s, mem %08lx, chip rev %02x (Au1200 %s)\n",
+                        tmp, dev->phys_addr, dev->chiprev, (dev->chiprev == 0) ? "AB" : "AC");
+        strcpy(tmp, UDC_DRIVER_VERSION_STRING);
+#ifdef CONFIG_DMA_COHERENT
+        /* coherent DMA not possible with AB silicon */
+        if (dev->chiprev == UDC_AUAB_REV) {
+                ERR("Your chip revision is %s, it must be at least %s to use coherent DMA. \nPlease change DMA_COHERENT to DMA_NONCOHERENT in arch/mips/Kconfig and re-compile .\n",
+                    "AB", "AC");
+                retval = -ENODEV;
+                goto finished;
+        }
+#endif
+        
+#ifdef UDC_AUA1
+        if (dev->chiprev < UDC_AUA1) {
+                ERR("Your chip revision is %s, it must be at least %s\n",
+                    "AB", "AC");
+                retval = -ENODEV;
+                goto finished;
+        }
+        INFO("driver version: %s (for Au1200 AC)\n", tmp);
+#else
+        INFO("driver version: %s (for Au1200 AB)\n", tmp);
+#endif
+#ifdef CONFIG_DMA_COHERENT
+        INFO("Compiled for coherent memory.\n");
+#endif
+#ifdef CONFIG_DMA_NONCOHERENT
+        INFO("Compiled for non-coherent memory.\n");
+#endif
+#else
+        INFO("irq %s, pci mem %08lx, chip rev %02x (Geode5536 %s)\n",
+              tmp, dev->phys_addr, dev->chiprev, (dev->chiprev == UDC_HSA0_REV) ? "A0" : "B1");
+        strcpy(tmp, UDC_DRIVER_VERSION_STRING);
+#ifdef UDC_HSB1
+        if (dev->chiprev == UDC_HSA0_REV) {
+                ERR("Your chip revision is %s, it must be at least %s\n",
+                    "A0", "B1");
+                retval = -ENODEV;
+                goto finished;
+        }
+        INFO("driver version: %s (for Geode5536 B1)\n", tmp);
+#else
+        INFO("driver version: %s (for Geode5536 A0)\n", tmp);
+#endif
+#endif
+        udc = dev;
+
+        device_register (&dev->gadget.dev);
+        /* device_create_file (&pdev->dev, &dev_attr_registers); */
+
+#ifdef UDC_USE_TIMER
+        /* timer init */
+        init_timer(&udc_timer);
+        udc_timer.function = udc_timer_function;
+        udc_timer.data = 1;
+        /* timer pollstall init */
+        init_timer(&udc_pollstall_timer);
+        udc_pollstall_timer.function = udc_pollstall_timer_function;
+        udc_pollstall_timer.data = 1;
+#endif
+
+        /* set SD */
+        reg = readl(&dev->regs->ctl);
+        reg |= AMD_BIT(UDC_DEVCTL_SD);
+        writel(reg, &dev->regs->ctl);
+
+        /* print dev register info */
+        print_regs(dev);
+
+        return 0;
+
+finished:
+        return retval;
+}
+
+
+/**
+ *  Initiates a remote wakeup 
+ *
+ * \return 0 if success
+ */
+/* initiate remote wakeup */
+static int udc_remote_wakeup(struct udc* dev)
+{
+        u32 tmp;
+
+        INFO("UDC initiates remote wakeup\n");
+        
+        tmp =  readl(&dev->regs->ctl);
+        tmp |= AMD_BIT(UDC_DEVCTL_RES);
+        writel(tmp, &dev->regs->ctl);                     
+        /* wait 1ms before clear resume bit */
+        /* udelay(1000); */
+        tmp &= AMD_CLEAR_BIT(UDC_DEVCTL_RES);
+        writel(tmp, &dev->regs->ctl);                     
+
+        return 0;
+}
+
+#if   defined(CONFIG_SOC_AU1200)
+/**
+ *  Suspends UDC 
+ *
+ * \return 0 if success
+ */
+static int udc_suspend(struct udc* dev)
+{
+        int retval = 0;
+
+        INFO("UDC suspend\n");
+#ifdef CONFIG_SOC_AU1200
+        u32 tmp;
+        /* mask interrupts */
+        udc_mask_unused_interrupts(dev);
+
+        if (dev->driver && dev->driver->disconnect) {
+                /* call gadget to reset context */
+                if (spin_is_locked(&dev->lock)) {
+                        spin_unlock(&dev->lock);
+                        dev->driver->disconnect (&dev->gadget);
+                        spin_lock(&dev->lock);
+                }
+                else
+                        dev->driver->disconnect (&dev->gadget);
+
+                /* disable ep0 to empty req queue */
+                empty_req_queue (&dev->ep [UDC_EP0IN_IX]);
+                ep_init (dev->regs,
+                          &dev->ep [UDC_EP0IN_IX]);
+
+                /* init controller by soft reset */
+                udc_soft_reset(dev);
+
+        }
+        if (dev->otg_driver && dev->otg_transceiver 
+            && dev->otg_transceiver->set_peripheral) {
+                /* if UDC is supended by Host or already disconnected then
+                   don't force disconnect by unbind() */
+                if (dev->otg_driver->query) {
+                        if (!(dev->otg_driver->query(0) & OTG_FLAGS_UDC_SUSP)) {
+                                /* unbind from otg driver -> host disconnect */
+                                dev->otg_transceiver->set_peripheral(dev->otg_transceiver, NULL);
+                                dev->connected = 0;
+                        }
+                }
+                else
+                {
+                        /* unbind from otg driver -> host disconnect */
+                        dev->otg_transceiver->set_peripheral (dev->otg_transceiver, NULL);
+                        dev->connected = 0;
+                }
+        }
+                
+        dev->sys_suspended = 1;
+
+        /* switch off UDC clock */
+        tmp = readl((u32*) (USB_MSR_BASE + USB_MSR_MCFG));
+        tmp &= AMD_CLEAR_BIT(USBMSRMCFG_UDCCLKEN);
+        writel(tmp, USB_MSR_BASE + USB_MSR_MCFG); 
+
+#endif        
+
+        return retval;
+}
+
+/**
+ *  Resumes UDC 
+ *
+ * \return 0 if success
+ */
+static int udc_resume(struct udc* dev)
+{
+        int retval = 0;
+
+        INFO("UDC resume\n");
+#ifdef CONFIG_SOC_AU1200
+        u32 tmp;
+        /* switch on UDC clock */
+        tmp = readl((u32*) (USB_MSR_BASE + USB_MSR_MCFG));
+        tmp |= AMD_BIT(USBMSRMCFG_UDCCLKEN);
+        writel(tmp, USB_MSR_BASE + USB_MSR_MCFG); 
+
+        dev->sys_suspended = 0;
+
+        usb_connect(dev);
+        if (dev->otg_transceiver && dev->otg_transceiver->set_peripheral) {
+                /* bind to otg driver */
+                dev->otg_transceiver->set_peripheral(dev->otg_transceiver, &dev->gadget);
+        }
+        
+#endif
+
+        return retval;
+}
+
+static int udc_au1xxx_drv_probe(struct device *dev)
+{
+	int retval;
+
+	DBG("udc_au1xxx_drv_probe()\n");
+        retval = udc_drv_probe(dev);
+	return retval;
+}
+
+static int udc_au1xxx_drv_remove(struct device *dev)
+{
+	DBG("udc_au1xxx_drv_remove()\n");
+        udc_drv_remove(dev);
+	return 0;
+}
+
+static int udc_au1xxx_drv_suspend(struct device *dev, pm_message_t state)
+{
+	struct udc *udc_dev = dev_get_drvdata(dev);
+        return udc_suspend(udc_dev);
+}
+
+static int udc_au1xxx_drv_resume(struct device *dev)
+{
+	struct udc *udc_dev = dev_get_drvdata(dev);
+        return udc_resume(udc_dev);
+}
+
+static struct device_driver udc_au1xxx_driver = {
+	.name		= "au1xxx-udc",
+	.bus		= &platform_bus_type,
+	.probe		= udc_au1xxx_drv_probe,
+	.remove		= udc_au1xxx_drv_remove,
+	.suspend	= udc_au1xxx_drv_suspend,
+	.resume	        = udc_au1xxx_drv_resume,
+};
+#endif
+
+
+/**
+ * Inits driver
+ *
+ * \return 0 if success
+ */
+static int __init init(void)
+{
+        int rc;
+
+#ifdef UDC_DEBUG
+        /* register char device */
+        rc = register_chrdev(UDC_MAJOR_NUM, UDC_DEVICE_NAME, &udc_fops);
+        if (rc < 0)
+        {
+                printk("Error registering udc char device");
+        }
+#endif        
+
+#ifdef CONFIG_SOC_AU1200 
+        /* probe by device system */
+        rc = driver_register(&udc_au1xxx_driver); 
+#else
+        /* probe by PCI bus driver */
+        rc = pci_module_init (&udc_pci_driver);
+#endif
+
+        return rc;
+}
+module_init (init);
+
+/**
+ * Cleans driver
+ */
+static void __exit cleanup(void)
+{
+#ifdef UDC_DEBUG
+        /* unregister char device */
+        unregister_chrdev(UDC_MAJOR_NUM, UDC_DEVICE_NAME);
+#endif
+
+#ifdef CONFIG_SOC_AU1200 
+        /* unregister at device system */
+        driver_unregister(&udc_au1xxx_driver); 
+#else
+        /* unregister at PCI bus driver */
+        pci_unregister_driver (&udc_pci_driver);
+#endif
+
+}
+module_exit (cleanup);
+
diff --git a/drivers/usb/gadget/au1200udc.h b/drivers/usb/gadget/au1200udc.h
new file mode 100644
index 0000000..d7d8491
--- /dev/null
+++ b/drivers/usb/gadget/au1200udc.h
@@ -0,0 +1,936 @@
+/*
+ * Header for driver for AMD Au1200 UDC high/full speed USB device controller
+ */
+
+/*
+ * Copyright (C) 2005 AMD (http://www.amd.com)
+ * Author: Thomas Dahlmann 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef AU1200UDC_H
+#define AU1200UDC_H
+
+/*****************************************************************************
+*  Constants
+*****************************************************************************/
+
+/* Driver  constants -------------------------------------------------------*/
+#define DRIVER_NAME_FOR_PRINT "au1200udc"
+
+/* PCI constants -----------------------------------------------------------*/
+#define UDC_PCI_VENID 0x1022
+#define UDC_PCI_DEVID 0x2096
+#define UDC_PCI_CLASS ((PCI_CLASS_SERIAL_USB << 8) | 0xfe)
+#define UDC_PCI_CLASS_MASK 0xffffffff
+
+/* Platform specific -------------------------------------------------------*/
+#if defined(CONFIG_SOC_AU1200)
+#define UDC_PCIPOOL_ALIGN       32 
+#define UDC_PCIPOOL_CROSS       4096
+#define UDC_PCIPOOL_GFP_STP     (GFP_ATOMIC | GFP_DMA)
+#else
+#define UDC_PCIPOOL_ALIGN       0 
+#define UDC_PCIPOOL_CROSS       0 
+#define UDC_PCIPOOL_GFP_STP     (GFP_KERNEL)
+#endif
+
+/* temp define for AU1200, will live in au1000.h normally */
+#ifndef USB_UDC_BASE
+#define USB_UDC_BASE              0x14022000
+#define USB_UDC_LEN               0x2000
+#define USB_MSR_BASE              0xB4020000
+#define USB_MSR_MCFG              4
+#define USBMSRMCFG_DMEMEN         4
+#define USBMSRMCFG_DBMEN          5
+#define USBMSRMCFG_UDCCLKEN       18
+#define USBMSRMCFG_PHYPLLEN       19
+#define USBMSRMCFG_RDCOMB         30
+#define USBMSRMCFG_PFEN           31
+#define AU1200_USB_INT            29
+#endif
+#ifndef USBMSRMCFG_UCAM           
+#define USBMSRMCFG_UCAM           7
+#endif
+#define USBMSRMCFG_DEFAULT        0x00d02000
+
+/* other constants */
+#define UDC_RDE_TIMER_SECONDS                   1
+#define UDC_RDE_TIMER_DIV                       10
+#define UDC_POLLSTALL_TIMER_USECONDS            500
+
+/* Special optimization for certain gadgets ------------------------------- */ 
+/* use hardware NAK if IN queue empty, this can be used to 
+* avoid interrupt flood as for the ethernet gadget where host side
+* sends IN tokens permamently */
+#define UDC_DISABLE_IRQ_IF_EMPTY_IN_QUEUE
+/*#undef UDC_DISABLE_IRQ_IF_EMPTY_IN_QUEUE*/                                       
+
+/* IP core defect/bug/case workarounds ---------------------------------------- */
+/* Hs AU1200 A0 workarounds */
+/* Description: "Last descriptor loop */
+#define UDC_IPDEFECT_9000004946_WORKAROUND
+/* Description: "DMA machine not restartable" */
+#define UDC_IPCASE_8000018724_WORKAROUND
+/* Description: "UDC not accessible when phy is suspended */
+#define UDC_IPBUG_3943_WORKAROUND
+/* Description: "USB device needs session-valid status information */
+#define UDC_IPBUG_3950_WORKAROUND
+/* Description: "Clearing endpoint NAK bits not possible if RxFIFO
+   not empty (PCS#1503) */
+#define UDC_IPBUG_3958_WORKAROUND
+/* UDC data errors during loop test (DMA) 
+   - found only with Au1200 but used for Hs too, bug entry
+     is in Au1200 bugzilla
+   - the workaround applies only for small packets */
+#define UDC_IPBUG_2253_WORKAROUND
+#define UDC_SMALL_PACKET        32
+
+/* Disable workarounds which don't apply to Hs AU1200 B1/ Au1200 A1 */
+/* And enable new features */
+ 
+/* Hs AU1200 A0 flag */
+/* #define UDC_HSA0 */
+/* Hs AU1200 B1 flag */
+#define UDC_HSB1
+
+/* Hs AU1200 chip rev. */
+#define UDC_HSA0_REV 1
+#define UDC_HSB1_REV 2
+
+/* consistency */
+#ifdef UDC_HSB1
+#undef UDC_HSA0
+#endif
+
+/* Au1200 rev. */
+#if defined(CONFIG_SOC_AU1200)
+#undef UDC_HSB1
+#undef UDC_HSA0
+/* revision value */
+#define UDC_AUAB_REV 0
+#define UDC_AUAC_REV 1
+#define UDC_AUA0 0
+/* Au1200 AC flag */
+/* #define UDC_AUA1 1 */
+#endif
+
+/* disable workarounds for newer chip revisions */
+#ifdef UDC_HSB1
+#undef UDC_IPBUG_3943_WORKAROUND
+#undef UDC_IPBUG_3950_WORKAROUND
+#define UDC_DMARST_AVAIL
+#endif
+#ifdef UDC_AUA1
+#undef UDC_IPBUG_3943_WORKAROUND
+#endif
+
+/* SETUP usb commands 
+*  needed, because some SETUP's are handled in hw, but must be passed to 
+*  gadget driver above -----------------------------------------------------*/
+/* SET_CONFIG */
+#define UDC_SETCONFIG_DWORD0                    0x00000900
+#define UDC_SETCONFIG_DWORD0_VALUE_MASK         0xffff0000 
+#define UDC_SETCONFIG_DWORD0_VALUE_OFS          16 
+
+#define UDC_SETCONFIG_DWORD1                    0x00000000
+
+/* SET_INTERFACE */
+#define UDC_SETINTF_DWORD0                      0x00000b00
+#define UDC_SETINTF_DWORD0_ALT_MASK             0xffff0000 
+#define UDC_SETINTF_DWORD0_ALT_OFS              16
+
+#define UDC_SETINTF_DWORD1                      0x00000000
+#define UDC_SETINTF_DWORD1_INTF_MASK            0x0000ffff 
+#define UDC_SETINTF_DWORD1_INTF_OFS             0 
+
+/* Mass storage reset */
+#define UDC_MSCRES_DWORD0                       0x0000ff21
+#define UDC_MSCRES_DWORD1                       0x00000000
+
+/* Global CSR's -------------------------------------------------------------*/
+/* UDC CSR's */
+#define UDC_CSR_ADDR                            0x500 
+
+/* EP NE bits */
+/* EP number */
+#define UDC_CSR_NE_NUM_MASK                     0x0000000f 
+#define UDC_CSR_NE_NUM_OFS                      0 
+/* EP direction */
+#define UDC_CSR_NE_DIR_MASK                     0x00000010 
+#define UDC_CSR_NE_DIR_OFS                      4 
+/* EP type */
+#define UDC_CSR_NE_TYPE_MASK                    0x00000060
+#define UDC_CSR_NE_TYPE_OFS                     5
+/* EP config number */
+#define UDC_CSR_NE_CFG_MASK                     0x00000780
+#define UDC_CSR_NE_CFG_OFS                      7
+/* EP interface number */
+#define UDC_CSR_NE_INTF_MASK                    0x00007800
+#define UDC_CSR_NE_INTF_OFS                     11 
+/* EP alt setting */
+#define UDC_CSR_NE_ALT_MASK                     0x00078000
+#define UDC_CSR_NE_ALT_OFS                      15
+ 
+/* max pkt */
+#define UDC_CSR_NE_MAX_PKT_MASK                 0x3ff80000 
+#define UDC_CSR_NE_MAX_PKT_OFS                  19 
+
+/* Device Config Register ---------------------------------------------------*/
+#define UDC_DEVCFG_ADDR                         0x400 
+
+#define UDC_DEVCFG_SOFTRESET                    31
+#define UDC_DEVCFG_HNPSFEN                      30
+#define UDC_DEVCFG_DMARST                       29
+#define UDC_DEVCFG_SET_DESC                     18
+#define UDC_DEVCFG_CSR_PRG                      17
+#define UDC_DEVCFG_STATUS                       7
+#define UDC_DEVCFG_DIR                          6
+#define UDC_DEVCFG_PI                           5
+#define UDC_DEVCFG_SS                           4
+#define UDC_DEVCFG_SP                           3
+#define UDC_DEVCFG_RWKP                         2
+
+#define UDC_DEVCFG_SPD_MASK                     0x3
+#define UDC_DEVCFG_SPD_OFS                      0
+#define UDC_DEVCFG_SPD_HS                       0x0
+#define UDC_DEVCFG_SPD_FS                       0x1
+#define UDC_DEVCFG_SPD_LS                       0x2
+/*#define UDC_DEVCFG_SPD_FS                     0x3*/
+
+
+/* Device Control Register --------------------------------------------------*/
+#define UDC_DEVCTL_ADDR                         0x404 
+
+#define UDC_DEVCTL_THLEN_MASK                   0xff000000 
+#define UDC_DEVCTL_THLEN_OFS                    24 
+
+#define UDC_DEVCTL_BRLEN_MASK                   0x00ff0000 
+#define UDC_DEVCTL_BRLEN_OFS                    16 
+
+#define UDC_DEVCTL_CSR_DONE                     13
+#define UDC_DEVCTL_DEVNAK                       12
+#define UDC_DEVCTL_SD                           10
+#define UDC_DEVCTL_MODE                         9 
+#define UDC_DEVCTL_BREN                         8
+#define UDC_DEVCTL_THE                          7
+#define UDC_DEVCTL_BF                           6
+#define UDC_DEVCTL_BE                           5
+#define UDC_DEVCTL_DU                           4
+#define UDC_DEVCTL_TDE                          3
+#define UDC_DEVCTL_RDE                          2
+#define UDC_DEVCTL_RES                          0
+
+
+/* Device Status Register ---------------------------------------------------*/
+#define UDC_DEVSTS_ADDR                         0x408
+
+#define UDC_DEVSTS_TS_MASK                      0xfffc0000
+#define UDC_DEVSTS_TS_OFS                       18
+
+#define UDC_DEVSTS_SESSVLD                      17
+#define UDC_DEVSTS_PHY_ERROR                    16
+#define UDC_DEVSTS_RXFIFO_EMPTY                 15
+
+#define UDC_DEVSTS_ENUM_SPEED_MASK              0x00006000
+#define UDC_DEVSTS_ENUM_SPEED_OFS               13
+#define UDC_DEVSTS_ENUM_SPEED_FULL              1
+#define UDC_DEVSTS_ENUM_SPEED_HIGH              0
+
+#define UDC_DEVSTS_SUSP                         12
+
+#define UDC_DEVSTS_ALT_MASK                     0x00000f00
+#define UDC_DEVSTS_ALT_OFS                      8
+
+#define UDC_DEVSTS_INTF_MASK                    0x000000f0
+#define UDC_DEVSTS_INTF_OFS                     4
+
+#define UDC_DEVSTS_CFG_MASK                     0x0000000f
+#define UDC_DEVSTS_CFG_OFS                      0
+
+
+/* Device Interrupt Register ------------------------------------------------*/
+#define UDC_DEVINT_ADDR                         0x40c
+
+#define UDC_DEVINT_SVC                          7
+#define UDC_DEVINT_ENUM                         6
+#define UDC_DEVINT_SOF                          5
+#define UDC_DEVINT_US                           4
+#define UDC_DEVINT_UR                           3
+#define UDC_DEVINT_ES                           2
+#define UDC_DEVINT_SI                           1
+#define UDC_DEVINT_SC                           0
+
+/* Device Interrupt Mask Register -------------------------------------------*/
+#define UDC_DEVINT_MSK_ADDR                     0x410
+
+#define UDC_DEVINT_MSK                          0x7f
+
+/* Endpoint Interrupt Register ----------------------------------------------*/
+#define UDC_EPINT_ADDR                          0x414           
+
+#define UDC_EPINT_OUT_MASK                      0xffff0000           
+#define UDC_EPINT_OUT_OFS                       16           
+#define UDC_EPINT_IN_MASK                       0x0000ffff           
+#define UDC_EPINT_IN_OFS                        0 
+
+#define UDC_EPINT_IN_EP0                        0 
+#define UDC_EPINT_IN_EP1                        1 
+#define UDC_EPINT_IN_EP2                        2 
+#define UDC_EPINT_IN_EP3                        3 
+#define UDC_EPINT_OUT_EP0                       16 
+#define UDC_EPINT_OUT_EP1                       17
+#define UDC_EPINT_OUT_EP2                       18 
+#define UDC_EPINT_OUT_EP3                       19 
+
+#define UDC_EPINT_EP0_ENABLE_MSK                0x001e001e    
+
+/* Endpoint Interrupt Mask Register -----------------------------------------*/
+#define UDC_EPINT_MSK_ADDR                      0x418           
+
+#define UDC_EPINT_OUT_MSK_MASK                  0xffff0000           
+#define UDC_EPINT_OUT_MSK_OFS                   16           
+#define UDC_EPINT_IN_MSK_MASK                   0x0000ffff           
+#define UDC_EPINT_IN_MSK_OFS                    0 
+
+#define UDC_EPINT_MSK_DISABLE_ALL               0xffffffff
+/* mask non-EP0 endpoints */
+#define UDC_EPDATAINT_MSK_DISABLE               0xfffefffe
+/* mask all dev interrupts */
+#define UDC_DEV_MSK_DISABLE                     0x7f
+
+/* Endpoint-specific CSR's --------------------------------------------------*/
+/* Endpoint Control Registers -----------------------------------------------*/
+#define UDC_EPREGS_ADDR                         0x0
+#define UDC_EPIN_REGS_ADDR                      0x0
+#define UDC_EPOUT_REGS_ADDR                     0x200
+
+#define UDC_EPCTL_ADDR                          0x0
+
+#define UDC_EPCTL_RRDY                          9
+#define UDC_EPCTL_CNAK                          8
+#define UDC_EPCTL_SNAK                          7
+#define UDC_EPCTL_NAK                           6
+
+#define UDC_EPCTL_ET_MASK                       0x00000030
+#define UDC_EPCTL_ET_OFS                        4
+#define UDC_EPCTL_ET_CONTROL                    0
+#define UDC_EPCTL_ET_ISO                        1 
+#define UDC_EPCTL_ET_BULK                       2
+#define UDC_EPCTL_ET_INTERRUPT                  3
+
+#define UDC_EPCTL_P                             3
+#define UDC_EPCTL_SN                            2
+#define UDC_EPCTL_F                             1
+#define UDC_EPCTL_S                             0
+
+/* Endpoint Status Registers ------------------------------------------------*/
+#define UDC_EPSTS_ADDR                          0x4
+
+#define UDC_EPSTS_RX_PKT_SIZE_MASK              0x007ff800
+#define UDC_EPSTS_RX_PKT_SIZE_OFS               11
+
+#define UDC_EPSTS_TDC                           10
+#define UDC_EPSTS_HE                            9
+#define UDC_EPSTS_BNA                           7
+#define UDC_EPSTS_IN                            6
+
+#define UDC_EPSTS_OUT_MASK                      0x00000030
+#define UDC_EPSTS_OUT_OFS                       4 
+#define UDC_EPSTS_OUT_DATA                      1
+#define UDC_EPSTS_OUT_DATA_CLEAR                0x10
+#define UDC_EPSTS_OUT_SETUP                     2
+#define UDC_EPSTS_OUT_SETUP_CLEAR               0x20
+
+/* Endpoint Buffer Size IN/ Receive Packet Frame Number OUT  Registers ------*/
+#define UDC_EPIN_BUFF_SIZE_ADDR                 0x8
+#define UDC_EPOUT_FRAME_NUMBER_ADDR             0x8
+
+#define UDC_EPIN_BUFF_SIZE_MASK                 0x0000ffff
+#define UDC_EPIN_BUFF_SIZE_OFS                  0
+/*  EP0in txfifo = 128 bytes*/ 
+#define UDC_EPIN0_BUFF_SIZE                     32
+/*  EP0in fullspeed txfifo = 128 bytes*/ 
+#define UDC_FS_EPIN0_BUFF_SIZE                  32
+
+/* fifo size mult = fifo size / max packet */
+#define UDC_EPIN_BUFF_SIZE_MULT                 2
+
+/* EPin data fifo size = 1024 bytes DOUBLE BUFFERING */
+#define UDC_EPIN_BUFF_SIZE                      256 
+/* EPin small INT data fifo size = 128 bytes */
+#define UDC_EPIN_SMALLINT_BUFF_SIZE             32 
+
+/* EPin fullspeed data fifo size = 128 bytes DOUBLE BUFFERING */
+#define UDC_FS_EPIN_BUFF_SIZE                   32 
+
+#define UDC_EPOUT_FRAME_NUMBER_MASK             0x0000ffff
+#define UDC_EPOUT_FRAME_NUMBER_OFS              0 
+
+/* Endpoint Buffer Size OUT/Max Packet Size Registers -----------------------*/
+#define UDC_EPOUT_BUFF_SIZE_ADDR                0x0c
+#define UDC_EP_MAX_PKT_SIZE_ADDR                0x0c
+
+#define UDC_EPOUT_BUFF_SIZE_MASK                0xffff0000
+#define UDC_EPOUT_BUFF_SIZE_OFS                 16 
+#define UDC_EP_MAX_PKT_SIZE_MASK                0x0000ffff
+#define UDC_EP_MAX_PKT_SIZE_OFS                 0
+/* EP0in max packet size = 64 bytes */
+#define UDC_EP0IN_MAX_PKT_SIZE                  64
+/* EP0out max packet size = 64 bytes */
+#define UDC_EP0OUT_MAX_PKT_SIZE                 64
+/* EP0in fullspeed max packet size = 64 bytes */
+#define UDC_FS_EP0IN_MAX_PKT_SIZE               64   
+/* EP0out fullspeed max packet size = 64 bytes */
+#define UDC_FS_EP0OUT_MAX_PKT_SIZE              64
+
+/* Endpoint dma descriptors ------------------------------------------------*/
+/* Setup data */
+/* Status dword */
+#define UDC_DMA_STP_STS_CFG_MASK                0x0fff0000
+#define UDC_DMA_STP_STS_CFG_OFS                 16
+#define UDC_DMA_STP_STS_CFG_ALT_MASK            0x000f0000     
+#define UDC_DMA_STP_STS_CFG_ALT_OFS             16     
+#define UDC_DMA_STP_STS_CFG_INTF_MASK           0x00f00000     
+#define UDC_DMA_STP_STS_CFG_INTF_OFS            20     
+#define UDC_DMA_STP_STS_CFG_NUM_MASK            0x0f000000     
+#define UDC_DMA_STP_STS_CFG_NUM_OFS             24     
+#define UDC_DMA_STP_STS_RX_MASK                 0x30000000
+#define UDC_DMA_STP_STS_RX_OFS                  28 
+#define UDC_DMA_STP_STS_BS_MASK                 0xc0000000
+#define UDC_DMA_STP_STS_BS_OFS                  30 
+#define UDC_DMA_STP_STS_BS_HOST_READY           0 
+#define UDC_DMA_STP_STS_BS_DMA_BUSY             1 
+#define UDC_DMA_STP_STS_BS_DMA_DONE             2 
+#define UDC_DMA_STP_STS_BS_HOST_BUSY            3 
+/* IN data */
+/* Status dword */
+#define UDC_DMA_IN_STS_TXBYTES_MASK            0x0000ffff
+#define UDC_DMA_IN_STS_TXBYTES_OFS             0
+#define UDC_DMA_IN_STS_FRAMENUM_MASK           0x07ff0000
+#define UDC_DMA_IN_STS_FRAMENUM_OFS            0
+#define UDC_DMA_IN_STS_L                       27
+#define UDC_DMA_IN_STS_TX_MASK                 0x30000000
+#define UDC_DMA_IN_STS_TX_OFS                  28 
+#define UDC_DMA_IN_STS_BS_MASK                 0xc0000000
+#define UDC_DMA_IN_STS_BS_OFS                  30 
+#define UDC_DMA_IN_STS_BS_HOST_READY           0 
+#define UDC_DMA_IN_STS_BS_DMA_BUSY             1 
+#define UDC_DMA_IN_STS_BS_DMA_DONE             2 
+#define UDC_DMA_IN_STS_BS_HOST_BUSY            3 
+/* OUT data */
+/* Status dword */
+#define UDC_DMA_OUT_STS_RXBYTES_MASK            0x0000ffff
+#define UDC_DMA_OUT_STS_RXBYTES_OFS             0
+#define UDC_DMA_OUT_STS_FRAMENUM_MASK           0x07ff0000
+#define UDC_DMA_OUT_STS_FRAMENUM_OFS            0
+#define UDC_DMA_OUT_STS_L                       27
+#define UDC_DMA_OUT_STS_RX_MASK                 0x30000000
+#define UDC_DMA_OUT_STS_RX_OFS                  28 
+#define UDC_DMA_OUT_STS_BS_MASK                 0xc0000000
+#define UDC_DMA_OUT_STS_BS_OFS                  30 
+#define UDC_DMA_OUT_STS_BS_HOST_READY           0 
+#define UDC_DMA_OUT_STS_BS_DMA_BUSY             1 
+#define UDC_DMA_OUT_STS_BS_DMA_DONE             2 
+#define UDC_DMA_OUT_STS_BS_HOST_BUSY            3 
+/* other constants */
+/* max ep0in packet */
+#define UDC_EP0IN_MAXPACKET                     1000
+/* max dma packet */
+#define UDC_DMA_MAXPACKET                       65536 
+/* DMA buffer len for temp request, should be the same as the upper
+layer gadget is using */
+#define UDC_DMA_TEMP_BUFFER_LEN                 4096 
+/* un-usable DMA address */
+#define DMA_DONT_USE                           (~(dma_addr_t) 0 )
+
+/* other Endpoint register addresses and values-----------------------------*/
+#define UDC_EP_SUBPTR_ADDR                      0x10
+#define UDC_EP_DESPTR_ADDR                      0x14
+#define UDC_EP_WRITE_CONFIRM_ADDR               0x1c
+
+/* EP number as layouted in AHB space */
+#define UDC_EP_NUM                              32
+#define UDC_EPIN_NUM                            16
+#define UDC_EPIN_NUM_USED                       5
+#define UDC_EPOUT_NUM                           16
+/* EP number of EP's really used = EP0 + 8 data EP's */
+#define UDC_USED_EP_NUM                         9
+/* UDC CSR regs are aligned but AHB regs not - offset for OUT EP's */
+#define UDC_CSR_EP_OUT_IX_OFS                   12
+
+#define UDC_EP0OUT_IX                           16
+#define UDC_EP0IN_IX                            0
+
+/* max packet */
+#define UDC_HS_BULK_MAXPKT                      512
+
+/* Rx fifo address and size = 1k -------------------------------------------*/
+#define UDC_RXFIFO_ADDR                         0x800
+#define UDC_RXFIFO_SIZE                         0x400
+
+/* Tx fifo address and size = 1.5k -----------------------------------------*/
+#define UDC_TXFIFO_ADDR                         0xc00
+#define UDC_TXFIFO_SIZE                         0x600
+
+/* default data endpoints --------------------------------------------------*/
+#define UDC_EPIN_STATUS_IX                      1                            
+#define UDC_EPIN_IX                             2                            
+#define UDC_EPOUT_IX                            18                            
+
+/* general constants -------------------------------------------------------*/ 
+#define UDC_DWORD_BYTES                         4
+#define UDC_BITS_PER_BYTE_SHIFT                 3
+#define UDC_BYTE_MASK                           0xff
+#define UDC_BITS_PER_BYTE                       8
+
+/* char device constants ---------------------------------------------------*/
+/* names */
+#ifdef UDC_DEBUG
+#ifdef UDC_DRIVER_NAME
+#define UDC_DEVICE_NAME UDC_DRIVER_NAME
+#else
+#define UDC_DEVICE_NAME "au1200udc"
+#endif
+#define UDC_DEVICE_FILE_NAME "au1200udc_dev"
+#define UDC_DEVICE_FILE_INODE "/dev/au1200udc_dev"
+/* major number */
+#define UDC_MAJOR_NUM   240
+#endif
+
+#ifdef __KERNEL__
+/* kernel wrappers */
+#define device_create_file(x,y) do {} while (0)
+#define device_remove_file device_create_file
+
+#ifndef WARN_ON
+#define WARN_ON(a) do {} while (0)
+#endif
+
+#ifndef BUG_ON
+#define BUG_ON(cond)do {if (unlikely((cond) != 0)) BUG();} while(0)
+#endif
+
+#ifndef likely
+#define likely(a) (a)
+#define unlikely(a) (a)
+#endif
+
+#ifndef container_of
+#define container_of list_entry
+#endif
+
+#ifndef        IRQ_NONE
+typedef void irqreturn_t;
+#define IRQ_HANDLED
+#define IRQ_NONE
+#define IRQ_RETVAL(a)
+#endif
+#endif 
+
+/* MIPS specific -----------------------------------------------------------*/
+#if defined(CONFIG_SOC_AU1200)
+/* sync does it without refilling the pipe,
+   so read after write can bypass write */
+#define au1200_sync_delay() {\
+  asm(".set noreorder"); \
+  asm("b l1");\
+  asm("l1:");\
+  asm("sync");\
+  asm("nop");\
+  asm("nop");\
+  asm("nop");\
+  asm("nop");\
+  asm("b l2");\
+  asm("l2:");\
+  asm("nop");\
+  asm("nop");\
+  asm(".set reorder");\
+}
+
+/* #define wb_flush() au1200_sync() */
+#define wb_flush() __asm__ volatile ("sync")
+
+/* special write functions for MIPS (with write buffer flush) */
+#undef writel
+#undef writeb
+#define writel(d,a) {((*(volatile unsigned int *)(a))=(d));wb_flush();}
+#define writeb(d,a) {((*(volatile unsigned char *)(a))=(d));wb_flush();}
+#else
+#define wb_flush() {}
+#endif
+
+/*****************************************************************************
+* Includes 
+*****************************************************************************/
+
+#if !defined(UDC_HSB1)	
+#include "au1200otg.h"
+#endif
+
+/*****************************************************************************
+*  Types
+*****************************************************************************/
+
+/* UDC CSR's */
+struct udc_csrs {
+        
+        /* sca - setup command address */
+        u32 sca;
+
+        /* ep ne's */
+        u32 ne[UDC_USED_EP_NUM];
+} __attribute__ ((packed));
+
+/* AHB subsystem CSR registers */
+struct udc_regs {
+
+        /* device configuration */
+        u32 cfg;
+
+        /* device control */
+        u32 ctl;
+
+        /* device status */
+        u32 sts;
+
+        /* device interrupt */
+        u32 irqsts;
+
+        /* device interrupt mask */
+        u32 irqmsk;
+        
+        /* endpoint interrupt  */
+        u32 ep_irqsts;
+
+        /* endpoint interrupt mask */
+        u32 ep_irqmsk;
+} __attribute__ ((packed));
+
+/* endpoint specific registers */
+struct udc_ep_regs {
+
+        /* endpoint control */
+        u32 ctl;
+
+        /* endpoint status */
+        u32 sts;
+
+        /* endpoint buffer size in/ receive packet frame number out  */
+        u32 bufin_framenum;
+
+        /* endpoint buffer size out/max packet size */
+        u32 bufout_maxpkt;        
+
+        /* endpoint setup buffer pointer */
+        u32 subptr; 
+        
+        /* endpoint data descriptor pointer */
+        u32 desptr;
+
+        /* reserverd */
+        u32 reserved;
+
+        /* write/read confirmation */
+        u32 confirm;
+
+}  __attribute__ ((packed));
+
+#ifdef __KERNEL__
+/* control data DMA desc */
+struct udc_stp_dma {
+        /* status quadlet */
+        u32     status;
+        /* reserved */
+        u32     _reserved;
+        /* first setup word */
+        u32     data12;
+        /* second setup word */
+        u32     data34;
+} __attribute__ ((aligned (16)));
+
+/* normal data DMA desc */
+struct udc_data_dma {
+        /* status quadlet */
+        u32     status;
+        /* reserved */
+        u32     _reserved;
+        /* buffer pointer */
+        u32     bufptr;
+        /* next descriptor pointer */
+        u32     next;
+} __attribute__ ((aligned (16)));
+
+/* request packet */
+struct udc_request {
+        /* embedded gadget ep */
+        struct usb_request                  req;
+
+        /* flags */
+        unsigned                            dma_going : 1,
+                                            dma_mapping : 1,
+                                            dma_done : 1;
+        /* phys. address */
+        dma_addr_t                          td_phys;
+        /* first dma desc. of chain */
+        struct udc_data_dma                 *td_data;
+        /* last dma desc. of chain */
+        struct udc_data_dma                 *td_data_last;
+#ifdef UDC_IPDEFECT_9000004946_WORKAROUND
+        /* next pointer of broken chain */
+        dma_addr_t                          td_data_last_next; 
+#endif
+
+        struct list_head                    queue;
+
+        /* chain length */
+        unsigned                            chain_len;
+
+};
+
+/* UDC specific endpoint parameters */
+struct udc_ep {
+        struct usb_ep                       ep;
+        struct udc_ep_regs                  *regs;
+        u32                                 *txfifo;
+        u32*                                dma;
+        dma_addr_t                          td_phys;
+        dma_addr_t                          td_stp_dma;        
+        struct udc_stp_dma                  *td_stp;
+        struct udc_data_dma                 *td;
+        /* temp request */
+        struct udc_request                  *req;
+        unsigned                            req_used;        
+        unsigned                            req_completed;        
+        /* NAK state */
+        unsigned                            naking;        
+
+        struct udc                          *dev;
+
+        /* queue for requests */
+        struct list_head                        queue;
+        const struct usb_endpoint_descriptor    *desc;
+        unsigned                                halted;
+        unsigned                                num : 5,
+                                                fifo_depth : 14,
+                                                in : 1;
+};
+
+/* device struct */
+struct udc {
+        struct usb_gadget               gadget;
+        spinlock_t                      lock;
+        /* all endpoints */
+        struct udc_ep                   ep[UDC_EP_NUM];
+        struct usb_gadget_driver        *driver;
+        struct otg_transceiver          *otg_transceiver;
+#if !defined(UDC_HSB1)	
+        struct usb_otg_gadget_extension *otg_driver;
+#endif
+        /* operational flags */
+        unsigned                        active : 1,
+                                        stall_ep0in : 1,
+                                        waiting_zlp_ack_ep0in : 1,
+                                        set_cfg_not_acked : 1,
+                                        irq_registered : 1,
+                                        otg_supported : 1,
+                                        data_ep_enabled : 1,
+                                        data_ep_queued : 1,
+                                        mem_region : 1,
+                                        selfpowered : 1,
+                                        sys_suspended : 1,
+                                        connected;
+
+        u16                             chiprev;
+
+        /* registers */
+#if defined(CONFIG_SOC_AU1200) && !defined(USE_AU1200_PCI_DUMMY)
+        struct device                   *pdev;
+#else
+        struct pci_dev                  *pdev;
+#endif
+        struct udc_csrs                 *csr;
+        struct udc_regs                 *regs;
+        struct udc_ep_regs              *ep_regs;
+        u32*                            rxfifo;
+        u32*                            txfifo;
+
+        /* DMA desc pools */
+#if   defined(CONFIG_SOC_AU1200)
+        struct dma_pool                 *data_requests;
+        struct dma_pool                 *stp_requests;
+#else
+        struct pci_pool                 *data_requests;
+        struct pci_pool                 *stp_requests;
+#endif
+
+        /* device data */
+        unsigned long                   phys_addr;
+        void*                           virt_addr; 
+        unsigned                        irq;
+
+        /* states */
+        u16                             cur_config;
+        u16                             cur_intf;
+        u16                             cur_alt;
+};
+
+/* setup request data */
+union udc_setup_data {
+        u32                        data[2];
+        struct usb_ctrlrequest     request;
+};
+#endif /*__KERNEL__*/
+
+/*****************************************************************************
+*  Macros
+*****************************************************************************/
+
+/***************************************
+* SET and GET bitfields in u32 values
+* via constants for mask/offset:
+* <bit_field_stub_name> is the text between
+* UDC_ and _MASK|_OFS of appropiate
+* constant
+****************************************/
+/* set bitfield value in u32 u32Val */
+#define AMD_ADDBITS(u32Val, bitfield_val, bitfield_stub_name)\
+        (((u32Val) & (((u32) ~((u32) bitfield_stub_name##_MASK))))\
+        |(((bitfield_val) << ((u32) bitfield_stub_name##_OFS))\
+        & ((u32) bitfield_stub_name##_MASK)))
+
+/* set bitfield value in zero-initialized u32 u32Val */
+/* => bitfield bits in u32Val are all zero */
+#define AMD_INIT_SETBITS(u32Val, bitfield_val, bitfield_stub_name)\
+        ((u32Val)\
+        |(((bitfield_val) << ((u32) bitfield_stub_name##_OFS))\
+        &((u32) bitfield_stub_name##_MASK)))
+
+/* get bitfield value from u32 u32Val */
+#define AMD_GETBITS(u32Val, bitfield_stub_name)\
+        ((u32Val & ((u32) bitfield_stub_name##_MASK))\
+        >> ((u32) bitfield_stub_name##_OFS))
+
+/* SET and GET bits in u32 values ------------------------------------------*/
+#define AMD_BIT(bit_stub_name) (1 << bit_stub_name)
+#define AMD_UNMASK_BIT(bit_stub_name) (~AMD_BIT(bit_stub_name))
+#define AMD_CLEAR_BIT(bit_stub_name) (~AMD_BIT(bit_stub_name))
+
+/* misc --------------------------------------------------------------------*/
+#define        DIR_STRING(bAddress) (((bAddress) & USB_DIR_IN) ? "in" : "out")
+
+/* UDC specific macros -----------------------------------------------------*/
+#ifdef UDC_DMARST_AVAIL
+#define UDC_DMARST(tmp, dev) \
+        DBG("DMA machine reset\n"); \
+        tmp = readl(&dev->regs->cfg); \
+        writel(tmp | AMD_BIT(UDC_DEVCFG_DMARST), &dev->regs->cfg); \
+        writel(tmp, &dev->regs->cfg);
+#else
+#define UDC_DMARST(tmp, dev) {} 
+#endif
+
+/* print macros ------------------------------------------------------------*/
+
+#ifdef UDC_VERBOSE
+#ifndef UDC_DEBUG
+#define UDC_DEBUG
+#endif
+#endif
+
+/**
+ * \brief
+ * Macro for printing information in drivers
+ * 
+ * This macro is used for printing kernel messages in driver source code.
+ * It should be used for printing useful information about states and called
+ * functions for normal operation (not for errors and warnings).
+ * 
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#define INFO(args...) \
+        printk(KERN_INFO DRIVER_NAME_FOR_PRINT ": " args)
+
+/**
+ * \brief
+ * Macro for printing warnings in drivers
+ * 
+ * This macro is used for printing kernel messages in driver source code.
+ * It should be used for printing warnings.
+ * 
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#define WARN(args...) \
+        printk(KERN_WARNING DRIVER_NAME_FOR_PRINT " warning: " args)
+
+/**
+ * \brief
+ * Macro for printing errors in drivers
+ * 
+ * This macro is used for printing kernel messages in driver source code.
+ * It should be used for printing errors.
+ * 
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#define ERR(args...) \
+        printk(KERN_ERR DRIVER_NAME_FOR_PRINT " error: " args)
+
+/**
+ * \brief
+ * Macro for printing debug messages in drivers
+ * 
+ * This macro is used for printing kernel messages in driver source code
+ * when UDC_DEBUG is defined 
+ * It should be used for printing debug messages.
+ * 
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#ifdef UDC_DEBUG
+#define DBG(args...) \
+        printk(KERN_DEBUG DRIVER_NAME_FOR_PRINT " debug: " args)
+#else
+
+#define DBG(args...) \
+        do {} while (0)
+#endif
+
+/**
+ * \brief
+ * Macro for printing verbose debug messages in drivers
+ * 
+ * This macro is used for printing kernel messages in driver source code
+ * when UDC_DEBUG and UDC_VERBOSE is defined
+ * It should be used for printing debug messages.
+ * 
+ * \param fmt is format string for printk
+ * \param args... are arguments given to printk (number depends on <fmt>)
+ * \return code from printk
+ */
+#ifdef UDC_VERBOSE
+#define VDBG DBG
+#else
+#define VDBG(args...) \
+	do {} while (0)
+#endif
+#endif /* #ifdef  AU1200UDC_H */
diff --git a/drivers/usb/gadget/au1200uoc.c b/drivers/usb/gadget/au1200uoc.c
new file mode 100644
index 0000000..5297eee
--- /dev/null
+++ b/drivers/usb/gadget/au1200uoc.c
@@ -0,0 +1,2015 @@
+/*
+ * AMD Au1200 USB OTG controller driver
+ */
+
+/*
+ * Copyright (C) 2005 AMD (http://www.amd.com)
+ * Author: Karsten Boge 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+/*****************************************************************************
+ *  Includes
+ *****************************************************************************/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/unaligned.h>
+
+#ifdef CONFIG_USB_OTG_TEST_INTERFACE
+#ifndef CONFIG_USB_OTG
+#define CONFIG_USB_OTG
+#endif
+#endif
+
+/* #define DEBUG */
+/* #define VERBOSE */
+
+#ifdef CONFIG_SOC_AU1200
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1000_gpio.h>
+#include <linux/platform_device.h>
+#endif
+
+#include <linux/usb.h>
+#include <linux/usb_gadget.h>
+#include <linux/usb_otg.h>
+
+#define	DRIVER_DESC		"AMD Au1200 USB OTG Controller"
+#define	DRIVER_VERSION		"01.00.0201 - $Revision: #3 $"
+#define DRIVER_NAME_FOR_PRINT   OTG_DRIVER_NAME
+
+#include "au1200otg.h"
+#include "au1200uoc.h"
+
+
+/*****************************************************************************
+ *  Function Declarations
+ *****************************************************************************/
+
+#ifdef CONFIG_USB_OTG_TEST_INTERFACE
+static int otg_test_bind(struct otg **);
+static int otg_test_unbind(struct otg **);
+#endif
+#ifdef CONFIG_USB_OTG
+static int otg_app_request(u32);
+static int otg1200_set_host (struct otg_transceiver *, struct usb_bus *);
+static int otg1200_set_power (struct otg_transceiver *, unsigned);
+static int otg1200_start_srp (struct otg_transceiver *);
+static int otg1200_start_hnp (struct otg_transceiver *);
+#endif
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+static u32 otg_app_query(int);
+static int otg1200_set_peripheral (struct otg_transceiver *,
+                                   struct usb_gadget *);
+#endif
+
+
+/*****************************************************************************
+ *  Data
+ *****************************************************************************/
+
+static const char driver_name [] = OTG_DRIVER_NAME;
+static const char driver_desc [] = DRIVER_DESC;
+
+static struct otg *the_controller;
+static const char *transceiver_label = "au1200_otg";
+
+static u32 init_state = 0;
+#ifdef OTG_HNP_ERR_LOG
+int hnp_err = 0;
+#endif
+
+#ifdef CONFIG_USB_OTG_TEST_INTERFACE
+static struct usb_otg_test_extension otg_test_extension = {
+	.bind    = otg_test_bind,
+	.unbind  = otg_test_unbind,
+	.request = otg_app_request,
+	.query   = otg_app_query
+};
+#endif
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+struct usb_otg_gadget_extension otg_gadget_extension = {
+#ifdef CONFIG_USB_OTG
+	.request = otg_app_request,
+#else
+	.request = NULL,
+#endif
+	.query   = otg_app_query,
+	.notify  = NULL
+};
+
+static u32 state_mask;
+u32 otg_tmr_high_count = 0;
+#endif
+
+#ifdef CONFIG_SOC_AU1200
+#ifdef USE_AU1200_PCI_DUMMY
+static struct pci_dev pdev_dummy;
+#endif
+#endif
+
+
+/*****************************************************************************
+ *  Function Definitions
+ *****************************************************************************/
+
+/**
+ * \brief
+ * fill OTG transceiver struct
+ *
+ * \param  transceiver  OTG transceiver
+ *
+ * \return              void
+ */
+static inline void otg_init_transceiver (struct otg_transceiver *transceiver)
+{
+        transceiver_to_otg(transceiver)->prv_state = OTG_STATE_UNDEFINED;
+	transceiver_to_otg(transceiver)->params    = 0;
+	transceiver_to_otg(transceiver)->hostcount = 0;
+	transceiver_to_otg(transceiver)->otg_priv       = (void *) &otg_gadget_extension;
+
+	transceiver->dev            = NULL;
+	transceiver->label          = transceiver_label;
+	transceiver->default_a      = 0;
+	transceiver->state          = OTG_STATE_UNDEFINED;
+	transceiver->host           = NULL;
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+	transceiver->companion      = NULL;
+#endif
+	transceiver->gadget         = NULL;
+	transceiver->port_status    = 0;
+	transceiver->port_change    = 0;
+#ifdef CONFIG_USB_OTG
+	transceiver->set_host       = otg1200_set_host;
+	transceiver->set_peripheral = otg1200_set_peripheral;
+	transceiver->set_power      = otg1200_set_power;
+	transceiver->start_srp      = otg1200_start_srp;
+	transceiver->start_hnp      = otg1200_start_hnp;
+#else
+	transceiver->set_host       = NULL;
+	transceiver->set_peripheral = otg1200_set_peripheral;
+	transceiver->set_power      = NULL;
+	transceiver->start_srp      = NULL;
+	transceiver->start_hnp      = NULL;
+#endif
+}
+
+#ifdef CONFIG_USB_OTGMUX_GADGET
+/**
+ * \brief
+ * OTG state change
+ *
+ * subset of OTG states to support the gadget only or
+ * ID pin configuration
+ *
+ * \param  otg          OTG controller info
+ * \param  event_code   event that requested a state change
+ * \param  pEvt_mask
+ *
+ * \return              events that were not handled here
+ */
+u32 otg_change_state (struct otg *otg, u32 _event, u32 *pEvt_mask)
+{
+	u32  event_code = _event;
+	u32  uoc_status = get_status (otg);
+
+	if (GOT_EVENT (OTG_GADGET_READY, event_code)
+
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+
+	    || GOT_EVENT (OTG_HOST_READY, event_code)
+#endif
+	   ) {
+
+		if (((IS_FLAG_RES (otg, OTG_GADGET_READY))
+
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+
+		     || (IS_FLAG_RES (otg, OTG_HOST_READY))
+#endif
+            )
+
+		    && ((otg->transceiver.state & OTG_STATE_MASK) !=
+		        OTG_STATE_UNDEFINED)) {
+
+			/* driver unload, back to "not ready" state          */
+
+			CHANGE_STATE (otg, OTG_STATE_UNDEFINED, pEvt_mask);
+			RES_EVENT ((OTG_GADGET_READY | OTG_HOST_READY),
+			           event_code);
+		}
+	}
+	if ((OTG_INT_TMX & event_code) && otg_tmr_high_count) {
+
+		/* a long timer is running : decrement the high part         */
+
+		restart_timer (otg);
+		otg_tmr_high_count--;
+		RES_EVENT (OTG_INT_TMX, event_code);
+	}
+
+	do switch (otg->transceiver.state & OTG_STATE_MASK) {
+
+	/* NOT_ASSIGNED (yet): init state, 1st time after loading            */
+	/* ======================================================            */
+
+	case OTG_STATE_UNDEFINED :
+
+		CHECK_STATE (otg, OTG_STATE_UNDEFINED, pEvt_mask);
+
+		if (IS_FLAG_RES (otg, OTG_FLAGS_ACTIV)) {
+
+			/* seems to be the first time: let it run !          */
+
+			SET_FLAG (otg, OTG_FLAGS_ACTIV);
+		}
+
+		/*      muxer is still neutral                               */
+
+		RES_EVENT ((OTG_GADGET_READY | OTG_HOST_READY |
+		            OTG_INT_IDC | OTG_INT_TMX), event_code);
+
+		if ((IS_FLAG_SET (otg, OTG_GADGET_READY))
+
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+
+		    || (IS_FLAG_SET (otg, OTG_HOST_READY))
+#endif
+		    ) {
+
+			/* NOT_READY (substate): drivers now ready           */
+			/* =======================================           */
+
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+
+			if (IS_BIT_RES (OTG_STS_ID, uoc_status)) {
+
+				/* ID pin connected: A-device (host)         */
+
+				CHANGE_STATE (otg, OTG_STATE_A_HOST,
+					      pEvt_mask);
+			}
+			else {
+				/* ID pin not connected: disable (neutral)   */
+#endif
+				CHANGE_STATE (otg, OTG_STATE_B_IDLE,
+					      pEvt_mask);
+
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+			}
+#endif
+		}
+		break;
+
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+
+	/* A: ID pin is connected, A-device drives VBus                      */
+	/* ============================================                      */
+
+	case OTG_STATE_A_HOST :
+
+		CHECK_STATE (otg, OTG_STATE_A_HOST, pEvt_mask);
+
+		if (IS_BIT_SET (OTG_STS_ID, uoc_status)) {
+
+			/* ID change => B_IDLE                               */
+
+			RES_EVENT ((OTG_INT_IDC | OTG_INT_PCC), event_code);
+			CHANGE_STATE (otg, OTG_STATE_B_IDLE, pEvt_mask);
+		}
+		break;
+
+	/* B: ID pin is not connected                                        */
+	/* ==========================                                        */
+#endif
+
+	case OTG_STATE_B_IDLE :
+
+		/* B_IDLE: init state for B-devices                          */
+		/*         monitor VBus, no connection, no activity          */
+
+		CHECK_STATE (otg, OTG_STATE_B_IDLE, pEvt_mask);
+
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+
+		if (IS_BIT_RES (OTG_STS_ID, uoc_status)) {
+
+			/* ID pin changed => A_HOST                          */
+
+			RES_EVENT (OTG_INT_IDC, event_code);
+			CHANGE_STATE (otg, OTG_STATE_A_HOST, pEvt_mask);
+		}
+		else if (IS_BIT_SET (OTG_STS_SESSVLD, uoc_status))
+#else
+		if (IS_BIT_SET (OTG_STS_SESSVLD, uoc_status))
+#endif
+		{
+			/* Session valid => B_PERIPHERAL                     */
+
+			RES_EVENT (OTG_INT_SVC, event_code);
+			CHANGE_STATE (otg, OTG_STATE_B_PERIPHERAL, pEvt_mask);
+#ifndef CONFIG_TEST_MODE_ONLY
+			if (otg_gadget_extension.notify) {
+				otg_gadget_extension.notify (
+					OTG_GADGET_EVT_SVALID);
+			}
+#endif
+		}
+		break;
+
+	case OTG_STATE_B_PERIPHERAL :
+
+		/* B_PERIPHERAL: connected to A-host, responding             */
+		/*               VBus driven by A, remote activity           */
+
+		CHECK_STATE (otg, OTG_STATE_B_PERIPHERAL, pEvt_mask);
+
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+
+		if (IS_BIT_RES (OTG_STS_ID, uoc_status) ||
+		    IS_BIT_RES (OTG_STS_SESSVLD, uoc_status))
+#else
+		if (IS_BIT_RES (OTG_STS_SESSVLD, uoc_status))
+#endif
+		{
+			/* ID pin changed | ~Session valid => B_IDLE         */
+
+			RES_EVENT ((OTG_INT_IDC | OTG_INT_SVC), event_code);
+			CHANGE_STATE (otg, OTG_STATE_B_IDLE, pEvt_mask);
+#ifndef CONFIG_TEST_MODE_ONLY
+			if (otg_gadget_extension.notify) {
+				otg_gadget_extension.notify (
+					OTG_GADGET_EVT_SVDROP);
+			}
+#endif
+		}
+		break;
+
+	/* unlikely */ default :
+
+		/* something went wrong */
+
+		BUG ();
+		break;
+	}
+	while ((otg->transceiver.state ^ otg->prv_state) &
+	       OTG_STATE_MASK);
+
+	DBG ("OTG-state change done\n");
+
+	return event_code;
+}
+#endif /* CONFIG_USB_OTGMUX_GADGET */
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+/**
+ * \brief
+ * OTG state change request
+ *
+ * \param  dev    OTG device info
+ * \param  params
+ *
+ * \return void
+ */
+static inline void otg_req_state_chg (struct otg *otg, u32 params)
+{
+	u32 temp, tmp2, flags;
+
+	local_irq_save (flags);
+
+	/* disable global OTG interrupt, clear int status:                   */
+	temp = ~((u32) OTG_INT_GLOBAL) & readl (&otg->regs->inten);
+	writel (temp, &otg->regs->inten);
+	tmp2 = readl (&otg->regs->intr);
+	writel (tmp2, &otg->regs->intr);
+	temp &= tmp2;
+
+	/* update OTG state:                                                 */
+	otg_change_state (otg, (params | temp), &temp);
+
+	/* enable global OTG interrupt:                                      */
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3950: gadget needs disconnect notification              ***/
+#ifdef UDC_HSA0_WORKAROUNDS
+	state_mask = ~temp & OTG_INT_ADDS;
+	writel ((OTG_INT_ADDS | temp | OTG_INT_GLOBAL), &otg->regs->inten);
+#else
+	writel ((temp | OTG_INT_GLOBAL), &otg->regs->inten);
+#endif
+	local_irq_restore (flags);
+}
+#endif /* CONFIG_USB_OTG || CONFIG_USB_OTGMUX_GADGET */
+
+#ifdef CONFIG_USB_OTG_TEST_INTERFACE
+
+/**
+ * \brief
+ * Bind the OTG controller to the test driver
+ *
+ * \param  dev   otg controller info
+ *
+ * \return error code
+ */
+static int otg_test_bind (struct otg **otg)
+{
+	*otg = the_controller;
+	if (!*otg)
+		return -EINVAL;
+#ifdef CONFIG_TEST_MODE_ONLY
+	INFO ("bind OTG driver to the test driver, enable device\n");
+	SET_FLAG (*otg, OTG_HOST_READY | OTG_GADGET_READY);
+	if (IS_FLAG_SET (*otg, OTG_FLAGS_ACTIV)) {
+		otg_req_state_chg (*otg, OTG_HOST_READY | OTG_GADGET_READY);
+	}
+	(*otg)->transceiver.gadget = (struct usb_gadget *) 1;
+#else
+	INFO ("bind OTG driver to the test interface\n");
+#endif
+	return 0;
+}
+
+/**
+ * \brief
+ * Unbind the OTG controller from the test driver
+ *
+ * \param  dev   otg controller info
+ *
+ * \return error code
+ */
+static int otg_test_unbind (struct otg **otg)
+{
+#ifdef CONFIG_TEST_MODE_ONLY
+	INFO ("unbind OTG driver from the test driver, disable device\n");
+	(*otg)->transceiver.gadget = NULL;
+	RES_FLAG (*otg, OTG_HOST_READY | OTG_GADGET_READY);
+	if (IS_FLAG_SET (*otg, OTG_FLAGS_ACTIV)) {
+		otg_req_state_chg (*otg, OTG_HOST_READY | OTG_GADGET_READY);
+	}
+	*otg = NULL;
+	return otg_unbind_gadget ();
+#else
+	INFO ("unbind OTG driver from the test interface\n");
+	*otg = NULL;
+	return 0;
+#endif
+}
+#endif /* CONFIG_USB_OTG_TEST_INTERFACE */
+
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+/**
+ * \brief
+ * OTG set transceiver:
+ *
+ * \param  pointer to transceiver struct
+ *
+ * \return void
+ */
+int otg_set_transceiver (struct otg_transceiver *transceiver)
+{
+	struct otg *otg = the_controller;
+
+	if (unlikely (transceiver != otg_to_transceiver (otg))) {
+		ERR ("USB OTG: unknown transceiver\n");
+		return -EINVAL;
+	}
+	else {
+		return 0;
+	}
+}
+
+/**
+ * \brief
+ * OTG get transceiver: provide info to others
+ *
+ * \param  void
+ *
+ * \return pointer to transceiver struct
+ */
+struct otg_transceiver * otg_get_transceiver (void)
+{
+	return otg_to_transceiver (the_controller);
+}
+#endif
+
+#ifdef CONFIG_USB_OTG
+
+/**
+ * \brief
+ * Bind/unbind the OTG controller to/from usbcore
+ *
+ * \param  transceiver  this transceiver
+ * \param  bus          usb bus the host is assigned to
+ *
+ * \return error code
+ */
+static int otg1200_set_host (struct otg_transceiver *transceiver,
+                             struct usb_bus *bus)
+{
+	struct otg *otg = the_controller;
+	int flag, count = 0;
+
+	if (unlikely (transceiver != otg_to_transceiver (otg))) {
+		ERR ("USB OTG: unknown transceiver\n");
+		return -EINVAL;
+	}
+	if (bus) {
+
+		/* This bus supports OTG */
+
+		if (transceiver->host) {
+			count++;
+		}
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+		if (transceiver->companion) {
+			count++;
+		}
+		/* Now checking consistence ...                              */
+		/* Depending on the driver loading sequence is possible      */
+		/* that the "Load state defaults" function was already       */
+		/*  called so the state could be inconsistent.               */
+		if (transceiver->host && transceiver->companion) {
+			flag = (transceiver->host->is_b_host |
+			        transceiver->companion->is_b_host);
+			if (transceiver->gadget &&
+			    !transceiver->gadget->is_a_peripheral) {
+				flag |= 1;
+			}
+			transceiver->host->is_b_host = flag;
+			transceiver->companion->is_b_host = flag;
+		}
+#endif
+		DBG ("USB OTG: bind host: bus %d, port %d (OTG host #%d)\n",
+		     bus->busnum, bus->otg_port, count);
+		if (IS_FLAG_RES (otg, OTG_HOST_READY)) {
+			RES_FLAG (otg, OTG_A_BUS_DROP);
+			SET_FLAG (otg, OTG_HOST_READY | OTG_A_BUS_REQ);
+			if (IS_FLAG_SET (otg, OTG_FLAGS_ACTIV)) {
+				otg_req_state_chg (otg, OTG_HOST_READY);
+			}
+		}
+	}
+	else {
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+		if (transceiver->companion) {
+			count++;
+		}
+#endif
+		if (transceiver->host) {
+			count++;
+		}
+		DBG ("USB OTG: unbind host (actual OTG hosts: %d)\n", count);
+		if (!count) {
+			RES_FLAG (otg, OTG_HOST_READY | OTG_A_BUS_REQ);
+			SET_FLAG (otg, OTG_A_BUS_DROP);
+			if (IS_FLAG_SET (otg, OTG_FLAGS_ACTIV)) {
+				otg_req_state_chg (otg, OTG_HOST_READY);
+			}
+		}
+	}
+	return 0;
+}
+#endif /* CONFIG_USB_OTG */
+
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+/**
+ * \brief
+ * Bind/unbind the OTG controller to/from usb gadget
+ *
+ * \param  transceiver  this transceiver
+ * \param  gadget       usb gadget info
+ *
+ * \return error code
+ */
+static int otg1200_set_peripheral (struct otg_transceiver *transceiver,
+                                   struct usb_gadget *gadget)
+{
+	struct otg *otg = the_controller;
+	int flag = 0;
+
+	if (unlikely (transceiver != otg_to_transceiver (otg))) {
+		ERR ("USB OTG: unknown transceiver\n");
+		return -EINVAL;
+	}
+	if (gadget) {
+		if (transceiver->gadget) {
+			ERR ("USB gadget: OTG driver already registered\n");
+			return -EBUSY;
+		}
+		DBG ("bind OTG driver to USB gadget\n");
+		transceiver->gadget = gadget;
+		SET_FLAG (otg, OTG_GADGET_READY | OTG_B_BUS_REQ);
+
+		/* Now checking consistence ...                              */
+		/* Depending on the driver loading sequence is possible      */
+		/* that the "Load state defaults" function was already       */
+		/*  called so the state could be inconsistent.               */
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+		if (transceiver->companion &&
+		    !transceiver->companion->is_b_host) {
+			flag |= 1;
+		}
+#endif
+		if (transceiver->host && !transceiver->host->is_b_host) {
+			flag |= 1;
+		}
+		transceiver->gadget->is_a_peripheral = flag;
+
+		if (IS_FLAG_SET (otg, OTG_FLAGS_ACTIV)) {
+			otg_req_state_chg (otg, OTG_GADGET_READY);
+		}
+		if (IS_BIT_SET (OTG_STS_SESSVLD, readl (&otg->regs->sts)) &&
+		    (otg->transceiver.state & OTG_STATE_MASK)
+		     == OTG_STATE_B_PERIPHERAL) {
+			VDBG ("calling gadget: connect\n");
+			if (otg_gadget_extension.notify) {
+				otg_gadget_extension.notify (
+				OTG_GADGET_EVT_SVALID);
+			}
+		}
+		return 0;
+	}
+	else {
+		DBG ("unbind OTG driver from USB gadget\n");
+		RES_FLAG (otg, OTG_GADGET_READY | OTG_B_BUS_REQ);
+		if (IS_FLAG_SET (otg, OTG_FLAGS_ACTIV)) {
+			otg_req_state_chg (otg, OTG_GADGET_READY);
+		}
+		transceiver->gadget = NULL;
+		return 0;
+	}
+}
+#endif /* CONFIG_USB_OTGMUX || CONFIG_USB_OTGMUX_GADGET */
+
+#ifdef CONFIG_USB_OTG
+
+/**
+ * \brief
+ * Set host controllers power budget
+ *
+ * \param  transceiver  this transceiver
+ * \param  mA           value to fill in
+ *
+ * \return error code
+ */
+static int otg1200_set_power (struct otg_transceiver *transceiver,
+                              unsigned mA)
+{
+	struct otg *otg = the_controller;
+
+	if (unlikely (transceiver != otg_to_transceiver (otg))) {
+		ERR ("USB OTG: unknown transceiver\n");
+		return -EINVAL;
+	}
+	/* TODO kboge: do we need to support this ?                          */
+
+	DBG ("USB OTG: power budget change not supported\n");
+	return 0;
+}
+
+/**
+ * \brief
+ * Start a HNP request
+ *
+ * \param  transceiver  this transceiver
+ *
+ * \return error code
+ */
+static int otg1200_start_hnp (struct otg_transceiver *transceiver)
+{
+	struct otg *otg = the_controller;
+
+	if (unlikely (transceiver != otg_to_transceiver (otg))) {
+		ERR ("USB OTG: unknown transceiver\n");
+		return -ENODEV;
+	}
+	if (transceiver->default_a
+	    && (!transceiver->host || !transceiver->host->b_hnp_enable)
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+	    && (!transceiver->companion || !transceiver->companion->b_hnp_enable)
+#endif
+	   )
+		return -ENOTCONN;
+	if (!transceiver->default_a &&
+	    (!transceiver->gadget || !transceiver->gadget->b_hnp_enable))
+		return -ENOTCONN;
+
+	switch (transceiver->state & OTG_STATE_MASK) {
+	case OTG_STATE_B_HOST:
+	case OTG_STATE_A_HOST:
+	case OTG_STATE_A_PERIPHERAL:
+		break;
+	default:
+		ERR ("USB OTG: wrong OTG state for role swap\n");
+		return -EILSEQ;
+	}
+	return 0;
+}
+
+/**
+ * \brief
+ * Start a SRP request
+ *
+ * \param  transceiver  this transceiver
+ *
+ * \return error code
+ */
+static int otg1200_start_srp (struct otg_transceiver *transceiver)
+{
+	struct otg *otg = the_controller;
+
+	if (unlikely (transceiver != otg_to_transceiver (otg))) {
+		ERR ("USB OTG: unknown transceiver\n");
+		return -EINVAL;
+	}
+	if ((transceiver->state & OTG_STATE_MASK) != OTG_STATE_B_IDLE) {
+		RES_FLAG (otg, OTG_B_aSSN_REQ);
+		ERR ("USB OTG: wrong OTG state for SRP\n");
+		return -EBUSY;
+	}
+	SET_FLAG (otg, OTG_B_aSSN_REQ);
+	otg_req_state_chg (otg, OTG_B_aSSN_REQ);
+	return 0;
+}
+
+/**
+ * \brief
+ * Start a USB host enumeration
+ *
+ * \param  transceiver  this transceiver
+ *
+ * \return error code
+ */
+int otg_hnp_start_enum (struct otg_transceiver *transceiver)
+{
+	struct otg *otg = the_controller;
+	struct usb_bus *bus;
+	int status = 0;
+
+	if (unlikely (transceiver != otg_to_transceiver (otg))) {
+		ERR ("USB OTG: unknown transceiver\n");
+		return -EINVAL;
+	}
+	if (otg->transceiver.state == OTG_STATE_B_HOST) {
+
+		bus = otg->transceiver.host;
+
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+
+		if (!bus || !bus->is_b_host) {
+			bus = otg->transceiver.companion;
+		}
+#endif
+		if (bus && bus->is_b_host) {
+			DBG ("USB OTG: in HNP, start enumeration ...\n");
+			status = usb_bus_start_enum (bus, bus->otg_port);
+		}
+		else {
+			DBG ("USB OTG: no device to enumerate\n");
+		}
+	}
+	else {
+		DBG ("USB OTG: in HNP: wrong state %02x\n",
+		      otg->transceiver.state);
+	}
+	return status;
+}
+
+/**
+ * \brief
+ * OTG application request
+ *
+ * \param  params
+ *
+ * \return OTG_APP_REQ_ACK
+ */
+static int otg_app_request (u32 params)
+{
+	struct otg *otg = the_controller;
+	u32  flags = params;
+	struct usb_bus *bus;
+
+	if (OTG_UDC_RWK_REQ & flags) {
+
+		if (otg_gadget_extension.notify) {
+			otg_gadget_extension.notify (OTG_GADGET_REQ_WAKE);
+		}
+		flags &= ~((u32) OTG_UDC_RWK_REQ);
+	}
+
+	if (OTG_AB_HNP_REQ & flags) {
+
+		/* request HNP */
+
+		bus = otg->transceiver.host;
+		if (!bus->b_hnp_enable) {
+
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+			bus = otg->transceiver.companion;
+		}
+		if (!bus->b_hnp_enable) {
+#endif
+			INFO ("HNP not enabled, ignoring request\n");
+		}
+		else {
+			if (!otg1200_start_hnp (&otg->transceiver) &&
+			    bus->root_hub->children [bus->otg_port - 1]) {
+				usb_suspend_device (bus->root_hub->children [bus->otg_port - 1],
+				                    PM_SUSPEND_MEM);
+			}
+			else {
+				ERR ("no device found for HNP\n");
+			}
+		}
+		flags &= ~((u32) OTG_AB_HNP_REQ);
+	}
+
+	if (OTG_A_CLR_ERR & flags) {
+
+		/* request to clear error flags                              */
+
+		flags |= OTG_A_VBUS_FAILED;
+	}
+
+	/* create mask of flags to clear                                     */
+
+	flags &= (OTG_B_SRP_ERROR | OTG_A_VBUS_FAILED);
+
+	if (flags) {
+
+		/* reset error flags if requested                            */
+
+		RES_FLAG (otg, (flags));
+	}
+
+	/* prepare for pending requests (no more actions on OTG_A_bHNP_EN)   */
+
+	flags = params & SW_REQUEST_MASK;
+	SET_FLAG (otg, (flags));
+
+	if (OTG_A_BUS_DROP & flags) {
+
+		/* request to drop A-VBus: reset "rise" request if pending   */
+
+		flags &= ~OTG_A_BUS_REQ;
+		RES_FLAG (otg, OTG_A_BUS_REQ);
+	}
+	if (OTG_A_BUS_REQ & flags) {
+
+		/* request to rise A-VBus: reset "drop" request if pending   */
+
+		RES_FLAG (otg, OTG_A_BUS_DROP);
+	}
+	if (OTG_B_BUS_DIS & flags) {
+
+		/* request to disable B-dev: reset "ena" request if pending  */
+
+		flags &= ~OTG_B_BUS_REQ;
+		RES_FLAG (otg, OTG_B_BUS_REQ);
+	}
+	if (OTG_B_BUS_REQ & flags) {
+
+		/* request to enable B-dev: reset "disa" request if pending  */
+
+		RES_FLAG (otg, OTG_B_BUS_DIS);
+	}
+	if (flags) {
+
+		/* request still pending may force a state change            */
+
+		otg_req_state_chg (otg, flags);
+	}
+	return OTG_APP_REQ_ACK;
+}
+#endif /* CONFIG_USB_OTG */
+
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+/**
+ * \brief
+ * OTG application query
+ *
+ * \param  index   select status info data
+ *
+ * \return status
+ */
+static u32 otg_app_query (int index)
+{
+	struct otg *otg = the_controller;
+	u32  temp = 0;
+
+	if (index == 0) {
+		temp = otg->params |
+		       readl (&otg->regs->sts);
+
+/*** HS-A0 WA: BUG-3943: gadget phy suspend issue                          ***/
+#ifdef UDC_HSA0_WORKAROUNDS
+		if (((readl (&otg->regs->ctl) & OTG_CTL_MUX_MASK) ==
+		     OTG_CTL_ENABLE_UDC) &&
+		    ((temp & OTG_STS_PSUS) || (~temp & OTG_STS_VBUSVLD))) {
+			temp |= OTG_FLAGS_UDC_SUSP;
+		}
+#endif
+	}
+	else if (index == 1) {
+		temp = otg->transceiver.state;
+	}
+#ifdef OTG_HNP_ERR_LOG
+    if (hnp_err) {
+        temp |= OTG_FLAGS_HNP_ERR;
+    }
+#endif
+	return temp;
+}
+
+/**
+ * \brief
+ * OTG ISR calling the main state machine
+ *
+ * \param  irq    IRQ number
+ * \param  _dev  
+ * \param  r     
+ *
+ * \return IRQ_HANDLED (system code)
+ */
+static irqreturn_t otg_isr (int irq, void *dev, struct pt_regs *r)
+{
+	struct otg *otg = (struct otg *) dev;
+	u32         interrupts, int_mask, temp;
+
+	int_mask = readl (&otg->regs->inten);
+	if ((OTG_INT_GLOBAL & int_mask) &&
+	    (int_mask &= ~((u32) OTG_INT_GLOBAL)) &&
+	    (interrupts = int_mask &
+		          (temp = readl (&otg->regs->intr)))) {
+
+		writel (int_mask, &otg->regs->inten);
+		/* clear interrupt status */
+		writel (temp, &otg->regs->intr);
+/*
+#ifdef CONFIG_USB_OTG
+
+		if (GOT_EVENT (OTG_INT_PCC, interrupts) &&
+		    IS_BIT_SET (OTG_STS_PCON, readl (&otg->regs->sts))) {
+			otg_hnp_start_enum (&otg->transceiver);
+		}
+#endif */
+		/* filter out additional WA interrupts, they're done         */
+		/*       don't want to see them in the state machine         */
+
+		if (interrupts & ~state_mask) {
+
+			/* events pending for the state machine              */
+
+			otg_change_state (otg, (interrupts & ~state_mask),
+			                  &int_mask);
+		}
+
+		/* enable interrupts and keep information about WA ints:     */
+
+		state_mask = OTG_INT_ADDS & ~int_mask;
+		writel ((OTG_INT_ADDS | int_mask | OTG_INT_GLOBAL),
+		        &otg->regs->inten);
+	}
+	return IRQ_HANDLED;
+}
+#endif /* CONFIG_USB_OTG || CONFIG_USB_OTGMUX_GADGET */
+
+/**
+ * \brief
+ * OTG probe: init hardware, register the driver
+ *
+ * \param  otg   otg controller info
+ *
+ * \return  success
+ */
+static inline int __init otg_probe (struct otg *otg)
+{
+	int         retval;
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+	u32         temp;
+	int         i;
+#endif
+
+	/* initialize the OTG controller */
+
+	VDBG ("OTG init ...\n");
+
+#ifdef VERBOSE
+	/* print regs */
+	print_regs (otg);
+#endif
+	/* Make sure we'll remember the initial state                        */
+	init_state = readl (&otg->regs->ctl);
+	VDBG ("  OTG init state was %08x\n", init_state);
+
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	/* turn on the OTG controller                                        */
+
+	writel ((init_state | OTG_CTL_PADEN), &otg->regs->ctl);
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+#ifndef UDC_HSA0_WORKAROUNDS
+
+	/* Enable OTG hardware (incl. auto pull-up enable)                   */
+
+	writel ((readl (&dev->regs->cap) | OTG_CAP_APU), &otg->regs->cap);
+#endif
+
+	/* initialize flags                                                  */
+	otg->params = 0;
+#endif
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	/* make sure all interrupts are disabled                             */
+
+	writel (OTG_INT_DISALL, &otg->regs->inten);
+	writel (OTG_INT_ENALL, &otg->regs->intr);
+
+	/* Set multiplexer to neutral, get power control, drop VBus          */
+
+	if (((init_state & OTG_CTL_MUX_MASK) == OTG_CTL_ENABLE_UHC) &&
+	    ((((init_state & OTG_CTL_PPO) && (init_state & OTG_CTL_PPWR))) ||
+	     ((~init_state & OTG_CTL_PPO) &&
+	      (readl (&otg->regs->sts) & OTG_STS_SESSVLD)))) {
+
+		/* VBus still powered try to discharge VBus and set timer    */
+
+		DBG ("Setting init state, trying to discharge VBus ...\n");
+
+		for (i = 0; i < 4; i++) {
+			writel (TIMER_PERIOD, &otg->regs->tmr);
+			writel ((OTG_CTL_PADEN | OTG_CTL_IDSNSEN |
+			         OTG_CTL_PPO | OTG_CTL_DISCHRG |
+			         OTG_CTL_TMR_UNCOND), &otg->regs->ctl);
+			do { }
+			while (!(readl (&otg->regs->sts) & OTG_STS_TMH));
+		}
+		writel ((OTG_CTL_PADEN | OTG_CTL_IDSNSEN | OTG_CTL_PPO),
+		        &otg->regs->ctl);
+		writel (OTG_INT_ENALL, &otg->regs->intr);
+#ifdef DEBUG
+		if (readl (&otg->regs->sts) & OTG_STS_SESSVLD) {
+
+			DBG ("  VBus still high, external host connected\n");
+		}
+		else {
+
+			DBG ("  VBus discharged\n");
+		}
+#endif
+	}
+	else {
+		DBG ("Setting init state\n");
+
+		writel ((OTG_CTL_PADEN | OTG_CTL_IDSNSEN | OTG_CTL_PPO),
+		        &otg->regs->ctl);
+	}
+#endif /* CONFIG_USB_OTG || CONFIG_USB_OTGMUX_GADGET */
+
+#ifdef CONFIG_USB_OTGMUX_HOST
+
+	/* Set multiplexer to host                                           */
+	writel ((readl (&otg->regs->cap) & ~((u32) OTG_CAP_APU)),
+	        &otg->regs->cap);
+
+#ifdef CONFIG_SOC_AU1200
+
+	writel ((OTG_CTL_ENABLE_UHC | OTG_CTL_PPO | OTG_CTL_PPWR),
+	        &otg->regs->ctl);
+
+	/* Turn on VBus                                                      */
+	AU1000GPIO_CLR_BIT (USB_VBUS_GPIO);
+#else
+	writel (OTG_CTL_ENABLE_UHC, &otg->regs->ctl);
+#endif
+
+	INFO ("OTG functionality is disabled, port is assigned to host\n");
+#endif
+	VDBG ("OTG init done\n");
+
+#ifdef CONFIG_USB_OTG_TEST_INTERFACE
+
+	/* registering to the test driver */
+	usb_otg_test_register_driver (&otg_test_extension);
+#endif
+#ifndef CONFIG_TEST_MODE_ONLY
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	/* registering to the device driver */
+	if (usb_gadget_register_otg (otg_get_transceiver)) {
+		ERR ("gadget driver registration failed\n");
+		retval = -ENODEV;
+		goto err1;
+	}
+#endif
+#ifdef CONFIG_USB_OTG
+
+	/* registering to the usbcore */
+	if (usb_host_register_otg (otg_get_transceiver)) {
+		ERR ("usbcore registration failed\n");
+		retval = -ENODEV;
+		goto err2;
+	}
+#endif
+#endif
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	/* finally activate OTG functionality */
+	/* Enable timer interrupt, start timer, set state                    */
+
+	SET_OTG_TIMER (otg, IDSNS_WAIT);
+	CHANGE_STATE (otg, OTG_STATE_UNDEFINED, &temp);
+	CHECK_STATE (otg, OTG_STATE_UNDEFINED, &temp);
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget needs disconnect notification              ***/
+
+	/* clear all interrupts before enable */
+	writel (readl (&otg->regs->intr), &otg->regs->intr);
+
+	state_mask = ~temp & OTG_INT_ADDS;
+	writel ((OTG_INT_ADDS | temp | OTG_INT_GLOBAL), &otg->regs->inten);
+
+	DBG ("OTG-HW initialized, now checking ID ...\n");
+#endif
+
+	return 0;
+
+#ifndef CONFIG_TEST_MODE_ONLY
+#ifdef CONFIG_USB_OTG
+
+err2:
+
+#endif
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	usb_gadget_unregister_otg ();
+err1:
+
+#endif
+#endif
+#ifdef CONFIG_USB_OTG_TEST_INTERFACE
+
+	usb_otg_test_unregister_driver ();
+#endif
+	return retval;
+}
+
+/**
+ * \brief
+ * OTG remove: deregister the driver, clean-up hardware
+ *
+ * \param  otg   otg controller info
+ *
+ * \return void
+ */
+static inline void __exit otg_remove (struct otg *otg)
+{
+	int muxer;
+
+#ifndef CONFIG_TEST_MODE_ONLY
+#ifdef CONFIG_USB_OTG
+
+	/* unregistering from the usb core */
+	usb_host_deregister_otg ();
+#endif
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	/* unregistering from the usb gadget */
+	usb_gadget_unregister_otg ();
+
+#endif
+#endif
+#ifdef CONFIG_USB_OTG_TEST_INTERFACE
+
+	/* unregistering from the test driver */
+	usb_otg_test_unregister_driver ();
+#endif
+
+	/* clean up the OTG controller */
+
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	/* Disable all interrupts                                            */
+	writel (OTG_INT_DISALL, &otg->regs->inten);
+	writel (OTG_INT_ENALL, &otg->regs->intr);
+
+	/* reset state, terminate all connections                            */
+	CHANGE_STATE (otg, OTG_STATE_UNDEFINED, &state_mask);
+	CHECK_STATE (otg, OTG_STATE_UNDEFINED, &state_mask);
+	otg->params = 0;
+#endif
+
+	muxer = init_state & (OTG_CTL_ENABLE_UHC | OTG_CTL_ENABLE_UDC);
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+#ifdef UDC_HSA0_WORKAROUNDS
+
+	/* Don't assign the port to the device controller                    */
+
+	if (!(muxer ^ OTG_CTL_ENABLE_UDC)) {
+
+		init_state &= ~((u32) (OTG_CTL_MUX_MASK | OTG_CTL_PUEN));
+		muxer = OTG_CTL_DISABLE_ALL;
+	}
+	VDBG ("OTG writing back corrected init state: %08x\n", init_state);
+#else
+	/* Reset APU                                                         */
+
+	writel ((readl (&otg->regs->cap) & ~((u32) OTG_CAP_APU)),
+	        &otg->regs->cap);
+
+	VDBG ("OTG writing back init state: %08x\n", init_state);
+#endif
+	/* Now, that's the moment to remember                                */
+	/* Set dev muxer and pull up bits, turn off the OTG controller       */
+
+#ifdef CONFIG_SOC_AU1200
+
+	/* Turn off VBus                                                     */
+	AU1000GPIO_SET_BIT (USB_VBUS_GPIO);
+#endif
+	writel (init_state, &otg->regs->ctl);
+
+	if (!(muxer ^ OTG_CTL_ENABLE_UHC)) {
+		INFO ("disabling OTG-HW, port is assigned to host\n");
+	}
+	else if (!(muxer ^ OTG_CTL_ENABLE_UDC)) {
+		INFO ("disabling OTG-HW, port is assigned to device\n");
+	}
+	else {
+		INFO ("disabling OTG-HW, port is not assigned\n");
+	}
+
+	VDBG ("OTG exit: OTG-HW disabled\n");
+
+	if (!muxer) {
+		INFO ("OTG HW disabled, port is not assigned\n");
+	}
+}
+
+#ifdef CONFIG_SOC_AU1200
+#ifdef USE_AU1200_PCI_DUMMY
+
+/**
+ * \brief
+ * OTG dev probe: enable, init controller hardware
+ *
+ * \param pdev   dummy pci device pointer
+ *
+ * \return  success
+ */
+static int __init otg_pci_probe (struct pci_dev *pdev)
+{
+	struct otg *otg;
+	void       *base;
+	int         retval;
+	char        buf [8] = {0,0,0,0,0,0,0,0}, *bufp;
+
+	/* alloc, and start init */
+	otg = (struct otg *) kmalloc (sizeof(struct otg), SLAB_KERNEL);
+	if (!otg) {
+		ERR ("couldn't allocate memory for OTG driver\n");
+		retval = -ENOMEM;
+		goto err1;
+	}
+	DBG ( "kmalloc: OTG driver: %p\n", otg);
+
+	/* hold global device pointer */
+	the_controller = otg;
+
+	memset (otg, 0, sizeof(struct otg));
+	spin_lock_init (&otg->lock);
+
+	/*
+	* Fill in the dummy pci_dev. Only those members actually
+	* dereferenced in this driver are initialized.
+	*/
+	memset(pdev, 0, sizeof(struct pci_dev));
+	pdev->resource[0].name = "UOC Registers";
+	pdev->resource[0].start = USB_UOC_BASE;
+	pdev->resource[0].end = USB_UOC_BASE + USB_UOC_LEN - 1;
+	pdev->resource[0].flags = 0;
+	pdev->irq = AU1200_USB_INT;
+
+	otg->pdev = pdev;
+
+	au_writel ((au_readl (USB_MSR_BASE + USB_MSR_MCFG) |
+	            (1 << USBMSRMCFG_GMEMEN)), (USB_MSR_BASE + USB_MSR_MCFG));
+	au_readl (USB_MSR_BASE + USB_MSR_MCFG);
+	/* au_sync (); */
+	udelay (1000);
+	if (AU1000GPIO_INIT_BIT (USB_VBUS_GPIO))
+		WARN ("Couldn't initialize power switch GPIO\n");
+	otg->enabled = 1;
+
+	if (!request_mem_region (pdev->resource[0].start,
+	                         pdev->resource[0].end + 1
+	                         - pdev->resource[0].start,
+	                         driver_name)) {
+		ERR ("controller already in use\n");
+		retval = -EBUSY;
+		goto err3;
+	}
+	otg->region = 1;
+
+	base = ioremap_nocache (pdev->resource[0].start,
+	                        pdev->resource[0].end + 1
+	                        - pdev->resource[0].start);
+	if (!base) {
+		ERR ("couldn't map memory\n");
+		retval = -EFAULT;
+		goto err4;
+	}
+	otg->regs = (struct otg_regs *) base;
+	bufp = buf;
+
+	otg->chiprev = (u16) read_c0_prid() & 0xff;
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	/* OTG transceiver info */
+	otg->transceiver.dev = &pdev->dev;
+	otg_init_transceiver (otg_to_transceiver (otg));
+
+	/* make sure all interrupts are disabled */
+	writel (OTG_INT_DISALL, &otg->regs->inten);
+	writel (OTG_INT_ENALL, &otg->regs->intr);
+	readl (&otg->regs->inten);
+
+	/* irq setup after old hardware is cleaned up */
+	if (!pdev->irq) {
+		ERR ("No IRQ. Check system setup!\n");
+		retval = -ENODEV;
+		goto err5;
+	}
+	snprintf (buf, sizeof buf, "%d", pdev->irq);
+	bufp = buf;
+	if (request_irq (pdev->irq, otg_isr, SA_INTERRUPT | SA_SHIRQ,
+	                 driver_name, otg) != 0) {
+		ERR ("request interrupt %s failed\n", bufp);
+		retval = -EBUSY;
+		goto err5;
+	}
+	otg->got_irq = 1;
+
+	/* done */
+	INFO ("%s\n", driver_desc);
+	INFO ("irq %s, mem %08lx, chip rev %02x (Au1200 %s)\n",
+	      bufp, pdev->resource[0].start, otg->chiprev,
+	      (otg->chiprev ? "AC" : "AB"));
+
+#else /* CONFIG_USB_OTG || CONFIG_USB_OTGMUX_GADGET */
+
+	INFO ("%s\n", driver_desc);
+	INFO ("mem %08lx, chip rev %02x (Au1200 %s)\n",
+	      pdev->resource[0].start, otg->chiprev,
+	      (otg->chiprev ? "AC" : "AB"));
+#endif
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_IDPIN) || defined(CONFIG_USB_OTGMUX_HOST)
+
+	INFO ("using GPIO_%d for VBus control\n", USB_VBUS_GPIO);
+#endif
+	bufp = DRIVER_VERSION;
+	INFO ("driver version: %s\n", bufp);
+
+	if ((retval = otg_probe (otg)) == 0) {
+		pci_set_drvdata (pdev, otg);
+		return 0;
+	}
+
+	/* something went wrong */
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	otg->got_irq = 0;
+	free_irq (pdev->irq, otg);
+err5:
+
+#endif
+	otg->regs = NULL;
+	iounmap (base);
+err4:
+	otg->region = 0;
+	release_mem_region (pdev->resource[0].start,
+	                    pdev->resource[0].end + 1
+	                    - pdev->resource[0].start);
+err3:
+	otg->enabled = 0;
+	AU1000GPIO_TERM_BIT (USB_VBUS_GPIO);
+	au_writel ((au_readl (USB_MSR_BASE + USB_MSR_MCFG) &
+	            ~((u32) (1 << USBMSRMCFG_GMEMEN))),
+	           (USB_MSR_BASE + USB_MSR_MCFG));
+	au_readl (USB_MSR_BASE + USB_MSR_MCFG);
+	/* au_sync (); */
+	udelay (1000);
+
+	otg->pdev = NULL;
+	the_controller = NULL;
+	DBG ( "kfree: OTG driver: %p\n", otg);
+	kfree (otg);
+err1:
+	otg = NULL;
+	return retval;
+}
+
+/**
+ * \brief
+ * OTG dev remove: clean-up, disable controller hardware
+ *
+ * \param  pdev   dummy pci device info
+ *
+ * \return void
+ */
+static void __exit otg_pci_remove (struct pci_dev *pdev)
+{
+	struct otg *otg = pci_get_drvdata (pdev);
+
+	otg_remove (otg);
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	otg->got_irq = 0;
+	free_irq (pdev->irq, otg);
+#endif
+	iounmap (otg->regs);
+	otg->regs = NULL;
+	otg->region = 0;
+	release_mem_region (pdev->resource[0].start,
+	                    pdev->resource[0].end + 1
+	                    - pdev->resource[0].start);
+	otg->enabled = 0;
+	AU1000GPIO_TERM_BIT (USB_VBUS_GPIO);
+/*	au_writel ((au_readl (USB_MSR_BASE + USB_MSR_MCFG) &
+	            ~((u32) (1 << USBMSRMCFG_GMEMEN))),
+	           (USB_MSR_BASE + USB_MSR_MCFG)); */
+	au_readl (USB_MSR_BASE + USB_MSR_MCFG);
+	/* au_sync (); */
+	udelay (1000);
+	otg->pdev = NULL;
+	the_controller = NULL;
+	DBG ( "kfree: OTG driver: %p\n", otg);
+	kfree (otg);
+	otg = NULL;
+	pci_set_drvdata(pdev, NULL);
+}
+#else
+
+/**
+ * \brief
+ * OTG dev probe: enable, init controller hardware
+ *
+ * \param  dev   platform device info
+ *
+ * \return success
+ */
+static int __init otg_drv_probe (struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct otg *otg;
+	u32         resource, len, irq;
+	void       *base;
+	int         retval;
+	char        buf [8] = {0,0,0,0,0,0,0,0}, *bufp;
+
+	/* alloc, and start init */
+	otg = (struct otg *) kmalloc (sizeof(struct otg), SLAB_KERNEL);
+	if (!otg) {
+		ERR ("couldn't allocate memory for OTG driver\n");
+		retval = -ENOMEM;
+		goto err1;
+	}
+	DBG ( "kmalloc: OTG driver: %p\n", otg);
+
+	/* hold global device pointer */
+	the_controller = otg;
+
+	memset (otg, 0, sizeof(struct otg));
+	spin_lock_init (&otg->lock);
+
+	if (pdev->resource[0].flags != IORESOURCE_MEM) {
+		ERR ("resource is not IORESOURCE_MEM\n");
+		retval = -ENOMEM;
+		goto err2;
+	}
+	resource = pdev->resource[0].start;
+	len = pdev->resource[0].end + 1 - pdev->resource[0].start;
+	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+		ERR ("resource is not IORESOURCE_IRQ\n");
+		retval = -ENOMEM;
+		goto err2;
+	}
+	irq = pdev->resource[1].start;
+
+	otg->pdev = pdev;
+
+	au_writel ((au_readl (USB_MSR_BASE + USB_MSR_MCFG) |
+	            (1 << USBMSRMCFG_GMEMEN)), (USB_MSR_BASE + USB_MSR_MCFG));
+	au_readl (USB_MSR_BASE + USB_MSR_MCFG);
+	/* au_sync (); */
+	udelay (1000);
+	if (AU1000GPIO_INIT_BIT (USB_VBUS_GPIO))
+		WARN ("Couldn't initialize power switch GPIO\n");
+	otg->enabled = 1;
+
+	if (!request_mem_region (resource, len, driver_name)) {
+		ERR ("controller already in use\n");
+		retval = -EBUSY;
+		goto err3;
+	}
+	otg->region = 1;
+
+	base = ioremap_nocache (resource, len);
+	if (!base) {
+		ERR ("couldn't map memory\n");
+		retval = -EFAULT;
+		goto err4;
+	}
+	otg->regs = (struct otg_regs *) base;
+	bufp = buf;
+
+	otg->chiprev = (u16) read_c0_prid() & 0xff;
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	/* OTG transceiver info */
+	otg->transceiver.dev = dev;
+	otg_init_transceiver (otg_to_transceiver (otg));
+
+	/* make sure all interrupts are disabled */
+	writel (OTG_INT_DISALL, &otg->regs->inten);
+	writel (OTG_INT_ENALL, &otg->regs->intr);
+	readl (&otg->regs->inten);
+
+	/* irq setup after old hardware is cleaned up */
+	if (!irq) {
+		ERR ("No IRQ. Check system setup!\n");
+		retval = -ENODEV;
+		goto err5;
+	}
+	snprintf (buf, sizeof buf, "%d", irq);
+	bufp = buf;
+	if (request_irq (irq, otg_isr, SA_INTERRUPT | SA_SHIRQ,
+	                 driver_name, otg) != 0) {
+		ERR ("request interrupt %s failed\n", bufp);
+		retval = -EBUSY;
+		goto err5;
+	}
+	otg->got_irq = 1;
+
+	/* done */
+	INFO ("%s\n", driver_desc);
+	INFO ("irq %s, mem %08x, chip rev %02x (Au1200 %s)\n",
+	      bufp, resource, otg->chiprev, (otg->chiprev ? "AC" : "AB"));
+
+#else /* CONFIG_USB_OTG || CONFIG_USB_OTGMUX_GADGET */
+
+	INFO ("%s\n", driver_desc);
+	INFO ("mem %08x, chip rev %02x (Au1200 %s)\n",
+	      resource, otg->chiprev, (otg->chiprev ? "AC" : "AB"));
+#endif
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_IDPIN) || defined(CONFIG_USB_OTGMUX_HOST)
+
+	INFO ("using GPIO_%d for VBus control\n", USB_VBUS_GPIO);
+#endif
+	bufp = DRIVER_VERSION;
+	INFO ("driver version: %s\n", bufp);
+
+	if ((retval = otg_probe (otg)) == 0) {
+		dev_set_drvdata (dev, otg);
+		return 0;
+	}
+
+	/* something went wrong */
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	otg->got_irq = 0;
+	free_irq (irq, otg);
+err5:
+
+#endif
+	otg->regs = NULL;
+	iounmap (base);
+err4:
+	otg->region = 0;
+	release_mem_region (resource, len);
+err3:
+	otg->enabled = 0;
+	AU1000GPIO_TERM_BIT (USB_VBUS_GPIO);
+	au_writel ((au_readl (USB_MSR_BASE + USB_MSR_MCFG) &
+	            ~((u32) (1 << USBMSRMCFG_GMEMEN))),
+	           (USB_MSR_BASE + USB_MSR_MCFG));
+	au_readl (USB_MSR_BASE + USB_MSR_MCFG);
+	/* au_sync (); */
+	udelay (1000);
+err2:
+	otg->pdev = NULL;
+	the_controller = NULL;
+	DBG ( "kfree: OTG driver: %p\n", otg);
+	kfree (otg);
+err1:
+	otg = NULL;
+
+	return retval;
+}
+
+/**
+ * \brief
+ * OTG dev remove: clean-up, disable controller hardware
+ *
+ * \param  dev   platform device info
+ *
+ * \return void
+ */
+static int __exit otg_drv_remove (struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct otg *otg = dev_get_drvdata (dev);
+
+	otg_remove (otg);
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	otg->got_irq = 0;
+	free_irq (pdev->resource[1].start, otg);
+#endif
+	iounmap (otg->regs);
+	otg->regs = NULL;
+	otg->region = 0;
+	release_mem_region (pdev->resource[0].start,
+	                    pdev->resource[0].end + 1
+	                    - pdev->resource[0].start);
+	otg->enabled = 0;
+	AU1000GPIO_TERM_BIT (USB_VBUS_GPIO);
+/*	au_writel ((au_readl (USB_MSR_BASE + USB_MSR_MCFG) &
+	            ~((u32) (1 << USBMSRMCFG_GMEMEN))),
+	           (USB_MSR_BASE + USB_MSR_MCFG)); */
+	au_readl (USB_MSR_BASE + USB_MSR_MCFG);
+	/* au_sync (); */
+	udelay (1000);
+	otg->pdev = NULL;
+	the_controller = NULL;
+	DBG ( "kfree: OTG driver: %p\n", otg);
+	kfree (otg);
+	otg = NULL;
+	dev_set_drvdata(dev, NULL);
+	return 0;
+}
+#endif
+#else
+#ifdef CONFIG_PCI
+
+/**
+ * \brief
+ * OTG PCI probe: enable, init controller hardware
+ *
+ * \param  pdev   pci device info
+ * \param  id     pci ids
+ *
+ * \return  success
+ */
+static int __init otg_pci_probe (struct pci_dev *pdev,
+                                 const struct pci_device_id *id)
+{
+	struct otg *otg;
+	u32         resource, len;
+	void       *base;
+	int         retval;
+	char        buf [8] = {0,0,0,0,0,0,0,0}, *bufp;
+
+	/* alloc, and start init */
+	otg = (struct otg *) kmalloc (sizeof(struct otg), SLAB_KERNEL);
+	if (!otg) {
+		ERR ("couldn't allocate memory for OTG driver\n");
+		retval = -ENOMEM;
+		goto err1;
+	}
+	DBG ( "kmalloc: OTG driver: %p\n", otg);
+
+	/* hold global device pointer */
+	the_controller = otg;
+
+	memset (otg, 0, sizeof(struct otg));
+	spin_lock_init (&otg->lock);
+
+	otg->pdev = pdev;
+
+	/* now all the pci goodies ...                                       */
+	if (pci_enable_device (pdev) < 0) {
+		ERR ("couldn't enable PCI device\n");
+		retval = -ENODEV;
+		goto err2;
+	}
+	otg->enabled = 1;
+
+	resource = pci_resource_start (pdev, 0);
+	len = pci_resource_len (pdev, 0);
+
+	if (!request_mem_region (resource, len, driver_name)) {
+		ERR ("controller already in use\n");
+		retval = -EBUSY;
+		goto err3;
+	}
+	otg->region = 1;
+
+	base = ioremap_nocache (resource, len);
+	if (!base) {
+		ERR ("couldn't map memory\n");
+		retval = -EFAULT;
+		goto err4;
+	}
+	otg->regs = (struct otg_regs *) base;
+	bufp = buf;
+
+	pci_read_config_byte (pdev, PCI_REVISION_ID, (u8*) &otg->chiprev);
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	/* OTG transceiver info */
+
+	otg->transceiver.dev = &pdev->dev;
+	otg_init_transceiver (otg_to_transceiver (otg));
+
+	/* make sure all interrupts are disabled */
+	writel (OTG_INT_DISALL, &otg->regs->inten);
+	writel (OTG_INT_ENALL, &otg->regs->intr);
+	readl (&otg->regs->inten);
+
+	/* irq setup after old hardware is cleaned up */
+	if (!pdev->irq) {
+		ERR ("No IRQ. Check PCI setup!\n");
+		retval = -ENODEV;
+		goto err5;
+	}
+#ifndef __sparc__
+	snprintf (buf, sizeof buf, "%d", pdev->irq);
+	bufp = buf;
+#else
+	bufp = __irq_itoa(pdev->irq);
+#endif
+	if (request_irq (pdev->irq, otg_isr, SA_INTERRUPT | SA_SHIRQ,
+	                 driver_name, otg) != 0) {
+		ERR ("request interrupt %s failed\n", bufp);
+		retval = -EBUSY;
+		goto err5;
+	}
+	otg->got_irq = 1;
+
+	/* done */
+	INFO ("%s\n", driver_desc);
+	INFO ("irq %s, pci mem %08x, chip rev %02x (Geode5536 %s)\n",
+	      bufp, resource, otg->chiprev, (otg->chiprev - 1 ? "B1" : "A0"));
+
+#else /* CONFIG_USB_OTG || CONFIG_USB_OTGMUX_GADGET */
+
+	INFO ("%s\n", driver_desc);
+	INFO ("pci mem %08x, chip rev %02x (Geode5536 %s)\n",
+	      resource, otg->chiprev, (otg->chiprev - 1 ? "B1" : "A0"));
+#endif
+	bufp = DRIVER_VERSION;
+	INFO ("driver version: %s\n", bufp);
+
+	if ((retval = otg_probe (otg)) == 0) {
+		pci_set_drvdata (pdev, otg);
+		return 0;
+	}
+
+	/* something went wrong */
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	otg->got_irq = 0;
+	free_irq (pdev->irq, otg);
+err5:
+
+#endif
+	otg->regs = NULL;
+	iounmap (base);
+err4:
+	otg->region = 0;
+	release_mem_region (resource, len);
+err3:
+	otg->enabled = 0;
+	pci_disable_device (pdev);
+err2:
+	otg->pdev = NULL;
+	the_controller = NULL;
+	DBG ( "kfree: OTG driver: %p\n", otg);
+	kfree (otg);
+err1:
+	otg = NULL;
+	return retval;
+}
+
+/**
+ * \brief
+ * OTG PCI remove: clean-up, disable controller hardware
+ *
+ * \param  pdev   pci device info
+ *
+ * \return void
+ */
+static void __exit otg_pci_remove (struct pci_dev *pdev)
+{
+	struct otg *otg = pci_get_drvdata (pdev);
+
+	otg_remove (otg);
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/*** HS-A0 WA: BUG-3950: gadget disconnect notification                    ***/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+	otg->got_irq = 0;
+	free_irq (pdev->irq, otg);
+#endif
+	iounmap (otg->regs);
+	otg->regs = NULL;
+	otg->region = 0;
+	release_mem_region (pci_resource_start(pdev, 0),
+	                    pci_resource_len(pdev, 0));
+	otg->enabled = 0;
+	pci_disable_device (pdev);
+	otg->pdev = NULL;
+	the_controller = NULL;
+	DBG ( "kfree: OTG driver: %p\n", otg);
+	kfree (otg);
+	otg = NULL;
+	pci_set_drvdata(pdev, NULL);
+}
+#endif
+#endif
+
+
+/*****************************************************************************
+ *  More data
+ *****************************************************************************/
+
+#ifdef CONFIG_SOC_AU1200
+#ifndef USE_AU1200_PCI_DUMMY
+/**
+ * \brief
+ * driver struct to be used for driver registration
+ *
+ */
+static struct device_driver otg_device_driver = {
+	.name =		"au1xxx-uoc",
+	.bus =		&platform_bus_type,
+	.probe =	otg_drv_probe,
+	.remove =	otg_drv_remove,
+/* 	.suspend =	otg_drv_suspend, */
+/* 	.resume =	otg_drv_resume, */
+};
+#endif
+#else
+#ifdef CONFIG_PCI
+/**
+ * \brief
+ * PCI ID table
+ *
+ */
+static struct pci_device_id pci_ids [] = { {
+	.vendor =	PCI_VENDOR_ID_AMD,
+	.device =	PCI_DEVICE_ID_AMD_CS5536_UOC,
+	.subvendor =	PCI_ANY_ID,
+	.subdevice =	PCI_ANY_ID,
+	.class = 	0,
+	.class_mask = 	0,
+
+}, { /* end: all zeroes */ }
+};
+
+/**
+ * \brief
+ * PCI driver struct to be used for driver registration
+ * ( this is a "new style" PCI driver module )
+ *
+ */
+static struct pci_driver otg_pci_driver = {
+	.name =		(char *) driver_name,
+	.id_table =	pci_ids,
+	.probe =	otg_pci_probe,
+	.remove =	otg_pci_remove,
+/* 	.suspend =	otg_pci_suspend, */
+/* 	.resume =	otg_pci_resume, */
+};
+MODULE_DEVICE_TABLE (pci, pci_ids);
+#endif
+#endif
+
+/* This comment closes the module definition from above. There can be multiple 
+   definitions of this kind in a file. See the doxygen documentation for more
+   information. */
+/** \}*/
+
+MODULE_DESCRIPTION (DRIVER_DESC);
+MODULE_AUTHOR ("Karsten Boge");
+MODULE_LICENSE ("GPL");
+
+#ifdef CONFIG_SOC_AU1200
+#ifdef USE_AU1200_PCI_DUMMY
+
+static int __init init (void)
+{
+	return otg_pci_probe (&pdev_dummy);
+}
+static void __exit cleanup (void)
+{
+	otg_pci_remove (&pdev_dummy);
+}
+#else
+
+static int __init init (void)
+{
+        return driver_register (&otg_device_driver);
+}
+static void __exit cleanup (void)
+{
+	driver_unregister (&otg_device_driver);
+}
+#endif
+#else
+#ifdef CONFIG_PCI
+
+static int __init init (void)
+{
+        return pci_module_init (&otg_pci_driver);
+}
+static void __exit cleanup (void)
+{
+	pci_unregister_driver (&otg_pci_driver);
+}
+#endif
+#endif
+
+module_init (init);
+module_exit (cleanup);
diff --git a/drivers/usb/gadget/au1200uoc.h b/drivers/usb/gadget/au1200uoc.h
new file mode 100644
index 0000000..9b4503e
--- /dev/null
+++ b/drivers/usb/gadget/au1200uoc.h
@@ -0,0 +1,1338 @@
+/*
+ * AMD Au1200 USB OTG controller driver
+ */
+
+/*
+ * Copyright (C) 2005 AMD (http://www.amd.com)
+ * Author: Karsten Boge 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef AU1200UOC_H
+#define AU1200UOC_H
+
+
+/*****************************************************************************
+*  Config options
+*****************************************************************************/
+
+#ifndef UDC_HSA0_WORKAROUNDS
+#define UDC_HSA0_WORKAROUNDS
+#endif
+
+/* #define USE_AU1200_PCI_DUMMY */
+#undef USE_AU1200_PCI_DUMMY
+
+#ifdef CONFIG_USB_OTG
+#undef CONFIG_USB_OTGMUX_HOST
+#undef CONFIG_USB_OTGMUX_GADGET
+#undef CONFIG_USB_OTGMUX_IDPIN
+#endif
+
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+#undef CONFIG_USB_OTGMUX_HOST
+#ifndef CONFIG_USB_OTGMUX_GADGET
+#define CONFIG_USB_OTGMUX_GADGET
+#endif
+#endif
+
+#ifndef OTG_HSA0_HNP_WA
+#define OTG_HSA0_HNP_WA
+#endif
+
+#ifdef VERBOSE
+#ifndef DEBUG
+#define DEBUG
+#endif
+#endif
+
+
+/*****************************************************************************
+*  Constants
+*****************************************************************************/
+
+#define OTG_DRIVER_NAME        "au1200otg"
+
+#define OTG_CHIPREV            0
+
+#define OTG_FLAGS_ACTIV        (1<<19)   /* full OTG functionality is activ  */
+
+#ifndef CONFIG_SOC_AU1200
+#ifdef CONFIG_PCI
+#ifndef PCI_VENDOR_ID_AMD
+#define PCI_VENDOR_ID_AMD             0x1022
+#endif
+#ifndef PCI_DEVICE_ID_AMD_CS5536_UOC
+#define PCI_DEVICE_ID_AMD_CS5536_UOC  0x2097
+#endif
+#else
+#error "!!! UNKNOWN SYSTEM BUS TYPE !!!"
+#endif
+#endif
+
+#ifdef CONFIG_SOC_AU1200
+#define GPIO_2_BASE                   200
+#define GPIO_215                      215
+#define SYS_PINFUNC_P0A_GPIO          (2<<17)
+#ifdef CONFIG_MIPS_PB1200
+#define USB_VBUS_GPIO                 3     /* AU1000_GPIO_3 */
+#endif
+#ifdef CONFIG_MIPS_DB1200
+#define USB_VBUS_GPIO                 GPIO_215
+#endif
+#if !(defined(CONFIG_MIPS_PB1200) || defined(CONFIG_MIPS_DB1200))
+#error "!!! UNKNOWN AU1200 BOARD !!!"
+#endif
+#endif
+
+
+/**********************************
+*  UOC Register definitions
+**********************************/
+
+/* capabilities */
+#define OTG_CAP_APU            (1<<15)   /* automatic pull-up enable         */
+
+/* multiplexer */
+#define OTG_MUX_DISABLE_ALL    0         /* not assigned                     */
+#define OTG_MUX_ENABLE_UHC     (2<<0)    /* assigned to host                 */
+#define OTG_MUX_ENABLE_UDC     (3<<0)    /* assigned to device               */
+#define OTG_MUX_PUEN           (1<<2)    /* pull-up enable                   */
+#define OTG_MUX_VBUSVLD        (1<<8)    /* VBus valid                       */
+
+/* status */
+#define OTG_STS_ID             (1<<0)    /* ID pin status                    */
+#define OTG_STS_VBUSVLD        (1<<1)    /* VBus valid                       */
+#define OTG_STS_SESSVLD        (1<<2)    /* Session valid                    */
+#define OTG_STS_SESSEND        (1<<3)    /* Session end                      */
+#define OTG_STS_LST            (3<<4)    /* Line state                       */
+#define OTG_STS_LST_J          (1<<4)    /* Line state                       */
+#define OTG_STS_LST_K          (2<<4)    /* Line state                       */
+#define OTG_STS_PSPD           (3<<6)    /* Port speed                       */
+#define OTG_STS_PSPD_LS        (2<<6)    /* Port speed                       */
+#define OTG_STS_PSPD_FS        (1<<6)    /* Port speed                       */
+#define OTG_STS_FSOE           (1<<8)    /* FS output enable (OHC)           */
+#define OTG_STS_PCON           (1<<9)    /* Port connected                   */
+#define OTG_STS_PSUS           (1<<10)   /* Port suspended                   */
+#define OTG_STS_TMH            (1<<11)   /* Timer halted                     */
+#define OTG_STS_HNP_EN         (1<<12)   /* HNP enabled for B-dev            */
+#define OTG_STS_HNP_SUPP       (1<<13)   /* A-host supports HNP              */
+#define OTG_STS_HNP_ALTSUPP    (1<<14)   /* A-host supports alt. HNP         */
+#define OTG_STS_HNPSTS         (OTG_STS_HNP_EN | OTG_STS_HNP_SUPP | \
+                                OTG_STS_HNP_ALTSUPP)
+#define OTG_STS_OC             (1<<15)   /* over-current                     */
+#define OTG_STS_DPR            (1<<16)   /* Downstream port reset            */
+
+/* control */
+#define OTG_CTL_DISABLE_ALL    0         /* not assigned                     */
+#define OTG_CTL_ENABLE_UHC     (2<<0)    /* assigned to host                 */
+#define OTG_CTL_ENABLE_UDC     (3<<0)    /* assigned to device               */
+#define OTG_CTL_MUX_MASK       (3<<0)    /* port mux mask                    */
+#define OTG_CTL_PPWR           (1<<2)    /* port power switch                */
+#define OTG_CTL_PPO            (1<<3)    /* port power override              */
+#define OTG_CTL_CHRG           (1<<4)    /* charge VBus                      */
+#define OTG_CTL_DISCHRG        (1<<5)    /* discharge VBus                   */
+#define OTG_CTL_IDSNSEN        (1<<6)    /* ID sense enable, ID-PU           */
+#define OTG_CTL_PADEN          (1<<7)
+#define OTG_CTL_PUEN           (1<<8)    /* pull-up enable                   */
+#define OTG_CTL_DMPDEN         (1<<9)    /* pull-down enable                 */
+#define OTG_CTL_HNPSFEN        (1<<10)   /* HNP SET_FEATURE enable           */
+#define OTG_CTL_WPCS_DEAS      (2<<16)   /* deassert port connect            */
+#define OTG_CTL_WPCS_ASRT      (3<<16)   /* assert port connect              */
+#define OTG_CTL_WPSS_DEAS      (2<<18)   /* deassert port suspend            */
+#define OTG_CTL_WPSS_ASRT      (3<<18)   /* assert port suspend              */
+/* timer conditions */
+#define OTG_CTL_TMR_RLP        (1<<28)   /* timer reload policy              */
+#define OTG_CTL_TMR_ALL        (0xf<<24) /* stop timer                       */
+#define OTG_CTL_TMR_STOP       0         /* timer disabled                   */
+#define OTG_CTL_TMR_UNCOND     (1<<24)   /* count unconditionally            */
+#define OTG_CTL_TMR_SE0        (2<<24)   /* count if LSt = FS-SE0            */
+#define OTG_CTL_TMR_FSJ        (3<<24)   /* count if LSt = FS-J              */
+#define OTG_CTL_TMR_FSK        (4<<24)   /* count if LSt = FS-K              */
+#define OTG_CTL_TMR_NOSE0      (5<<24)   /* count if LSt <> FS-SE0           */
+#define OTG_CTL_TMR_NORX       (6<<24)   /* count if Rx inactiv              */
+#define OTG_CTL_TMR_ID         (7<<24)   /* count if ID = 0                  */
+
+/* interrupts */
+#define OTG_INT_GLOBAL         (1<<31)   /* global interrupt enable          */
+#define OTG_INT_ENALL          0x7fff    /* enable all                       */
+#define OTG_INT_DISALL         0         /* disable all                      */
+#define OTG_INT_IDC            (1<<0)    /* ID pin change                    */
+#define OTG_INT_VBVC           (1<<1)    /* VBUS valid change                */
+#define OTG_INT_SVC            (1<<2)    /* Session valid change             */
+#define OTG_INT_SEC            (1<<3)    /* Session end change               */
+#define OTG_INT_LSTC           (1<<4)    /* Line state change                */
+#define OTG_INT_PSPDC          (1<<5)    /* Port speed change                */
+#define OTG_INT_FSOEC          (1<<6)    /* FS/LS OE change                  */
+#define OTG_INT_HSDD           (1<<7)    /* HS disconnect detected           */
+#define OTG_INT_RXACT          (1<<8)    /* Rx activity detected             */
+#define OTG_INT_PCC            (1<<9)    /* Port connect change              */
+#define OTG_INT_PSC            (1<<10)   /* Port suspend change              */
+#define OTG_INT_TMX            (1<<11)   /* Timer expired                    */
+#define OTG_INT_HNPFC          (1<<12)   /* HNP feature change               */
+#define OTG_INT_OCD            (1<<13)   /* over current detected            */
+#define OTG_INT_DPRC           (1<<14)   /* Downstream port reset change     */
+
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3950: gadget SV notification                            ***/
+#ifdef UDC_HSA0_WORKAROUNDS
+#define OTG_INT_ADDS   OTG_INT_SVC
+#endif
+
+
+/**********************************
+*  OTG state dependend data
+**********************************/
+
+/*
+ * generic
+ */
+#define OTG_CTL_DEFAULT                      (OTG_CTL_PADEN | \
+                                              OTG_CTL_IDSNSEN)
+#define OTG_CTL_HOST_DEFAULT                 (OTG_CTL_DEFAULT | \
+                                              OTG_CTL_ENABLE_UHC)
+#ifdef UDC_HSA0_WORKAROUNDS
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+#ifdef CONFIG_USB_OTG
+#define OTG_CTL_PERIPHERAL_DEFAULT           (OTG_CTL_DEFAULT | \
+                                              OTG_CTL_HNPSFEN | \
+                                              OTG_CTL_ENABLE_UDC | \
+                                              OTG_CTL_PPO | OTG_CTL_PUEN)
+#else
+#define OTG_CTL_PERIPHERAL_DEFAULT           (OTG_CTL_DEFAULT | \
+                                              OTG_CTL_ENABLE_UDC | \
+                                              OTG_CTL_PPO | OTG_CTL_PUEN)
+#endif
+#else
+#ifdef CONFIG_USB_OTG
+#define OTG_CTL_PERIPHERAL_DEFAULT           (OTG_CTL_DEFAULT | \
+                                              OTG_CTL_HNPSFEN | \
+                                              OTG_CTL_ENABLE_UDC | OTG_CTL_PPO)
+#else
+#define OTG_CTL_PERIPHERAL_DEFAULT           (OTG_CTL_DEFAULT | \
+                                              OTG_CTL_ENABLE_UDC | OTG_CTL_PPO)
+#endif
+#endif
+
+#define OTG_INT_DEFAULT                      OTG_INT_IDC
+
+/*
+ * OTG_STATE_UNDEFINED
+ */
+#define OTG_STATE_UNDEFINED_CONTROL          (OTG_CTL_DEFAULT | OTG_CTL_PPO | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_UNDEFINED_STATUS           0
+#define OTG_STATE_UNDEFINED_STATUS_MASK      0
+#define OTG_STATE_UNDEFINED_INTERRUPTS       OTG_INT_TMX
+
+/*
+ * OTG_STATE_A_IDLE
+ */
+#define OTG_STATE_A_IDLE_CONTROL             (OTG_CTL_DEFAULT | OTG_CTL_PPO)
+#define OTG_STATE_A_IDLE_STATUS              0
+#define OTG_STATE_A_IDLE_STATUS_MASK         0
+#define OTG_STATE_A_IDLE_INTERRUPTS          (OTG_INT_DEFAULT | OTG_INT_SVC | \
+                                              OTG_INT_LSTC)
+
+/*
+ * OTG_STATE_A_IDLE_WAIT_DP
+ */
+#define OTG_STATE_A_IDLE_WAIT_DP_CONTROL     (OTG_STATE_A_IDLE_CONTROL | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_IDLE_WAIT_DP_STATUS      0
+#define OTG_STATE_A_IDLE_WAIT_DP_STATUS_MASK 0
+#define OTG_STATE_A_IDLE_WAIT_DP_INTERRUPTS  (OTG_STATE_A_IDLE_INTERRUPTS | \
+                                              OTG_INT_TMX)
+
+/*
+ * OTG_STATE_A_IDLE_WAIT_VP
+ */
+#define OTG_STATE_A_IDLE_WAIT_VP_CONTROL     (OTG_STATE_A_IDLE_CONTROL | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_IDLE_WAIT_VP_STATUS      0
+#define OTG_STATE_A_IDLE_WAIT_VP_STATUS_MASK 0
+#define OTG_STATE_A_IDLE_WAIT_VP_INTERRUPTS  (OTG_STATE_A_IDLE_INTERRUPTS | \
+                                              OTG_INT_TMX)
+
+/*
+ * OTG_STATE_A_IDLE_WAIT_MP
+ */
+#define OTG_STATE_A_IDLE_WAIT_MP_CONTROL     (OTG_STATE_A_IDLE_CONTROL | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_IDLE_WAIT_MP_STATUS      0
+#define OTG_STATE_A_IDLE_WAIT_MP_STATUS_MASK 0
+#define OTG_STATE_A_IDLE_WAIT_MP_INTERRUPTS  (OTG_STATE_A_IDLE_INTERRUPTS | \
+                                              OTG_INT_TMX)
+
+/*
+ * OTG_STATE_A_IDLE_WAIT_DV
+ */
+#define OTG_STATE_A_IDLE_WAIT_DV_CONTROL     (OTG_STATE_A_IDLE_CONTROL | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_IDLE_WAIT_DV_STATUS      0
+#define OTG_STATE_A_IDLE_WAIT_DV_STATUS_MASK 0
+#define OTG_STATE_A_IDLE_WAIT_DV_INTERRUPTS  (OTG_STATE_A_IDLE_INTERRUPTS | \
+                                              OTG_INT_TMX)
+
+/*
+ * OTG_STATE_A_WAIT_VRISE
+ */
+#define OTG_STATE_A_WAIT_VRISE_CONTROL       (OTG_CTL_HOST_DEFAULT | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_WAIT_VRISE_STATUS        0
+#define OTG_STATE_A_WAIT_VRISE_STATUS_MASK   0
+#define OTG_STATE_A_WAIT_VRISE_INTERRUPTS    (OTG_INT_DEFAULT | OTG_INT_TMX | \
+                                              OTG_INT_VBVC)
+
+/*
+ * OTG_STATE_A_WAIT_BCON
+ */
+#define OTG_STATE_A_WAIT_BCON_CONTROL        OTG_CTL_HOST_DEFAULT
+#define OTG_STATE_A_WAIT_BCON_STATUS         0
+#define OTG_STATE_A_WAIT_BCON_STATUS_MASK    0
+#define OTG_STATE_A_WAIT_BCON_INTERRUPTS     (OTG_INT_DEFAULT | OTG_INT_TMX | \
+                                              OTG_INT_VBVC | OTG_INT_PCC)
+
+/*
+ * OTG_STATE_A_WAIT_BCON_VB
+ */
+#define OTG_STATE_A_WAIT_BCON_VB_CONTROL     (OTG_STATE_A_WAIT_BCON_CONTROL | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_WAIT_BCON_VB_STATUS      0
+#define OTG_STATE_A_WAIT_BCON_VB_STATUS_MASK 0
+#define OTG_STATE_A_WAIT_BCON_VB_INTERRUPTS  OTG_STATE_A_WAIT_BCON_INTERRUPTS
+
+/*
+ * OTG_STATE_A_HOST
+ */
+#define OTG_STATE_A_HOST_CONTROL             OTG_CTL_HOST_DEFAULT
+#define OTG_STATE_A_HOST_STATUS              0
+#define OTG_STATE_A_HOST_STATUS_MASK         0
+#ifdef CONFIG_USB_OTG
+#ifndef VERBOSE
+#define OTG_STATE_A_HOST_INTERRUPTS          (OTG_INT_DEFAULT | \
+                                              OTG_INT_VBVC | OTG_INT_DPRC | \
+                                              OTG_INT_PCC | OTG_INT_PSC)
+#else
+#define OTG_STATE_A_HOST_INTERRUPTS          (OTG_INT_DEFAULT | \
+                                              OTG_INT_VBVC | OTG_INT_DPRC | \
+                                              OTG_INT_PCC | OTG_INT_PSC | \
+                                              OTG_INT_PSPDC)
+                                              /* OTG_INT_LSTC */
+#endif
+#else
+        /* IDPIN mode only                                                   */
+#define OTG_STATE_A_HOST_INTERRUPTS          OTG_INT_IDC
+#endif
+
+/*
+ * OTG_STATE_A_SUSPEND
+ */
+#define OTG_STATE_A_SUSPEND_CONTROL          (OTG_CTL_HOST_DEFAULT | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_SUSPEND_STATUS           0
+#define OTG_STATE_A_SUSPEND_STATUS_MASK      0
+#define OTG_STATE_A_SUSPEND_INTERRUPTS       (OTG_INT_DEFAULT | OTG_INT_TMX | \
+                                              OTG_INT_VBVC |  OTG_INT_DPRC | \
+                                              OTG_INT_PCC | OTG_INT_PSC)
+
+/*
+ * OTG_STATE_A_PERIPHERAL
+ */
+#define OTG_STATE_A_PERIPHERAL_CONTROL       (OTG_CTL_PERIPHERAL_DEFAULT | \
+                                              OTG_CTL_PPWR | OTG_CTL_DMPDEN)
+#define OTG_STATE_A_PERIPHERAL_STATUS        0
+#define OTG_STATE_A_PERIPHERAL_STATUS_MASK   0
+#ifndef VERBOSE
+#define OTG_STATE_A_PERIPHERAL_INTERRUPTS    (OTG_INT_DEFAULT | \
+                                              OTG_INT_VBVC | OTG_INT_OCD | \
+                                              OTG_INT_PCC | OTG_INT_PSC)
+#else
+#define OTG_STATE_A_PERIPHERAL_INTERRUPTS    (OTG_INT_DEFAULT | \
+                                              OTG_INT_VBVC | OTG_INT_OCD | \
+                                              OTG_INT_PCC | OTG_INT_PSC | \
+                                              OTG_INT_PSPDC)
+                                              /* OTG_INT_LSTC */
+#endif
+
+/*
+ * OTG_STATE_A_VBUS_ERR
+ */
+#define OTG_STATE_A_VBUS_ERR_CONTROL         (OTG_CTL_HOST_DEFAULT | \
+                                              OTG_CTL_PPO | OTG_CTL_DISCHRG)
+#define OTG_STATE_A_VBUS_ERR_STATUS          0
+#define OTG_STATE_A_VBUS_ERR_STATUS_MASK     0
+#define OTG_STATE_A_VBUS_ERR_INTERRUPTS      OTG_INT_DEFAULT
+
+/*
+ * OTG_STATE_A_WAIT_VFALL
+ */
+#define OTG_STATE_A_WAIT_VFALL_CONTROL       (OTG_CTL_HOST_DEFAULT | \
+                                              OTG_CTL_PPO)
+#define OTG_STATE_A_WAIT_VFALL_STATUS        0
+#define OTG_STATE_A_WAIT_VFALL_STATUS_MASK   0
+#define OTG_STATE_A_WAIT_VFALL_INTERRUPTS    (OTG_INT_DEFAULT | OTG_INT_SEC)
+
+/*
+ * OTG_STATE_A_WAIT_VFALL_DN
+ */
+#define OTG_STATE_A_WAIT_VFALL_DN_CONTROL    (OTG_STATE_A_WAIT_VFALL_CONTROL | \
+                                              OTG_CTL_DISCHRG)
+#define OTG_STATE_A_WAIT_VFALL_DN_STATUS      0
+#define OTG_STATE_A_WAIT_VFALL_DN_STATUS_MASK 0
+#define OTG_STATE_A_WAIT_VFALL_DN_INTERRUPTS  OTG_STATE_A_WAIT_VFALL_INTERRUPTS
+
+/*
+ * OTG_STATE_A_WAIT_BDISCON
+ */
+#define OTG_STATE_A_WAIT_BDISCON_CONTROL     (OTG_CTL_DEFAULT | \
+                                              OTG_CTL_PPO | OTG_CTL_PPWR | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_A_WAIT_BDISCON_STATUS      0
+#define OTG_STATE_A_WAIT_BDISCON_STATUS_MASK 0
+#define OTG_STATE_A_WAIT_BDISCON_INTERRUPTS  (OTG_INT_DEFAULT | OTG_INT_TMX | \
+                                              OTG_INT_VBVC | OTG_INT_OCD | \
+                                              OTG_INT_PSPDC | OTG_INT_LSTC)
+
+/*
+ * OTG_STATE_B_IDLE
+ */
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+#ifdef UDC_HSA0_WORKAROUNDS
+#define OTG_STATE_B_IDLE_CONTROL             (OTG_CTL_PERIPHERAL_DEFAULT & \
+                                              ~((u32) (OTG_CTL_PUEN | \
+                                                       OTG_CTL_ENABLE_UDC)))
+#else
+#define OTG_STATE_B_IDLE_CONTROL             OTG_CTL_PERIPHERAL_DEFAULT
+#endif
+#define OTG_STATE_B_IDLE_STATUS              0
+#define OTG_STATE_B_IDLE_STATUS_MASK         0
+#ifdef CONFIG_USB_OTG
+#define OTG_STATE_B_IDLE_INTERRUPTS          (OTG_INT_DEFAULT | OTG_INT_SVC)
+#else
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+        /* IDPIN mode                                                        */
+#define OTG_STATE_B_IDLE_INTERRUPTS          (OTG_INT_IDC | OTG_INT_SVC)
+#else
+        /* gadget mode                                                       */
+#define OTG_STATE_B_IDLE_INTERRUPTS          OTG_INT_SVC
+#endif
+#endif
+
+/*
+ * OTG_STATE_B_PERIPHERAL
+ */
+#define OTG_STATE_B_PERIPHERAL_CONTROL       (OTG_CTL_PERIPHERAL_DEFAULT | \
+                                              OTG_CTL_DMPDEN)
+#define OTG_STATE_B_PERIPHERAL_STATUS        0
+#define OTG_STATE_B_PERIPHERAL_STATUS_MASK   0
+#ifdef CONFIG_USB_OTG
+#ifndef VERBOSE
+#define OTG_STATE_B_PERIPHERAL_INTERRUPTS    (OTG_INT_DEFAULT | OTG_INT_SVC | \
+                                              OTG_INT_PCC | OTG_INT_PSC | \
+                                              OTG_INT_HNPFC)
+#else
+#define OTG_STATE_B_PERIPHERAL_INTERRUPTS    (OTG_INT_DEFAULT | OTG_INT_SVC | \
+                                              OTG_INT_PCC | OTG_INT_PSC | \
+                                              OTG_INT_HNPFC | OTG_INT_PSPDC)
+                                              /* OTG_INT_LSTC */
+#endif
+#else
+#ifdef CONFIG_USB_OTGMUX_IDPIN
+        /* IDPIN mode                                                        */
+#define OTG_STATE_B_PERIPHERAL_INTERRUPTS    (OTG_INT_IDC | OTG_INT_SVC)
+#else
+        /* gadget mode                                                       */
+#define OTG_STATE_B_PERIPHERAL_INTERRUPTS    OTG_INT_SVC
+#endif
+#endif
+
+/*
+ * OTG_STATE_B_PERIPHERAL_WT
+ */
+#define OTG_STATE_B_PERIPHERAL_WT_CONTROL    (OTG_STATE_B_PERIPHERAL_CONTROL | \
+                                              OTG_CTL_PPO | OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_PERIPHERAL_WT_STATUS      0
+#define OTG_STATE_B_PERIPHERAL_WT_STATUS_MASK 0
+#define OTG_STATE_B_PERIPHERAL_WT_INTERRUPTS (OTG_STATE_B_PERIPHERAL_INTERRUPTS \
+                                              | OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_PERIPHERAL_DC
+ */
+#define OTG_STATE_B_PERIPHERAL_DC_CONTROL    (OTG_CTL_HOST_DEFAULT | \
+                                              OTG_CTL_PPO | OTG_CTL_DMPDEN | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_PERIPHERAL_DC_STATUS      0
+#define OTG_STATE_B_PERIPHERAL_DC_STATUS_MASK 0
+#define OTG_STATE_B_PERIPHERAL_DC_INTERRUPTS (OTG_STATE_B_PERIPHERAL_INTERRUPTS \
+                                              | OTG_INT_TMX | OTG_INT_LSTC)
+
+/*
+ * OTG_STATE_B_WAIT_ACON
+ */
+#define OTG_STATE_B_WAIT_ACON_CONTROL        (OTG_CTL_HOST_DEFAULT | \
+                                              OTG_CTL_PPO | OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_WAIT_ACON_STATUS         0
+#define OTG_STATE_B_WAIT_ACON_STATUS_MASK    0
+#define OTG_STATE_B_WAIT_ACON_INTERRUPTS     (OTG_INT_DEFAULT | OTG_INT_SVC | \
+                                              OTG_INT_PCC | OTG_INT_PSC | \
+                                              OTG_INT_HNPFC | OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_HOST
+ */
+#define OTG_STATE_B_HOST_CONTROL             (OTG_CTL_HOST_DEFAULT | \
+                                              OTG_CTL_PPO)
+#define OTG_STATE_B_HOST_STATUS              0
+#define OTG_STATE_B_HOST_STATUS_MASK         0
+#ifndef VERBOSE
+#define OTG_STATE_B_HOST_INTERRUPTS          (OTG_INT_DEFAULT | OTG_INT_SVC | \
+                                              OTG_INT_PCC)
+#else
+#define OTG_STATE_B_HOST_INTERRUPTS          (OTG_INT_DEFAULT | OTG_INT_SVC | \
+                                              OTG_INT_PCC | OTG_INT_SVC | \
+                                              OTG_INT_PSPDC)
+                                              /* OTG_INT_LSTC */
+#endif
+
+/*
+ * OTG_STATE_B_HOST_WT
+ */
+#define OTG_STATE_B_HOST_WT_CONTROL          (OTG_STATE_B_HOST_CONTROL | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_HOST_WT_STATUS           0
+#define OTG_STATE_B_HOST_WT_STATUS_MASK      0
+#ifndef VERBOSE
+#define OTG_STATE_B_HOST_WT_INTERRUPTS       (OTG_INT_DEFAULT | OTG_INT_SVC | \
+                                              OTG_INT_PCC | OTG_INT_TMX)
+#else
+#define OTG_STATE_B_HOST_WT_INTERRUPTS       (OTG_STATE_B_HOST_INTERRUPTS | \
+                                              OTG_INT_TMX)
+/*
+#define OTG_STATE_B_HOST_WT_INTERRUPTS       (OTG_INT_DEFAULT | OTG_INT_SVC | \
+                                              OTG_INT_PCC | OTG_INT_DPRC | \
+                                              OTG_INT_TMX | OTG_INT_PSPDC) */
+                                              /* OTG_INT_LSTC */
+#endif
+
+/*
+ * OTG_STATE_B_SRP_INIT
+ */
+#define OTG_STATE_B_SRP_INIT_CONTROL         OTG_STATE_B_IDLE_CONTROL
+#define OTG_STATE_B_SRP_INIT_STATUS          0
+#define OTG_STATE_B_SRP_INIT_STATUS_MASK     0
+#define OTG_STATE_B_SRP_INIT_INTERRUPTS      OTG_INT_DEFAULT 
+
+/*
+ * OTG_STATE_B_SRP_WTSE0
+ */
+#define OTG_STATE_B_SRP_WAIT_SE0_CONTROL     (OTG_STATE_B_SRP_INIT_CONTROL | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_SRP_WAIT_SE0_STATUS      0
+#define OTG_STATE_B_SRP_WAIT_SE0_STATUS_MASK 0
+#define OTG_STATE_B_SRP_WAIT_SE0_INTERRUPTS  (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+                                              | OTG_INT_TMX | OTG_INT_LSTC)
+
+/*
+ * OTG_STATE_B_SRP_D_PLS
+ *
+ * note: changing to this state requires an additional call:
+ *       set_srp_conditions (dev);
+ *       reset_srp_conditions (dev) is required for the next state
+ */
+/*** HS-A0 WA: BUG-3885: VB_SESS_VLD value too high                        ***/
+/*** HS-A0 WA: BUG-3943: gadget suspend issue                              ***/
+/* note: set_/reset_srp_conditions is not needed if HS-A0 WAs are active
+ */
+#ifdef UDC_HSA0_WORKAROUNDS
+#define OTG_STATE_B_SRP_D_PULSE_CONTROL      (OTG_CTL_PERIPHERAL_DEFAULT | \
+                                              OTG_CTL_PUEN | \
+                                              OTG_CTL_TMR_UNCOND)
+#else
+#define OTG_STATE_B_SRP_D_PULSE_CONTROL      (OTG_STATE_B_SRP_INIT_CONTROL | \
+                                              OTG_CTL_PUEN | \
+                                              OTG_CTL_TMR_UNCOND)
+#endif
+#define OTG_STATE_B_SRP_D_PULSE_STATUS       0
+#define OTG_STATE_B_SRP_D_PULSE_STATUS_MASK  0
+#define OTG_STATE_B_SRP_D_PULSE_INTERRUPTS   (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+                                              | OTG_INT_SEC | OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_SRP_V_PLS
+ */
+#define OTG_STATE_B_SRP_V_PULSE_CONTROL      (OTG_STATE_B_SRP_INIT_CONTROL | \
+                                              OTG_CTL_CHRG | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_SRP_V_PULSE_STATUS       0
+#define OTG_STATE_B_SRP_V_PULSE_STATUS_MASK  0
+#define OTG_STATE_B_SRP_V_PULSE_INTERRUPTS   (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+                                              | OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_SRP_V_DCG
+ */
+#define OTG_STATE_B_SRP_V_DCHRG_CONTROL      (OTG_STATE_B_SRP_INIT_CONTROL | \
+                                              OTG_CTL_DISCHRG | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_SRP_V_DCHRG_STATUS       0
+#define OTG_STATE_B_SRP_V_DCHRG_STATUS_MASK  0
+#define OTG_STATE_B_SRP_V_DCHRG_INTERRUPTS   (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+                                              | OTG_INT_TMX)
+
+/*
+ * OTG_STATE_B_SRP_WTVB
+ */
+#define OTG_STATE_B_SRP_WAIT_VBUS_CONTROL    (OTG_STATE_B_SRP_INIT_CONTROL | \
+                                              OTG_CTL_TMR_UNCOND)
+#define OTG_STATE_B_SRP_WAIT_VBUS_STATUS      0
+#define OTG_STATE_B_SRP_WAIT_VBUS_STATUS_MASK 0
+#define OTG_STATE_B_SRP_WAIT_VBUS_INTERRUPTS (OTG_STATE_B_SRP_INIT_INTERRUPTS \
+                                              | OTG_INT_SVC | OTG_INT_TMX)
+
+/*********************************/
+
+/* other */
+
+#define OTG_APP_REQ_ACK        0
+
+
+/*****************************************************************************
+*  Types
+*****************************************************************************/
+
+
+/*****************************************************************************
+*  Macros
+*****************************************************************************/
+
+/* printing messages */
+#ifndef INFO
+#define INFO(args...) \
+        printk(KERN_INFO DRIVER_NAME_FOR_PRINT ": " args)
+#endif
+
+#ifndef WARN
+#define WARN(args...) \
+        printk(KERN_WARNING DRIVER_NAME_FOR_PRINT " warning: " args)
+#endif
+
+#ifndef ERR
+#define ERR(args...) \
+        printk(KERN_ERR DRIVER_NAME_FOR_PRINT " error: " args)
+#endif
+
+#ifndef DBG 
+#ifdef DEBUG
+#define DBG(args...) \
+        printk(KERN_DEBUG DRIVER_NAME_FOR_PRINT " debug: " args)
+#else
+#define DBG(args...) \
+        do {} while (0)
+#endif
+#endif
+
+#ifndef VDBG 
+#ifdef VERBOSE
+#define VDBG DBG
+#else
+#define VDBG(args...) \
+	do { } while (0)
+#endif
+#endif
+
+/****************************************************************************/
+
+/* this should always return "1" and print something in verbose mode */
+#ifdef VERBOSE
+#define VDBG_SPC(fmt,args...) \
+	(VDBG (fmt, args) ? 1 : 1)
+#else
+#define VDBG_SPC(fmt,args...) 1
+#endif
+
+/* query bit(s) (long: 32-bit access) */
+#define IS_BIT_RES(data, code) \
+	(!((data) & (code)) ? \
+	 (VDBG_SPC ("  OTG HW status: %s is reset\n", #data)) : 0)
+
+#define IS_BIT_SET(data, code) \
+	(((data) & (code)) ? \
+	 (VDBG_SPC ("  OTG HW status: %s is set\n", #data)) : 0)
+
+/* query SW flag(s) */
+#define IS_FLAG_RES(dev, data) \
+	(!((data) & (dev)->params) ? \
+	 (VDBG_SPC ("  OTG SW status: %s is reset\n", #data)) : 0)
+
+#define IS_FLAG_SET(dev, data) \
+	(((data) & (dev)->params) ? \
+	 (VDBG_SPC ("  OTG SW status: %s is set\n", #data)) : 0)
+
+/* query event bit(s) */
+#define GOT_EVENT(data, code) \
+	(((data) & (code)) ? \
+	 (VDBG_SPC ("  OTG event: %s\n", #data)) : 0)
+
+/* set SW flag */
+#ifdef VERBOSE
+#define SET_FLAG(dev, data) \
+	if (!((data) & (dev)->params)) \
+		DBG ("  OTG SW status change: set flag %s\n", #data); \
+	(dev)->params |= (data)
+#else
+#define SET_FLAG(dev, data) \
+	(dev)->params |= (data)
+#endif
+
+/* reset SW flag */
+#ifdef VERBOSE
+#define RES_FLAG(dev, data) \
+	if ((data) & (dev)->params) \
+		DBG ("  OTG SW status change: reset flag %s\n", #data); \
+	(dev)->params &= ~((u32) (data))
+#else
+#define RES_FLAG(dev, data) \
+	(dev)->params &= ~((u32) (data))
+#endif
+
+/* reset event bit */
+#define RES_EVENT(data, code) \
+	(code) &= ~((u32) (data))
+/* NOTE: this is not really needed so far, might be replaced with */
+/* #define RES_EVENT(data, code) \                                */
+/* 	do {} while (0)                                           */
+
+/* change OTG state */
+#ifdef CONFIG_USB_OTG
+#define PREPARE_STATE_CHANGE_1ST(dev, new_state) \
+	switch ((new_state) & OTG_STATE_MASK) { \
+	case OTG_STATE_UNDEFINED: \
+		set_undef_state_defaults((dev)); \
+		break; \
+	case OTG_STATE_A_IDLE: \
+		set_a_state_defaults((dev)); \
+		break; \
+	case OTG_STATE_B_IDLE: \
+		set_b_state_defaults((dev)); \
+		break; \
+	default: \
+		break; \
+	} \
+	do {} while (0)
+#else
+#define PREPARE_STATE_CHANGE_1ST(dev, new_state) \
+	do {} while (0)
+#endif
+
+#ifdef CONFIG_SOC_AU1200
+
+#if (USB_VBUS_GPIO < GPIO_2_BASE)
+#define AU1000GPIO_SET_BIT(data) \
+	au1000gpio_bit_set (data)
+#define AU1000GPIO_CLR_BIT(data) \
+	au1000gpio_bit_clear (data)
+#define AU1000GPIO_INIT_BIT(data) \
+	au1000gpio_bit_init (data)
+#define AU1000GPIO_TERM_BIT(data) \
+	au1000gpio_bit_term (data)
+#else
+#define AU1000GPIO_SET_BIT(data) \
+	au1000gpio2_bit_set (data)
+#define AU1000GPIO_CLR_BIT(data) \
+	au1000gpio2_bit_clear (data)
+#define AU1000GPIO_INIT_BIT(data) \
+	au1000gpio2_bit_init (data)
+#define AU1000GPIO_TERM_BIT(data) \
+	au1000gpio2_bit_term (data)
+#endif
+
+#define PREPARE_STATE_CHANGE_2ND(new_state_control) \
+	if (((new_state_control) & OTG_CTL_PPO) && \
+	    (~(new_state_control) & OTG_CTL_PPWR)) \
+		AU1000GPIO_SET_BIT(USB_VBUS_GPIO); \
+	else \
+		AU1000GPIO_CLR_BIT(USB_VBUS_GPIO)
+#else
+#define PREPARE_STATE_CHANGE_2ND(new_state_control) \
+	do {} while (0)
+#endif
+
+#define CHANGE_STATE(dev, new_state, pMask) \
+	PREPARE_STATE_CHANGE_1ST(dev, new_state); \
+	PREPARE_STATE_CHANGE_2ND(new_state##_CONTROL); \
+	writel ((new_state##_CONTROL), &(dev)->regs->ctl); \
+	*(pMask) = (new_state##_INTERRUPTS); \
+	(dev)->transceiver.state = (new_state); \
+	DBG ("OTG new state: %s\n", #new_state)
+
+/* verify OTG state */
+#ifndef CONFIG_OTG_TEST_MODE
+
+#define CHECK_STATE(dev, act_state, pMask) \
+	*(pMask) = (act_state##_INTERRUPTS); \
+	(dev)->prv_state = (act_state); \
+	VDBG ("OTG state: %s\n", #act_state)
+#else
+#define CHECK_STATE(dev, act_state, pMask) \
+	*(pMask) = (act_state##_INTERRUPTS); \
+	(dev)->prv_state = (act_state); \
+	if (((readl (&(dev)->regs->sts) ^ (act_state##_STATUS))) & \
+	    act_state##_STATUS_MASK) \
+		WARN ("OTG warning: incorrect status\n"); \
+	VDBG ("OTG state: %s\n", #act_state)
+#endif
+
+/* set timer */
+#define SET_OTG_TIMER(dev, val) \
+	set_timer ((dev), ((OTG_TMR_##val) * 100))
+
+/* set timer ( <1ms ) */
+#define SET_OTG_TIMER_SHORT(dev, val) \
+	set_timer ((dev), ((OTG_TMR_##val) / 10))
+
+/* set timer ( >10ms ) */
+#define SET_OTG_TIMER_LONG(dev, val) \
+	set_timer_long ((dev), ((OTG_TMR_##val) / 10))
+
+#ifdef VERBOSE
+#define HS_DISCON_WARNING() \
+	if (!(OTG_CTL_ENABLE_UHC ^ \
+	      (OTG_CTL_MUX_MASK & readl (&dev->regs->ctl))) && \
+	    !(OTG_STS_PSPD & readl (&dev->regs->sts))) \
+		DBG ("  OTG warning: disable UHC from HS-mode\n")
+#else
+#define HS_DISCON_WARNING() \
+	do { } while (0)
+#endif
+
+
+/*****************************************************************************
+*  Data
+*****************************************************************************/
+struct otg_regs {
+	u32  cap;               /* capabilities */
+	u32  mux;               /* mux */
+	u32  sts;               /* status */
+	u32  ctl;               /* control */
+	u32  tmr;               /* timer */
+	u32  intr;              /* interrupt request */
+	u32  inten;             /* interrupt enable */
+} __attribute__ ((packed));
+
+struct otg {
+	spinlock_t              lock;
+	unsigned                enabled : 1,
+	                        got_irq : 1,
+	                        region : 1;
+	u16                     chiprev;
+
+        /* state variables */
+        u8                      prv_state;
+        u32                     params;
+        void                    *otg_priv;
+        u8                      hostcount;
+
+#ifdef CONFIG_SOC_AU1200
+#ifdef USE_AU1200_PCI_DUMMY
+
+	struct pci_dev          *pdev;
+#else
+	struct platform_device  *pdev;
+#endif
+#else
+	struct pci_dev          *pdev;
+#endif
+	struct otg_regs         *regs;
+	struct otg_transceiver  transceiver;
+};
+#define transceiver_to_otg(pTransceiver) \
+	container_of (pTransceiver, struct otg, transceiver)
+#define otg_to_transceiver(pOtg) \
+	&pOtg->transceiver
+
+#ifdef CONFIG_USB_OTG_TEST_INTERFACE
+struct usb_otg_test_extension {
+	int (*bind) (struct otg **);
+	int (*unbind) (struct otg **);
+	int (*request) (u32);	/* function call for state change requests */
+	u32 (*query) (int);	/* function call to query state */
+};
+#endif
+
+#ifdef	__KERNEL__
+
+/* 2.5 and 2.4.older portability changes ... */
+
+#ifndef container_of
+#define	container_of	list_entry
+#endif
+
+#ifndef likely
+#define likely(x) (x)
+#define unlikely(x) (x)
+#endif
+
+#ifndef BUG_ON
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+#endif
+
+#ifndef WARN_ON
+#define	WARN_ON(x)	do { } while (0)
+#endif
+
+#endif	/* __KERNEL__ */
+
+/*****************************************************************************
+*  Functions
+*****************************************************************************/
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+extern int usb_gadget_register_otg (struct otg_transceiver * (
+                                    *get_transceiver)(void));
+extern int usb_gadget_unregister_otg (void);
+
+#endif
+#ifdef CONFIG_USB_OTG
+u32 otg_change_state (struct otg *, u32, u32 *);
+int otg_hnp_start_enum (struct otg_transceiver *);
+#endif
+
+void otg_init_state (struct otg *);
+int otg_exit_state (struct otg *);
+
+#ifdef DEBUG
+static void print_regs (struct otg *);
+#endif  /* DEBUG */
+
+#ifdef CONFIG_USB_OTG_TEST_INTERFACE
+int usb_otg_test_register_driver (struct usb_otg_test_extension *);
+int usb_otg_test_unregister_driver (void);
+#endif
+
+/*****************************************************************************
+*  Inline Functions
+*****************************************************************************/
+
+extern u32 otg_tmr_high_count;
+extern struct otg_ctl *otg_ctl;
+
+#ifdef CONFIG_USB_OTG
+/**
+ * \brief
+ * set neutral state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void set_undef_state_defaults (struct otg *dev)
+{
+	dev->transceiver.default_a = 0;
+	if (dev->transceiver.host) {
+		dev->transceiver.host->is_b_host = 0;
+	}
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+	if (dev->transceiver.companion) {
+		dev->transceiver.companion->is_b_host = 0;
+	}
+#endif
+	if (dev->transceiver.gadget) {
+		dev->transceiver.gadget->is_a_peripheral = 0;
+	}
+}
+
+/**
+ * \brief
+ * set A state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void set_a_state_defaults (struct otg *dev)
+{
+	dev->transceiver.default_a = 1;
+	if (dev->transceiver.host) {
+		dev->transceiver.host->is_b_host = 0;
+	}
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+	if (dev->transceiver.companion) {
+		dev->transceiver.companion->is_b_host = 0;
+	}
+#endif
+	if (dev->transceiver.gadget) {
+		dev->transceiver.gadget->is_a_peripheral = 1;
+	}
+}
+
+/**
+ * \brief
+ * set B state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void set_b_state_defaults (struct otg *dev)
+{
+	dev->transceiver.default_a = 0;
+	if (dev->transceiver.host) {
+		dev->transceiver.host->is_b_host = 1;
+	}
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+	if (dev->transceiver.companion) {
+		dev->transceiver.companion->is_b_host = 1;
+	}
+#endif
+	if (dev->transceiver.gadget) {
+		dev->transceiver.gadget->is_a_peripheral = 0;
+	}
+}
+
+/**
+ * \brief
+ * set B state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void reset_b_hnp_enable (struct otg *dev)
+{
+	if (dev->transceiver.host) {
+		dev->transceiver.host->b_hnp_enable = 0;
+	}
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+	if (dev->transceiver.companion) {
+		dev->transceiver.companion->b_hnp_enable = 0;
+	}
+#endif
+	VDBG ("  OTG action: HNP disabled in B-device\n");
+}
+
+/**
+ * \brief
+ * set B state information
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline int is_b_hnp_enabled (struct otg *dev)
+{
+	int retVal = 0;
+
+	if (dev->transceiver.host &&
+		dev->transceiver.host->b_hnp_enable) {
+		VDBG ("  OTG status: HNP is enabled in HS-B-device\n");
+		retVal = 1;
+	}
+#ifdef CONFIG_USB_OTG_HIGHSPEED
+	else if (dev->transceiver.companion &&
+		dev->transceiver.companion->b_hnp_enable) {
+		VDBG ("  OTG status: HNP is enabled in FS-B-device\n");
+		retVal = 1;
+	}
+#endif
+#ifdef VERBOSE
+	else {
+		DBG ("  OTG status: HNP is disabled in B-device\n");
+	}
+#endif
+	return retVal;
+}
+#endif
+
+#if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_OTGMUX_GADGET)
+
+/**
+ * \brief
+ * Read the status register
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return status
+ */
+static inline u32 get_status (struct otg *dev)
+{
+	return (readl (&dev->regs->sts));
+}
+
+/**
+ * \brief
+ * Load and start the timer for an unconditional run
+ *
+ * \param  dev   OTG controller info
+ * \param  val   Value to load
+ *
+ * \return void
+ */
+static inline void set_timer (struct otg *dev, u32 val)
+{
+	otg_tmr_high_count = 0;
+
+	writel ((val), &dev->regs->tmr);
+	VDBG ("  OTG action: start timer: %d0 us\n", val);
+}
+
+/**
+ * \brief
+ * Load and start the timer for an unconditional run
+ *
+ * \param  dev   OTG controller info
+ * \param  val   Value to load
+ *
+ * \return void
+ */
+static inline void set_timer_long (struct otg *dev, u32 val)
+{
+	otg_tmr_high_count = val - 1;
+
+	writel (TIMER_PERIOD, &dev->regs->tmr);
+	VDBG ("  OTG action: start timer: %d0 ms\n", val);
+}
+
+/**
+ * \brief
+ * Re-start the timer (value already loaded)
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void restart_timer (struct otg *dev)
+{
+	writel ((readl (&dev->regs->ctl) | OTG_CTL_TMR_UNCOND),
+	        &dev->regs->ctl);
+}
+
+/**
+ * \brief
+ * Reset the timer while running (value already loaded)
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void reset_timer (struct otg *dev)
+{
+	u32 temp;
+
+	temp = readl (&dev->regs->ctl);
+	writel ((temp & ~((u32) OTG_CTL_TMR_ALL)), &dev->regs->ctl);
+	writel (temp, &dev->regs->ctl);
+	VDBG ("  OTG action: re-start timer\n");
+}
+
+/**
+ * \brief
+ * Prepare the D-pulse
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void set_srp_conditions (struct otg *dev)
+{
+#ifdef UDC_HSA0_WORKAROUNDS
+	VDBG ("  OTG action: SRP init: no action needed due to A0 WAs\n");
+#else
+	writel ((readl (&dev->regs->cap) & ~((u32) OTG_CAP_APU)),
+	        &dev->regs->cap);
+	VDBG ("  OTG action: set SRP conditions: disable APU\n");
+#endif
+}
+
+/**
+ * \brief
+ * Reset conditions after SRP
+ *
+ * activates the auto-pull-up feature so after SRP the host
+ * will detect a device connect after calling this function
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return void
+ */
+static inline void reset_srp_conditions (struct otg *dev)
+{
+#ifdef UDC_HSA0_WORKAROUNDS
+	VDBG ("  OTG action: SRP done: no action needed due to A0 WAs\n");
+#else
+	writel ((readl (&dev->regs->cap) | OTG_CAP_APU),
+	        &dev->regs->cap);
+	VDBG ("  OTG action: reset SRP conditions: enable APU\n");
+#endif
+}
+
+/**
+ * \brief
+ * enable HNP for both devices
+ *
+ * \param  dev   OTG controller info
+ *
+ * \return success
+ */
+static inline int otg_enable_hnp (struct otg *dev)
+{
+	int  retVal = 0;
+
+/*	if (!dev->device) {
+		ERR ("Tried to send OTG request, device pointer not valid\n");
+		retVal = -ENODEV;
+	}
+	else {
+		retVal = usb_otg_enable_b_hnp (dev->device);
+		DBG ("  OTG action: enabled HNP in B-device\n");
+	}
+	if (retVal < 0) {
+		RES_FLAG (OTG_A_bHNP_EN);
+	}
+	else {
+		SET_FLAG (OTG_A_bHNP_EN);
+	}*/
+	return retVal;
+}
+
+#endif /* CONFIG_USB_OTG || CONFIG_USB_OTGMUX_GADGET */
+#ifdef DEBUG
+/**
+ * \brief
+ * Print OTG controller registers (debug mode only)
+ *
+ * \param dev    OTG controller info
+ *
+ * \return void
+ */
+static inline void print_regs (struct otg *dev)
+{
+	DBG( "-- UOC registers ---\n");
+	DBG( "otg cap   = %08x\n", readl (&dev->regs->cap));
+	DBG( "otg mux   = %08x\n", readl (&dev->regs->mux));
+	DBG( "otg sts   = %08x\n", readl (&dev->regs->sts));
+	DBG( "otg ctl   = %08x\n", readl (&dev->regs->ctl));
+	DBG( "otg tmr   = %08x\n", readl (&dev->regs->tmr));
+	DBG( "otg intr  = %08x\n", readl (&dev->regs->intr));
+	DBG( "otg inten = %08x\n", readl (&dev->regs->inten));
+	DBG( "--------------------\n");
+}
+#endif /* DEBUG */
+
+#ifdef CONFIG_SOC_AU1200
+
+/**
+ * \brief
+ * GPIO functions (Au1200 only)
+ *
+ * \param  data  pin info
+ *
+ * \return success
+ */
+static inline int au1000gpio_bit_get (u32 data)
+{
+	return (au_readl ((SYS_PINSTATERD & (1 << data)) ? 1 : 0));
+}
+
+#ifdef CONFIG_AU1X00_GPIO
+
+	/* GPIO functions are defined in drivers/char/au1000_gpio.c          */
+
+#else
+
+static inline int au1000gpio_bit_tristate (u32 data)
+{
+	au_writel ((1 << data), SYS_TRIOUTCLR);
+	return 0;
+}
+
+static inline int au1000gpio_bit_set (u32 data)
+{
+	au_writel ((1 << data), SYS_OUTPUTSET);
+	return 0;
+}
+
+static inline int au1000gpio_bit_clear (u32 data)
+{
+	au_writel ((1 << data), SYS_OUTPUTCLR);
+	return 0;
+}
+
+static inline int au1000gpio_bit_init (u32 data)
+{
+	return au1000gpio_bit_set (data);
+}
+
+static inline int au1000gpio_bit_term (u32 data)
+{
+	return au1000gpio_bit_set (data);
+}
+
+static inline int au1000gpio2_bit_set (u32 data)
+{
+	au_writel (((1 << (data - GPIO_2_BASE)) |
+	            (1 << (data - GPIO_2_BASE + 0x10))), GPIO2_OUTPUT);
+	au_sync();
+	return 0;
+}
+
+static inline int au1000gpio2_bit_clear (u32 data)
+{
+	au_writel ((1 << (data - GPIO_2_BASE + 0x10)), GPIO2_OUTPUT);
+	au_sync();
+	return 0;
+}
+
+static inline int au1000gpio2_bit_init (u32 data)
+{
+	u32 temp = au_readl (GPIO2_ENABLE);
+
+	if (!(temp | 1)) {
+		au_writel (temp | 1, GPIO2_ENABLE);
+		au_readl (GPIO2_ENABLE);
+		udelay (20);
+	}
+	if (temp | 2) {
+		au_writel (((temp & 0xfffffffd) | 1), GPIO2_ENABLE);
+		au_readl (GPIO2_ENABLE);
+	}
+
+	/* FIXME: check the system impact of the P0A setting                 */
+	/* DbAu1200 pin (GPIO_215) pin is shared w/ PSC0 functions           */
+	/* setting this field to GPIO affects also GPIO_16, GPIO_31          */
+
+	if (data == GPIO_215) {
+		au_writel (((au_readl (SYS_PINFUNC) &
+		             ~((u32) SYS_PINFUNC_P0A)) | SYS_PINFUNC_P0A_GPIO),
+			   SYS_PINFUNC);
+	}
+	au_writel (au_readl (GPIO2_INTENABLE) & ~(1 << (data - GPIO_2_BASE)),
+	           GPIO2_INTENABLE);
+	au_writel (au_readl (GPIO2_DIR) | (1 << (data - GPIO_2_BASE)),
+	           GPIO2_DIR);
+	au_sync();
+	return 0;
+}
+
+static inline int au1000gpio2_bit_term (u32 data)
+{
+	return au1000gpio2_bit_set (data);
+}
+#endif
+#endif /* CONFIG_SOC_AU1200 */
+
+#endif /* AU1200UOC_H */
diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 8f402f8..e147883 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -91,6 +91,13 @@ static const char driver_desc [] = DRIVE
 
 #define RX_EXTRA	20		/* guard against rx overflows */
 
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+/*
+ * AMD UDC supports dword aligned DMA buffers only, so skbuf buffers
+ * from network layer must be copied
+ */
+#define UDC_MAX_BUFLEN 2048            /* size of dword aligned buffer */
+#endif
 #include "rndis.h"
 
 #ifndef	CONFIG_USB_ETH_RNDIS
@@ -151,8 +158,13 @@ struct eth_dev {
 /* Thanks to NetChip Technologies for donating this product ID.
  * It's for devices with only CDC Ethernet configurations.
  */
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+#define CDC_VENDOR_NUM	0x0438		/* AMD */
+#define CDC_PRODUCT_NUM	0xdc01		/* AMD Linux-USB Ethernet Gadget (temporary) */
+#else
 #define CDC_VENDOR_NUM	0x0525		/* NetChip */
 #define CDC_PRODUCT_NUM	0xa4a1		/* Linux-USB Ethernet Gadget */
+#endif
 
 /* For hardware that can't talk CDC, we use the same vendor ID that
  * ARM Linux has used for ethernet-over-usb, both with sa1100 and
@@ -253,6 +265,10 @@ MODULE_PARM_DESC(host_addr, "Host Ethern
 #define DEV_CONFIG_CDC
 #endif
 
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+#define	DEV_CONFIG_CDC
+#endif
+
 
 /* For CDC-incapable hardware, choose the simple cdc subset.
  * Anything that talks bulk (without notable bugs) can do this.
@@ -1056,6 +1072,10 @@ static void eth_reset_config (struct eth
 			req = container_of (dev->tx_reqs.next,
 						struct usb_request, list);
 			list_del (&req->list);
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+                        if (req->buf)
+                                usb_ep_free_buffer (dev->in_ep, req->buf, req->dma, UDC_MAX_BUFLEN);
+#endif
 			usb_ep_free_request (dev->in_ep, req);
 		}
 	}
@@ -1065,6 +1085,10 @@ static void eth_reset_config (struct eth
 			req = container_of (dev->rx_reqs.next,
 						struct usb_request, list);
 			list_del (&req->list);
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+                        if (req->buf)
+                                usb_ep_free_buffer (dev->out_ep, req->buf, req->dma, UDC_MAX_BUFLEN);
+#endif
 			usb_ep_free_request (dev->out_ep, req);
 		}
 	}
@@ -1632,7 +1656,9 @@ rx_submit (struct eth_dev *dev, struct u
 	 */
 	skb_reserve(skb, NET_IP_ALIGN);
 
+#ifndef CONFIG_USB_GADGET_AU1200UDC
 	req->buf = skb->data;
+#endif
 	req->length = size;
 	req->complete = rx_complete;
 	req->context = skb;
@@ -1674,6 +1700,16 @@ static void rx_complete (struct usb_ep *
 			break;
 		}
 
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+                /* we need to copy here because AMD UDC needs dword aligned buffers */
+                VDEBUG(dev, "memcpy( skb->data %lx,req->buf %lx,req->actual %d)\n",  skb->data,req->buf,req->actual);
+                if (req->actual <= UDC_MAX_BUFLEN) {
+                        memcpy(skb->data, req->buf, req->actual);
+                }
+                else {
+                        ERROR(dev, "memcpy of %d bytes bigger than max %d\n", req->actual, UDC_MAX_BUFLEN);
+                }
+#endif
 		skb->dev = dev->net;
 		skb->protocol = eth_type_trans (skb, dev->net);
 		dev->stats.rx_packets++;
@@ -1742,6 +1778,15 @@ static int prealloc (struct list_head *l
 		req = usb_ep_alloc_request (ep, gfp_flags);
 		if (!req)
 			return list_empty (list) ? -ENOMEM : 0;
+
+
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+                /* allocate buffer which must be dword aligned for AMD UDC */
+                req->buf = usb_ep_alloc_buffer (ep, UDC_MAX_BUFLEN, 
+                                &req->dma, GFP_ATOMIC);
+#endif
+
+
 		list_add (&req->list, list);
 	}
 	return 0;
@@ -1753,6 +1798,10 @@ extra:
 
 		next = req->list.next;
 		list_del (&req->list);
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+                if (req->buf)
+                        usb_ep_free_buffer (ep, req->buf, req->dma, UDC_MAX_BUFLEN);
+#endif
 		usb_ep_free_request (ep, req);
 
 		if (next == list)
@@ -1905,7 +1954,19 @@ static int eth_start_xmit (struct sk_buf
 		rndis_add_hdr (skb);
 		length = skb->len;
 	}
-	req->buf = skb->data;
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+        /* we need to copy here because AMD UDC needs dword aligned buffers */
+        VDEBUG(dev, "memcpy(req->buf %lx, skb->data %lx, length %d)", req->buf, skb->data, length);
+        if (length <= UDC_MAX_BUFLEN) {
+                memcpy(req->buf, skb->data, length);
+        }
+        else {
+                ERROR(dev, "memcpy of %d bytes bigger than max %d\n", length, UDC_MAX_BUFLEN);
+        }
+        VDEBUG(dev, "past memcpy(req->buf %lx, skb->data %lx, length %d)", req->buf, skb->data, length);
+#else
+        req->buf = skb->data;
+#endif
 	req->context = skb;
 	req->complete = tx_complete;
 
@@ -2202,6 +2263,8 @@ eth_bind (struct usb_gadget *gadget)
 		/* sh doesn't support multiple interfaces or configs */
 		cdc = 0;
 		rndis = 0;
+	} else if (gadget_is_au1200udc(gadget)) {
+		rndis = 0;
 	} else if (gadget_is_sa1100 (gadget)) {
 		/* hardware can't write zlps */
 		zlp = 0;
diff --git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
index ea09aaa..ae800e6 100644
--- a/drivers/usb/gadget/file_storage.c
+++ b/drivers/usb/gadget/file_storage.c
@@ -263,8 +263,14 @@ MODULE_LICENSE("Dual BSD/GPL");
  *
  * DO NOT REUSE THESE IDs with any other driver!!  Ever!!
  * Instead:  allocate your own, using normal USB-IF procedures. */
+
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+#define DRIVER_VENDOR_ID	0x0438  // AMD
+#define DRIVER_PRODUCT_ID	0xdc02	// AMD Linux-USB File-backed Storage Gadget (temporary)
+#else
 #define DRIVER_VENDOR_ID	0x0525	// NetChip
 #define DRIVER_PRODUCT_ID	0xa4a5	// Linux-USB File-backed Storage Gadget
+#endif
 
 
 /*
@@ -3717,6 +3723,8 @@ static int __init check_parameters(struc
 		mod_data.can_stall = 0;
 
 	if (mod_data.release == 0xffff) {	// Parameter wasn't set
+		if (gadget_is_au1200udc(fsg->gadget))
+			mod_data.can_stall = 0;
 		/* The sa1100 controller is not supported */
 		if (gadget_is_sa1100(fsg->gadget))
 			gcnum = -1;
diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index 8cbae21..541fbd0 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -15,6 +15,12 @@
 #define	gadget_is_net2280(g)	0
 #endif
 
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+#define	gadget_is_au1200udc(g)	!strcmp("au1200udc", (g)->name)
+#else
+#define	gadget_is_au1200udc(g)	0
+#endif
+
 #ifdef CONFIG_USB_GADGET_DUMMY_HCD
 #define	gadget_is_dummy(g)	!strcmp("dummy_udc", (g)->name)
 #else
@@ -143,5 +149,7 @@ static inline int usb_gadget_controller_
 		return 0x13;
 	else if (gadget_is_imx(gadget))
 		return 0x14;
+	else if (gadget_is_au1200udc(gadget))
+		return 0x15;
 	return -ENOENT;
 }
diff --git a/drivers/usb/gadget/zero.c b/drivers/usb/gadget/zero.c
index 6c58636..4ec28bb 100644
--- a/drivers/usb/gadget/zero.c
+++ b/drivers/usb/gadget/zero.c
@@ -193,6 +193,10 @@ module_param (loopdefault, bool, S_IRUGO
  * DO NOT REUSE THESE IDs with a protocol-incompatible driver!!  Ever!!
  * Instead:  allocate your own, using normal USB-IF procedures.
  */
+#ifdef CONFIG_USB_GADGET_AU1200UDC
+#define DRIVER_VENDOR_NUM	0x0438		/* AMD */
+#define DRIVER_PRODUCT_NUM	0xdc00		/* AMD Linux-USB "Gadget Zero" (temporary) */
+#else
 #ifndef	CONFIG_USB_ZERO_HNPTEST
 #define DRIVER_VENDOR_NUM	0x0525		/* NetChip */
 #define DRIVER_PRODUCT_NUM	0xa4a0		/* Linux-USB "Gadget Zero" */
@@ -200,6 +204,7 @@ module_param (loopdefault, bool, S_IRUGO
 #define DRIVER_VENDOR_NUM	0x1a0a		/* OTG test device IDs */
 #define DRIVER_PRODUCT_NUM	0xbadd
 #endif
+#endif
 
 /*-------------------------------------------------------------------------*/
 
@@ -1127,8 +1132,11 @@ zero_unbind (struct usb_gadget *gadget)
 	DBG (dev, "unbind\n");
 
 	/* we've already been disconnected ... no i/o is active */
-	if (dev->req)
+	if (dev->req) {
+                /* free with original length */
+                dev->req->length = USB_BUFSIZ;
 		free_ep_req (gadget->ep0, dev->req);
+        }
 	del_timer_sync (&dev->resume);
 	kfree (dev);
 	set_gadget_data (gadget, NULL);

--3MwIy2ne0vdjdPXF--
