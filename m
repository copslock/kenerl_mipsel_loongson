Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 17:53:20 +0000 (GMT)
Received: from p4-3018.uk2net.com ([213.232.92.20]:65418 "EHLO
	p4-3018.uk2net.com") by ftp.linux-mips.org with ESMTP
	id S8133683AbWAZRxC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 17:53:02 +0000
Received: from pdh by p4-3018.uk2net.com with local (Exim 3.36 #1 (Debian))
	id 1F2BN7-00006u-00; Thu, 26 Jan 2006 17:57:25 +0000
Date:	Thu, 26 Jan 2006 17:57:25 +0000
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2.6] Cobalt IDE fix, again
Message-ID: <20060126175725.GA409@colonel-panic.org>
Reply-To: pdh@colonel-panic.org
References: <20060125001303.GA2569@colonel-panic.org> <20060126171904.GA12850@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126171904.GA12850@deprecation.cyrius.com>
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@p4-3018.uk2net.com>
Return-Path: <pdh@p4-3018.uk2net.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@p4-3018.uk2net.com
Precedence: bulk
X-list: linux-mips

On Thu, Jan 26, 2006 at 05:19:04PM +0000, Martin Michlmayr wrote:
> now I get:
> 
> drivers/ide/mips/swarm.c: In function ???swarm_ide_probe???:
> drivers/ide/mips/swarm.c:78: error: ???CONFIG_IDE_MAX_HWIFS??? undeclared (first use in this function)
> drivers/ide/mips/swarm.c:78: error: (Each undeclared identifier is reported only once
> drivers/ide/mips/swarm.c:78: error: for each function it appears in.)
> 

Bum, I munged the patch. Fixed patch below ...

P.

Index: linux.git/include/asm-mips/mach-generic/ide.h
===================================================================
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
