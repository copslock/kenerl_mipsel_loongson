Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2003 01:36:44 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:53889
	"HELO alpha.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225209AbTF3Agl>; Mon, 30 Jun 2003 01:36:41 +0100
Received: (qmail 17309 invoked from network); 29 Jun 2003 17:31:08 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with SMTP; 29 Jun 2003 17:31:08 -0000
Received: (qmail 6242 invoked by uid 502); 30 Jun 2003 00:36:36 -0000
Date: Sun, 29 Jun 2003 17:36:36 -0700
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: ip32 specific stuff
Message-ID: <20030630003636.GI13617@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mGCtrYeZ202LI9ZG"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the patch that includes most of things that I have in IP32-specific
parts of my tree.
1. IRQ handling rewrite by me and Vivien.
2. Propper memory detection pathc by Keith.
3. Some other minor fixlets.


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ip32.diff"
Content-Transfer-Encoding: quoted-printable

Index: arch/mips/sgi-ip32/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/Makefile,v
retrieving revision 1.7
diff -u -r1.7 Makefile
--- arch/mips/sgi-ip32/Makefile	13 Jun 2003 13:58:31 -0000	1.7
+++ arch/mips/sgi-ip32/Makefile	30 Jun 2003 00:25:00 -0000
@@ -4,6 +4,6 @@
 #
=20
 obj-y	+=3D ip32-berr.o ip32-rtc.o ip32-setup.o ip32-irq.o ip32-irq-glue.o \
-	   ip32-timer.o crime.o ip32-reset.o
+	   ip32-timer.o crime.o ip32-reset.o ip32-memory.o
=20
 EXTRA_AFLAGS :=3D $(CFLAGS)
