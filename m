Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 20:55:37 +0000 (GMT)
Received: from dhcp-1268-39.blizz.at ([IPv6:::ffff:213.143.126.4]:6528 "EHLO
	cervus.intra") by linux-mips.org with ESMTP id <S8224936AbUKVUzb>;
	Mon, 22 Nov 2004 20:55:31 +0000
Received: from xterm.intra ([10.49.1.10])
	by cervus.intra with esmtp (Exim 4.34)
	id 1CWLDR-0000an-C2; Mon, 22 Nov 2004 21:55:17 +0100
Subject: [PATCH] support for au1xxx on-chip usb in BE mode
From: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: Research Group for Industrial Software @ Vienna University of
	Technology
Date: Mon, 22 Nov 2004 21:55:16 +0100
Message-Id: <1101156917.26578.9.camel@xterm.intra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Return-Path: <hvr@inso.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@inso.tuwien.ac.at
Precedence: bulk
X-list: linux-mips


It's not pretty... but here it is anyway... :-)


Index: drivers/usb/host/Kconfig
===================================================================
RCS file: /home/cvs/linux/drivers/usb/host/Kconfig,v
retrieving revision 1.8
diff -u -u -r1.8 Kconfig
--- drivers/usb/host/Kconfig	15 Nov 2004 11:49:33 -0000	1.8
+++ drivers/usb/host/Kconfig	22 Nov 2004 20:49:20 -0000
@@ -16,6 +16,10 @@
 	default y if PXA27x
 	default PCI
 
+config USB_OHCI_BIG_ENDIAN
+	boolean
+	default y if SOC_AU1X00 && !CPU_LITTLE_ENDIAN
+
 #
 # USB Host Controller Drivers
 #
Index: drivers/usb/host/ohci-hcd.c
===================================================================
RCS file: /home/cvs/linux/drivers/usb/host/ohci-hcd.c,v
retrieving revision 1.40
diff -u -u -r1.40 ohci-hcd.c
--- drivers/usb/host/ohci-hcd.c	15 Nov 2004 11:49:33 -0000	1.40
+++ drivers/usb/host/ohci-hcd.c	22 Nov 2004 20:49:21 -0000
@@ -881,7 +881,7 @@
 MODULE_LICENSE ("GPL");
 
 #ifdef CONFIG_PCI
-#include "ohci-pci.c"
+//#include "ohci-pci.c"
 #endif
 
 #ifdef CONFIG_SA1111
Index: drivers/usb/host/ohci.h
===================================================================
RCS file: /home/cvs/linux/drivers/usb/host/ohci.h,v
retrieving revision 1.21
diff -u -u -r1.21 ohci.h
--- drivers/usb/host/ohci.h	15 Nov 2004 11:49:33 -0000	1.21
+++ drivers/usb/host/ohci.h	22 Nov 2004 20:49:21 -0000
@@ -458,6 +458,11 @@
 #define writel_be(val, addr)	out_be32((__force unsigned *)addr, val)
 #endif
 
+#if defined(CONFIG_SOC_AU1X00)
+#define readl_be(addr)          __raw_readl((__force u32 *)(addr))
+#define writel_be(val, addr)    __raw_writel(val, (__force u32 *)(addr))
+#endif
+
 static inline unsigned int ohci_readl (const struct ohci_hcd *ohci,
 							__hc32 __iomem * regs)
 {
@@ -467,8 +472,11 @@
 static inline void ohci_writel (const struct ohci_hcd *ohci,
 				const unsigned int val, __hc32 __iomem *regs)
 {
-	big_endian(ohci) ? writel_be (val, regs) :
-			   writel (val, (__force u32 *)regs);
+	if (big_endian(ohci)) {
+		writel_be (val, regs);
+	} else {
+		writel (val, (__force u32 *)regs);
+	}
 }
 
 #else	/* !CONFIG_USB_OHCI_BIG_ENDIAN */


-- 
Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
Research Group for Industrial Software @ Vienna University of Technology
