Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA57048 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Oct 1998 19:54:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA99612
	for linux-list;
	Thu, 15 Oct 1998 19:54:26 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA42205
	for <linux@engr.sgi.com>;
	Thu, 15 Oct 1998 19:54:24 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA00830
	for <linux@engr.sgi.com>; Thu, 15 Oct 1998 19:54:18 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id EAA24391
	for <linux@engr.sgi.com>; Fri, 16 Oct 1998 04:54:06 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id MAA02181;
	Thu, 15 Oct 1998 12:56:02 +0200
Message-ID: <19981015125602.A2130@uni-koblenz.de>
Date: Thu, 15 Oct 1998 12:56:02 +0200
From: ralf@uni-koblenz.de
To: Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: R4000SC ...
References: <19981013220043.A2620@uni-koblenz.de> <19981014181331.A26597@zigzegv.ml.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=envbJBWh7q8WU6mo
X-Mailer: Mutt 0.91.1
In-Reply-To: <19981014181331.A26597@zigzegv.ml.org>; from Ulf Carlsson on Wed, Oct 14, 1998 at 06:13:31PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii

On Wed, Oct 14, 1998 at 06:13:31PM +0200, Ulf Carlsson wrote:

> Can you please explain to me what the fixes actually needed for the SC were? I
> am quite interested.

Ok, here we go again.  Attached the patch which I checked in yesterday.
Should tell most easy what I've changed:

 - The VCE exceptions need special handling in the general exception vector.
   In particular it's important that we cannot do any cached loads / stores
   before we've brought caches back to a sane state.  So all the old handlers
   in entry.S and traps.c had to go away.
 - Some of the cache operations defined in r4xx0.c use Hit_*_SD operations to
   work on the caches.  These have the nice property that they will also
   invalidate any primary cache line in both icache and dcache that maps to
   the affected secondary cache line.  In other words code sequences like

       blast_dcache16_page(start);
       if(text)
               blast_icache16_page(start);
       blast_scache16_page(start);

   can simply be replaced by

       blast_scache16_page(start);

   This change does not represent any kind of bug, it's just important
   performance work because cache instructions are expensive even if there
   is no work to do, that is no writebacks or invalidates.  Aside due to the
   massive loop unrolling used in that code we just saved us close to 10kb
   in kernel size.
 - We had code to support a cache configuration with a data cache linesize
   of 32 bytes and second level linesize of 16 bytes.  Configurations where
   the second level linesize is smaller than the primary cache linesize are
   however forbidden, so away with the code.
 - As you remember I disabled the use of the Create_Dirty_Excl_D based
   versions of clear_page and copy_page for R4000 / R4400 SC and MC versions
   as part of the first round of SC fixes.  Now I implemented a set of four
   routines optimized for each possible second level cache linesize.  Right
   now there are only new variants of clear_page; copy_page will come asap.
   I attempted to implement optimized variants using both Create_Dirty_Excl_SD
   and Create_Dirty_Excl_D in clear_page but the resulting kernel crashed
   immediately.  Not shure what the cause is.
 - The untested draft variant of head.S which I mailed to you was not word-
   aligning the address used to index the primary cache tag array.  The
   effect is somewhat hidden, just occasionally programs will die with
   SIGBUS.  No idea why this is necessary.
 - One structure in sgiseeq needed extra padding.  This was not an actual
   SC-bug; the driver would have failed on any machine with cachelines
   larger than 64 bytes.  I increased the number of fill bytes to make the
   driver work with 128 byte linesized caches which is the largest available
   for the IP22.

Somebody asked me why the general exception handler or the VCED / VCEI
exception handlers never crash with a VCE exception resulting in a infinite
loop.  First of all don't do any loads or stores before we've serviced a
VCED / VCEI exception, so we can never catch any VCED exception.  Second,
a VCED / VCEI exception will only occur in case of both a primary and
secondary cache hit where the second level cache virtual index is different
from the actual virtual address' index bits.  In normal live this will
never happen since the exception handlers are only accessed via KSEG0 but
never mapped.  In other words mmaping /dev/mem and just _reading_ the wrong
RAM addresses is a safe way to crash the machine.  Well, you're not supposed
to even try that.

  Ralf

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=vce-patch

diff -u linux/arch/mips/kernel/entry.S:1.14 linux/arch/mips/kernel/entry.S:1.15
--- linux/arch/mips/kernel/entry.S:1.14	Tue Sep  8 21:11:46 1998
+++ linux/arch/mips/kernel/entry.S	Wed Oct 14 22:26:26 1998
@@ -152,10 +152,8 @@
 		BUILD_HANDLER(cpu,cpu,sti,silent)		/* #11 */
 		BUILD_HANDLER(ov,ov,sti,silent)			/* #12 */
 		BUILD_HANDLER(tr,tr,sti,silent)			/* #13 */
-		BUILD_HANDLER(vcei,vcei,sti,verbose)		/* #14 */
 		BUILD_HANDLER(fpe,fpe,fpe,silent)		/* #15 */
 		BUILD_HANDLER(watch,watch,sti,verbose)		/* #23 */
-		BUILD_HANDLER(vced,vced,sti,verbose)		/* #31 */
 		BUILD_HANDLER(reserved,reserved,sti,verbose)	/* others */
 
 /*
diff -u linux/arch/mips/kernel/head.S:1.12 linux/arch/mips/kernel/head.S:1.13
--- linux/arch/mips/kernel/head.S:1.12	Tue May 26 08:16:52 1998
+++ linux/arch/mips/kernel/head.S	Wed Oct 14 22:26:27 1998
@@ -19,6 +19,7 @@
 #include <linux/tasks.h>
 
 #include <asm/asm.h>
+#include <asm/cacheops.h>
 #include <asm/current.h>
 #include <asm/offset.h>
 #include <asm/processor.h>
@@ -34,10 +35,10 @@
 	/*
 	 * Reserved space for exception handlers.
 	 * Necessary for machines which link their kernels at KSEG0.
-	 * FIXME: We could overwrite some of the useless handlers
-	 * with those actually being used.
+	 * FIXME: Use the initcode feature to get rid of unused handler
+	 * variants.
 	 */
