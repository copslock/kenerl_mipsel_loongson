Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UJRcnC000463
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 12:27:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UJRbI2000462
	for linux-mips-outgoing; Thu, 30 May 2002 12:27:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UJQWnC000431
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 12:26:32 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Thu, 30 May 2002 12:28:01 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from ldt-sj3-022.sj.broadcom.com (ldt-sj3-022 [10.21.64.22])
 by mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g4UJS31S016298 for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 12:28:03
 -0700 (PDT)
Received: (from carlson@localhost) by ldt-sj3-022.sj.broadcom.com (
 8.11.6/8.9.3) id g4UJS3R17799; Thu, 30 May 2002 12:28:03 -0700
X-Authentication-Warning: ldt-sj3-022.sj.broadcom.com: carlson set
 sender to justinca@cs.cmu.edu using -f
Subject: Cache flushing, take 2
From: "Justin Carlson" <justinca@cs.cmu.edu>
To: linux-mips@oss.sgi.com
X-Mailer: Ximian Evolution 1.0.5
Date: 30 May 2002 12:28:03 -0700
Message-ID: <1022786883.7643.466.camel@ldt-sj3-022.sj.broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 10E8A2CB62503-01-01
Content-Type: multipart/mixed; 
 boundary="=-OIpXZaCsihiMHNAFriFG"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-OIpXZaCsihiMHNAFriFG
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit

I've taken a second look at the cache flushing, and think maybe this is
a better way to fix what I see as the major problems.

Attached is a patch which does the following:

* Removes __flush_cache_all()
* Adds writeback_inv_dcache_all() and writeback_inv_dcache_range().
  these functions force the flushing of the dcache, as opposed to the
  flush_cache_* functions, which only flush if needed for coherence.
* Adds better documentation to the function declarations in pgtable.h
* Fixes up gdb-stub.c to use this interface
* Actually implements the more agressive semantics for the cacheflush 
  system call
* Fixes up the old sysmips system call to use this interface

I've only implemented the actual new routines for the sb1; I'd like to
solicit some feedback as to what other people think of this approach
before taking the plunge to other implementations.  Note this patch is
not tested beyond compilability; if people like this approach I'll flesh
it out and resubmit something tested.

Comments?

-Justin


--=-OIpXZaCsihiMHNAFriFG
Content-Disposition: attachment; 
 filename=cacheflush.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; 
 charset=iso-8859-1; 
 name=cacheflush.patch

? cacheflush.patch
Index: arch/mips/kernel/gdb-stub.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/kernel/gdb-stub.c,v
retrieving revision 1.16
diff -u -r1.16 gdb-stub.c
--- arch/mips/kernel/gdb-stub.c	2002/05/29 22:40:04	1.16
+++ arch/mips/kernel/gdb-stub.c	2002/05/30 19:13:10
@@ -575,7 +575,7 @@
 	async_bp.addr =3D epc;
 	async_bp.val  =3D *(unsigned *)epc;
 	*(unsigned *)epc =3D BP;
-	__flush_cache_all();
+	flush_icache_range(epc, epc + 4);
 }
=20
=20
@@ -799,10 +799,8 @@
 			 * has no way of knowing that a data ref to some location
 			 * may have changed something that is in the instruction
 			 * cache.
-			 * NB: We flush both caches, just to be sure...
 			 */
-
-			__flush_cache_all();
+			flush_icache_all();
 			return;
 			/* NOTREACHED */
 			break;
@@ -831,7 +829,7 @@
 			 * use breakpoints and continue, instead.
 			 */
 			single_step(regs);
-			__flush_cache_all();
+			flush_icache_all();
 			return;
 			/* NOTREACHED */
=20
Index: arch/mips/kernel/sysmips.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/kernel/sysmips.c,v
retrieving revision 1.21
diff -u -r1.21 sysmips.c
--- arch/mips/kernel/sysmips.c	2002/05/29 18:36:28	1.21
+++ arch/mips/kernel/sysmips.c	2002/05/30 19:13:10
@@ -83,7 +83,8 @@
 		goto out;
=20
 	case FLUSH_CACHE:
-		__flush_cache_all();
+		flush_icache_all();
+		writeback_inv_dcache_all();
 		retval =3D 0;
 		goto out;
=20
Index: arch/mips/mm/c-sb1.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/mm/c-sb1.c,v
retrieving revision 1.19
diff -u -r1.19 c-sb1.c
--- arch/mips/mm/c-sb1.c	2002/05/29 22:40:05	1.19
+++ arch/mips/mm/c-sb1.c	2002/05/30 19:13:10
@@ -74,72 +74,6 @@
 {
 }
