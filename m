Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:14:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20075 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992916AbcGMNNebddxh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 06448B80E1A97;
        Wed, 13 Jul 2016 14:13:24 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:26 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 07/13] MIPS: c-r4k: Add r4k_on_each_cpu cache op type arg
Date:   Wed, 13 Jul 2016 14:12:50 +0100
Message-ID: <1468415576-12600-8-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
References: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The r4k_on_each_cpu() function calls the specified cache flush helper on
other CPUs if deemed necessary due to the cache ops not being
globalized by hardware. However this really depends on the cache op
addressing type, as the MIPS Coherence Manager (CM) if present will
globalize "hit" cache ops (addressed by virtual address), but not
"index" cache ops (addressed by cache index). This results in index
cache ops only being performed on a single CPU when CM is present.

Most (but not all) of the functions called by r4k_on_each_cpu() perform
cache operations exclusively with a single cache op type, so add a type
argument and modify the callers to pass in some combination of R4K_HIT
(global kernel virtual addressing or user virtual addressing
conditional upon matching active_mm) and R4K_INDEX (index into cache).

This will allow r4k_on_each_cpu() to later distinguish these cases and
decide whether to perform an SMP call based on it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 70 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 58b810e67bba..412052321472 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -40,6 +40,43 @@
 #include <asm/mips-cm.h>
 
 /*
+ * Bits describing what cache ops an SMP callback function may perform.
+ *
+ * R4K_HIT   -	Virtual user or kernel address based cache operations. The
+ *		active_mm must be checked before using user addresses, falling
+ *		back to kmap.
+ * R4K_INDEX -	Index based cache operations.
+ */
+
+#define R4K_HIT		BIT(0)
+#define R4K_INDEX	BIT(1)
+
+/**
+ * r4k_op_needs_ipi() - Decide if a cache op needs to be done on every core.
+ * @type:	Type of cache operations (R4K_HIT or R4K_INDEX).
+ *
+ * Decides whether a cache op needs to be performed on every core in the system.
+ * This may change depending on the @type of cache operation.
+ *
+ * Returns:	1 if the cache operation @type should be done on every core in
+ *		the system.
+ *		0 if the cache operation @type is globalized and only needs to
+ *		be performed on a simple CPU.
+ */
+static inline bool r4k_op_needs_ipi(unsigned int type)
+{
+	/* The MIPS Coherence Manager (CM) globalizes address-based cache ops */
+	if (mips_cm_present())
+		return false;
+
+	/*
+	 * Hardware doesn't globalize the required cache ops, so SMP calls may
+	 * be needed.
+	 */
+	return true;
+}
+
+/*
  * Special Variant of smp_call_function for use by cache functions:
  *
  *  o No return value
@@ -48,19 +85,11 @@
  *    primary cache.
  *  o doesn't disable interrupts on the local CPU
  */
-static inline void r4k_on_each_cpu(void (*func) (void *info), void *info)
+static inline void r4k_on_each_cpu(unsigned int type,
+				   void (*func)(void *info), void *info)
 {
 	preempt_disable();
-
-	/*
-	 * The Coherent Manager propagates address-based cache ops to other
-	 * cores but not index-based ops. However, r4k_on_each_cpu is used
-	 * in both cases so there is no easy way to tell what kind of op is
-	 * executed to the other cores. The best we can probably do is
-	 * to restrict that call when a CM is not present because both
-	 * CM-based SMP protocols (CMP & CPS) restrict index-based cache ops.
-	 */
-	if (!mips_cm_present())
+	if (r4k_op_needs_ipi(type))
 		smp_call_function_many(&cpu_foreign_map, func, info, 1);
 	func(info);
 	preempt_enable();
@@ -456,7 +485,7 @@ static inline void local_r4k___flush_cache_all(void * args)
 
 static void r4k___flush_cache_all(void)
 {
-	r4k_on_each_cpu(local_r4k___flush_cache_all, NULL);
+	r4k_on_each_cpu(R4K_INDEX, local_r4k___flush_cache_all, NULL);
 }
 
 static inline int has_valid_asid(const struct mm_struct *mm)
@@ -514,7 +543,7 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
 	int exec = vma->vm_flags & VM_EXEC;
 
 	if (cpu_has_dc_aliases || exec)
-		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
+		r4k_on_each_cpu(R4K_INDEX, local_r4k_flush_cache_range, vma);
 }
 
 static inline void local_r4k_flush_cache_mm(void * args)
@@ -546,7 +575,7 @@ static void r4k_flush_cache_mm(struct mm_struct *mm)
 	if (!cpu_has_dc_aliases)
 		return;
 
-	r4k_on_each_cpu(local_r4k_flush_cache_mm, mm);
+	r4k_on_each_cpu(R4K_INDEX, local_r4k_flush_cache_mm, mm);
 }
 
 struct flush_cache_page_args {
@@ -641,7 +670,7 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
 	args.addr = addr;
 	args.pfn = pfn;
 
-	r4k_on_each_cpu(local_r4k_flush_cache_page, &args);
+	r4k_on_each_cpu(R4K_HIT, local_r4k_flush_cache_page, &args);
 }
 
 static inline void local_r4k_flush_data_cache_page(void * addr)
@@ -654,7 +683,8 @@ static void r4k_flush_data_cache_page(unsigned long addr)
 	if (in_atomic())
 		local_r4k_flush_data_cache_page((void *)addr);
 	else
-		r4k_on_each_cpu(local_r4k_flush_data_cache_page, (void *) addr);
+		r4k_on_each_cpu(R4K_HIT, local_r4k_flush_data_cache_page,
+				(void *) addr);
 }
 
 struct flush_icache_range_args {
@@ -715,7 +745,8 @@ static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 	args.start = start;
 	args.end = end;
 
-	r4k_on_each_cpu(local_r4k_flush_icache_range_ipi, &args);
+	r4k_on_each_cpu(R4K_HIT | R4K_INDEX, local_r4k_flush_icache_range_ipi,
+			&args);
 	instruction_hazard();
 }
 
@@ -898,7 +929,7 @@ static void r4k_flush_cache_sigtramp(unsigned long addr)
 	args.mm = current->mm;
 	args.addr = addr;
 
-	r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, &args);
+	r4k_on_each_cpu(R4K_HIT, local_r4k_flush_cache_sigtramp, &args);
 
 	put_page(args.page);
 out:
@@ -941,7 +972,8 @@ static void r4k_flush_kernel_vmap_range(unsigned long vaddr, int size)
 	args.vaddr = (unsigned long) vaddr;
 	args.size = size;
 
-	r4k_on_each_cpu(local_r4k_flush_kernel_vmap_range, &args);
+	r4k_on_each_cpu(R4K_HIT | R4K_INDEX, local_r4k_flush_kernel_vmap_range,
+			&args);
 }
 
 static inline void rm7k_erratum31(void)
-- 
2.4.10