-	.fill	520
+	.fill	0x280
 /*	
  * This is space for the interrupt handlers.
  * After trap_init() they are located at virtual address KSEG0.
@@ -322,16 +323,48 @@
 	NESTED(except_vec3_r4000, 0, sp)
 	.set	noat
 	mfc0	k1, CP0_CAUSE
-
-	/* XXX Have to check for VCE's _before_ we do a load or store. */
-
-	la	k0, exception_handlers
 	andi	k1, k1, 0x7c
+	li	k0, 31<<2
+	beq	k1, k0, handle_vced
+	 li	k0, 14<<2
+	beq	k1, k0, handle_vcei
+	 la	k0, exception_handlers
 	addu	k0, k0, k1
 	lw	k0, (k0)
 	nop
 	jr	k0
 	 nop
+
+/*
+ * Big shit, we now may have two dirty primary cache lines for the same
+ * physical address.  We can savely invalidate the line pointed to by
+ * c0_badvaddr because after return from this exception handler the load /
+ * store will be re-executed.
+ */
+handle_vced:
+	mfc0	k0, CP0_BADVADDR
+ li k1, -4
+ and k0, k1
+	mtc0	zero, CP0_TAGLO
+ //	nop;nop
+	cache	Index_Store_Tag_D,(k0)
+ //	nop;nop
+	cache	Hit_Writeback_Inv_SD,(k0)
+	lui	k0, %hi(vced_count)
+	lw	k1, %lo(vced_count)(k0)
+	addiu	k1, 1
+	sw	k1, %lo(vced_count)(k0)
+	eret
+
+handle_vcei:
+	mfc0	k0, CP0_BADVADDR
+	cache	Hit_Writeback_Inv_SD,(k0)		# also cleans pi
+	lui	k0, %hi(vcei_count)
+	lw	k1, %lo(vcei_count)(k0)
+	addiu	k1, 1
+	sw	k1, %lo(vcei_count)(k0)
+	eret
+
 	END(except_vec3_r4000)
 	.set	at
 
diff -u linux/arch/mips/kernel/proc.c:1.3 linux/arch/mips/kernel/proc.c:1.4
--- linux/arch/mips/kernel/proc.c:1.3	Thu Oct  2 23:55:16 1997
+++ linux/arch/mips/kernel/proc.c	Wed Oct 14 22:27:49 1998
@@ -12,6 +12,7 @@
 #include <asm/watch.h>
 
 unsigned long unaligned_instructions;
+unsigned int vced_count, vcei_count;
 
 /*
  * BUFFER is PAGE_SIZE bytes long.
@@ -21,6 +22,7 @@
  */
 int get_cpuinfo(char *buffer)
 {
+	char fmt [64];
 	const char *cpu_name[] = CPU_NAMES;
 	const char *mach_group_names[] = GROUP_NAMES;
 	const char *mach_unknown_names[] = GROUP_UNKNOWN_NAMES;
@@ -71,6 +73,11 @@
 	               dedicated_iv_available ? "yes" : "no");
 	len += sprintf(buffer + len, "hardware watchpoint\t: %s\n",
 	               watch_available ? "yes" : "no");
+
+	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
+	        vce_available ? "%d" : "not available");
+	len += sprintf(buffer + len, fmt, 'D', vced_count);
+	len += sprintf(buffer + len, fmt, 'I', vcei_count);
 
 	return len;
 }
diff -u linux/arch/mips/kernel/traps.c:1.19 linux/arch/mips/kernel/traps.c:1.20
--- linux/arch/mips/kernel/traps.c:1.19	Thu Aug 20 18:33:18 1998
+++ linux/arch/mips/kernel/traps.c	Wed Oct 14 22:26:26 1998
@@ -55,9 +55,7 @@
 extern asmlinkage void handle_cpu(void);
 extern asmlinkage void handle_ov(void);
 extern asmlinkage void handle_tr(void);
-extern asmlinkage void handle_vcei(void);
 extern asmlinkage void handle_fpe(void);
-extern asmlinkage void handle_vced(void);
 extern asmlinkage void handle_watch(void);
 extern asmlinkage void handle_reserved(void);
 
@@ -65,6 +63,7 @@
 
 char watch_available = 0;
 char dedicated_iv_available = 0;
+char vce_available = 0;
 
 void (*ibe_board_handler)(struct pt_regs *regs);
 void (*dbe_board_handler)(struct pt_regs *regs);
@@ -359,24 +358,6 @@
 	force_sig(SIGILL, current);
 }
 
-void do_vcei(struct pt_regs *regs)
-{
-	/*
-	 * Only possible on R4[04]00[SM]C. No handler because I don't have
-	 * such a cpu.  Theory says this exception doesn't happen.
-	 */
-	panic("Caught VCEI exception - should not happen");
-}
-
-void do_vced(struct pt_regs *regs)
-{
-	/*
-	 * Only possible on R4[04]00[SM]C. No handler because I don't have
-	 * such a cpu.  Theory says this exception doesn't happen.
-	 */
-	panic("Caught VCE exception - should not happen");
-}
-
 void do_watch(struct pt_regs *regs)
 {
 	/*
@@ -513,11 +494,8 @@
 	case CPU_R4400MC:
 	case CPU_R4000SC:
 	case CPU_R4400SC:
-		/* XXX The following won't work because we _cannot_
-		 * XXX perform any load/store before the VCE handler.
-		 */
-		set_except_vector(14, handle_vcei);
-		set_except_vector(31, handle_vced);
+		vce_available = 1;
+		/* Fall through ...  */
 	case CPU_R4000PC:
 	case CPU_R4400PC:
 	case CPU_R4200:
@@ -533,13 +511,16 @@
 		else
 			memcpy((void *)KSEG0, &except_vec0_r4000, 0x80);
 
-		/*
-		 * The idea is that this special r4000 general exception
-		 * vector will check for VCE exceptions before calling
-		 * out of the exception array.  XXX TODO
-		 */
+		/* Cache error vector  */
 		memcpy((void *)(KSEG0 + 0x100), (void *) KSEG0, 0x80);
-		memcpy((void *)(KSEG0 + 0x180), &except_vec3_r4000, 0x80);
+
+		if (vce_available) {
+			memcpy((void *)(KSEG0 + 0x180), &except_vec3_r4000,
+			       0x180);
+		} else {
+			memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic,
+			       0x100);
+		}
 
 		save_fp_context = r4k_save_fp_context;
 		restore_fp_context = r4k_restore_fp_context;
