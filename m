Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2004 16:15:43 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:56767 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225343AbUBJQPm>; Tue, 10 Feb 2004 16:15:42 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id DEE8C4C3D6; Tue, 10 Feb 2004 17:15:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id CB2024C175; Tue, 10 Feb 2004 17:15:39 +0100 (CET)
Date: Tue, 10 Feb 2004 17:15:39 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] dump_tlb.c clean-ups
Message-ID: <Pine.LNX.4.55.0402101653290.6769@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 Gcc 3.4 complains about a possibly undefined operation in dump16() in 
arch/mips/lib/r3k_dump_tlb.c.  The following patch fixes it.  I've taken 
the opportunity to clean up the file and its counterparts thus:

1. I've cast the pointers to "unsigned long" consistently for output
formatting as the width specifier doesn't work very well with pointers.

2. I've renamed msg2str() to msk2str() in one of the variations.

3. I've reordered header inclusions in one of the variations.

4. I've fixed indentation throughout, perhaps not completely, but still 
the result should be somewhat closer to sanity.

These changes make the three variations closer to one another where 
possible.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-dump_tlb-0
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/dump_tlb.c linux-mips-2.4.24-pre2-20040116/arch/mips/lib/dump_tlb.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/dump_tlb.c	2003-04-24 02:56:38.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/lib/dump_tlb.c	2004-02-09 22:13:24.000000000 +0000
@@ -11,13 +11,13 @@
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
-#include <asm/cpu.h>
 #include <asm/cachectl.h>
+#include <asm/cpu.h>
 #include <asm/mipsregs.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
