Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 16:44:30 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:59374 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225389AbTIKPoa>;
	Thu, 11 Sep 2003 16:44:30 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA22242;
	Fri, 12 Sep 2003 00:44:24 +0900 (JST)
Received: 4UMDO01 id h8BFiOg00519; Fri, 12 Sep 2003 00:44:24 +0900 (JST)
Received: 4UMRO01 id h8BFiMF03393; Fri, 12 Sep 2003 00:44:23 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date:	Fri, 12 Sep 2003 00:44:20 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	ralf@linux-mips.org
Cc:	yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [patch] NEC VR4100 KIU support
Message-Id: <20030912004420.4d7e0091.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__12_Sep_2003_00:44:20_+0900_0822dc80"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Fri__12_Sep_2003_00:44:20_+0900_0822dc80
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I rewrote NEC VR4100 KIU driver for v2.4.
This driver adds keyboard support to IBM WorkPad z50 and Victor MP-C303/304.

Please apply this patch to v2.4 tree.

Yoichi

--Multipart_Fri__12_Sep_2003_00:44:20_+0900_0822dc80
Content-Type: text/plain;
 name="vr41xx_keyb-v24.diff"
Content-Disposition: attachment;
 filename="vr41xx_keyb-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Makefile linux/arch/mips/Makefile
--- linux.orig/arch/mips/Makefile	Thu Sep 11 23:28:55 2003
+++ linux/arch/mips/Makefile	Thu Sep 11 23:26:53 2003
@@ -651,6 +651,8 @@
 	$(MAKE) -C arch/$(ARCH)/tools clean
 	$(MAKE) -C arch/mips/baget clean
 	$(MAKE) -C arch/mips/lasat clean
+	$(MAKE) -C arch/mips/vr41xx/ibm-workpad clean
+	$(MAKE) -C arch/mips/vr41xx/victor-mpc30x clean
 
 archmrproper:
 	@$(MAKEBOOT) mrproper
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/config-shared.in linux/arch/mips/config-shared.in
--- linux.orig/arch/mips/config-shared.in	Mon Sep  8 19:53:59 2003
+++ linux/arch/mips/config-shared.in	Thu Sep 11 23:19:28 2003
@@ -413,7 +413,6 @@
    define_bool CONFIG_VR41XX_TIME_C y
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_ISA y
-   define_bool CONFIG_DUMMY_KEYB y
    define_bool CONFIG_SCSI n
 fi
 if [ "$CONFIG_LASAT" = "y" ]; then
@@ -657,7 +656,6 @@
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
    define_bool CONFIG_PCI_AUTO y
-   define_bool CONFIG_DUMMY_KEYB y
    define_bool CONFIG_SCSI n
 fi
 if [ "$CONFIG_ZAO_CAPCELLA" = "y" ]; then
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/defconfig-mpc30x linux/arch/mips/defconfig-mpc30x
--- linux.orig/arch/mips/defconfig-mpc30x	Mon Aug 25 00:36:51 2003
+++ linux/arch/mips/defconfig-mpc30x	Thu Sep 11 23:22:54 2003
@@ -14,7 +14,7 @@
 # Loadable module support
 #
 CONFIG_MODULES=y
-# CONFIG_MODVERSIONS is not set
+CONFIG_MODVERSIONS=y
 CONFIG_KMOD=y
 
 #
@@ -31,6 +31,7 @@
 # CONFIG_MIPS_PB1500 is not set
 # CONFIG_MIPS_XXS1500 is not set
 # CONFIG_MIPS_MTX1 is not set
+# CONFIG_COGENT_CSB250 is not set
 # CONFIG_BAGET_MIPS is not set
 # CONFIG_CASIO_E55 is not set
 # CONFIG_MIPS_COBALT is not set
@@ -78,7 +79,6 @@
 CONFIG_PCI=y
 CONFIG_NEW_PCI=y
 CONFIG_PCI_AUTO=y
-CONFIG_DUMMY_KEYB=y
 # CONFIG_SCSI is not set
 # CONFIG_MIPS_AU1000 is not set
 
@@ -118,9 +118,24 @@
 # CONFIG_TC is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
-# CONFIG_HOTPLUG is not set
-# CONFIG_PCMCIA is not set
+CONFIG_HOTPLUG=y
+
+#
+# PCMCIA/CardBus support
+#
+CONFIG_PCMCIA=y
+# CONFIG_CARDBUS is not set
+# CONFIG_TCIC is not set
+# CONFIG_I82092 is not set
+# CONFIG_I82365 is not set
+CONFIG_PCMCIA_VRC4173=y
+
+#
+# PCI Hotplug Support
+#
 # CONFIG_HOTPLUG_PCI is not set
+# CONFIG_HOTPLUG_PCI_COMPAQ is not set
+# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
 CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
@@ -191,10 +206,7 @@
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-# CONFIG_IP_PNP_DHCP is not set
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
+# CONFIG_IP_PNP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -247,9 +259,79 @@
 #
 # ATA/IDE/MFM/RLL support
 #
-# CONFIG_IDE is not set
-# CONFIG_BLK_DEV_IDE_MODES is not set
+CONFIG_IDE=y
+
+#
+# IDE, ATA and ATAPI Block devices
+#
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_HD_IDE is not set
 # CONFIG_BLK_DEV_HD is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+# CONFIG_IDEDISK_STROKE is not set