diff -u linux/arch/mips/mm/r4xx0.c:1.28 linux/arch/mips/mm/r4xx0.c:1.29
--- linux/arch/mips/mm/r4xx0.c:1.28	Tue Aug 18 22:45:08 1998
+++ linux/arch/mips/mm/r4xx0.c	Wed Oct 14 22:29:59 1998
@@ -41,7 +41,7 @@
 static int ic_lsize, dc_lsize;       /* LineSize in bytes */
 
 /* Secondary cache (if present) parameters. */
-static unsigned long scache_size, sc_lsize;	/* Again, in bytes */
+static unsigned int scache_size, sc_lsize;	/* Again, in bytes */
 
 #include <asm/cacheops.h>
 #include <asm/r4kcache.h>
@@ -78,10 +78,7 @@
  * - a version which handles the buggy R4600 v1.x
  * - a version which handles the buggy R4600 v2.0
  * - Finally a last version without fancy cache games for the SC and MC
- *   versions of R4000 and R4400.  Cache instructions are quite expensive
- *   and I guess using them for both the primary and the second level cache
- *   wouldn't be worth the effort.
- *   This needs to be verified by benchmarking.
+ *   versions of R4000 and R4400.
  */
 
 static void r4k_clear_page_d16(unsigned long page)
@@ -245,14 +242,84 @@
 	restore_flags(flags);
 }
 
-static void r4k_clear_page(unsigned long page)
+/*
+ * The next 4 versions are optimized for all possible scache configurations
+ * of the SC / MC versions of R4000 and R4400 ...
+ *
+ * Todo: For even better performance we should have a routine optimized for
+ * every legal combination of dcache / scache linesize.  When I (Ralf) tried
+ * this the kernel crashed shortly after mounting the root filesystem.  CPU
+ * bug?  Weirdo cache instruction semantics?
+ */
+static void r4k_clear_page_s16(unsigned long page)
+{
+	__asm__ __volatile__(
+		".set\tnoreorder\n\t"
+		".set\tnoat\n\t"
+		".set\tmips3\n\t"
+		"daddiu\t$1,%0,%2\n"
+		"1:\tcache\t%3,(%0)\n\t"
+		"sd\t$0,(%0)\n\t"
+		"sd\t$0,8(%0)\n\t"
+		"cache\t%3,16(%0)\n\t"
+		"sd\t$0,16(%0)\n\t"
+		"sd\t$0,24(%0)\n\t"
+		"daddiu\t%0,64\n\t"
+		"cache\t%3,-32(%0)\n\t"
+		"sd\t$0,-32(%0)\n\t"
+		"sd\t$0,-24(%0)\n\t"
+		"cache\t%3,-16(%0)\n\t"
+		"sd\t$0,-16(%0)\n\t"
+		"bne\t$1,%0,1b\n\t"
+		"sd\t$0,-8(%0)\n\t"
+		".set\tmips0\n\t"
+		".set\tat\n\t"
+		".set\treorder"
+		:"=r" (page)
+		:"0" (page),
+		 "I" (PAGE_SIZE),
+		 "i" (Create_Dirty_Excl_SD)
+		:"$1","memory");
+}
+
+static void r4k_clear_page_s32(unsigned long page)
+{
+	__asm__ __volatile__(
+		".set\tnoreorder\n\t"
+		".set\tnoat\n\t"
+		".set\tmips3\n\t"
+		"daddiu\t$1,%0,%2\n"
+		"1:\tcache\t%3,(%0)\n\t"
+		"sd\t$0,(%0)\n\t"
+		"sd\t$0,8(%0)\n\t"
+		"sd\t$0,16(%0)\n\t"
+		"sd\t$0,24(%0)\n\t"
+		"daddiu\t%0,64\n\t"
+		"cache\t%3,-32(%0)\n\t"
+		"sd\t$0,-32(%0)\n\t"
+		"sd\t$0,-24(%0)\n\t"
+		"sd\t$0,-16(%0)\n\t"
+		"bne\t$1,%0,1b\n\t"
+		"sd\t$0,-8(%0)\n\t"
+		".set\tmips0\n\t"
+		".set\tat\n\t"
+		".set\treorder"
+		:"=r" (page)
+		:"0" (page),
+		 "I" (PAGE_SIZE),
+		 "i" (Create_Dirty_Excl_SD)
+		:"$1","memory");
+}
+
+static void r4k_clear_page_s64(unsigned long page)
 {
 	__asm__ __volatile__(
 		".set\tnoreorder\n\t"
 		".set\tnoat\n\t"
 		".set\tmips3\n\t"
 		"daddiu\t$1,%0,%2\n"
-		"1:\tsd\t$0,(%0)\n\t"
+		"1:\tcache\t%3,(%0)\n\t"
+		"sd\t$0,(%0)\n\t"
 		"sd\t$0,8(%0)\n\t"
 		"sd\t$0,16(%0)\n\t"
 		"sd\t$0,24(%0)\n\t"
@@ -267,7 +334,44 @@
 		".set\treorder"
 		:"=r" (page)
 		:"0" (page),
-		 "I" (PAGE_SIZE)
+		 "I" (PAGE_SIZE),
+		 "i" (Create_Dirty_Excl_SD)
+		:"$1","memory");
+}
+
+static void r4k_clear_page_s128(unsigned long page)
+{
+	__asm__ __volatile__(
+		".set\tnoreorder\n\t"
+		".set\tnoat\n\t"
+		".set\tmips3\n\t"
+		"daddiu\t$1,%0,%2\n"
+		"1:\tcache\t%3,(%0)\n\t"
+		"sd\t$0,(%0)\n\t"
+		"sd\t$0,8(%0)\n\t"
+		"sd\t$0,16(%0)\n\t"
+		"sd\t$0,24(%0)\n\t"
+		"sd\t$0,32(%0)\n\t"
+		"sd\t$0,40(%0)\n\t"
+		"sd\t$0,48(%0)\n\t"
+		"sd\t$0,56(%0)\n\t"
+		"daddiu\t%0,128\n\t"
+		"sd\t$0,-64(%0)\n\t"
+		"sd\t$0,-56(%0)\n\t"
+		"sd\t$0,-48(%0)\n\t"
+		"sd\t$0,-40(%0)\n\t"
+		"sd\t$0,-32(%0)\n\t"
+		"sd\t$0,-24(%0)\n\t"
+		"sd\t$0,-16(%0)\n\t"
+		"bne\t$1,%0,1b\n\t"
+		"sd\t$0,-8(%0)\n\t"
+		".set\tmips0\n\t"
+		".set\tat\n\t"
+		".set\treorder"
+		:"=r" (page)
+		:"0" (page),
+		 "I" (PAGE_SIZE),
+		 "i" (Create_Dirty_Excl_SD)
 		:"$1","memory");
 }
 
