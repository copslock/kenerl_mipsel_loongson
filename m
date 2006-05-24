Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 14:53:44 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:22291 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133534AbWEXMxd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 May 2006 14:53:33 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9B95F64D54; Wed, 24 May 2006 12:53:26 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A542366AFD; Wed, 24 May 2006 14:53:12 +0200 (CEST)
Date:	Wed, 24 May 2006 14:53:12 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Fix long IDE detection delay by not scanning non-existent channels
Message-ID: <20060524125312.GA22947@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The following patch still hasn't been applied.  Anything wrong with
it?


From: Peter Horton <pdh@colonel-panic.org>

Fix long delay during Cobalt boot whilst scanning non-existent
interfaces. The logic is copied from i386 i.e. we only scan 2 legacy
ports if we have PCI IDE.

Signed-off-by: Peter Horton <pdh@colonel-panic.org>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>

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