+# CONFIG_BLK_DEV_IDECS is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_BLK_DEV_IDESCSI is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+# CONFIG_BLK_DEV_CMD640 is not set
+# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
+# CONFIG_BLK_DEV_ISAPNP is not set
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_BLK_DEV_GENERIC=y
+CONFIG_IDEPCI_SHARE_IRQ=y
+# CONFIG_BLK_DEV_IDEDMA_PCI is not set
+# CONFIG_BLK_DEV_OFFBOARD is not set
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+# CONFIG_IDEDMA_PCI_AUTO is not set
+# CONFIG_IDEDMA_ONLYDISK is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_PCI_WIP is not set
+# CONFIG_BLK_DEV_ADMA100 is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_WDC_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_AMD74XX_OVERRIDE is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_HPT34X_AUTODMA is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_PDC202XX_BURST is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_RZ1000 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SIS5513 is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_CHIPSETS is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_DMA_NONPCI is not set
+CONFIG_BLK_DEV_IDE_MODES=y
+# CONFIG_BLK_DEV_ATARAID is not set
+# CONFIG_BLK_DEV_ATARAID_PDC is not set
+# CONFIG_BLK_DEV_ATARAID_HPT is not set
+# CONFIG_BLK_DEV_ATARAID_SII is not set
 
 #
 # SCSI support
@@ -337,6 +419,22 @@
 # CONFIG_WAN is not set
 
 #
+# PCMCIA network device support
+#
+CONFIG_NET_PCMCIA=y
+# CONFIG_PCMCIA_3C589 is not set
+# CONFIG_PCMCIA_3C574 is not set
+CONFIG_PCMCIA_FMVJ18X=y
+CONFIG_PCMCIA_PCNET=y
+# CONFIG_PCMCIA_AXNET is not set
+# CONFIG_PCMCIA_NMCLAN is not set
+# CONFIG_PCMCIA_SMC91C92 is not set
+# CONFIG_PCMCIA_XIRC2PS is not set
+# CONFIG_ARCNET_COM20020_CS is not set
+# CONFIG_PCMCIA_IBMTR is not set
+# CONFIG_NET_PCMCIA_RADIO is not set
+
+#
 # Amateur Radio support
 #
 # CONFIG_HAMRADIO is not set
@@ -364,11 +462,12 @@
 # Character devices
 #
 CONFIG_VT=y
-# CONFIG_VT_CONSOLE is not set
+CONFIG_VT_CONSOLE=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_CONSOLE=y
 # CONFIG_SERIAL_EXTENDED is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
+CONFIG_VR41XX_KIU=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_UNIX98_PTY_COUNT=256
 
@@ -423,6 +522,12 @@
 # CONFIG_DRM is not set
 
 #
+# PCMCIA character devices
+#
+# CONFIG_PCMCIA_SERIAL_CS is not set
+# CONFIG_SYNCLINK_CS is not set
+
+#
 # File systems
 #
 # CONFIG_QUOTA is not set
@@ -487,7 +592,7 @@
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
 # CONFIG_NFS_DIRECTIO is not set
-CONFIG_ROOT_NFS=y
+# CONFIG_ROOT_NFS is not set
 # CONFIG_NFSD is not set
 # CONFIG_NFSD_V3 is not set
 # CONFIG_NFSD_TCP is not set
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/defconfig-workpad linux/arch/mips/defconfig-workpad
--- linux.orig/arch/mips/defconfig-workpad	Mon Aug 25 00:36:57 2003
+++ linux/arch/mips/defconfig-workpad	Thu Sep 11 23:45:09 2003
@@ -31,6 +31,7 @@
 # CONFIG_MIPS_PB1500 is not set
 # CONFIG_MIPS_XXS1500 is not set
 # CONFIG_MIPS_MTX1 is not set
+# CONFIG_COGENT_CSB250 is not set
 # CONFIG_BAGET_MIPS is not set
 # CONFIG_CASIO_E55 is not set
 # CONFIG_MIPS_COBALT is not set
@@ -74,7 +75,6 @@
 CONFIG_VR41XX_TIME_C=y
 CONFIG_NONCOHERENT_IO=y
 CONFIG_ISA=y
-CONFIG_DUMMY_KEYB=y
 # CONFIG_SCSI is not set
 # CONFIG_MIPS_AU1000 is not set
 
@@ -395,6 +395,7 @@
 # CONFIG_SERIAL_MULTIPORT is not set
 # CONFIG_HUB6 is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
+CONFIG_VR41XX_KIU=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_UNIX98_PTY_COUNT=256
 
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/ibm-workpad/Makefile linux/arch/mips/vr41xx/ibm-workpad/Makefile
--- linux.orig/arch/mips/vr41xx/ibm-workpad/Makefile	Wed Jul 30 09:35:38 2003
+++ linux/arch/mips/vr41xx/ibm-workpad/Makefile	Thu Sep 11 23:19:29 2003
@@ -14,4 +14,12 @@
 
 obj-y	:= init.o setup.o
 
+obj-$(CONFIG_VR41XX_KIU)	+= keymap.o
+
+keymap.c: keymap.map
+	set -e ; loadkeys --mktable $< | sed -e 's/^static *//' > $@
+
+clean:
+	rm -f keymap.c
+
 include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/ibm-workpad/keymap.map linux/arch/mips/vr41xx/ibm-workpad/keymap.map