@@ -529,7 +633,10 @@
 	restore_flags(flags);
 }
 
-static void r4k_copy_page(unsigned long to, unsigned long from)
+/*
+ * These are for R4000SC / R4400MC
+ */
+static void r4k_copy_page_s16(unsigned long to, unsigned long from)
 {
 	unsigned long dummy1, dummy2;
 	unsigned long reg1, reg2, reg3, reg4;
@@ -539,7 +646,8 @@
 		".set\tnoat\n\t"
 		".set\tmips3\n\t"
 		"daddiu\t$1,%0,%8\n"
-		"1:\tlw\t%2,(%1)\n\t"
+		"1:\tcache\t%9,(%0)\n\t"
+		"lw\t%2,(%1)\n\t"
 		"lw\t%3,4(%1)\n\t"
 		"lw\t%4,8(%1)\n\t"
 		"lw\t%5,12(%1)\n\t"
@@ -547,6 +655,7 @@
 		"sw\t%3,4(%0)\n\t"
 		"sw\t%4,8(%0)\n\t"
 		"sw\t%5,12(%0)\n\t"
+		"cache\t%9,16(%0)\n\t"
 		"lw\t%2,16(%1)\n\t"
 		"lw\t%3,20(%1)\n\t"
 		"lw\t%4,24(%1)\n\t"
@@ -555,6 +664,7 @@
 		"sw\t%3,20(%0)\n\t"
 		"sw\t%4,24(%0)\n\t"
 		"sw\t%5,28(%0)\n\t"
+		"cache\t%9,32(%0)\n\t"
 		"daddiu\t%0,64\n\t"
 		"daddiu\t%1,64\n\t"
 		"lw\t%2,-32(%1)\n\t"
@@ -565,6 +675,208 @@
 		"sw\t%3,-28(%0)\n\t"
 		"sw\t%4,-24(%0)\n\t"
 		"sw\t%5,-20(%0)\n\t"
+		"cache\t%9,-16(%0)\n\t"
+		"lw\t%2,-16(%1)\n\t"
+		"lw\t%3,-12(%1)\n\t"
+		"lw\t%4,-8(%1)\n\t"
+		"lw\t%5,-4(%1)\n\t"
+		"sw\t%2,-16(%0)\n\t"
+		"sw\t%3,-12(%0)\n\t"
+		"sw\t%4,-8(%0)\n\t"
+		"bne\t$1,%0,1b\n\t"
+		"sw\t%5,-4(%0)\n\t"
+		".set\tmips0\n\t"
+		".set\tat\n\t"
+		".set\treorder"
+		:"=r" (dummy1), "=r" (dummy2),
+		 "=&r" (reg1), "=&r" (reg2), "=&r" (reg3), "=&r" (reg4)
+		:"0" (to), "1" (from),
+		 "I" (PAGE_SIZE),
+		 "i" (Create_Dirty_Excl_SD));
+}
+
+static void r4k_copy_page_s32(unsigned long to, unsigned long from)
+{
+	unsigned long dummy1, dummy2;
+	unsigned long reg1, reg2, reg3, reg4;
+
+	__asm__ __volatile__(
+		".set\tnoreorder\n\t"
+		".set\tnoat\n\t"
+		".set\tmips3\n\t"
+		"daddiu\t$1,%0,%8\n"
+		"1:\tcache\t%9,(%0)\n\t"
+		"lw\t%2,(%1)\n\t"
+		"lw\t%3,4(%1)\n\t"
+		"lw\t%4,8(%1)\n\t"
+		"lw\t%5,12(%1)\n\t"
+		"sw\t%2,(%0)\n\t"
+		"sw\t%3,4(%0)\n\t"
+		"sw\t%4,8(%0)\n\t"
+		"sw\t%5,12(%0)\n\t"
+		"lw\t%2,16(%1)\n\t"
+		"lw\t%3,20(%1)\n\t"
+		"lw\t%4,24(%1)\n\t"
+		"lw\t%5,28(%1)\n\t"
+		"sw\t%2,16(%0)\n\t"
+		"sw\t%3,20(%0)\n\t"
+		"sw\t%4,24(%0)\n\t"
+		"sw\t%5,28(%0)\n\t"
+		"cache\t%9,32(%0)\n\t"
+		"daddiu\t%0,64\n\t"
+		"daddiu\t%1,64\n\t"
+		"lw\t%2,-32(%1)\n\t"
+		"lw\t%3,-28(%1)\n\t"
+		"lw\t%4,-24(%1)\n\t"
+		"lw\t%5,-20(%1)\n\t"
+		"sw\t%2,-32(%0)\n\t"
+		"sw\t%3,-28(%0)\n\t"
+		"sw\t%4,-24(%0)\n\t"
+		"sw\t%5,-20(%0)\n\t"
+		"lw\t%2,-16(%1)\n\t"
+		"lw\t%3,-12(%1)\n\t"
+		"lw\t%4,-8(%1)\n\t"
+		"lw\t%5,-4(%1)\n\t"
+		"sw\t%2,-16(%0)\n\t"
+		"sw\t%3,-12(%0)\n\t"
+		"sw\t%4,-8(%0)\n\t"
+		"bne\t$1,%0,1b\n\t"
+		"sw\t%5,-4(%0)\n\t"
+		".set\tmips0\n\t"
+		".set\tat\n\t"
+		".set\treorder"
+		:"=r" (dummy1), "=r" (dummy2),
+		 "=&r" (reg1), "=&r" (reg2), "=&r" (reg3), "=&r" (reg4)
+		:"0" (to), "1" (from),
+		 "I" (PAGE_SIZE),
+		 "i" (Create_Dirty_Excl_SD));
+}
+
+static void r4k_copy_page_s64(unsigned long to, unsigned long from)
+{
+	unsigned long dummy1, dummy2;
+	unsigned long reg1, reg2, reg3, reg4;
+
+	__asm__ __volatile__(
+		".set\tnoreorder\n\t"
+		".set\tnoat\n\t"
+		".set\tmips3\n\t"
+		"daddiu\t$1,%0,%8\n"
+		"1:\tcache\t%9,(%0)\n\t"
+		"lw\t%2,(%1)\n\t"
+		"lw\t%3,4(%1)\n\t"
+		"lw\t%4,8(%1)\n\t"
+		"lw\t%5,12(%1)\n\t"
+		"sw\t%2,(%0)\n\t"
+		"sw\t%3,4(%0)\n\t"
+		"sw\t%4,8(%0)\n\t"
+		"sw\t%5,12(%0)\n\t"
+		"lw\t%2,16(%1)\n\t"
+		"lw\t%3,20(%1)\n\t"
+		"lw\t%4,24(%1)\n\t"
+		"lw\t%5,28(%1)\n\t"
+		"sw\t%2,16(%0)\n\t"
+		"sw\t%3,20(%0)\n\t"
+		"sw\t%4,24(%0)\n\t"
+		"sw\t%5,28(%0)\n\t"
+		"daddiu\t%0,64\n\t"
+		"daddiu\t%1,64\n\t"
+		"lw\t%2,-32(%1)\n\t"
+		"lw\t%3,-28(%1)\n\t"
+		"lw\t%4,-24(%1)\n\t"
+		"lw\t%5,-20(%1)\n\t"
+		"sw\t%2,-32(%0)\n\t"
+		"sw\t%3,-28(%0)\n\t"
+		"sw\t%4,-24(%0)\n\t"
+		"sw\t%5,-20(%0)\n\t"
+		"lw\t%2,-16(%1)\n\t"
+		"lw\t%3,-12(%1)\n\t"
+		"lw\t%4,-8(%1)\n\t"
+		"lw\t%5,-4(%1)\n\t"
+		"sw\t%2,-16(%0)\n\t"
+		"sw\t%3,-12(%0)\n\t"
+		"sw\t%4,-8(%0)\n\t"
+		"bne\t$1,%0,1b\n\t"
+		"sw\t%5,-4(%0)\n\t"
+		".set\tmips0\n\t"
+		".set\tat\n\t"
+		".set\treorder"
+		:"=r" (dummy1), "=r" (dummy2),
+		 "=&r" (reg1), "=&r" (reg2), "=&r" (reg3), "=&r" (reg4)
+		:"0" (to), "1" (from),
+		 "I" (PAGE_SIZE),
+		 "i" (Create_Dirty_Excl_SD));
+}
+
+static void r4k_copy_page_s128(unsigned long to, unsigned long from)
+{
+	unsigned long dummy1, dummy2;
+	unsigned long reg1, reg2, reg3, reg4;
+
+	__asm__ __volatile__(
+		".set\tnoreorder\n\t"
+		".set\tnoat\n\t"
+		".set\tmips3\n\t"
+		"daddiu\t$1,%0,%8\n"
+		"1:\tcache\t%9,(%0)\n\t"
+		"lw\t%2,(%1)\n\t"
+		"lw\t%3,4(%1)\n\t"
+		"lw\t%4,8(%1)\n\t"
+		"lw\t%5,12(%1)\n\t"
+		"sw\t%2,(%0)\n\t"
+		"sw\t%3,4(%0)\n\t"
+		"sw\t%4,8(%0)\n\t"
+		"sw\t%5,12(%0)\n\t"
+		"lw\t%2,16(%1)\n\t"
+		"lw\t%3,20(%1)\n\t"
+		"lw\t%4,24(%1)\n\t"
+		"lw\t%5,28(%1)\n\t"
+		"sw\t%2,16(%0)\n\t"
+		"sw\t%3,20(%0)\n\t"
+		"sw\t%4,24(%0)\n\t"
+		"sw\t%5,28(%0)\n\t"
+		"lw\t%2,32(%1)\n\t"
+		"lw\t%3,36(%1)\n\t"
+		"lw\t%4,40(%1)\n\t"
+		"lw\t%5,44(%1)\n\t"
+		"sw\t%2,32(%0)\n\t"
+		"sw\t%3,36(%0)\n\t"
+		"sw\t%4,40(%0)\n\t"
+		"sw\t%5,44(%0)\n\t"
+		"lw\t%2,48(%1)\n\t"
+		"lw\t%3,52(%1)\n\t"
+		"lw\t%4,56(%1)\n\t"
+		"lw\t%5,60(%1)\n\t"
+		"sw\t%2,48(%0)\n\t"
+		"sw\t%3,52(%0)\n\t"
+		"sw\t%4,56(%0)\n\t"
+		"sw\t%5,60(%0)\n\t"
+		"daddiu\t%0,128\n\t"
+		"daddiu\t%1,128\n\t"
+		"lw\t%2,-64(%1)\n\t"
+		"lw\t%3,-60(%1)\n\t"
+		"lw\t%4,-56(%1)\n\t"
+		"lw\t%5,-52(%1)\n\t"
+		"sw\t%2,-64(%0)\n\t"
+		"sw\t%3,-60(%0)\n\t"
+		"sw\t%4,-56(%0)\n\t"
+		"sw\t%5,-52(%0)\n\t"
+		"lw\t%2,-48(%1)\n\t"
+		"lw\t%3,-44(%1)\n\t"
+		"lw\t%4,-40(%1)\n\t"
+		"lw\t%5,-36(%1)\n\t"
+		"sw\t%2,-48(%0)\n\t"
+		"sw\t%3,-44(%0)\n\t"
+		"sw\t%4,-40(%0)\n\t"
+		"sw\t%5,-36(%0)\n\t"
+		"lw\t%2,-32(%1)\n\t"
+		"lw\t%3,-28(%1)\n\t"
+		"lw\t%4,-24(%1)\n\t"
+		"lw\t%5,-20(%1)\n\t"
+		"sw\t%2,-32(%0)\n\t"
+		"sw\t%3,-28(%0)\n\t"
+		"sw\t%4,-24(%0)\n\t"
+		"sw\t%5,-20(%0)\n\t"
 		"lw\t%2,-16(%1)\n\t"
 		"lw\t%3,-12(%1)\n\t"
 		"lw\t%4,-8(%1)\n\t"
@@ -580,9 +892,11 @@
 		:"=r" (dummy1), "=r" (dummy2),
 		 "=&r" (reg1), "=&r" (reg2), "=&r" (reg3), "=&r" (reg4)
 		:"0" (to), "1" (from),
-		 "I" (PAGE_SIZE));
+		 "I" (PAGE_SIZE),
+		 "i" (Create_Dirty_Excl_SD));
 }
 