Index: arch/mips/sgi-ip32/crime.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/crime.c,v
retrieving revision 1.2
diff -u -r1.2 crime.c
--- arch/mips/sgi-ip32/crime.c	6 Aug 2002 00:08:57 -0000	1.2
+++ arch/mips/sgi-ip32/crime.c	30 Jun 2003 00:25:00 -0000
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
=20
 void __init crime_init (void)
 {
@@ -18,32 +22,75 @@
=20
 	id =3D (id & CRIME_ID_IDBITS) >> 4;
=20
-	printk ("CRIME id %1lx rev %ld detected at %016lx\n", id, rev,
+	printk ("CRIME id %1lx rev %ld detected at 0x%016lx\n", id, rev,
 		(unsigned long) CRIME_BASE);
 }
=20
-/* XXX Like on Sun, these give us various useful information to printk. */
-void crime_memerr_intr (unsigned int irq, void *dev_id, struct pt_regs *re=
gs)
+irqreturn_t crime_memerr_intr (unsigned int irq, void *dev_id, struct pt_r=
egs *regs)
 {
 	u64 memerr =3D crime_read_64 (CRIME_MEM_ERROR_STAT);
 	u64 addr =3D crime_read_64 (CRIME_MEM_ERROR_ADDR);
+	int fatal =3D 0;
+
 	memerr &=3D CRIME_MEM_ERROR_STAT_MASK;
+	addr &=3D CRIME_MEM_ERROR_ADDR_MASK;
+
+	printk("CRIME memory error at 0x%08lx ST 0x%08lx<", addr, memerr);
=20
-	printk ("CRIME memory error at physaddr 0x%08lx status %08lx\n",
-		addr << 2, memerr);
+	if (memerr & CRIME_MEM_ERROR_INV)
+		printk("INV,");
+	if (memerr & CRIME_MEM_ERROR_ECC) {
+		u64 ecc_syn =3D crime_read_64(CRIME_MEM_ERROR_ECC_SYN);
+		u64 ecc_gen =3D crime_read_64(CRIME_MEM_ERROR_ECC_CHK);
+
+		ecc_syn &=3D CRIME_MEM_ERROR_ECC_SYN_MASK;
+		ecc_gen &=3D CRIME_MEM_ERROR_ECC_CHK_MASK;
+
+		printk("ECC,SYN=3D0x%08lx,GEN=3D0x%08lx,", ecc_syn, ecc_gen);
+	}
+	if (memerr & CRIME_MEM_ERROR_MULTIPLE) {
+		fatal =3D 1;
+		printk("MULTIPLE,");
+	}
+	if (memerr & CRIME_MEM_ERROR_HARD_ERR) {
+		fatal =3D 1;
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
+		printk("RE,REID=3D0x%02lx,", (memerr & CRIME_MEM_ERROR_RE_ID)>>8);
+	if (memerr & CRIME_MEM_ERROR_MACE_ACCESS)
+		printk("MACE,MACEID=3D0x%02lx,", memerr & CRIME_MEM_ERROR_MACE_ID);
=20
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
=20
-void crime_cpuerr_intr (unsigned int irq, void *dev_id, struct pt_regs *re=
gs)
+irqreturn_t crime_cpuerr_intr (unsigned int irq, void *dev_id, struct pt_r=
egs *regs)
 {
 	u64 cpuerr =3D crime_read_64 (CRIME_CPU_ERROR_STAT);
 	u64 addr =3D crime_read_64 (CRIME_CPU_ERROR_ADDR);
 	cpuerr &=3D CRIME_CPU_ERROR_MASK;
 	addr <<=3D 2UL;
=20
-	printk ("CRIME CPU interface error detected at %09lx status %08lx\n",
+	printk ("CRIME CPU error detected at 0x%09lx status 0x%08lx\n",
 		addr, cpuerr);
=20
 	crime_write_64 (CRIME_CPU_ERROR_STAT, 0);
+	return IRQ_HANDLED;
 }
Index: arch/mips/sgi-ip32/ip32-berr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-berr.c,v
retrieving revision 1.4
diff -u -r1.4 ip32-berr.c
--- arch/mips/sgi-ip32/ip32-berr.c	14 Apr 2003 16:33:24 -0000	1.4
+++ arch/mips/sgi-ip32/ip32-berr.c	30 Jun 2003 00:25:00 -0000
@@ -9,6 +9,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/sched.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 #include <asm/addrspace.h>
Index: arch/mips/sgi-ip32/ip32-irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-irq.c,v
retrieving revision 1.5
diff -u -r1.5 ip32-irq.c
--- arch/mips/sgi-ip32/ip32-irq.c	16 Apr 2003 13:02:43 -0000	1.5
+++ arch/mips/sgi-ip32/ip32-irq.c	30 Jun 2003 00:25:00 -0000
@@ -28,6 +28,10 @@
 #include <asm/ip32/mace.h>
 #include <asm/signal.h>
=20
+/* issue a PIO read to make sure no PIO writes are pending */
+#define flush_crime_bus() crime_read_64(CRIME_CONTROL);
+#define flush_mace_bus() mace_read_64(MACEISA_FLASH_NIC_REG);
+
 #undef DEBUG_IRQ
 #ifdef DEBUG_IRQ
 #define DBG(x...) printk(x)
@@ -103,9 +107,9 @@
  */
=20
 /* Some initial interrupts to set up */
-extern void crime_memerr_intr (unsigned int irq, void *dev_id,
+extern irqreturn_t crime_memerr_intr (int irq, void *dev_id,
 			       struct pt_regs *regs);
-extern void crime_cpuerr_intr (unsigned int irq, void *dev_id,
+extern irqreturn_t crime_cpuerr_intr (int irq, void *dev_id,
 			       struct pt_regs *regs);
=20
 struct irqaction memerr_irq =3D { crime_memerr_intr, SA_INTERRUPT,
@@ -163,13 +167,13 @@
  * We get to split the register in half and do faster lookups.
  */
=20
+static u64 crime_mask=3D0;
+
 static void enable_crime_irq(unsigned int irq)
 {
-	u64 crime_mask;
 	unsigned long flags;
=20
 	local_irq_save(flags);
-	crime_mask =3D crime_read_64(CRIME_INT_MASK);
 	crime_mask |=3D 1 << (irq - 1);
 	crime_write_64(CRIME_INT_MASK, crime_mask);
 	local_irq_restore(flags);
@@ -177,35 +181,35 @@
=20
 static unsigned int startup_crime_irq(unsigned int irq)
 {
+        crime_mask =3D crime_read_64(CRIME_INT_MASK);
 	enable_crime_irq(irq);
 	return 0; /* This is probably not right; we could have pending irqs */
 }
=20
 static void disable_crime_irq(unsigned int irq)
 {
-	u64 crime_mask;
 	unsigned long flags;
=20
 	local_irq_save(flags);
-	crime_mask =3D crime_read_64(CRIME_INT_MASK);
 	crime_mask &=3D ~(1 << (irq - 1));
 	crime_write_64(CRIME_INT_MASK, crime_mask);
+	flush_crime_bus();
 	local_irq_restore(flags);
 }
=20
 static void mask_and_ack_crime_irq (unsigned int irq)
 {
-	u64 crime_mask;
 	unsigned long flags;
=20
 	/* Edge triggered interrupts must be cleared. */
 	if ((irq >=3D CRIME_GBE0_IRQ && irq <=3D CRIME_GBE3_IRQ)
 	    || (irq >=3D CRIME_RE_EMPTY_E_IRQ && irq <=3D CRIME_RE_IDLE_E_IRQ)
 	    || (irq >=3D CRIME_SOFT0_IRQ && irq <=3D CRIME_SOFT2_IRQ)) {
+	        u64 crime_int;
 		local_irq_save(flags);
-		crime_mask =3D crime_read_64(CRIME_HARD_INT);
-		crime_mask &=3D ~(1 << (irq - 1));
-		crime_write_64(CRIME_HARD_INT, crime_mask);
+		crime_int =3D crime_read_64(CRIME_HARD_INT);
+		crime_int &=3D ~(1 << (irq - 1));
+		crime_write_64(CRIME_HARD_INT, crime_int);
 		local_irq_restore(flags);
 	}
 	disable_crime_irq(irq);
@@ -236,42 +240,39 @@
  * next chunk of the CRIME register in one piece.
  */
=20
+static u32 macepci_mask;
+
 static void enable_macepci_irq(unsigned int irq)
 {
-	u32 mace_mask;
-	u64 crime_mask;
 	unsigned long flags;
=20
 	local_irq_save(flags);
-	mace_mask =3D mace_read_32(MACEPCI_CONTROL);
-	mace_mask |=3D MACEPCI_CONTROL_INT(irq - 9);
-	mace_write_32(MACEPCI_CONTROL, mace_mask);
-	/*
-	 * In case the CRIME interrupt isn't enabled, we must enable it;
-	 * however, we never disable interrupts at that level.
-	 */
-	crime_mask =3D crime_read_64(CRIME_INT_MASK);
-	crime_mask |=3D 1 << (irq - 1);
-	crime_write_64(CRIME_INT_MASK, crime_mask);
+	macepci_mask |=3D MACEPCI_CONTROL_INT(irq - 9);
+	mace_write_32(MACEPCI_CONTROL, macepci_mask);
+        crime_mask |=3D 1 << (irq - 1);
+        crime_write_64(CRIME_INT_MASK, crime_mask);
 	local_irq_restore(flags);
 }
=20
 static unsigned int startup_macepci_irq(unsigned int irq)
 {
-	enable_macepci_irq (irq);
-
-	return 0; /* XXX */
+	crime_mask =3D crime_read_64 (CRIME_INT_MASK);
+	macepci_mask =3D mace_read_32(MACEPCI_CONTROL);
+  	enable_macepci_irq (irq);
+	return 0;
 }
=20
 static void disable_macepci_irq(unsigned int irq)
 {
-	u32 mace_mask;
 	unsigned long flags;
=20
 	local_irq_save(flags);
-	mace_mask =3D mace_read_32(MACEPCI_CONTROL);
-	mace_mask &=3D ~MACEPCI_CONTROL_INT(irq - 9);
-	mace_write_32(MACEPCI_CONTROL, mace_mask);
+	crime_mask &=3D ~(1 << (irq - 1));
+	crime_write_64(CRIME_INT_MASK, crime_mask);
+	flush_crime_bus();
+	macepci_mask &=3D ~MACEPCI_CONTROL_INT(irq - 9);
+	mace_write_32(MACEPCI_CONTROL, macepci_mask);
+	flush_mace_bus();
 	local_irq_restore(flags);
 }
=20
@@ -299,10 +300,10 @@
  * CRIME register.
  */
=20
+u32 maceisa_mask =3D 0;
+
 static void enable_maceisa_irq (unsigned int irq)
 {
-	u64 crime_mask;
-	u32 mace_mask;
 	unsigned int crime_int =3D 0;
 	unsigned long flags;
=20
@@ -321,46 +322,56 @@
 	}
 	DBG ("crime_int %016lx enabled\n", crime_int);
 	local_irq_save(flags);
-	crime_mask =3D crime_read_64(CRIME_INT_MASK);
 	crime_mask |=3D crime_int;
 	crime_write_64(CRIME_INT_MASK, crime_mask);
-	mace_mask =3D mace_read_32(MACEISA_INT_MASK);
-	mace_mask |=3D 1 << (irq - 33);
-	mace_write_32(MACEISA_INT_MASK, mace_mask);
+	maceisa_mask |=3D 1 << (irq - 33);
+	mace_write_32(MACEISA_INT_MASK, maceisa_mask);
 	local_irq_restore(flags);
 }
=20
 static unsigned int startup_maceisa_irq (unsigned int irq)
 {
+	crime_mask =3D crime_read_64 (CRIME_INT_MASK);
+	maceisa_mask =3D mace_read_32(MACEISA_INT_MASK);
 	enable_maceisa_irq(irq);
 	return 0;
 }
=20
 static void disable_maceisa_irq(unsigned int irq)
 {
-	u32 mace_mask;
+	unsigned int crime_int =3D 0;
 	unsigned long flags;
=20
 	local_irq_save(flags);
-	mace_mask =3D mace_read_32(MACEISA_INT_MASK);
-	mace_mask &=3D ~(1 << (irq - 33));
-	mace_write_32(MACEISA_INT_MASK, mace_mask);
+	maceisa_mask &=3D ~(1 << (irq - 33));
+        if(!(maceisa_mask & MACEISA_AUDIO_INT))
+		crime_int |=3D MACE_AUDIO_INT;
+        if(!(maceisa_mask & MACEISA_MISC_INT))
+		crime_int |=3D MACE_MISC_INT;
+        if(!(maceisa_mask & MACEISA_SUPERIO_INT))
+		crime_int |=3D MACE_SUPERIO_INT;
+	crime_mask &=3D ~crime_int;
+	crime_write_64(CRIME_INT_MASK, crime_mask);
+	flush_crime_bus();
+	mace_write_32(MACEISA_INT_MASK, maceisa_mask);
+	flush_mace_bus();
 	local_irq_restore(flags);
 }
=20
 static void mask_and_ack_maceisa_irq(unsigned int irq)
 {
-	u32 mace_mask;
+	u32 mace_int;
 	unsigned long flags;
=20
 	switch (irq) {
 	case MACEISA_PARALLEL_IRQ:
 	case MACEISA_SERIAL1_TDMAPR_IRQ:
 	case MACEISA_SERIAL2_TDMAPR_IRQ:
+		/* edge triggered */
 		local_irq_save(flags);
-		mace_mask =3D mace_read_32(MACEISA_INT_STAT);
-		mace_mask &=3D ~(1 << (irq - 33));
-		mace_write_32(MACEISA_INT_STAT, mace_mask);
+		mace_int =3D mace_read_32(MACEISA_INT_STAT);
+		mace_int &=3D ~(1 << (irq - 33));
+		mace_write_32(MACEISA_INT_STAT, mace_int);
 		local_irq_restore(flags);
 		break;
 	}
@@ -392,11 +403,9 @@
=20
 static void enable_mace_irq(unsigned int irq)
 {
-	u64 crime_mask;
 	unsigned long flags;
=20
 	local_irq_save(flags);
-	crime_mask =3D crime_read_64 (CRIME_INT_MASK);
 	crime_mask |=3D 1 << (irq - 1);
 	crime_write_64 (CRIME_INT_MASK, crime_mask);
 	local_irq_restore (flags);
@@ -404,19 +413,19 @@
=20
 static unsigned int startup_mace_irq(unsigned int irq)
 {
+        crime_mask =3D crime_read_64 (CRIME_INT_MASK);
 	enable_mace_irq(irq);
 	return 0;
 }
=20
 static void disable_mace_irq(unsigned int irq)
 {
-	u64 crime_mask;
 	unsigned long flags;
=20
 	local_irq_save(flags);
-	crime_mask =3D crime_read_64 (CRIME_INT_MASK);
 	crime_mask &=3D ~(1 << (irq - 1));
 	crime_write_64 (CRIME_INT_MASK, crime_mask);
+	flush_crime_bus();
 	local_irq_restore(flags);
 }
=20
@@ -446,9 +455,12 @@
 	u32 mace;
=20
 	printk ("Unknown interrupt occurred!\n");
-	printk ("cp0_status: %08x\tcp0_cause: %08x\n",
-		read_c0_status(),
-		read_c0_cause());
+	printk ("cp0_status: %08x\n",
+		read_c0_status ());
+	printk ("cp0_cause: %08x\n",
+		read_c0_cause ());
+//	printk ("badvaddr: %08x\n",
+//		read_32bit_cp0_register (CP0_BADVADDR));
 	crime =3D crime_read_64 (CRIME_INT_MASK);
 	printk ("CRIME interrupt mask: %016lx\n", crime);
 	crime =3D crime_read_64 (CRIME_INT_STAT);
@@ -465,7 +477,7 @@
 	printk("Register dump:\n");
 	show_regs(regs);
=20
-	printk("Please mail this report to linux-mips@oss.sgi.com\n");
+	printk("Please mail this report to linux-mips@linux-mips.org\n");
 	printk("Spinning...");
 	while(1) ;
 }
@@ -474,43 +486,18 @@
 void ip32_irq0(struct pt_regs *regs)
 {
 	u64 crime_int;
-	u64 crime_mask;
 	int irq =3D 0;
-	unsigned long flags;
=20
-	local_irq_save(flags);
-	/* disable crime interrupts */
-	crime_mask =3D crime_read_64(CRIME_INT_MASK);
-	crime_write_64(CRIME_INT_MASK, 0);
-
-	crime_int =3D crime_read_64(CRIME_INT_STAT);
-
-	if (crime_int & CRIME_MACE_INT_MASK) {
-		crime_int &=3D CRIME_MACE_INT_MASK;
-		irq =3D ffs (crime_int);
-	} else if (crime_int & CRIME_MACEISA_INT_MASK) {
-		u32 mace_int;
-		mace_int =3D mace_read_32 (MACEISA_INT_STAT);
-		if (mace_int =3D=3D 0)
-			irq =3D 0;
-		else
-			irq =3D ffs (mace_int) + 32;
-	} else if (crime_int & CRIME_MACEPCI_INT_MASK) {
-		crime_int &=3D CRIME_MACEPCI_INT_MASK;
-		crime_int >>=3D 8;
-		irq =3D ffs (crime_int) + 8;
-	} else if (crime_int & 0xffff0000) {
-		crime_int >>=3D 16;
-		irq =3D ffs (crime_int) + 16;
+	crime_int =3D crime_read_64(CRIME_INT_STAT) & crime_mask;
+        irq =3D ffs(crime_int);
+        crime_int =3D 1ULL << (irq - 1);
+
+	if (crime_int & CRIME_MACEISA_INT_MASK) {
+		u32 mace_int =3D mace_read_32 (MACEISA_INT_STAT) & maceisa_mask;
+                irq =3D ffs (mace_int) + 32;
 	}
-	if (irq =3D=3D 0)
-		ip32_unknown_interrupt(regs);
 	DBG("*irq %u*\n", irq);
 	do_IRQ(irq, regs);
-
-	/* enable crime interrupts */
-	crime_write_64(CRIME_INT_MASK, crime_mask);
-	local_irq_restore (flags);
 }
=20
 void ip32_irq1(struct pt_regs *regs)
Index: arch/mips/sgi-ip32/ip32-setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-setup.c,v
retrieving revision 1.4
diff -u -r1.4 ip32-setup.c
--- arch/mips/sgi-ip32/ip32-setup.c	14 Apr 2003 16:33:24 -0000	1.4
+++ arch/mips/sgi-ip32/ip32-setup.c	30 Jun 2003 00:25:00 -0000
@@ -13,6 +13,8 @@
 #include <linux/mc146818rtc.h>
 #include <linux/param.h>
 #include <linux/init.h>
+#include <linux/console.h>
+#include <linux/bootmem.h>
=20
 #include <asm/time.h>
 #include <asm/mipsregs.h>
@@ -28,7 +30,6 @@
 extern u32 cc_interval;
=20
 #ifdef CONFIG_SGI_O2MACE_ETH
-
 /*
  * This is taken care of in here 'cause they say using Arc later on is
  * problematic
@@ -59,19 +60,41 @@
 }
 #endif
=20
+#ifdef CONFIG_FB_SGIO2
+#include "../../../drivers/video/sgio2fb.h"
+void *sgio2fb_mem;
+#endif
+
+void __init ip32_devsetup(void)
+{
+#ifdef CONFIG_FB_SGIO2
+	sgio2fb_mem=3D__alloc_bootmem(TILE_PTR_SIZE<<TILE_SHIFT, TILE_SIZE,__pa(M=
AX_DMA_ADDRESS));
+#endif
+#ifdef CONFIG_SGI_O2MACE_ETH
+	{
+		char *mac=3DArcGetEnvironmentVariable("eaddr");
+		str2eaddr(o2meth_eaddr, mac);
+	}
+#endif
+}
+
 extern void ip32_time_init(void);
-extern void ip32_reboot_setup(void);
+extern void ip32_be_init(void);
=20
 void __init ip32_setup(void)
 {
-#ifdef CONFIG_SERIAL_CONSOLE
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_MACE_SGIO2)
 	char *ctype;
 #endif
 	TLBMISS_HANDLER_SETUP ();
=20
 	mips_io_port_base =3D UNCACHEDADDR(MACEPCI_HI_IO);;
=20
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_MACE_SGIO2
+#warning O2MACECONSOLE compiled in
+	o2serial_console_init();
+#endif
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SERIAL_MACE_SGIO2)
 	ctype =3D ArcGetEnvironmentVariable("console");
 	if (*ctype =3D=3D 'd') {
 		if (ctype[1] =3D=3D '2')
@@ -80,26 +103,16 @@
 			console_setup ("ttyS0");
 	}
 #endif
-#ifdef CONFIG_SGI_O2MACE_ETH
-	{
-		char *mac=3DArcGetEnvironmentVariable("eaddr");
-		str2eaddr(o2meth_eaddr, mac);
-	}
-#endif
-
+	ip32_devsetup();
 #ifdef CONFIG_VT
+# ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp =3D &dummy_con;
+# endif
 #endif
-
 	rtc_ops =3D &ip32_rtc_ops;
 	board_be_init =3D ip32_be_init;
 	board_time_init =3D ip32_time_init;
+	board_timer_setup =3D NULL;
=20
 	crime_init ();
-}
-
-int __init page_is_ram (unsigned long pagenr)
-{
-	/* XXX: to do? */
-	return 1;
 }
Index: include/asm-mips64/ip32/crime.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/include/asm-mips64/ip32/crime.h,v
retrieving revision 1.3
diff -u -r1.3 crime.h
--- include/asm-mips64/ip32/crime.h	27 Jun 2002 14:27:11 -0000	1.3
+++ include/asm-mips64/ip32/crime.h	30 Jun 2003 00:25:06 -0000
@@ -11,7 +11,9 @@
 #ifndef __ASM_CRIME_H__
 #define __ASM_CRIME_H__
=20
+#include <asm/types.h>
 #include <asm/addrspace.h>
+#include <asm/io64.h>
=20
 /*
  * Address map
@@ -23,12 +25,8 @@
 #endif
=20
 #ifndef __ASSEMBLY__
-static inline u64 crime_read_64 (unsigned long __offset) {
-        return *((volatile u64 *) (CRIME_BASE + __offset));
-}
-static inline void crime_write_64 (unsigned long __offset, u64 __val) {
-        *((volatile u64 *) (CRIME_BASE + __offset)) =3D __val;
-}
+#define crime_read_64(__offset)		__in64(CRIME_BASE+(__offset))
+#define crime_write_64(__offset,__val)	__out64(__val,CRIME_BASE+(__offset))
 #endif
=20
 #undef BIT
@@ -179,11 +177,9 @@
  * macros for CRIME memory bank control registers.
  */
 #define CRIME_MEM_BANK_CONTROL(__bank)		(0x00000208 + ((__bank) << 3))
-#define CRIME_MEM_BANK_CONTROL_MSK		0x11f /* 9 bits 7:5 reserved */
+#define CRIME_MEM_BANK_CONTROL_MASK		0x11f /* 9 bits 7:5 reserved */
 #define CRIME_MEM_BANK_CONTROL_ADDR		0x01f
 #define CRIME_MEM_BANK_CONTROL_SDRAM_SIZE	0x100
-#define CRIME_MEM_BANK_CONTROL_BANK_TO_ADDR(__bank) \
-	(((__bank) & CRIME_MEM_BANK_CONTROL_ADDR) << 25)
=20
 #define CRIME_MEM_REFRESH_COUNTER	(0x00000248)
 #define CRIME_MEM_REFRESH_COUNTER_MASK	0x7ff	/* 11-bit register */
@@ -206,8 +202,10 @@
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
Index: include/asm-mips64/ip32/mace.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/include/asm-mips64/ip32/mace.h,v
retrieving revision 1.6
diff -u -r1.6 mace.h
--- include/asm-mips64/ip32/mace.h	7 Apr 2003 02:28:45 -0000	1.6
+++ include/asm-mips64/ip32/mace.h	30 Jun 2003 00:25:06 -0000
@@ -12,7 +12,8 @@
 #define __ASM_MACE_H__
=20
 #include <asm/addrspace.h>
-
+#include <asm/system.h>
+#include <asm/io64.h>
 /*
  * Address map
  */
@@ -50,8 +51,7 @@
 #define MACEPCI_SWAPPED_VIEW		0
 #define MACEPCI_NATIVE_VIEW		0x40000000
 #define MACEPCI_IO			0x80000000
-/*#define MACEPCI_HI_MEMORY		0x0000000280000000UL * This mipght be just 0x=
0000000200000000UL 2G more :) (or maybe it is different between 1.1 & 1.5 */
-#define MACEPCI_HI_MEMORY		0x0000000200000000UL /* This mipght be just 0x0=
000000200000000UL 2G more :) (or maybe it is different between 1.1 & 1.5 */
+#define MACEPCI_HI_MEMORY		0x0000000200000000UL
 #define MACEPCI_HI_IO			0x0000000100000000UL
=20
 /*
@@ -130,7 +130,9 @@
 #define MACEISA_EPP_BASE   	(MACE_ISA_EXT		  )
 #define MACEISA_ECP_BASE   	(MACE_ISA_EXT + 0x00008000)
 #define MACEISA_SER1_BASE	(MACE_ISA_EXT + 0x00010000)
+#define MACEISA_SER1_REGS       (MACE_ISA_BASE + 0x00020000)
 #define MACEISA_SER2_BASE	(MACE_ISA_EXT + 0x00018000)
+#define MACEISA_SER2_REGS       (MACE_ISA_BASE + 0x00030000)
 #define MACEISA_RTC_BASE	(MACE_ISA_EXT + 0x00020000)
 #define MACEISA_GAME_BASE	(MACE_ISA_EXT + 0x00030000)
=20
@@ -138,6 +140,8 @@
  * Ringbase address and reset register - 64 bits
  */
 #define MACEISA_RINGBASE	MACE_ISA_BASE
+/* Ring buffers occupy 8 4K buffers */
+#define MACEISA_RINGBUFFERS_SIZE 8*4*1024
=20
 /*
  * Flash-ROM/LED/DP-RAM/NIC Controller Register - 64 bits (?)
@@ -197,6 +201,61 @@
 #define MACEISA_SERIAL2_RDMAT_INT	BIT (30)
 #define MACEISA_SERIAL2_RDMAOR_INT	BIT (31)
=20
+#define MACEI2C_CONFIG	MACE_I2C_BASE
+#define MACEI2C_CONTROL	(MACE_I2C_BASE|0x10)
+#define MACEI2C_DATA	(MACE_I2C_BASE|0x18)
+
+/* Bits for I2C_CONFIG */
+#define MACEI2C_RESET           BIT(0)
+#define MACEI2C_FAST            BIT(1)
+#define MACEI2C_DATA_OVERRIDE   BIT(2)
+#define MACEI2C_CLOCK_OVERRIDE  BIT(3)
+#define MACEI2C_DATA_STATUS     BIT(4)
+#define MACEI2C_CLOCK_STATUS    BIT(5)
+
+/* Bits for I2C_CONTROL */
+#define MACEI2C_NOT_IDLE        BIT(0)	/* write: 0=3Dforce idle
+				         * read: 0=3Didle 1=3Dnot idle */
+#define MACEI2C_DIR		BIT(1)	/* 0=3Dwrite 1=3Dread */
+#define MACEI2C_MORE_BYTES	BIT(2)	/* 0=3Dlast byte 1=3Dmore bytes */
+#define MACEI2C_TRANS_BUSY	BIT(4)	/* 0=3Dtrans done 1=3Dtrans busy */
+#define MACEI2C_NACK	        BIT(5)	/* 0=3Dack received 1=3Dack not */
+#define MACEI2C_BUS_ERROR	BIT(7)	/* 0=3Dno bus err 1=3Dbus err */
+
+
+#define MACEISA_AUDIO_INT (MACEISA_AUDIO_SW_INT |               \
+                           MACEISA_AUDIO_SC_INT |               \
+                           MACEISA_AUDIO1_DMAT_INT |            \
+                           MACEISA_AUDIO1_OF_INT |              \
+                           MACEISA_AUDIO2_DMAT_INT |            \
+                           MACEISA_AUDIO2_MERR_INT |            \
+                           MACEISA_AUDIO3_DMAT_INT |            \
+                           MACEISA_AUDIO3_MERR_INT)
+#define MACEISA_MISC_INT (MACEISA_RTC_INT |                     \
+                          MACEISA_KEYB_INT |                    \
+                          MACEISA_KEYB_POLL_INT |               \
+                          MACEISA_MOUSE_INT |                   \
+                          MACEISA_MOUSE_POLL_INT |              \
+                          MACEISA_TIMER0_INT |                  \
+                          MACEISA_TIMER1_INT |                  \
+                          MACEISA_TIMER2_INT)
+#define MACEISA_SUPERIO_INT (MACEISA_PARALLEL_INT |             \
+                             MACEISA_PAR_CTXA_INT |             \
+                             MACEISA_PAR_CTXB_INT |             \
+                             MACEISA_PAR_MERR_INT |             \
+                             MACEISA_SERIAL1_INT |              \
+                             MACEISA_SERIAL1_TDMAT_INT |        \
+                             MACEISA_SERIAL1_TDMAPR_INT |       \
+                             MACEISA_SERIAL1_TDMAME_INT |       \
+                             MACEISA_SERIAL1_RDMAT_INT |        \
+                             MACEISA_SERIAL1_RDMAOR_INT |       \
+                             MACEISA_SERIAL2_INT |              \
+                             MACEISA_SERIAL2_TDMAT_INT |        \
+                             MACEISA_SERIAL2_TDMAPR_INT |       \
+                             MACEISA_SERIAL2_TDMAME_INT |       \
+                             MACEISA_SERIAL2_RDMAT_INT |        \
+                             MACEISA_SERIAL2_RDMAOR_INT)
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
=20
@@ -220,7 +279,7 @@
=20
 static inline u64 mace_read_64 (unsigned long __offset)
 {
-	return *((volatile u64 *) (MACE_BASE + __offset));
+	return __in64 (MACE_BASE + __offset);
 }
=20
 static inline void mace_write_8 (unsigned long __offset, u8 __val)
@@ -240,7 +299,7 @@
=20
 static inline void mace_write_64 (unsigned long __offset, u64 __val)
 {
-	*((volatile u64 *) (MACE_BASE + __offset)) =3D __val;
+	__out64 (__val, MACE_BASE + __offset);
 }
=20
 /* Call it whenever device needs to read data from main memory coherently =
*/
@@ -248,6 +307,17 @@
 {
 /*	mace_write_32(MACEPCI_WFLUSH,0xffffffff);*/
 }
+
+/* MACE ISA ring buffers access */
+void maceisa_init(void);
+void* maceisa_audio_input_ring(void);
+/* num - audio channel number: 0 or 1 */
+void* maceisa_audio_output_ring(int num);
+void* maceisa_scratch_ring(void);
+/* num - number of serial port: 0 or 1 */
+void* maceisa_serial_tx_ring(int num);
+void* maceisa_serial_rx_ring(int num);
+
 #endif /* !__ASSEMBLY__ */
=20
=20
--- /dev/null	Sun Jul 17 16:46:18 1994
+++ include/asm-mips64/io64.h	Sun Jun 15 10:35:18 2003
@@ -0,0 +1,99 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000, 2001 Broadcom Corporation
+ * Copyright (C) 2002 Ralf Baechle
+ * Copyright (C) 2003 Keith M Wesolowski
+ */
+
+#ifndef __ASM_IO64_H
+#define __ASM_IO64_H
+
+#include <linux/types.h>
+
+/* Generic 64-bit I/O register reads and writes.  This does no byte-swappi=
ng
+ * as it makes little sense and no platform that needs this is insane enou=
gh
+ * to require it.
+ */
+
+#ifndef __ASSEMBLY__
+#if _MIPS_SZLONG >=3D 64
+static inline u64 __in64(unsigned long addr)
+{
+	return *(volatile u64 *)addr;
+}
+
+static inline void __out64(u64 val, unsigned long addr)
+{
+	*(volatile u64 *)addr =3D val;
+}
+
+#define in64(a)		__in64(a)
+#define out64(v,a)	__out64(v,a)
+
+#else /* _MIPS_SZLONG < 64 */
+
+#include <asm/system.h>
+
+static inline u64 __in64(unsigned long addr)
+{
+	u64 res;
+
+	asm volatile (
+		"	.set	mips3				\n"
+		"	ld	%L0, (%1)	# __in64	\n"
+		"	dsra	%M0, %L0, 32			\n"
+		"	sll	%L0, 0				\n"
+		"	.set	mips0				\n"
+		: "=3Dr" (res)
+		: "r" (addr)
+	);
+
+	return res;
+}
+
+static inline u64 in64(unsigned long addr)
+{
+	unsigned long flags;
+	u64 res;
+
+	local_irq_save(flags);
+	res =3D __in64(addr);
+	local_irq_restore(flags);
+
+	return res;
+}
+
+static inline void __out64(u64 val, unsigned long addr)
+{
+	u64 tmp;
+
+	asm volatile (
+		"	.set	mips3				\n"
+		"	dsll	%L0, 32		# __out64	\n"
+		"	dsll	%M0, 32				\n"
+		"	dsrl	%L0, 32				\n"
+		"	or	%L0, %M0			\n"
+		"	sd	%L0, (%2)			\n"
+		"	.set	mips0				\n"
+		: "=3D&r" (tmp)
+		: "0" (val), "r" (addr)
+		: "memory"
+	);
+}
+
+static inline void out64(u64 val, unsigned long addr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__out64(val, addr);
+	local_irq_restore(flags);
+}
+#endif /* _MIPS_SZLONG */
+#endif /* !__ASSEMBLY__ */
+
+
+#endif /* __ASM_IO64_H */
--- /dev/null	Sun Jul 17 16:46:18 1994
+++ include/asm-mips/io64.h	Sun Jun 15 10:35:18 2003
@@ -0,0 +1,99 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000, 2001 Broadcom Corporation
+ * Copyright (C) 2002 Ralf Baechle
+ * Copyright (C) 2003 Keith M Wesolowski
+ */
+
+#ifndef __ASM_IO64_H
+#define __ASM_IO64_H
+
+#include <linux/types.h>
+
+/* Generic 64-bit I/O register reads and writes.  This does no byte-swappi=
ng
+ * as it makes little sense and no platform that needs this is insane enou=
gh
+ * to require it.
+ */
+
+#ifndef __ASSEMBLY__
+#if _MIPS_SZLONG >=3D 64
+static inline u64 __in64(unsigned long addr)
+{
+	return *(volatile u64 *)addr;
+}
+
+static inline void __out64(u64 val, unsigned long addr)
+{
+	*(volatile u64 *)addr =3D val;
+}
+
+#define in64(a)		__in64(a)
+#define out64(v,a)	__out64(v,a)
+
+#else /* _MIPS_SZLONG < 64 */
+
+#include <asm/system.h>
+
+static inline u64 __in64(unsigned long addr)
+{
+	u64 res;
+
+	asm volatile (
+		"	.set	mips3				\n"
+		"	ld	%L0, (%1)	# __in64	\n"
+		"	dsra	%M0, %L0, 32			\n"
+		"	sll	%L0, 0				\n"
+		"	.set	mips0				\n"
+		: "=3Dr" (res)
+		: "r" (addr)
+	);
+
+	return res;
+}
+
+static inline u64 in64(unsigned long addr)
+{
+	unsigned long flags;
+	u64 res;
+
+	local_irq_save(flags);
+	res =3D __in64(addr);
+	local_irq_restore(flags);
+
+	return res;
+}
+
+static inline void __out64(u64 val, unsigned long addr)
+{
+	u64 tmp;
+
+	asm volatile (
+		"	.set	mips3				\n"
+		"	dsll	%L0, 32		# __out64	\n"
+		"	dsll	%M0, 32				\n"
+		"	dsrl	%L0, 32				\n"
+		"	or	%L0, %M0			\n"
+		"	sd	%L0, (%2)			\n"
+		"	.set	mips0				\n"
+		: "=3D&r" (tmp)
+		: "0" (val), "r" (addr)
+		: "memory"
+	);
+}
+
+static inline void out64(u64 val, unsigned long addr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__out64(val, addr);
+	local_irq_restore(flags);
+}
+#endif /* _MIPS_SZLONG */
+#endif /* !__ASSEMBLY__ */
+
+
+#endif /* __ASM_IO64_H */
--- /dev/null	Sun Jul 17 16:46:18 1994
+++ arch/mips/sgi-ip32/ip32-memory.c	Sun Jun  1 18:55:04 2003
@@ -0,0 +1,37 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Keith M Wesolowski
+ */
+#include <asm/ip32/crime.h>
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+void __init prom_meminit (void)
+{
+	u64 base, size;
+	int bank;
+
+	for (bank=3D0; bank < CRIME_MAXBANKS; bank++) {
+		u64 bankctl =3D crime_read_64(CRIME_MEM_BANK_CONTROL(bank));
+		base =3D (bankctl & CRIME_MEM_BANK_CONTROL_ADDR) << 25;
+		if (bank !=3D 0 && base =3D=3D 0)
+			continue;
+		size =3D (bankctl & CRIME_MEM_BANK_CONTROL_SDRAM_SIZE) ? 128 : 32;
+		printk("CRIME MC: bank %d base 0x%016lx size %luMB\n",
+			bank, base, size);
+		size <<=3D 20;
+		if (base + size > (256 << 20))
+			continue;
+		add_memory_region (base, size, BOOT_MEM_RAM);
+	}
+}
+
+void __init prom_free_prom_memory (void) { }

--mGCtrYeZ202LI9ZG--