-static inline const char *msg2str(unsigned int mask)
+static inline const char *msk2str(unsigned int mask)
 {
 	switch (mask) {
 	case PM_4K:	return "4kb";
@@ -44,7 +44,7 @@ void dump_tlb(int first, int last)
 	asid = read_c0_entryhi() & 0xff;
 
 	printk("\n");
-	for(i=first;i<=last;i++) {
+	for (i = first; i <= last; i++) {
 		write_c0_index(i);
 		__asm__ __volatile__(
 			".set\tmips3\n\t"
@@ -65,7 +65,7 @@ void dump_tlb(int first, int last)
 			/*
 			 * Only print entries in use
 			 */
-			printk("Index: %2d pgmask=%s ", i, msg2str(pagemask));
+			printk("Index: %2d pgmask=%s ", i, msk2str(pagemask));
 
 			c0 = (entrylo0 >> 3) & 7;
 			c1 = (entrylo1 >> 3) & 7;
@@ -109,8 +109,7 @@ void dump_tlb_wired(void)
 		"nop;nop;nop;nop;nop;nop;nop\n\t"	\
 		".set\treorder");
 
-void
-dump_tlb_addr(unsigned long addr)
+void dump_tlb_addr(unsigned long addr)
 {
 	unsigned long flags, oldpid;
 	int index;
@@ -135,14 +134,12 @@ dump_tlb_addr(unsigned long addr)
 	dump_tlb(index, index);
 }
 
-void
-dump_tlb_nonwired(void)
+void dump_tlb_nonwired(void)
 {
 	dump_tlb(read_c0_wired(), current_cpu_data.tlbsize - 1);
 }
 
-void
-dump_list_process(struct task_struct *t, void *address)
+void dump_list_process(struct task_struct *t, void *address)
 {
 	pgd_t	*page_dir, *pgd;
 	pmd_t	*pmd;
@@ -194,14 +191,12 @@ dump_list_process(struct task_struct *t,
 	printk("\n");
 }
 
-void
-dump_list_current(void *address)
+void dump_list_current(void *address)
 {
 	dump_list_process(current, address);
 }
 
-unsigned int
-vtop(void *address)
+unsigned int vtop(void *address)
 {
 	pgd_t	*pgd;
 	pmd_t	*pmd;
@@ -218,14 +213,14 @@ vtop(void *address)
 	return paddr;
 }
 
-void
-dump16(unsigned long *p)
+void dump16(unsigned long *p)
 {
 	int i;
 
-	for(i=0;i<8;i++)
-	{
-		printk("*%8p = %08lx, ", p, *p); p++;
-		printk("*%8p = %08lx\n", p, *p); p++;
+	for (i = 0; i < 8; i++) {
+		printk("*%08lx == %08lx, ", (unsigned long)p, *p);
+		p++;
+		printk("*%08lx == %08lx\n", (unsigned long)p, *p);
+		p++;
 	}
 }
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/r3k_dump_tlb.c linux-mips-2.4.24-pre2-20040116/arch/mips/lib/r3k_dump_tlb.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/lib/r3k_dump_tlb.c	2003-04-07 02:56:28.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/lib/r3k_dump_tlb.c	2004-02-09 22:13:36.000000000 +0000
@@ -19,8 +19,7 @@
 
 extern int r3k_have_wired_reg;	/* defined in tlb-r3k.c */
 
-void
-dump_tlb(int first, int last)
+void dump_tlb(int first, int last)
 {
 	int	i;
 	unsigned int asid;
@@ -28,8 +27,7 @@ dump_tlb(int first, int last)
 
 	asid = read_c0_entryhi() & 0xfc0;
 
-	for(i=first;i<=last;i++)
-	{
+	for (i = first; i <= last; i++) {
 		write_c0_index(i<<8);
 		__asm__ __volatile__(
 			".set\tnoreorder\n\t"
@@ -63,14 +61,12 @@ dump_tlb(int first, int last)
 	write_c0_entryhi(asid);
 }
 
-void
-dump_tlb_all(void)
+void dump_tlb_all(void)
 {
 	dump_tlb(0, current_cpu_data.tlbsize - 1);
 }
 
-void
-dump_tlb_wired(void)
+void dump_tlb_wired(void)
 {
 	int wired = r3k_have_wired_reg ? read_c0_wired() : 8;
 
@@ -78,8 +74,7 @@ dump_tlb_wired(void)
 	dump_tlb(0, wired - 1);
 }
 
-void
-dump_tlb_addr(unsigned long addr)
+void dump_tlb_addr(unsigned long addr)
 {
 	unsigned long flags, oldpid;
 	int index;
@@ -101,15 +96,13 @@ dump_tlb_addr(unsigned long addr)
 	dump_tlb(index, index);
 }
 
-void
-dump_tlb_nonwired(void)
+void dump_tlb_nonwired(void)
 {
 	int wired = r3k_have_wired_reg ? read_c0_wired() : 8;
 	dump_tlb(wired, current_cpu_data.tlbsize - 1);
 }
 
-void
-dump_list_process(struct task_struct *t, void *address)
+void dump_list_process(struct task_struct *t, void *address)
 {
 	pgd_t	*page_dir, *pgd;
 	pmd_t	*pmd;
@@ -148,14 +141,12 @@ dump_list_process(struct task_struct *t,
 	printk("\n");
 }
 
-void
-dump_list_current(void *address)
+void dump_list_current(void *address)
 {
 	dump_list_process(current, address);
 }
 
-unsigned int
-vtop(void *address)
+unsigned int vtop(void *address)
 {
 	pgd_t	*pgd;
 	pmd_t	*pmd;
@@ -172,16 +163,14 @@ vtop(void *address)
 	return paddr;
 }
 
-void
-dump16(unsigned long *p)
+void dump16(unsigned long *p)
 {
 	int i;
 
-	for(i=0;i<8;i++)
-	{
-		printk("*%08lx == %08lx, ",
-		       (unsigned long)p, (unsigned long)*p++);
-		printk("*%08lx == %08lx\n",
-		       (unsigned long)p, (unsigned long)*p++);
+	for (i = 0; i < 8; i++) {
+		printk("*%08lx == %08lx, ", (unsigned long)p, *p);
+		p++;
+		printk("*%08lx == %08lx\n", (unsigned long)p, *p);
+		p++;
 	}
 }
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/dump_tlb.c linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/dump_tlb.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/lib/dump_tlb.c	2003-04-07 02:56:31.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/lib/dump_tlb.c	2004-02-09 22:12:48.000000000 +0000
@@ -201,12 +201,10 @@ void dump16(unsigned long *p)
 {
 	int i;
 
-	for(i = 0; i < 8; i++) {
-		printk("*%08lx == %08lx, ",
-		       (unsigned long)p, (unsigned long)*p);
+	for (i = 0; i < 8; i++) {
+		printk("*%08lx == %08lx, ", (unsigned long)p, *p);
 		p++;
-		printk("*%08lx == %08lx\n",
-		       (unsigned long)p, (unsigned long)*p);
+		printk("*%08lx == %08lx\n", (unsigned long)p, *p);
 		p++;
 	}
 }