+
 /*
  * If you think for one second that this stuff coming up is a lot
  * of bulky code eating too many kernel cache lines.  Think _again_.
@@ -632,15 +946,6 @@
 	restore_flags(flags);
 }
 
-static inline void r4k_flush_cache_all_s16d32i32(void)
-{
-	unsigned long flags;
-
-	save_and_cli(flags);
-	blast_dcache32(); blast_icache32(); blast_scache16();
-	restore_flags(flags);
-}
-
 static inline void r4k_flush_cache_all_s32d32i32(void)
 {
 	unsigned long flags;
@@ -718,12 +1023,8 @@
 				pmd = pmd_offset(pgd, start);
 				pte = pte_offset(pmd, start);
 
-				if(pte_val(*pte) & _PAGE_VALID) {
-					blast_dcache16_page(start);
-					if(text)
-						blast_icache16_page(start);
+				if(pte_val(*pte) & _PAGE_VALID)
 					blast_scache16_page(start);
-				}
 				start += PAGE_SIZE;
 			}
 			restore_flags(flags);
@@ -763,12 +1064,8 @@
 				pmd = pmd_offset(pgd, start);
 				pte = pte_offset(pmd, start);
 
-				if(pte_val(*pte) & _PAGE_VALID) {
-					blast_dcache16_page(start);
-					if(text)
-						blast_icache16_page(start);
+				if(pte_val(*pte) & _PAGE_VALID)
 					blast_scache32_page(start);
-				}
 				start += PAGE_SIZE;
 			}
 			restore_flags(flags);
@@ -807,12 +1104,8 @@
 				pmd = pmd_offset(pgd, start);
 				pte = pte_offset(pmd, start);
 
-				if(pte_val(*pte) & _PAGE_VALID) {
-					blast_dcache16_page(start);
-					if(text)
-						blast_icache16_page(start);
+				if(pte_val(*pte) & _PAGE_VALID)
 					blast_scache64_page(start);
-				}
 				start += PAGE_SIZE;
 			}
 			restore_flags(flags);
@@ -851,56 +1144,8 @@
 				pmd = pmd_offset(pgd, start);
 				pte = pte_offset(pmd, start);
 
-				if(pte_val(*pte) & _PAGE_VALID) {
-					blast_dcache16_page(start);
-					if(text)
-						blast_icache16_page(start);
+				if(pte_val(*pte) & _PAGE_VALID)
 					blast_scache128_page(start);
-				}
-				start += PAGE_SIZE;
-			}
-			restore_flags(flags);
-		}
-	}
-}
-
-static void r4k_flush_cache_range_s16d32i32(struct mm_struct *mm,
-					    unsigned long start,
-					    unsigned long end)
-{
-	struct vm_area_struct *vma;
-	unsigned long flags;
-
-	if(mm->context == 0)
-		return;
-
-	start &= PAGE_MASK;
-#ifdef DEBUG_CACHE
-	printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
-#endif
-	vma = find_vma(mm, start);
-	if(vma) {
-		if(mm->context != current->mm->context) {
-			r4k_flush_cache_all_s16d32i32();
-		} else {
-			pgd_t *pgd;
-			pmd_t *pmd;
-			pte_t *pte;
-			int text;
-
-			save_and_cli(flags);
-			text = vma->vm_flags & VM_EXEC;
-			while(start < end) {
-				pgd = pgd_offset(mm, start);
-				pmd = pmd_offset(pgd, start);
-				pte = pte_offset(pmd, start);
-
-				if(pte_val(*pte) & _PAGE_VALID) {
-					blast_dcache32_page(start);
-					if(text)
-						blast_icache32_page(start);
-					blast_scache16_page(start);
-				}
 				start += PAGE_SIZE;
 			}
 			restore_flags(flags);
@@ -939,12 +1184,8 @@
 				pmd = pmd_offset(pgd, start);
 				pte = pte_offset(pmd, start);
 
-				if(pte_val(*pte) & _PAGE_VALID) {
-					blast_dcache32_page(start);
-					if(text)
-						blast_icache32_page(start);
+				if(pte_val(*pte) & _PAGE_VALID)
 					blast_scache32_page(start);
-				}
 				start += PAGE_SIZE;
 			}
 			restore_flags(flags);
@@ -983,12 +1224,8 @@
 				pmd = pmd_offset(pgd, start);
 				pte = pte_offset(pmd, start);
 
-				if(pte_val(*pte) & _PAGE_VALID) {
-					blast_dcache32_page(start);
-					if(text)
-						blast_icache32_page(start);
+				if(pte_val(*pte) & _PAGE_VALID)
 					blast_scache64_page(start);
-				}
 				start += PAGE_SIZE;
 			}
 			restore_flags(flags);
@@ -1027,12 +1264,8 @@
 				pmd = pmd_offset(pgd, start);
 				pte = pte_offset(pmd, start);
 
-				if(pte_val(*pte) & _PAGE_VALID) {
-					blast_dcache32_page(start);
-					if(text)
-						blast_icache32_page(start);
+				if(pte_val(*pte) & _PAGE_VALID)
 					blast_scache128_page(start);
-				}
 				start += PAGE_SIZE;
 			}
 			restore_flags(flags);
@@ -1117,16 +1350,6 @@
 	}
 }
 
-static void r4k_flush_cache_mm_s16d32i32(struct mm_struct *mm)
-{
-	if(mm->context != 0) {
-#ifdef DEBUG_CACHE
-		printk("cmm[%d]", (int)mm->context);
-#endif
-		r4k_flush_cache_all_s16d32i32();
-	}
-}
-
 static void r4k_flush_cache_mm_s32d32i32(struct mm_struct *mm)
 {
 	if(mm->context != 0) {
@@ -1225,12 +1448,8 @@
 		if(text)
 			blast_icache16_page_indexed(page);
 		blast_scache16_page_indexed(page);
-	} else {
-		blast_dcache16_page(page);
-		if(text)
-			blast_icache16_page(page);
+	} else
 		blast_scache16_page(page);
-	}
 out:
 	restore_flags(flags);
 }
@@ -1282,12 +1501,8 @@
 		if(text)
 			blast_icache16_page_indexed(page);
 		blast_scache32_page_indexed(page);
-	} else {
-		blast_dcache16_page(page);
-		if(text)
-			blast_icache16_page(page);
+	} else
 		blast_scache32_page(page);
-	}
 out:
 	restore_flags(flags);
 }
@@ -1340,12 +1555,8 @@
 		if(text)
 			blast_icache16_page_indexed(page);
 		blast_scache64_page_indexed(page);
-	} else {
-		blast_dcache16_page(page);
-		if(text)
-			blast_icache16_page(page);
+	} else
 		blast_scache64_page(page);
-	}
 out:
 	restore_flags(flags);
 }
@@ -1399,70 +1610,8 @@
 		if(text)
 			blast_icache16_page_indexed(page);
 		blast_scache128_page_indexed(page);
-	} else {
-		blast_dcache16_page(page);
-		if(text)
-			blast_icache16_page(page);
+	} else
 		blast_scache128_page(page);
-	}
-out:
-	restore_flags(flags);
-}
-
-static void r4k_flush_cache_page_s16d32i32(struct vm_area_struct *vma,
-					   unsigned long page)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long flags;
-	pgd_t *pgdp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-	int text;
-
-	/*
-	 * If ownes no valid ASID yet, cannot possibly have gotten
-	 * this page into the cache.
-	 */
-	if(mm->context == 0)
-		return;
-
-#ifdef DEBUG_CACHE
-	printk("cpage[%d,%08lx]", (int)mm->context, page);
-#endif
-	save_and_cli(flags);
-	page &= PAGE_MASK;
-	pgdp = pgd_offset(mm, page);
-	pmdp = pmd_offset(pgdp, page);
-	ptep = pte_offset(pmdp, page);
-
-	/* If the page isn't marked valid, the page cannot possibly be
-	 * in the cache.
-	 */
-	if(!(pte_val(*ptep) & _PAGE_VALID))
-		goto out;
-
-	text = (vma->vm_flags & VM_EXEC);
-	/*
-	 * Doing flushes for another ASID than the current one is
-	 * too difficult since stupid R4k caches do a TLB translation
-	 * for every cache flush operation.  So we do indexed flushes
-	 * in that case, which doesn't overly flush the cache too much.
-	 */
-	if(mm->context != current->mm->context) {
-		/* Do indexed flush, too much work to get the (possible)
-		 * tlb refills to work correctly.
-		 */
-		page = (KSEG0 + (page & (scache_size - 1)));
-		blast_dcache32_page_indexed(page);
-		if(text)
-			blast_icache32_page_indexed(page);
-		blast_scache16_page_indexed(page);
-	} else {
-		blast_dcache32_page(page);
-		if(text)
-			blast_icache32_page(page);
-		blast_scache16_page(page);
-	}
 out:
 	restore_flags(flags);
 }