=20
-static void local_sb1___flush_cache_all(void)
-{
-	/*
-	 * Haven't worried too much about speed here; given that we're flushing
-	 * the icache, the time to invalidate is dwarfed by the time it's going
-	 * to take to refill it.  Register usage:
-	 *=20
-	 * $1 - moving cache index
-	 * $2 - set count
-	 */
-	__asm__ __volatile__ (
-		".set push                  \n"
-		".set noreorder             \n"
-		".set noat                  \n"
-		".set mips4                 \n"
-		"     move   $1, %2         \n" /* Start at index 0 */
-		"1:   cache  %3, 0($1)      \n" /* WB/Invalidate this index */
-		"     addiu  %1, %1, -1     \n" /* Decrement loop count */
-		"     bnez   %1, 1b         \n" /* loop test */
-		"      addu   $1, $1, %0    \n" /* Next address */
-		".set pop                   \n"
-		:
-		: "r" (dcache_line_size), "r" (dcache_sets * dcache_assoc),
-		  "r" (KSEG0), "i" (Index_Writeback_Inv_D));
-
-	__asm__ __volatile__ (
-		".set push                  \n"
-		".set noreorder             \n"
-		".set mips2                 \n"
-		"sync                       \n"
-#ifdef CONFIG_SB1_PASS_1_WORKAROUNDS		/* Bug 1384 */		=09
-		"sync                       \n"
-#endif
-		".set pop                   \n");
-
-	__asm__ __volatile__ (
-		".set push                  \n"
-		".set noreorder             \n"
-		".set noat                  \n"
-		".set mips4                 \n"
-		"     move   $1, %2         \n" /* Start at index 0 */
-		"1:   cache  %3, 0($1)       \n" /* Invalidate this index */
-		"     addiu  %1, %1, -1     \n" /* Decrement loop count */
-		"     bnez   %1, 1b         \n" /* loop test */
-		"      addu   $1, $1, %0    \n" /* Next address */
-		".set pop                   \n"
-		:
-		: "r" (icache_line_size), "r" (icache_sets * icache_assoc),
-		  "r" (KSEG0), "i" (Index_Invalidate_I));
-}
-
-#ifdef CONFIG_SMP
-extern void sb1___flush_cache_all_ipi(void *ignored);
-asm("sb1___flush_cache_all_ipi =3D local_sb1___flush_cache_all");
-
-static void sb1___flush_cache_all(void)
-{
-	smp_call_function(sb1___flush_cache_all_ipi, 0, 1, 1);
-	local_sb1___flush_cache_all();
-}
-#else
-extern void sb1___flush_cache_all(void);
-asm("sb1___flush_cache_all =3D local_sb1___flush_cache_all");
-#endif
-
-
 /*
  * When flushing a range in the icache, we have to first writeback
  * the dcache for the same range, so new ifetches will see any
@@ -216,33 +150,129 @@
 }
=20
 #ifdef CONFIG_SMP
-struct flush_icache_range_args {
+
+struct flush_cache_range_args {
 	unsigned long start;
 	unsigned long end;
 };
=20
 static void sb1_flush_icache_range_ipi(void *info)
 {
-	struct flush_icache_range_args *args =3D info;
+	struct flush_cache_range_args *args =3D info;
=20
 	local_sb1_flush_icache_range(args->start, args->end);
 }
=20
-void sb1_flush_icache_range(unsigned long start, unsigned long end)
+void smp_sb1_flush_icache_range(unsigned long start, unsigned long end)
 {
-	struct flush_icache_range_args args;
+	struct flush_cache_range_args args;
=20
 	args.start =3D start;
 	args.end =3D end;
 	smp_call_function(sb1_flush_icache_range_ipi, &args, 1, 1);
 	local_sb1_flush_icache_range(start, end);
 }
-#else
-void sb1_flush_icache_range(unsigned long start, unsigned long end);
-asm("sb1_flush_icache_range =3D local_sb1_flush_icache_range");
 #endif
=20
 /*
+ * Writeback and invalidate a range of addresses.
+ */
+static void local_sb1_writeback_inv_dcache_range(unsigned long start, unsi=
gned long end)
+{
+#ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
+	unsigned long flags;
+	local_irq_save(flags);
+#endif
+
+	__asm__ __volatile__ (
+		".set push                  \n"
+		".set noreorder             \n"
+		".set noat                  \n"
+		".set mips4                 \n"
+		"     move   $1, %0         \n"=20
+		"1:                         \n"
+#ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
+		".align 3                   \n"
+		"     lw     $0,   0($1)    \n" /* Bug 1370, 1368            */
+		"     sync                  \n"
+#endif
+		"     cache  %3, 0($1)      \n" /* Hit-WB{,-inval} this address */
+		"     bne    $1, %1, 1b     \n" /* loop test */
+		"      addu  $1, $1, %2     \n" /* next line */
+		"     sync                  \n"
+		".set pop                   \n"
+		:
+		: "r" (start  & ~(dcache_line_size - 1)),
+		  "r" ((end - 1) & ~(dcache_line_size - 1)),
+		  "r" (dcache_line_size),
+		  "i" (Hit_Writeback_Inv_D)
+		);
+#ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
+	local_irq_restore(flags);
+#endif
+}
+
+
+#ifdef CONFIG_SMP
+
+static void sb1_writeback_inv_dcache_range_ipi(void *info)
+{
+	struct flush_cache_range_args *args =3D info;
+
+	local_sb1_writeback_inv_dcache_range(args->start, args->end);
+}
+
+void smp_sb1_writeback_inv_dcache_range(unsigned long start, unsigned long=
 end)
