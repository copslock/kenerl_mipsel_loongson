Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2006 15:00:36 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:27915 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20038617AbWKSPAc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Nov 2006 15:00:32 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id AEB8664D3D; Sun, 19 Nov 2006 15:00:22 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B8A9254BEB; Sun, 19 Nov 2006 14:59:58 +0000 (GMT)
Date:	Sun, 19 Nov 2006 14:59:58 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Fix long IDE detection delay by not scanning non-existent channels
Message-ID: <20061119145958.GA5935@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Ralf, please consider this patch.  It's being used successfully in
Debian and has been acked by Alan Cox.


From: Peter Horton <pdh@colonel-panic.org>

Fix long delay during Cobalt boot whilst scanning non-existent
interfaces. The logic is copied from i386 i.e. we only scan 2 legacy
ports if we have PCI IDE.

Signed-off-by: Peter Horton <pdh@colonel-panic.org>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- linux.git.orig/include/asm-mips/mach-generic/ide.h	2006-01-24 22:07:36.000000000 +0000
+++ linux.git/include/asm-mips/mach-generic/ide.h	2006-01-24 23:41:19.000000000 +0000
@@ -30,7 +30,7 @@
 
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
-static __inline__ int ide_probe_legacy(void)
+static __inline__ int ide_legacy_ports(void)
 {
 #ifdef CONFIG_PCI
 	struct pci_dev *dev;
@@ -38,11 +38,11 @@
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
@@ -50,30 +50,26 @@
 
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
@@ -87,11 +83,8 @@
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


-- 
Martin Michlmayr
http://www.cyrius.com/