@@ -1517,12 +1666,8 @@
 		if(text)
 			blast_icache32_page_indexed(page);
 		blast_scache32_page_indexed(page);
-	} else {
-		blast_dcache32_page(page);
-		if(text)
-			blast_icache32_page(page);
+	} else
 		blast_scache32_page(page);
-	}
 out:
 	restore_flags(flags);
 }
@@ -1577,12 +1722,8 @@
 		if(text)
 			blast_icache32_page_indexed(page);
 		blast_scache64_page_indexed(page);
-	} else {
-		blast_dcache32_page(page);
-		if(text)
-			blast_icache32_page(page);
+	} else
 		blast_scache64_page(page);
-	}
 out:
 	restore_flags(flags);
 }
@@ -1635,12 +1776,8 @@
 		if(text)
 			blast_icache32_page_indexed(page);
 		blast_scache128_page_indexed(page);
-	} else {
-		blast_dcache32_page(page);
-		if(text)
-			blast_icache32_page(page);
+	} else
 		blast_scache128_page(page);
-	}
 out:
 	restore_flags(flags);
 }
@@ -1832,15 +1969,10 @@
 {
 	page &= PAGE_MASK;
 	if((page >= KSEG0 && page < KSEG1) || (page >= KSEG2)) {
-		unsigned long flags;
-
 #ifdef DEBUG_CACHE
 		printk("cram[%08lx]", page);
 #endif
-		save_and_cli(flags);
-		blast_dcache16_page(page);
 		blast_scache16_page(page);
-		restore_flags(flags);
 	}
 }
 
