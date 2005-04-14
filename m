Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2005 20:00:13 +0100 (BST)
Received: from i-83-67-53-76.freedom2surf.net ([IPv6:::ffff:83.67.53.76]:22429
	"EHLO skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8226017AbVDNS76>; Thu, 14 Apr 2005 19:59:58 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1DM9Z8-0001SV-00; Thu, 14 Apr 2005 19:59:50 +0100
Date:	Thu, 14 Apr 2005 19:59:49 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH Cobalt 1/1] 64-bit fix
Message-ID: <20050414185949.GA5578@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

This patch adds detection of broken 64-bit mode LL/SC on Cobalt units.
With this patch my Qube2700 boots a 64-bit build fine. The later units
have some problems with the Tulip driver.

P.

--

Index: linux/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux.orig/arch/mips/kernel/cpu-probe.c	2005-04-11 23:19:17.000000000 +0100
+++ linux/arch/mips/kernel/cpu-probe.c	2005-04-11 23:35:06.000000000 +0100
@@ -131,6 +131,58 @@
 	check_wait();
 }
 
+#ifdef CONFIG_MIPS64
+
+/*
+ * On RM5230/5231 all accesses to XKPHYS by LL(D) are forced
+ * to be uncached, bits 61-59 of the address are ignored.
+ *
+ * Apparently fixed on RM5230A/5231A.
+ */
+static inline int check_lld(void)
+{
+	unsigned long flags, value, match, phys, *addr;
+
+	printk("Checking for lld bug... ");
+
+	/* hope the stack is in the low 512MB */
+	phys = CPHYSADDR((unsigned long) &value);
+
+	/* write value to memory */
+	value = 0xfedcba9876543210;
+	addr = (unsigned long *) PHYS_TO_XKPHYS(K_CALG_UNCACHED, phys);
+	*addr = value;
+
+	/* stop spurious flushes */
+	local_irq_save(flags);
+
+	/* flip cached value */
+	value = ~value;
+
+	/* read value, supposedly from cache */
+	addr = (unsigned long *) PHYS_TO_XKPHYS(K_CALG_NONCOHERENT, phys);
+	asm volatile("lld %0, %1" : "=r" (match) : "m" (*addr));
+
+	local_irq_restore(flags);
+
+	match ^= value;
+
+	switch ((long) match) {
+	case 0:
+		printk("no.\n");
+		break;
+	case -1:
+		printk("yes.\n");
+		break;
+	default:
+		printk("yikes yes! (%lx/%lx@%p)\nPlease report to <linux-mips@linux-mips.org>.", value, match, &value);
+	}
+
+	return !match;
+}
+
+#endif
+
 /*
  * Probe whether cpu has config register by trying to play with
  * alternate cache bit and see whether it matters.
@@ -347,7 +399,11 @@
 		c->cputype = CPU_NEVADA;
 		c->isa_level = MIPS_CPU_ISA_IV;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
-		             MIPS_CPU_DIVEC | MIPS_CPU_LLSC;
+		             MIPS_CPU_DIVEC;
+#ifdef CONFIG_MIPS64
+		if (check_lld())
+#endif
+			c->options |= MIPS_CPU_LLSC;
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_R6000:
Index: linux/include/asm-mips/addrspace.h
===================================================================
--- linux.orig/include/asm-mips/addrspace.h	2005-04-11 23:19:17.000000000 +0100
+++ linux/include/asm-mips/addrspace.h	2005-04-11 23:19:20.000000000 +0100
@@ -120,7 +120,7 @@
 #define PHYS_TO_XKSEG_UNCACHED(p)	PHYS_TO_XKPHYS(K_CALG_UNCACHED,(p))
 #define PHYS_TO_XKSEG_CACHED(p)		PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE,(p))
 #define XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK)
-#define PHYS_TO_XKPHYS(cm,a)		(0x8000000000000000 | ((cm)<<59) | (a))
+#define PHYS_TO_XKPHYS(cm,a)		(0x8000000000000000 | ((unsigned long)(cm)<<59) | (a))
 
 #if defined (CONFIG_CPU_R4300)						\
     || defined (CONFIG_CPU_R4X00)					\