+{
+	struct flush_cache_range_args args;
+
+	args.start =3D start;
+	args.end =3D end;
+	smp_call_function(sb1_writeback_inv_dcache_range_ipi, &args, 1, 1);
+	local_sb1_flush_icache_range(start, end);
+}
+
+#endif
+
+/*
+ * Writeback and invalidate the entire dcache
+ */
+static void local_sb1_writeback_inv_dcache_all(void)
+{
+	/*
+	 * Register usage:
+	 *=20
+	 * $1 - moving cache index
+	 * $2 - set count
+	 */
+	__asm__ __volatile__ (
+		".set push                  \n"
+		".set noreorder             \n"
+		".set noat                  \n"
+		".set mips4                 \n"
+		"     move   $1, %2         \n" /* Start at index 0 */
+		"1:   cache  %3, 0($1)      \n" /* Invalidate this index */
+		"     addiu  %1, %1, -1     \n" /* Decrement loop count */
+		"     bnez   %1, 1b         \n" /* loop test */
+		"      addu   $1, $1, %0    \n" /* Next address */
+		".set pop                   \n"
+		:
+		: "r" (dcache_line_size), "r" (dcache_sets * dcache_assoc),
+		  "r" (KSEG0), "i" (Index_Writeback_Inv_D));
+}
+
+
+#ifdef CONFIG_SMP
+
+void smp_sb1_writeback_inv_dcache_all(void)
+{
+	smp_call_function((void (*)(void *))local_sb1_writeback_inv_dcache_all, 0=
, 1, 1);
+	local_sb1_writeback_inv_dcache_all();
+}
+
+#endif
+
+/*
  * If there's no context yet, or the page isn't executable, no icache flus=
h
  * is needed
  */
@@ -257,7 +287,7 @@
 	 * conservatively flush the entire caches on all processors
 	 * (ouch).
 	 */
-	sb1___flush_cache_all();
+	flush_icache_all();
 }
=20
 static inline void protected_flush_icache_line(unsigned long addr)
@@ -345,7 +375,7 @@
 	protected_flush_icache_line(iaddr);
 }
=20
-static void sb1_flush_cache_sigtramp(unsigned long addr)
+static void smp_sb1_flush_cache_sigtramp(unsigned long addr)
 {
 	unsigned long tmp;
=20
@@ -359,10 +389,6 @@
=20
 	smp_call_function(sb1_flush_cache_sigtramp_ipi, (void *) addr, 1, 1);
 }
-
-#else
-void sb1_flush_cache_sigtramp(unsigned long addr);
-asm("sb1_flush_cache_sigtramp =3D local_sb1_flush_cache_sigtramp");
 #endif
=20
 static void sb1_flush_icache_all(void)
@@ -506,17 +532,26 @@
 	_copy_page =3D sb1_copy_page;
=20
 	_flush_cache_all =3D sb1_flush_cache_all;
-	___flush_cache_all =3D sb1___flush_cache_all;
 	_flush_cache_mm =3D (void (*)(struct mm_struct *))sb1_nop;
 	_flush_cache_range =3D (void *) sb1_nop;
 	_flush_page_to_ram =3D sb1_flush_page_to_ram;
 	_flush_icache_page =3D sb1_flush_icache_page;