@@ -1848,15 +1980,10 @@
 {
 	page &= PAGE_MASK;
 	if((page >= KSEG0 && page < KSEG1) || (page >= KSEG2)) {
-		unsigned long flags;
-
 #ifdef DEBUG_CACHE
 		printk("cram[%08lx]", page);
 #endif
-		save_and_cli(flags);
-		blast_dcache16_page(page);
 		blast_scache32_page(page);
-		restore_flags(flags);
 	}
 }
 
@@ -1864,15 +1991,10 @@
 {
 	page &= PAGE_MASK;
 	if((page >= KSEG0 && page < KSEG1) || (page >= KSEG2)) {
-		unsigned long flags;
-
 #ifdef DEBUG_CACHE
 		printk("cram[%08lx]", page);
 #endif
-		save_and_cli(flags);
-		blast_dcache16_page(page);
 		blast_scache64_page(page);
-		restore_flags(flags);
 	}
 }
 
@@ -1880,31 +2002,10 @@
 {
 	page &= PAGE_MASK;
 	if((page >= KSEG0 && page < KSEG1) || (page >= KSEG2)) {
-		unsigned long flags;
-
 #ifdef DEBUG_CACHE
 		printk("cram[%08lx]", page);
 #endif
-		save_and_cli(flags);
-		blast_dcache16_page(page);
 		blast_scache128_page(page);
-		restore_flags(flags);
-	}
-}
-
-static void r4k_flush_page_to_ram_s16d32i32(unsigned long page)
-{
-	page &= PAGE_MASK;
-	if((page >= KSEG0 && page < KSEG1) || (page >= KSEG2)) {
-		unsigned long flags;
-
-#ifdef DEBUG_CACHE
-		printk("cram[%08lx]", page);
-#endif
-		save_and_cli(flags);
-		blast_dcache32_page(page);
-		blast_scache16_page(page);
-		restore_flags(flags);
 	}
 }
 
