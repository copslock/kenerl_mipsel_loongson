Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 00:35:03 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:35970
	"HELO alpha.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225212AbTF3XfA>; Tue, 1 Jul 2003 00:35:00 +0100
Received: (qmail 31335 invoked from network); 30 Jun 2003 16:27:45 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with SMTP; 30 Jun 2003 16:27:45 -0000
Received: (qmail 16941 invoked by uid 502); 30 Jun 2003 23:34:58 -0000
Date: Mon, 30 Jun 2003 16:34:58 -0700
From: ilya@theIlya.com
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: CRIME memory error reporting rewrite
Message-ID: <20030630233458.GT13617@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aH/0uqREc1VzwMkO"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--aH/0uqREc1VzwMkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is Keith's rewrite of CRIME memory error interrupt.
Works perfectly here, and makes life lot easier sometimes.
Plus it converts yet another irq handler to return irqreturn_t.


--aH/0uqREc1VzwMkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crime.diff"

Index: arch/mips/sgi-ip32/crime.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/crime.c,v
retrieving revision 1.2
diff -u -r1.2 crime.c
--- arch/mips/sgi-ip32/crime.c	6 Aug 2002 00:08:57 -0000	1.2
+++ arch/mips/sgi-ip32/crime.c	30 Jun 2003 23:26:54 -0000
@@ -3,13 +3,17 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001 Keith M Wesolowski
+ * Copyright (C) 2001, 2003 Keith M Wesolowski
  */