--- linux.orig/arch/mips/vr41xx/ibm-workpad/keymap.map	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/ibm-workpad/keymap.map	Thu Sep 11 23:19:29 2003
@@ -0,0 +1,344 @@
+# Keymap for IBM Workpad z50
+# US Mapping
+#
+# by Michael Klar <wyldfier@iname.com>
+#
+# This is a great big mess on account of how the Caps Lock key is handled as
+# LeftShift-RightShift.  Right shift key had to be broken out, so don't use
+# use this map file as a basis for other keyboards that don't do the same
+# thing with Caps Lock.
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+
+keymaps 0-2,4-5,8,12,32-33,36-37
+strings as usual
+
+keycode 0 = F1 F11 Console_13
+	shiftr keycode 0 = F11
+	shift shiftr keycode 0 = F11
+	control keycode 0 = F1
+	alt keycode 0 = Console_1
+	control alt keycode 0 = Console_1
+keycode 1 = F3 F13 Console_15
+	shiftr keycode 1 = F13
+	shift shiftr keycode 1 = F13
+	control keycode 1 = F3
+	alt keycode 1 = Console_3
+	control alt keycode 1 = Console_3
+keycode 2 = F5 F15 Console_17
+	shiftr keycode 2 = F15
+	shift shiftr keycode 2 = F15
+	control keycode 2 = F5
+	alt keycode 2 = Console_5
+	control alt keycode 2 = Console_5
+keycode 3 = F7 F17 Console_19
+	shiftr keycode 3 = F17
+	shift shiftr keycode 3 = F17
+	control keycode 3 = F7
+	alt keycode 3 = Console_7
+	control alt keycode 3 = Console_7
+keycode 4 = F9 F19 Console_21
+	shiftr keycode 4 = F19
+	shift shiftr keycode 4 = F19
+	control keycode 4 = F9
+	alt keycode 4 = Console_9
+	control alt keycode 4 = Console_9
+#keycode 5 is contrast down
+#keycode 6 is contrast up
+keycode 7 = F11 F11 Console_23
+	shiftr keycode 7 = F11
+	shift shiftr keycode 7 = F11
+	control keycode 7 = F11
+	alt keycode 7 = Console_11
+	control alt keycode 7 = Console_11
+keycode 8 = F2 F12 Console_14
+	shiftr keycode 8 = F12
+	shift shiftr keycode 8 = F12
+	control keycode 8 = F2
+	alt keycode 8 = Console_2
+	control alt keycode 8 = Console_2
+keycode 9 = F4 F14 Console_16
+	shiftr keycode 9 = F14
+	shift shiftr keycode 9 = F14
+	control keycode 9 = F4
+	alt keycode 9 = Console_4
+	control alt keycode 9 = Console_4
+keycode 10 = F6 F16 Console_18
+	shiftr keycode 10 = F16
+	shift shiftr keycode 10 = F16
+	control keycode 10 = F6
+	alt keycode 10 = Console_6
+	control alt keycode 10 = Console_6
+keycode 11 = F8 F18 Console_20
+	shiftr keycode 11 = F18
+	shift shiftr keycode 11 = F18
+	control keycode 11 = F8
+	alt keycode 11 = Console_8
+	control alt keycode 11 = Console_8
+keycode 12 = F10 F20 Console_22
+	shiftr keycode 12 = F20
+	shift shiftr keycode 12 = F20
+	control keycode 12 = F10
+	alt keycode 12 = Console_10
+	control alt keycode 12 = Console_10
+#keycode 13 is brightness down
+#keycode 14 is brightness up
+keycode 15 = F12 F12 Console_24
+	shiftr keycode 15 = F12
+	shift shiftr keycode 15 = F12
+	control keycode 15 = F12
+	alt keycode 15 = Console_12
+	control alt keycode 15 = Console_12
+keycode 16 = apostrophe quotedbl
+	shiftr keycode 16 = quotedbl
+	shift shiftr keycode 16 = quotedbl
+	control keycode 16 = Control_g
+	alt keycode 16 = Meta_apostrophe
+keycode 17 = bracketleft braceleft
+	shiftr keycode 17 = braceleft
+	shift shiftr keycode 17 = braceleft
+	control keycode 17 = Escape
+	alt keycode 17 = Meta_bracketleft
+keycode 18 = minus underscore backslash       
+	shiftr keycode 18 = underscore
+	shift shiftr keycode 18 = underscore
+	control keycode 18 = Control_underscore
+	shift control keycode 18 = Control_underscore
+	shiftr control keycode 18 = Control_underscore
+	shift shiftr control keycode 18 = Control_underscore
+	alt keycode 18 = Meta_minus
+keycode 19 = zero parenright braceright
+	shiftr keycode 19 = parenright
+	shift shiftr keycode 19 = parenright
+	alt keycode 19 = Meta_zero
+keycode 20 = p
+	shiftr keycode 20 = +P
+	shift shiftr keycode 20 = +p
+keycode 21 = semicolon colon
+	shiftr keycode 21 = colon
+	shift shiftr keycode 21 = colon
+	alt keycode 21 = Meta_semicolon
+keycode 22 = Up Scroll_Backward
+	shiftr keycode 22 = Scroll_Backward
+	shift shiftr keycode 22 = Scroll_Backward
+	alt keycode 22 = Prior
+keycode 23 = slash question
+	shiftr keycode 23 = question
+	shift shiftr keycode 23 = question
+	control keycode 23 = Delete
+	alt keycode 23 = Meta_slash
+
+keycode 27 = nine parenleft bracketright
+	shiftr keycode 27 = parenleft
+	shift shiftr keycode 27 = parenleft
+	alt keycode 27 = Meta_nine
+keycode 28 = o
+	shiftr keycode 28 = +O
+	shift shiftr keycode 28 = +o
+keycode 29 = l
+	shiftr keycode 29 = +L
+	shift shiftr keycode 29 = +l
+keycode 30 = period greater
+	shiftr keycode 30 = greater
+	shift shiftr keycode 30 = greater
+	control keycode 30 = Compose
+	alt keycode 30 = Meta_period
+
+keycode 32 = Left Decr_Console
+	shiftr keycode 32 = Decr_Console
+	shift shiftr keycode 32 = Decr_Console
+	alt keycode 32 = Home
+keycode 33 = bracketright braceright asciitilde      
+	shiftr keycode 33 = braceright
+	shift shiftr keycode 33 = braceright
+	control keycode 33 = Control_bracketright
+	alt keycode 33 = Meta_bracketright
+keycode 34 = equal plus
+	shiftr keycode 34 = plus
+	shift shiftr keycode 34 = plus
+	alt keycode 34 = Meta_equal
+keycode 35 = eight asterisk bracketleft
+	shiftr keycode 35 = asterisk
+	shift shiftr keycode 35 = asterisk
+	control keycode 35 = Delete
+	alt keycode 35 = Meta_eight
+keycode 36 = i
+	shiftr keycode 36 = +I
+	shift shiftr keycode 36 = +i
+keycode 37 = k
+	shiftr keycode 37 = +K
+	shift shiftr keycode 37 = +k
+keycode 38 = comma less
+	shiftr keycode 38 = less
+	shift shiftr keycode 38 = less
+	alt keycode 38 = Meta_comma
+
+keycode 40 = h
+	shiftr keycode 40 = +H
+	shift shiftr keycode 40 = +h
+keycode 41 = y
+	shiftr keycode 41 = +Y
+	shift shiftr keycode 41 = +y
+keycode 42 = six asciicircum
+	shiftr keycode 42 = asciicircum
+	shift shiftr keycode 42 = asciicircum
+	control keycode 42 = Control_asciicircum
+	alt keycode 42 = Meta_six
+keycode 43 = seven ampersand braceleft
+	shiftr keycode 43 = ampersand
+	shift shiftr keycode 43 = ampersand
+	control keycode 43 = Control_underscore
+	alt keycode 43 = Meta_seven
+keycode 44 = u
+	shiftr keycode 44 = +U
+	shift shiftr keycode 44 = +u
+keycode 45 = j
+	shiftr keycode 45 = +J
+	shift shiftr keycode 45 = +j
+keycode 46 = m
+	shiftr keycode 46 = +M
+	shift shiftr keycode 46 = +m
+keycode 47 = n
+	shiftr keycode 47 = +N
+	shift shiftr keycode 47 = +n
+
+# This is the "Backspace" key:
+keycode 49 = Delete Delete
+	shiftr keycode 49 = Delete
+	shift shiftr keycode 49 = Delete
+	control keycode 49 = BackSpace
+	alt keycode 49 = Meta_Delete
+keycode 50 = Num_Lock
+	shift keycode 50 = Bare_Num_Lock
+	shiftr keycode 50 = Bare_Num_Lock
+	shift shiftr keycode 50 = Bare_Num_Lock
+# This is the "Delete" key:
+keycode 51 = Remove
+	control alt keycode 51 = Boot
+
+keycode 53 = backslash bar
+	shiftr keycode 53 = bar
+	shift shiftr keycode 53 = bar
+	control keycode 53 = Control_backslash
+	alt keycode 53 = Meta_backslash
+keycode 54 = Return
+	alt keycode 54 = Meta_Control_m
+keycode 55 = space space           
+	shiftr keycode 55 = space
+	shift shiftr keycode 55 = space
+	control keycode 55 = nul
+	alt keycode 55 = Meta_space
+keycode 56 = g
+	shiftr keycode 56 = +G
+	shift shiftr keycode 56 = +g
+keycode 57 = t
+	shiftr keycode 57 = +T
+	shift shiftr keycode 57 = +t
+keycode 58 = five percent
+	shiftr keycode 58 = percent
+	shift shiftr keycode 58 = percent
+	control keycode 58 = Control_bracketright
+	alt keycode 58 = Meta_five
+keycode 59 = four dollar dollar
+	shiftr keycode 59 = dollar
+	shift shiftr keycode 59 = dollar
+	control keycode 59 = Control_backslash
+	alt keycode 59 = Meta_four
+keycode 60 = r
+	shiftr keycode 60 = +R
+	shift shiftr keycode 60 = +r
+keycode 61 = f
+	shiftr keycode 61 = +F
+	shift shiftr keycode 61 = +f
+	altgr keycode 61 = Hex_F
+keycode 62 = v
+	shiftr keycode 62 = +V
+	shift shiftr keycode 62 = +v
+keycode 63 = b
+	shiftr keycode 63 = +B
+	shift shiftr keycode 63 = +b
+	altgr keycode 63 = Hex_B
+
+keycode 67 = three numbersign
+	shiftr keycode 67 = numbersign
+	shift shiftr keycode 67 = numbersign
+	control keycode 67 = Escape
+	alt keycode 67 = Meta_three
+keycode 68 = e
+	shiftr keycode 68 = +E
+	shift shiftr keycode 68 = +e
+	altgr keycode 68 = Hex_E
+keycode 69 = d
+	shiftr keycode 69 = +D
+	shift shiftr keycode 69 = +d
+	altgr keycode 69 = Hex_D
+keycode 70 = c
+	shiftr keycode 70 = +C
+	shift shiftr keycode 70 = +c
+	altgr keycode 70 = Hex_C
+keycode 71 = Right Incr_Console
+	shiftr keycode 71 = Incr_Console
+	shift shiftr keycode 71 = Incr_Console
+	alt keycode 71 = End
+
+keycode 75 = two at at
+	shiftr keycode 75 = at
+	shift shiftr keycode 75 = at
+	control keycode 75 = nul
+	shift control keycode 75 = nul
+	shiftr control keycode 75 = nul
+	shift shiftr control keycode 75 = nul
+	alt keycode 75 = Meta_two
+keycode 76 = w
+	shiftr keycode 76 = +W
+	shift shiftr keycode 76 = +w
+keycode 77 = s
+	shiftr keycode 77 = +S
+	shift shiftr keycode 77 = +s
+keycode 78 = x
+	shiftr keycode 78 = +X
+	shift shiftr keycode 78 = +x
+keycode 79 = Down Scroll_Forward
+	shiftr keycode 79 = Scroll_Forward
+	shift shiftr keycode 79 = Scroll_Forward
+	alt keycode 79 = Next
+keycode 80 = Escape Escape
+	shiftr keycode 80 = Escape
+	shift shiftr keycode 80 = Escape
+	alt keycode 80 = Meta_Escape
+keycode 81 = Tab Tab             
+	shiftr keycode 81 = Tab
+	shift shiftr keycode 81 = Tab
+	alt keycode 81 = Meta_Tab
+keycode 82 = grave asciitilde
+	shiftr keycode 82 = asciitilde
+	shift shiftr keycode 82 = asciitilde
+	control keycode 82 = nul
+	alt keycode 82 = Meta_grave
+keycode 83 = one exclam
+	shiftr keycode 83 = exclam
+	shift shiftr keycode 83 = exclam
+	alt keycode 83 = Meta_one
+keycode 84 = q
+	shiftr keycode 84 = +Q
+	shift shiftr keycode 84 = +q
+keycode 85 = a
+	shiftr keycode 85 = +A
+	shift shiftr keycode 85 = +a
+	altgr keycode 85 = Hex_A
+keycode 86 = z
+	shiftr keycode 86 = +Z
+	shift shiftr keycode 86 = +z
+
+# This is the windows key:
+keycode 88 = Decr_Console
+keycode 89 = Shift
+keycode 90 = Control
+keycode 91 = Control
+keycode 92 = Alt
+keycode 93 = AltGr
+keycode 94 = ShiftR
+	shift keycode 94 = Caps_Lock
+
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/victor-mpc30x/Makefile linux/arch/mips/vr41xx/victor-mpc30x/Makefile
--- linux.orig/arch/mips/vr41xx/victor-mpc30x/Makefile	Wed Jul 30 09:35:38 2003
+++ linux/arch/mips/vr41xx/victor-mpc30x/Makefile	Thu Sep 11 23:19:29 2003
@@ -14,6 +14,13 @@
 
 obj-y	:= init.o setup.o
 
