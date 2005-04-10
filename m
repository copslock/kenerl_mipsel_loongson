Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2005 14:12:01 +0100 (BST)
Received: from i-83-67-53-76.freedom2surf.net ([IPv6:::ffff:83.67.53.76]:3465
	"EHLO skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225949AbVDJNLe>; Sun, 10 Apr 2005 14:11:34 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1DKcDx-0005OS-00; Sun, 10 Apr 2005 14:11:37 +0100
Date:	Sun, 10 Apr 2005 14:11:37 +0100
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH Cobalt 3/3] add PCI retry error handler
Message-ID: <20050410131137.GA20709@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Add PCI retry error handler. We can drop the check for the device #6
from pci_range_ck() as we now get a diagnostic message and the kernel
continues the boot.

--

Index: linux/arch/mips/pci/fixup-cobalt.c
===================================================================
--- linux.orig/arch/mips/pci/fixup-cobalt.c	2005-03-04 15:13:37.000000000 +0000
+++ linux/arch/mips/pci/fixup-cobalt.c	2005-04-10 13:16:12.000000000 +0100
@@ -102,7 +102,14 @@
 		/* XXX WE MUST DO THIS ELSE GALILEO LOCKS UP! -DaveM */
 		timeo = GALILEO_INL(GT_PCI0_TOR_OFS);
 		/* Old Galileo, assumes PCI STOP line to VIA is disconnected. */
-		GALILEO_OUTL(0xffff, GT_PCI0_TOR_OFS);
+		GALILEO_OUTL(
+			(0xff << 16) |		/* retry count */
+			(0xff << 8) |		/* timeout 1   */
+			0xff,			/* timeout 0   */
+			GT_PCI0_TOR_OFS);
+
+		/* enable PCI retry exceeded interrupt */
+		GALILEO_OUTL(GALILEO_INTR_RETRY_CTR | GALILEO_INL(GT_INTRMASK_OFS), GT_INTRMASK_OFS);
 	}
 }
 
Index: linux/arch/mips/pci/ops-gt64111.c
===================================================================
--- linux.orig/arch/mips/pci/ops-gt64111.c	2005-03-04 15:13:37.000000000 +0000
+++ linux/arch/mips/pci/ops-gt64111.c	2005-04-10 13:16:12.000000000 +0100
@@ -18,21 +18,13 @@
 #include <asm/cobalt/cobalt.h>
 
 /*
- * Accessing device 31 hangs the GT64120.  Not sure if this will also hang
- * the GT64111, let's be paranoid for now.
- *
- * Accessing device COBALT_PCICONF_CPU hangs early units.
+ * Device 31 on the GT64111 is used to generate PCI special
+ * cycles, so we shouldn't expected to find a device there ...
  */
 static inline int pci_range_ck(struct pci_bus *bus, unsigned int devfn)
 {
-	unsigned slot;
-
-	if (bus->number == 0) {
-
-		slot = PCI_SLOT(devfn);
-		if (slot != COBALT_PCICONF_CPU && slot < 31)
-			return 0;
-	}
+	if (bus->number == 0 && PCI_SLOT(devfn) < 31)
+		return 0;
 
 	return -1;
 }
Index: linux/arch/mips/cobalt/irq.c
===================================================================
--- linux.orig/arch/mips/cobalt/irq.c	2005-04-10 13:16:12.000000000 +0100
+++ linux/arch/mips/cobalt/irq.c	2005-04-10 13:43:39.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/pci.h>
 
 #include <asm/i8259.h>
 #include <asm/irq_cpu.h>
@@ -45,7 +46,7 @@
 
 static inline void galileo_irq(struct pt_regs *regs)
 {
-	unsigned int mask, pending;
+	unsigned int mask, pending, devfn;
 
 	mask = GALILEO_INL(GT_INTRMASK_OFS);
 	pending = GALILEO_INL(GT_INTRCAUSE_OFS) & mask;
@@ -55,6 +56,13 @@
 		GALILEO_OUTL(~GALILEO_INTR_T0EXP, GT_INTRCAUSE_OFS);
 		do_IRQ(COBALT_GALILEO_IRQ, regs);
 
+	} else if (pending & GALILEO_INTR_RETRY_CTR) {
+
+		devfn = GALILEO_INL(GT_PCI0_CFGADDR_OFS) >> 8;
+		GALILEO_OUTL(~GALILEO_INTR_RETRY_CTR, GT_INTRCAUSE_OFS);
+		printk(KERN_WARNING "Galileo: PCI retry count exceeded (%02x.%u)\n",
+			PCI_SLOT(devfn), PCI_FUNC(devfn));
+
 	} else {
 
 		GALILEO_OUTL(mask & ~pending, GT_INTRMASK_OFS);
Index: linux/include/asm-mips/cobalt/cobalt.h
===================================================================
--- linux.orig/include/asm-mips/cobalt/cobalt.h	2005-04-10 13:16:12.000000000 +0100
+++ linux/include/asm-mips/cobalt/cobalt.h	2005-04-10 13:16:12.000000000 +0100
@@ -87,6 +87,7 @@
 } while (0)
 
 #define GALILEO_INTR_T0EXP	(1 << 8)
+#define GALILEO_INTR_RETRY_CTR	(1 << 20)
 
 #define GALILEO_ENTC0		0x01
 #define GALILEO_SELTC0		0x02
