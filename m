Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 00:37:41 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:63500
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8225196AbUJJXhh>;
	Mon, 11 Oct 2004 00:37:37 +0100
Received: from [10.2.2.20] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9ANbYu18270
	for <linux-mips@linux-mips.org>; Sun, 10 Oct 2004 16:37:34 -0700
Subject: PATCH
From: Pete Popov <ppopov@embeddedalley.com>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain
Organization: 
Message-Id: <1097451798.4633.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 10 Oct 2004 16:43:18 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ralf,

Here is another patch for consideration. No updates are needed to other
platforms that need/require the obsolete ide probing. When enabled, the
patch gets rid of all the probing of obsolete ide devices.

diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/Kconfig linux-2.6-dev/arch/mips/Kconfig
--- linux-2.6-orig/arch/mips/Kconfig	2004-09-25 23:33:01.000000000 -0700
+++ linux-2.6-dev/arch/mips/Kconfig	2004-10-10 11:41:45.000000000 -0700
@@ -577,6 +577,7 @@
 	depends on SOC_AU1500
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
+	select MIPS_DISABLE_OBSOLETE_IDE
 
 config MIPS_DB1550
 	bool "DB1550 board"
@@ -896,6 +897,9 @@
 	depends on LASAT
 	default y
 
+config MIPS_DISABLE_OBSOLETE_IDE
+	bool
+
 config CPU_LITTLE_ENDIAN
 	bool "Generate little endian code"
 	default y if ACER_PICA_61 || CASIO_E55 || DDB5074 || DDB5476 || DDB5477 || MACH_DECSTATION || HP_LASERJET || IBM_WORKPAD || LASAT || MIPS_COBALT || MIPS_ITE8172 || MIPS_IVR || SOC_AU1X00 || NEC_OSPREY || OLIVETTI_M700 || SNI_RM200_PCI || VICTOR_MPC30X || ZAO_CAPCELLA
diff -Naur --exclude=CVS linux-2.6-orig/include/asm-mips/mach-generic/ide.h linux-2.6-dev/include/asm-mips/mach-generic/ide.h
--- linux-2.6-orig/include/asm-mips/mach-generic/ide.h	2004-06-09 07:12:13.000000000 -0700
+++ linux-2.6-dev/include/asm-mips/mach-generic/ide.h	2004-10-10 11:44:22.000000000 -0700
@@ -20,6 +20,7 @@
 # endif
 #endif
 
+#ifndef CONFIG_MIPS_DISABLE_OBSOLETE_IDE
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
 static inline int ide_default_irq(unsigned long base)
@@ -49,6 +50,7 @@
 			return 0;
 	}
 }
+#endif /* CONFIG_MIPS_DISABLE_OBSOLETE_IDE */
 
 #define IDE_ARCH_OBSOLETE_INIT
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