@@ -1912,15 +2013,10 @@
 {
 	page &= PAGE_MASK;
 	if((page >= KSEG0 && page < KSEG1) || (page >= KSEG2)) {
-		unsigned long flags;
-
 #ifdef DEBUG_CACHE
 		printk("cram[%08lx]", page);
 #endif
-		save_and_cli(flags);
-		blast_dcache32_page(page);
 		blast_scache32_page(page);
-		restore_flags(flags);
 	}
 }
 
@@ -1928,15 +2024,10 @@
 {
 	page &= PAGE_MASK;
 	if((page >= KSEG0 && page < KSEG1) || (page >= KSEG2)) {
-		unsigned long flags;
-
 #ifdef DEBUG_CACHE
 		printk("cram[%08lx]", page);
 #endif
-		save_and_cli(flags);
-		blast_dcache32_page(page);
 		blast_scache64_page(page);
-		restore_flags(flags);
 	}
 }
 
@@ -1944,15 +2035,10 @@
 {
 	page &= PAGE_MASK;
 	if((page >= KSEG0 && page < KSEG1) || (page >= KSEG2)) {
-		unsigned long flags;
-
 #ifdef DEBUG_CACHE
 		printk("cram[%08lx]", page);
 #endif
-		save_and_cli(flags);
-		blast_dcache32_page(page);
 		blast_scache128_page(page);
-		restore_flags(flags);
 	}
 }
 
@@ -2026,20 +2112,10 @@
 r4k_dma_cache_wback_inv_sc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	unsigned int flags;
 
 	if (size >= scache_size) {
 		flush_cache_all();
-	} else {
-		save_and_cli(flags);
-		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
-		restore_flags(flags);
+		return;
 	}
 
 	a = addr & ~(sc_lsize - 1);
@@ -2081,20 +2157,10 @@
 r4k_dma_cache_inv_sc(unsigned long addr, unsigned long size)
 {
 	unsigned long end, a;
-	unsigned int flags;
 
 	if (size >= scache_size) {
 		flush_cache_all();
-	} else {
-		save_and_cli(flags);
-		a = addr & ~(dc_lsize - 1);
-		end = (addr + size) & ~(dc_lsize - 1);
-		while (1) {
-			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
-			if (a == end) break;
-			a += dc_lsize;
-		}
-		restore_flags(flags);
+		return;
 	}
 
 	a = addr & ~(sc_lsize - 1);
@@ -2546,8 +2612,8 @@
 	}
 	restore_flags(flags);
 	addr -= begin;
-	printk("Secondary cache sized at %dK linesize %d\n", (int) (addr >> 10),
-	       sc_lsize);
+	printk("Secondary cache sized at %dK linesize %d\n",
+	       (int) (addr >> 10), sc_lsize);
 	scache_size = addr;
 	return 1;
 }
@@ -2602,13 +2668,10 @@
 			flush_page_to_ram = r4k_flush_page_to_ram_s16d16i16;
 			break;
 		case 32:
-			flush_cache_all = r4k_flush_cache_all_s16d32i32;
-			flush_cache_mm = r4k_flush_cache_mm_s16d32i32;
-			flush_cache_range = r4k_flush_cache_range_s16d32i32;
-			flush_cache_page = r4k_flush_cache_page_s16d32i32;
-			flush_page_to_ram = r4k_flush_page_to_ram_s16d32i32;
-			break;
+			panic("Invalid cache configuration detected");
 		};
+		clear_page = r4k_clear_page_s16;
+		copy_page = r4k_copy_page_s16;
 		break;
 	case 32:
 		switch(dc_lsize) {
@@ -2627,6 +2690,9 @@
 			flush_page_to_ram = r4k_flush_page_to_ram_s32d32i32;
 			break;
 		};
+		clear_page = r4k_clear_page_s32;
+		copy_page = r4k_copy_page_s32;
+		break;
 	case 64:
 		switch(dc_lsize) {
 		case 16:
@@ -2644,6 +2710,9 @@
 			flush_page_to_ram = r4k_flush_page_to_ram_s64d32i32;
 			break;
 		};
+		clear_page = r4k_clear_page_s64;
+		copy_page = r4k_copy_page_s64;
+		break;
 	case 128:
 		switch(dc_lsize) {
 		case 16:
@@ -2661,10 +2730,10 @@
 			flush_page_to_ram = r4k_flush_page_to_ram_s128d32i32;
 			break;
 		};
+		clear_page = r4k_clear_page_s128;
+		copy_page = r4k_copy_page_s128;
 		break;
 	}
-	clear_page = r4k_clear_page;
-	copy_page = r4k_copy_page;
 	dma_cache_wback_inv = r4k_dma_cache_wback_inv_sc;
 	dma_cache_inv = r4k_dma_cache_inv_sc;
 }
diff -u linux/drivers/net/sgiseeq.c:1.8 linux/drivers/net/sgiseeq.c:1.9
--- linux/drivers/net/sgiseeq.c:1.8	Wed Aug 19 23:55:06 1998
+++ linux/drivers/net/sgiseeq.c	Wed Oct 14 22:22:48 1998
@@ -86,7 +86,7 @@
 	/* Ptrs to the descriptors in KSEG1 uncached space. */
 	struct sgiseeq_rx_desc *rx_desc;
 	struct sgiseeq_tx_desc *tx_desc;
-	unsigned long _padding[14]; /* Pad out to largest cache line size. */
+	unsigned long _padding[30]; /* Pad out to largest cache line size. */
 
 	struct sgiseeq_rx_desc rxvector[SEEQ_RX_BUFFERS];
 	struct sgiseeq_tx_desc txvector[SEEQ_TX_BUFFERS];
diff -u linux/include/asm-mips/processor.h:1.17 linux/include/asm-mips/processor.h:1.18
--- linux/include/asm-mips/processor.h:1.17	Tue Aug 18 22:46:41 1998
+++ linux/include/asm-mips/processor.h	Wed Oct 14 22:31:12 1998
@@ -30,8 +30,10 @@
 extern char wait_available;		/* only available on R4[26]00 */
 extern char cyclecounter_available;	/* only available from R4000 upwards. */
 extern char dedicated_iv_available;	/* some embedded MIPS like Nevada */
+extern char vce_available;		/* Supports VCED / VCEI exceptions */
 
 extern struct mips_cpuinfo boot_cpu_data;
+extern unsigned int vced_count, vcei_count;
 
 #ifdef __SMP__
 extern struct mips_cpuinfo cpu_data[];

--envbJBWh7q8WU6mo--