+#include <asm/ip32/crime.h>
+#include <asm/ptrace.h>
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/mipsregs.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <asm/ip32/crime.h>
-#include <asm/ptrace.h>
+#include <linux/interrupt.h>
 
 void __init crime_init (void)
 {
@@ -18,32 +22,75 @@
 
 	id = (id & CRIME_ID_IDBITS) >> 4;
 
-	printk ("CRIME id %1lx rev %ld detected at %016lx\n", id, rev,
+	printk ("CRIME id %1lx rev %ld detected at 0x%016lx\n", id, rev,
 		(unsigned long) CRIME_BASE);
 }
 
-/* XXX Like on Sun, these give us various useful information to printk. */
-void crime_memerr_intr (unsigned int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t crime_memerr_intr (unsigned int irq, void *dev_id, struct pt_regs *regs)
 {
 	u64 memerr = crime_read_64 (CRIME_MEM_ERROR_STAT);
 	u64 addr = crime_read_64 (CRIME_MEM_ERROR_ADDR);
+	int fatal = 0;
+
 	memerr &= CRIME_MEM_ERROR_STAT_MASK;
+	addr &= CRIME_MEM_ERROR_ADDR_MASK;
+
+	printk("CRIME memory error at 0x%08lx ST 0x%08lx<", addr, memerr);
 
-	printk ("CRIME memory error at physaddr 0x%08lx status %08lx\n",
-		addr << 2, memerr);
+	if (memerr & CRIME_MEM_ERROR_INV)
+		printk("INV,");
+	if (memerr & CRIME_MEM_ERROR_ECC) {
+		u64 ecc_syn = crime_read_64(CRIME_MEM_ERROR_ECC_SYN);
+		u64 ecc_gen = crime_read_64(CRIME_MEM_ERROR_ECC_CHK);
+
+		ecc_syn &= CRIME_MEM_ERROR_ECC_SYN_MASK;
+		ecc_gen &= CRIME_MEM_ERROR_ECC_CHK_MASK;
+
+		printk("ECC,SYN=0x%08lx,GEN=0x%08lx,", ecc_syn, ecc_gen);
+	}
+	if (memerr & CRIME_MEM_ERROR_MULTIPLE) {
+		fatal = 1;
+		printk("MULTIPLE,");
+	}
+	if (memerr & CRIME_MEM_ERROR_HARD_ERR) {
+		fatal = 1;
+		printk("HARD,");
+	}
+	if (memerr & CRIME_MEM_ERROR_SOFT_ERR)
+		printk("SOFT,");
+	if (memerr & CRIME_MEM_ERROR_CPU_ACCESS)
+		printk("CPU,");
+	if (memerr & CRIME_MEM_ERROR_VICE_ACCESS)
+		printk("VICE,");
+	if (memerr & CRIME_MEM_ERROR_GBE_ACCESS)
+		printk("GBE,");
+	if (memerr & CRIME_MEM_ERROR_RE_ACCESS)
+		printk("RE,REID=0x%02lx,", (memerr & CRIME_MEM_ERROR_RE_ID)>>8);
+	if (memerr & CRIME_MEM_ERROR_MACE_ACCESS)
+		printk("MACE,MACEID=0x%02lx,", memerr & CRIME_MEM_ERROR_MACE_ID);
 
 	crime_write_64 (CRIME_MEM_ERROR_STAT, 0);
+
+	if (fatal) {
+		printk("FATAL>\n");
+		panic("Fatal memory error detected, halting\n");
+	} else {
+		printk("NONFATAL>\n");
+	}
+
+	return IRQ_HANDLED;
 }
 
-void crime_cpuerr_intr (unsigned int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t crime_cpuerr_intr (unsigned int irq, void *dev_id, struct pt_regs *regs)
 {
 	u64 cpuerr = crime_read_64 (CRIME_CPU_ERROR_STAT);
 	u64 addr = crime_read_64 (CRIME_CPU_ERROR_ADDR);
 	cpuerr &= CRIME_CPU_ERROR_MASK;
 	addr <<= 2UL;
 
-	printk ("CRIME CPU interface error detected at %09lx status %08lx\n",
+	printk ("CRIME CPU error detected at 0x%09lx status 0x%08lx\n",
 		addr, cpuerr);
 
 	crime_write_64 (CRIME_CPU_ERROR_STAT, 0);
+	return IRQ_HANDLED;
 }
Index: include/asm-mips64/ip32/crime.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/ip32/crime.h,v
retrieving revision 1.3
diff -u -r1.3 crime.h
--- include/asm-mips64/ip32/crime.h	27 Jun 2002 14:27:11 -0000	1.3
+++ include/asm-mips64/ip32/crime.h	30 Jun 2003 23:27:12 -0000
@@ -11,6 +11,7 @@
 #ifndef __ASM_CRIME_H__
 #define __ASM_CRIME_H__
 
+#include <asm/types.h>
 #include <asm/addrspace.h>
 
 /*
@@ -179,11 +180,9 @@
  * macros for CRIME memory bank control registers.
  */
 #define CRIME_MEM_BANK_CONTROL(__bank)		(0x00000208 + ((__bank) << 3))
-#define CRIME_MEM_BANK_CONTROL_MSK		0x11f /* 9 bits 7:5 reserved */
+#define CRIME_MEM_BANK_CONTROL_MASK		0x11f /* 9 bits 7:5 reserved */
 #define CRIME_MEM_BANK_CONTROL_ADDR		0x01f
 #define CRIME_MEM_BANK_CONTROL_SDRAM_SIZE	0x100
-#define CRIME_MEM_BANK_CONTROL_BANK_TO_ADDR(__bank) \
-	(((__bank) & CRIME_MEM_BANK_CONTROL_ADDR) << 25)
 
 #define CRIME_MEM_REFRESH_COUNTER	(0x00000248)
 #define CRIME_MEM_REFRESH_COUNTER_MASK	0x7ff	/* 11-bit register */
@@ -206,8 +205,10 @@
 #define CRIME_MEM_ERROR_SOFT_ERR	0x00100000
 #define CRIME_MEM_ERROR_HARD_ERR	0x00200000
 #define CRIME_MEM_ERROR_MULTIPLE	0x00400000
+#define CRIME_MEM_ERROR_ECC		0x01800000
 #define CRIME_MEM_ERROR_MEM_ECC_RD	0x00800000
 #define CRIME_MEM_ERROR_MEM_ECC_RMW	0x01000000
+#define CRIME_MEM_ERROR_INV		0x0e000000
 #define CRIME_MEM_ERROR_INV_MEM_ADDR_RD	0x02000000
 #define CRIME_MEM_ERROR_INV_MEM_ADDR_WR	0x04000000
 #define CRIME_MEM_ERROR_INV_MEM_ADDR_RMW	0x08000000

--aH/0uqREc1VzwMkO--