-	_flush_icache_range =3D sb1_flush_icache_range;
+
+#ifdef CONFIG_SMP
+	_writeback_inv_dcache_range =3D smp_sb1_writeback_inv_dcache_range;
+	_writeback_inv_dcache_all   =3D smp_sb1_writeback_inv_dcache_all;
+	_flush_icache_range         =3D smp_sb1_flush_icache_range;
+	_flush_cache_sigtramp       =3D smp_sb1_flush_cache_sigtramp;
+#else
+	_writeback_inv_dcache_range =3D local_sb1_writeback_inv_dcache_range;
+	_writeback_inv_dcache_all   =3D local_sb1_writeback_inv_dcache_all;
+	_flush_icache_range         =3D local_sb1_flush_icache_range;
+	_flush_cache_sigtramp       =3D local_sb1_flush_cache_sigtramp;=09
+#endif
=20
 	/* None of these are needed for the sb1 */
 	_flush_cache_page =3D (void *) sb1_nop;
=20
-	_flush_cache_sigtramp =3D sb1_flush_cache_sigtramp;
 	_flush_icache_all =3D sb1_flush_icache_all;
=20
 	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_COW);
Index: arch/mips/mm/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/mm/init.c,v
retrieving revision 1.43
diff -u -r1.43 init.c
--- arch/mips/mm/init.c	2002/03/15 03:14:31	1.43
+++ arch/mips/mm/init.c	2002/05/30 19:13:10
@@ -37,6 +37,7 @@
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/tlb.h>
+#include <asm/uaccess.h>
=20
 mmu_gather_t mmu_gathers[NR_CPUS];
 unsigned long highstart_pfn, highend_pfn;
@@ -48,8 +49,21 @@
=20
 asmlinkage int sys_cacheflush(void *addr, int bytes, int cache)
 {
-	/* This should flush more selectivly ...  */
-	__flush_cache_all();
+	if (cache & ~(ICACHE | DCACHE)) {
+		return -EINVAL;
+	}
+=09
+	if (verify_area(VERIFY_READ, addr, bytes)) {
+		return -EFAULT;
+	}
+
+	if (cache & DCACHE) {
+		writeback_inv_dcache_range((unsigned long)addr, (unsigned long)addr + by=
tes);
+	}=20
+
+	if (cache & ICACHE) {
+		flush_icache_range((unsigned long)addr, ((unsigned long)addr) + bytes);
+	}
=20
 	return 0;
 }
Index: arch/mips/mm/loadmmu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/mm/loadmmu.c,v
retrieving revision 1.45
diff -u -r1.45 loadmmu.c
--- arch/mips/mm/loadmmu.c	2001/11/29 04:47:24	1.45
+++ arch/mips/mm/loadmmu.c	2002/05/30 19:13:10
@@ -24,7 +24,6 @@
=20
 /* Cache operations. */
 void (*_flush_cache_all)(void);
-void (*___flush_cache_all)(void);
 void (*_flush_cache_mm)(struct mm_struct *mm);
 void (*_flush_cache_range)(struct mm_struct *mm, unsigned long start,
 			  unsigned long end);
@@ -35,6 +34,8 @@
=20
 void (*_flush_page_to_ram)(struct page * page);
 void (*_flush_icache_all)(void);
+void (*_writeback_inv_dcache_range)(unsigned long start, unsigned long end=
);
+void (*_writeback_inv_dcache_all)  (void);
=20
 #ifdef CONFIG_NONCOHERENT_IO
=20
Index: include/asm-mips/pgtable.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/include/asm-mips/pgtable.h,v
retrieving revision 1.74
diff -u -r1.74 pgtable.h
--- include/asm-mips/pgtable.h	2002/05/28 09:58:58	1.74
+++ include/asm-mips/pgtable.h	2002/05/30 19:13:22
@@ -17,49 +17,70 @@
 #include <asm/cachectl.h>
 #include <asm/fixmap.h>