-obj-$(CONFIG_PCI)	+= pci_fixup.o
+obj-$(CONFIG_PCI)		+= pci_fixup.o
+obj-$(CONFIG_VR41XX_KIU)	+= keymap.o
+
+keymap.c: keymap.map
+	set -e ; loadkeys --mktable $< | sed -e 's/^static *//' > $@
+
+clean:
+	rm -f keymap.c
 
 include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/victor-mpc30x/keymap.map linux/arch/mips/vr41xx/victor-mpc30x/keymap.map
--- linux.orig/arch/mips/vr41xx/victor-mpc30x/keymap.map	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/victor-mpc30x/keymap.map	Fri Sep 12 00:21:42 2003
@@ -0,0 +1,102 @@
+# Victor Interlink MP-C303/304 keyboard keymap
+#
+# Copyright 2003 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+keymaps 0-1,4-5,8-9,12
+alt_is_meta
+strings as usual
+compose as usual for "iso-8859-1"
+
+# First line
+keycode 89 = Escape
+keycode  9 = Delete
+
+# 2nd line
+keycode 73 = one              exclam
+keycode 18 = two              quotedbl
+keycode 92 = three            numbersign
+	control	keycode 92 = Escape
+keycode 53 = four             dollar
+	control	keycode 53 = Control_backslash
+keycode 21 = five             percent
+	control	keycode 21 = Control_bracketright
+keycode 50 = six              ampersand
+	control	keycode 50 = Control_underscore
+keycode 48 = seven            apostrophe
+keycode 51 = eight            parenleft
+keycode 16 = nine             parenright
+keycode 80 = zero             asciitilde
+	control	keycode 80 = nul
+keycode 49 = minus            equal
+keycode 30 = asciicircum      asciitilde
+	control	keycode 30 = Control_asciicircum
+keycode  5 = backslash        bar
+	control	keycode  5 = Control_backslash
+keycode 13 = BackSpace
+# 3rd line
+keycode 57 = Tab
+keycode 74 = q
+keycode 26 = w
+keycode 81 = e
+keycode 29 = r
+keycode 37 = t
+keycode 45 = y
+keycode 72 = u
+keycode 24 = i
+keycode 32 = o
+keycode 41 = p
+keycode  1 = at               grave
+	control	keycode  1 = nul
+keycode 54 = bracketleft      braceleft
+keycode 63 = Return
+	alt	keycode 63 = Meta_Control_m
+# 4th line
+keycode 23 = Caps_Lock
+keycode 34 = a
+keycode 66 = s
+keycode 52 = d
+keycode 20 = f
+keycode 84 = g
+keycode 67 = h
+keycode 64 = j
+keycode 17 = k
+keycode 83 = l
+keycode 22 = semicolon        plus
+keycode 61 = colon            asterisk
+	control keycode 61 = Control_g
+keycode 65 = bracketright     braceright
+	control	keycode 65 = Control_bracketright
+# 5th line
+keycode 91 = Shift
+keycode 76 = z
+keycode 68 = x
+keycode 28 = c
+keycode 36 = v
+keycode 44 = b
+keycode 19 = n
+keycode 27 = m
+keycode 35 = comma            less
+keycode  3 = period           greater
+	control	keycode  3 = Compose
+keycode 38 = slash            question
+	control	keycode 38 = Delete
+	shift	control	keycode 38 = Delete
+keycode  6 = backslash        underscore
+	control	keycode  6 = Control_backslash
+keycode 55 = Up
+	alt keycode 55 = PageUp
+keycode 14 = Shift
+# 6th line
+keycode 56 = Control
+keycode 42 = Alt
+keycode 33 = space
+	control	keycode 33 = nul
+keycode  7 = Left
+	alt keycode  7 = Home
+keycode 31 = Down
+	alt keycode 31 = PageDown
+keycode 47 = Right
+	alt keycode 47 = End
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/char/Config.in linux/drivers/char/Config.in
--- linux.orig/drivers/char/Config.in	Thu Aug 14 02:19:16 2003
+++ linux/drivers/char/Config.in	Thu Sep 11 23:19:29 2003
@@ -157,6 +157,9 @@
    fi
    bool 'Enable Smart Card Reader 0 Support ' CONFIG_IT8172_SCR0
 fi
