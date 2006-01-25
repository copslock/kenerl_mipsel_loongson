Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 00:09:08 +0000 (GMT)
Received: from i-83-67-53-76.freedom2surf.net ([83.67.53.76]:37841 "EHLO
	nephila.localnet") by ftp.linux-mips.org with ESMTP
	id S8133576AbWAYAIu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 00:08:50 +0000
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1F1YHX-0000fb-PI; Wed, 25 Jan 2006 00:13:03 +0000
Date:	Wed, 25 Jan 2006 00:13:03 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6] Cobalt IDE fix, again
Message-ID: <20060125001303.GA2569@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Fix long delay during Cobalt boot whilst scanning non-existent
interfaces. The logic is copied from i386 i.e. we only scan 2 legacy
ports if we have PCI IDE.

P.


Index: linux.git/include/asm-mips/mach-generic/ide.h
===================================================================
--- linux.git.orig/include/asm-mips/mach-generic/ide.h	2006-01-24 22:07:36.000000000 +0000
+++ linux.git/include/asm-mips/mach-generic/ide.h	2006-01-24 22:10:43.000000000 +0000
@@ -20,17 +20,9 @@
 #include <linux/stddef.h>
 #include <asm/processor.h>
 
-#ifndef MAX_HWIFS
-# ifdef CONFIG_BLK_DEV_IDEPCI
-#define MAX_HWIFS	10
-# else
-#define MAX_HWIFS	6
-# endif
-#endif
-
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
-static __inline__ int ide_probe_legacy(void)
+static __inline__ int ide_legacy_ports(void)
 {
 #ifdef CONFIG_PCI
 	struct pci_dev *dev;
@@ -38,11 +30,11 @@
 	    (dev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL)) != NULL) {
 		pci_dev_put(dev);
 
-		return 1;
+		return 2;
 	}
 	return 0;
 #elif defined(CONFIG_EISA) || defined(CONFIG_ISA)
-	return 1;
+	return 6;
 #else
 	return 0;
 #endif
@@ -50,30 +42,26 @@
 
 static __inline__ int ide_default_irq(unsigned long base)
 {
-	if (ide_probe_legacy())
-		switch (base) {
-		case 0x1f0:
-			return 14;
-		case 0x170:
-			return 15;
-		case 0x1e8:
-			return 11;
-		case 0x168:
-			return 10;
-		case 0x1e0:
-			return 8;
-		case 0x160:
-			return 12;
-		default:
-			return 0;
-		}
-	else
-		return 0;
+	switch (base) {
+	case 0x1f0:
+		return 14;
+	case 0x170:
+		return 15;
+	case 0x1e8:
+		return 11;
+	case 0x168:
+		return 10;
+	case 0x1e0:
+		return 8;
+	case 0x160:
+		return 12;
+	}
+	return 0;
 }
 
 static __inline__ unsigned long ide_default_io_base(int index)
 {
-	if (ide_probe_legacy())
+	if (index < ide_legacy_ports())
 		switch (index) {
 		case 0:
 			return 0x1f0;
@@ -87,11 +75,8 @@
 			return 0x1e0;
 		case 5:
 			return 0x160;
-		default:
-			return 0;
-		}
-	else
-		return 0;
+	}
+	return 0;
 }
 
 #define IDE_ARCH_OBSOLETE_INIT