=20
-/* Cache flushing:
+/* Generic cache flushing.  See Documentation/cachetlb for more specific d=
etails
  *
- *  - flush_cache_all() flushes entire cache
- *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
- *  - flush_cache_page(mm, vmaddr) flushes a single page
- *  - flush_cache_range(mm, start, end) flushes a range of pages
- *  - flush_page_to_ram(page) write back kernel page to ram
- *  - flush_icache_range(start, end) flush a range of instructions
+ * Note that none of these routines check access permissions.  Any needed
+ * checking should be done by the caller.
  *
- *  - flush_cache_sigtramp() flush signal trampoline
- *  - flush_icache_all() flush the entire instruction cache
+ *  - flush_cache_all      Writeback & inval all virtually mapped cached d=
ata
+ *                           & ensure all writes are visible to the system=
.
+ *  - flush_cache_mm       Same as above, but only for a specific mm conte=
xt
+ *  - flush_cache_page     Same as above, but for a single page
+ *  - flush_cache_range    Same as above, for a range of addresses
+ *  - flush_page_to_ram    Clear all virtual mappings of this physical pag=
e
+ *  - flush_icache_range   An istream modification may have occurred; ensu=
re=20
+ *                           that all data stores before this point are vi=
sible=20
+ *                           for new instruction fetches for the given ran=
ge.
+ *  - flush_icache_page    Same as above, but for a specific page
  */
-extern void (*_flush_cache_all)(void);
-extern void (*___flush_cache_all)(void);
-extern void (*_flush_cache_mm)(struct mm_struct *mm);
-extern void (*_flush_cache_range)(struct mm_struct *mm, unsigned long star=
t,
-				 unsigned long end);
-extern void (*_flush_cache_page)(struct vm_area_struct *vma, unsigned long=
 page);
-extern void (*_flush_page_to_ram)(struct page * page);
+
+/*
+ * Mips-specific cache flushing. =20
+ *  - flush_icache_all           Same as flush_icache_range, for all memor=
y=20
+ *  - writeback_inv_dcache_all   Force writeback and invalidation of the f=
irst
+ *                               level dcache.
+ *  - writeback_inv_dcache_range Same as above, but for a specific virtual=
 range
+ *  - flush_cache_sigtramp       Flush signal trampoline
+ */
+
+extern void (*_flush_cache_all)   (void);
+extern void (*_flush_cache_mm)    (struct mm_struct *mm);
+extern void (*_flush_cache_page)  (struct vm_area_struct *vma,=20
+				   unsigned long page);
+extern void (*_flush_cache_range) (struct mm_struct *mm, unsigned long sta=
rt,
+				   unsigned long end);
+extern void (*_flush_page_to_ram) (struct page * page);
 extern void (*_flush_icache_range)(unsigned long start, unsigned long end)=
;
-extern void (*_flush_icache_page)(struct vm_area_struct *vma,
-                                  struct page *page);
-extern void (*_flush_cache_sigtramp)(unsigned long addr);
-extern void (*_flush_icache_all)(void);
+extern void (*_flush_icache_page) (struct vm_area_struct *vma,
+				   struct page *page);
+
+extern void (*_flush_icache_all)          (void);
+extern void (*_writeback_inv_dcache_all)  (void);
+extern void (*_writeback_inv_dcache_range)(unsigned long start,=20
+					   unsigned long end);
+extern void (*_flush_cache_sigtramp)      (unsigned long addr);
+
=20
 #define flush_dcache_page(page)			do { } while (0)
=20
 #define flush_cache_all()		_flush_cache_all()
-#define __flush_cache_all()		___flush_cache_all()
 #define flush_cache_mm(mm)		_flush_cache_mm(mm)
-#define flush_cache_range(mm,start,end)	_flush_cache_range(mm,start,end)
 #define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
+#define flush_cache_range(mm,start,end)	_flush_cache_range(mm,start,end)
 #define flush_page_to_ram(page)		_flush_page_to_ram(page)
-
 #define flush_icache_range(start, end)	_flush_icache_range(start,end)
 #define flush_icache_page(vma, page) 	_flush_icache_page(vma, page)
+
+
=20
-#define flush_cache_sigtramp(addr)	_flush_cache_sigtramp(addr)
 #ifdef CONFIG_VTAG_ICACHE
-#define flush_icache_all()		_flush_icache_all()
+#define flush_icache_all()	    	       _flush_icache_all()
 #else
-#define flush_icache_all()		do { } while(0)
+#define flush_icache_all()		       do { } while(0)
 #endif
+#define writeback_inv_dcache_all()             _writeback_inv_dcache_all()
+#define writeback_inv_dcache_range(start, end) _writeback_inv_dcache_range=
(start, end)
+#define flush_cache_sigtramp(addr)	       _flush_cache_sigtramp(addr)
=20
 /*
  * - add_wired_entry() add a fixed TLB entry, and move wired register

--=-OIpXZaCsihiMHNAFriFG--