+if [ "$CONFIG_CPU_VR41XX" = "y" ]; then
+   bool 'NEC VR4100 series Keyboard Interface Unit Support ' CONFIG_VR41XX_KIU
+fi
 bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
 if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then
    int 'Maximum number of Unix98 PTYs in use (0-2048)' CONFIG_UNIX98_PTY_COUNT 256
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/char/Makefile linux/drivers/char/Makefile
--- linux.orig/drivers/char/Makefile	Thu Aug 14 02:19:16 2003
+++ linux/drivers/char/Makefile	Thu Sep 11 23:22:32 2003
@@ -46,6 +46,10 @@
   ifneq ($(CONFIG_PC_KEYB),y)
     KEYBD    =
   endif
+  ifeq ($(CONFIG_VR41XX_KIU),y)
+    KEYMAP   =
+    KEYBD    = vr41xx_keyb.o
+  endif
 endif
 
 ifeq ($(ARCH),s390x)
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/char/vr41xx_keyb.c linux/drivers/char/vr41xx_keyb.c
--- linux.orig/drivers/char/vr41xx_keyb.c	Thu Jan  1 09:00:00 1970
+++ linux/drivers/char/vr41xx_keyb.c	Thu Sep 11 23:40:26 2003
@@ -0,0 +1,410 @@
+/*
+ * FILE NAME
+ *	drivers/char/vr41xx_keyb.c
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Keyboard driver for NEC VR4100 series Keyboard Interface Unit.
+ *
+ * Copyright (C) 1999 Bradley D. LaRonde
+ * Copyright (C) 1999 Hiroshi Kawashima <kawashima@iname.com>
+ * Copyright (C) 2000 Michael Klar <wyldfier@iname.com>
+ * Copyright (C) 2002,2003 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+/*
+ * Changes:
+ *  version 1.0
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Mon, 25 Mar 2002
+ *  -  Rewrote extensively because of 2.4.18.
+ *
+ *  version 1.1
+ *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Wed,  9 Sep 200
+ *  -  Added NEC VRC4173 KIU support.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/kbd_ll.h>
+#ifdef CONFIG_PCI
+#include <linux/pci.h>
+#endif
+#include <linux/pm.h>
+
+#include <asm/addrspace.h>
+#include <asm/cpu.h>
+#include <asm/io.h>
+#include <asm/param.h>
+#include <asm/vr41xx/vr41xx.h>
+#ifdef CONFIG_VRC4173
+#include <asm/vr41xx/vrc4173.h>
+#endif
+
+#define KIU_BASE			KSEG1ADDR(0x0b000180)
+#define MKIUINTREG			KSEG1ADDR(0x0b000092)
+
+#define VRC4173_KIU_OFFSET		0x100
+#define VRC4173_MKIUINTREG_OFFSET	0x072
+
+#define KIUDAT0				0x00
+#define KIUDAT1				0x02
+#define KIUDAT2				0x04
+#define KIUDAT3				0x06
+#define KIUDAT4				0x08
+#define KIUDAT5				0x0a
+#define KIUDAT6				0x0c
+#define KIUDAT7				0x0e
+#define KIUSCANREP			0x10
+ #define KIUSCANREP_KEYEN		0x8000
+ #define KIUSCANREP_STPREP(x)		((x) << 4)
+ #define KIUSCANREP_SCANSTP		0x0008
+ #define KIUSCANREP_SCANSTART		0x0004
+ #define KIUSCANREP_ATSTP		0x0002
+ #define KIUSCANREP_ATSCAN		0x0001
+#define KIUSCANS			0x12
+ #define KIUSCANS_SCANNING		0x0003
+ #define KIUSCANS_INTERVAL		0x0002
+ #define KIUSCANS_WAITKEYIN		0x0001
+ #define KIUSCANS_STOPPED		0x0000
+#define KIUWKS				0x14
+ #define KIUWKS_T3CNT			0x7c00
+ #define KIUWKS_T3CNT_SHIFT		10
+ #define KIUWKS_T2CNT			0x03e0
+ #define KIUWKS_T2CNT_SHIFT		5
+ #define KIUWKS_T1CNT			0x001f
+ #define KIUWKS_T1CNT_SHIFT		0
+ #define KIUWKS_CNT_USEC(x)		(((x) / 30) - 1)
+#define KIUWKI				0x16
+ #define KIUWKI_INTERVAL_USEC(x)	((x) / 30)
+#define KIUINT				0x18
+ #define KIUINT_KDATLOST		0x0004
+ #define KIUINT_KDATRDY			0x0002
+ #define KIUINT_SCANINT			0x0001
+#define KIURST				0x1a
+ #define KIURST_KIURST			0x0001
+#define KIUGPEN				0x1c
+ #define KIUGPEN_KGPEN(x)		((uint16_t)1 << (x))
+#define SCANLINE			0x1e
+ #define SCANLINE_DONTUSE		0x0003
+ #define SCANLINE_8LINES		0x0002
+ #define SCANLINE_10LINES		0x0001
+ #define SCANLINE_12LINES		0x0000
+
+static unsigned long kiu_base;
+static unsigned long mkiuintreg;
+
+#ifdef CONFIG_VRC4173
+#define kiu_readw(offset)		vrc4173_inw(kiu_base + (offset))
+#define kiu_writew(val, offset)		vrc4173_outw(val, kiu_base + (offset))
+#define mkiuintreg_writew(val)		vrc4173_outw((val), mkiuintreg)
+#else
+#define kiu_readw(offset)		readw(kiu_base + (offset))
+#define kiu_writew(val, offset)		writew(val, kiu_base + (offset))
+#define mkiuintreg_writew(val)		writew((val), mkiuintreg)
+#endif
+
+#define KIU_CLOCK			0x0008
+
+#ifdef CONFIG_VRC4173
+#define KIU_IRQ				VRC4173_KIU_IRQ
+#else
+#define KIU_IRQ				SYSINT1_IRQ(7)
+#endif
+
+#define KEY_UP				0
+#define KEY_DOWN			1
+
+#define DEFAULT_KIUDAT_REGS		6
+#define DEFAULT_DATA_NOT_REVERSED	0
+#define DEFAULT_T3CNT			KIUWKS_CNT_USEC(200)
+#define DEFAULT_T2CNT			KIUWKS_CNT_USEC(200)
+#define DEFAULT_T1CNT			KIUWKS_CNT_USEC(200)
+#define DEFAULT_SCAN_INTERVAL		KIUWKI_INTERVAL_USEC(30000)
+#define DEFAULT_REPEAT_DELAY		HZ/4
+#define DEFAULT_REPEAT_RATE		HZ/25
+
+static char *kiu_driver_name = "Keyboard driver";
+static char *kiu_driver_version = "1.1";
+static char *kiu_driver_revdate = "2003-09-09";
+static char *kiu_driver_device_name = "NEC VR4100 series KIU";
+
+static unsigned char kiudat_regs = DEFAULT_KIUDAT_REGS;
+static unsigned char data_reverse = DEFAULT_DATA_NOT_REVERSED;
+static uint16_t scanlines = SCANLINE_12LINES;
+static uint16_t t3cnt = DEFAULT_T3CNT;
+static uint16_t t2cnt = DEFAULT_T2CNT;
+static uint16_t t1cnt = DEFAULT_T1CNT;
+static uint16_t scan_interval = DEFAULT_SCAN_INTERVAL;
+
+static unsigned long repeat_delay = DEFAULT_REPEAT_DELAY;
+static unsigned long repeat_rate = DEFAULT_REPEAT_RATE;
+
+static int repeat_scancode = -1;
+static unsigned long next_handle_time;
+
+struct kiudat_t {
+	uint32_t reg;
+	uint16_t data;
+};
+
+static struct kiudat_t kiudat [8] = {
+	{KIUDAT0, 0}, {KIUDAT1, 0},
+	{KIUDAT2, 0}, {KIUDAT3, 0},
+	{KIUDAT4, 0}, {KIUDAT5, 0},
+	{KIUDAT6, 0}, {KIUDAT7, 0},
+};
+
+int kbd_setkeycode(unsigned int scancode, unsigned int keycode)
+{
+	return (scancode == keycode) ? 0 : -EINVAL;
+}
+
+int kbd_getkeycode(unsigned int scancode)
+{
+	return scancode;
+}
+
+int kbd_translate(unsigned char scancode, unsigned char *keycode, char raw_mode)
+{
+	*keycode = scancode;
+	return 1;
+}
+
+char kbd_unexpected_up(unsigned char keycode)
+{
+	printk(KERN_WARNING "vr41xx_keyb: unexpected up, keycode 0x%02x\n", keycode);
+	return 0x80;
+}
+
+void kbd_leds(unsigned char leds)
+{
+	return;
+}
+
+static inline void handle_kiudat(uint16_t data, uint16_t cmp_data, int scancode)
+{
+	uint16_t mask;
+	int down, candidate_scancode = 0;
+
+	for (mask = 0x0001; mask ; mask <<= 1) {
+		if (cmp_data & mask) {
+			down = data & mask ? KEY_DOWN : KEY_UP;
+			if (down == KEY_DOWN) {
+				repeat_scancode = scancode;
+				next_handle_time = jiffies + repeat_delay;
+			}
+			else {
+				if (repeat_scancode == scancode)
+					repeat_scancode = -1;
+			}
+			handle_scancode(scancode, down);
+		}
+		if (data & mask) {
+			candidate_scancode = scancode;
+		}
+		scancode++;
+	}
+
+	if ((repeat_scancode < 0) && (candidate_scancode > 0)) {
+			repeat_scancode = candidate_scancode;
+			next_handle_time = jiffies + repeat_delay;
+	}
+}
+
+static inline void handle_kiu_event(void)
+{
+	struct kiudat_t *kiu = kiudat;
+	uint16_t data, last_data, cmp_data;
+	int i;
+
+	for (i = 0; i < kiudat_regs; i++) {
+		last_data = kiu->data;
+		data = kiu_readw(kiu->reg);
+		if (data_reverse)
+			data = ~data;
+		kiu->data = data;
+		cmp_data = data ^ last_data;
+		handle_kiudat(data, cmp_data, i * 16);
+		kiu++;
+	}
+
+	if ((repeat_scancode >= 0) &&
+	    (time_after_eq(jiffies, next_handle_time))) {
+		handle_scancode(repeat_scancode, KEY_DOWN);
+		next_handle_time = jiffies + repeat_rate;
+	}
+}
+
+static void kiu_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	uint16_t status;
+
+	mkiuintreg_writew(0);
+
+	status = kiu_readw(KIUINT);
+	kiu_writew(KIUINT_KDATLOST | KIUINT_KDATRDY | KIUINT_SCANINT, KIUINT);
+
+	if (status & KIUINT_KDATRDY)
+		handle_kiu_event();
+
+	mkiuintreg_writew(KIUINT_KDATLOST | KIUINT_KDATRDY);
+}
+
+#ifdef CONFIG_PM
+
+static int pm_kiu_request(struct pm_dev *dev, pm_request_t rqst, void *data)
+{
+	switch (rqst) {
+	case PM_SUSPEND:
+		mkiuintreg_writew(KIUINT_SCANINT);
+		break;
+	case PM_RESUME:
+		kiu_writew(KIUINT_KDATLOST | KIUINT_KDATRDY | KIUINT_SCANINT, KIUINT);
+		mkiuintreg_writew(KIUINT_KDATLOST | KIUINT_KDATRDY, MKIUINTREG);
+		break;
+	}
+
+	return 0;
+}
+
+#endif
+
+void __devinit kbd_init_hw(void)
+{
+	uint16_t kiugpen = 0;
+	int i;
+
+	if (current_cpu_data.cputype == CPU_VR4111 ||
+	    current_cpu_data.cputype == CPU_VR4121) {
+		kiu_base = KIU_BASE;
+		mkiuintreg = MKIUINTREG;
+#if defined(CONFIG_PCI) && defined(CONFIG_VRC4173)
+	} else if (current_cpu_data.cputype == CPU_VR4122 ||
+	           current_cpu_data.cputype == CPU_VR4131) {
+		struct pci_dev *dev;
+		int found = 0;
+		dev = pci_find_device(PCI_VENDOR_ID_NEC,
+		                      PCI_DEVICE_ID_NEC_VRC4173, NULL);
+		if (dev != NULL) {
+			switch (scanlines) {
+			case SCANLINE_8LINES:
+				vrc4173_select_function(KIU8_SELECT);
+				found = 1;
+				break;
+			case SCANLINE_10LINES:
+				vrc4173_select_function(KIU10_SELECT);
+				found = 1;
+				break;
+			case SCANLINE_12LINES:
+				vrc4173_select_function(KIU12_SELECT);
+				found = 1;
+				break;
+			default:
+				break;
+			}
+
+			if (found != 0) {
+				kiu_base = VRC4173_KIU_OFFSET;
+				mkiuintreg = VRC4173_MKIUINTREG_OFFSET;
+				vrc4173_clock_supply(VRC4173_KIU_CLOCK);
+			}
+		}
+#endif
+	}
+
+	if (kiu_base == 0 || mkiuintreg == 0)
+		return;
+
+	printk(KERN_INFO "%s version %s (%s) for %s\n",
+	       kiu_driver_name, kiu_driver_version,
+	       kiu_driver_revdate, kiu_driver_device_name);
+
+	mkiuintreg_writew(0);
+
+	if (current_cpu_data.cputype == CPU_VR4111 ||
+	    current_cpu_data.cputype == CPU_VR4121)
+		vr41xx_clock_supply(KIU_CLOCK);
+
+	kiu_writew(KIURST_KIURST, KIURST);
+
+	for (i = 0; i < scanlines; i++)
+		kiugpen &= ~(0x0001 << i);
+
+	kiu_writew(kiugpen, KIUGPEN);
+	kiu_writew(scanlines, SCANLINE);
+	kiu_writew((t3cnt << KIUWKS_T3CNT_SHIFT) |
+	           (t2cnt << KIUWKS_T2CNT_SHIFT) |
+	           (t1cnt << KIUWKS_T1CNT_SHIFT), KIUWKS);
+	kiu_writew(scan_interval, KIUWKI);
+	kiu_writew(KIUINT_KDATLOST | KIUINT_KDATRDY | KIUINT_SCANINT, KIUINT);
+
+
+	request_irq(KIU_IRQ, kiu_interrupt, 0, "keyboard", NULL);
+
+	mkiuintreg_writew(KIUINT_KDATLOST | KIUINT_KDATRDY);
+	kiu_writew(KIUSCANREP_KEYEN | KIUSCANREP_STPREP(1) |
+	       KIUSCANREP_ATSTP | KIUSCANREP_ATSCAN, KIUSCANREP);
+
+#ifdef CONFIG_PM
+	pm_register(PM_SYS_DEV, PM_SYS_KBC, pm_kiu_request);
+#endif
+}
+
+static int __devinit vr41xx_kbd_setup(char *options)
+{
+	char *this_opt;
+	int num;
+
+	if (!options || !*options)
+		return 1;
+
+	for (this_opt = strtok(options, ","); this_opt; this_opt = strtok(NULL, ",")) {
+		if (!strncmp(this_opt, "regs:", 5)) {
+			num = simple_strtoul(this_opt+5, NULL, 0);
+			if (num == 6 || num == 8)
+				kiudat_regs = num;
+		} else if (!strncmp(this_opt, "lines:", 6)) {
+			num = simple_strtoul(this_opt+6, NULL, 0);
+			if (num == 8)
+				scanlines = SCANLINE_8LINES;
+			else if (num == 10)
+				scanlines = SCANLINE_10LINES;
+			else if (num == 12)
+				scanlines = SCANLINE_12LINES;
+		} else if (!strncmp(this_opt, "reverse:", 8)) {
+			num = simple_strtoul(this_opt+8, NULL, 0);
+			if (num == 0 || num == 1)
+				data_reverse = num;
+		} else if (!strncmp(this_opt, "t3cnt:", 6)) {
+			num = simple_strtoul(this_opt+6, NULL, 0);
+			if (num >= 60 && num <= 960)
+				t3cnt = KIUWKS_CNT_USEC(num);
+		} else if (!strncmp(this_opt, "t2cnt:", 6)) {
+			num = simple_strtoul(this_opt+6, NULL, 0);
+			if (num >= 60 && num <= 960)
+				t2cnt = KIUWKS_CNT_USEC(num);
+		} else if (!strncmp(this_opt, "t1cnt:", 6)) {
+			num = simple_strtoul(this_opt+6, NULL, 0);
+			if (num >= 60 && num <= 960)
+				t1cnt = KIUWKS_CNT_USEC(num);
+		} else if (!strncmp(this_opt, "interval:", 9)) {
+			num = simple_strtoul(this_opt+9, NULL, 0);
+			if (num >= 30 && num <= 30690)
+				scan_interval = KIUWKI_INTERVAL_USEC(num);
+		} else if (!strncmp(this_opt, "delay:", 6)) {
+			num = simple_strtoul(this_opt+6, NULL, 0);
+			if (num > 0 && num <= HZ)
+				repeat_delay = num;
+		} else if (!strncmp(this_opt, "rate:", 5)) {
+			num = simple_strtoul(this_opt+5, NULL, 0);
+			if (num > 0 && num <= HZ)
+				repeat_rate = num;
+		}
+	}
+
+	return 1;
+}
+
+__setup("vr41xx_kbd=", vr41xx_kbd_setup);
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vrc4173.h linux/include/asm-mips/vr41xx/vrc4173.h
--- linux.orig/include/asm-mips/vr41xx/vrc4173.h	Thu Mar 20 03:15:16 2003
+++ linux/include/asm-mips/vr41xx/vrc4173.h	Thu Sep 11 23:47:58 2003
@@ -75,6 +75,12 @@
 extern void vrc4173_clock_supply(u16 mask);
 extern void vrc4173_clock_mask(u16 mask);
 
+#define VRC4173_PIU_CLOCK	0x0001
+#define VRC4173_KIU_CLOCK	0x0002
+#define VRC4173_AIU_CLOCK	0x0004
+#define VRC4173_PS2CH1_CLOCK	0x0008
+#define VRC4173_PS2CH2_CLOCK	0x0010
+
 /*
  * General-Purpose I/O Unit
  */

--Multipart_Fri__12_Sep_2003_00:44:20_+0900_0822dc80--
