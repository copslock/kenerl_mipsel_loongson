Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:17:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25145 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992551AbcGMNNqQra9h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DB573865796D1;
        Wed, 13 Jul 2016 14:13:26 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:29 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 08/13] MIPS: c-r4k: Fix valid ASID optimisation
Date:   Wed, 13 Jul 2016 14:12:51 +0100
Message-ID: <1468415576-12600-9-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54319
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

Several cache operations are optimised to return early from the SMP call
handler if the memory map in question has no valid ASID on the current
CPU, or any online CPU in the case of MIPS_MT_SMP. The idea is that if a
memory map has never been used on a CPU it shouldn't have cache lines in
need of flushing.

However this doesn't cover all cases when ASIDs for other CPUs need to
be checked:
- Offline VPEs may have recently been online and brought lines into the
  (shared) cache, so they should also be checked, rather than only
  online CPUs.
- SMP systems with a Coherence Manager (CM), but with MT disabled still
  have globalized hit cache ops, but don't use SMP calls, so all present
  CPUs should be taken into account.
- R6 systems have a different multithreading implementation, so
  MIPS_MT_SMP won't be set, but as above may still have a CM which
  globalizes hit cache ops.

Additionally for non-globalized cache operations where an SMP call to a
single VPE in each foreign core is used, it is not necessary to check
every CPU in the system, only sibling CPUs sharing the same first level
cache.

Fix this by making has_valid_asid() take a cache op type argument like
r4k_on_each_cpu(), so it can determine whether r4k_on_each_cpu() will
have done SMP calls to other cores. It can then determine which set of
CPUs to check the ASIDs of based on that, excluding foreign CPUs if an
SMP call will have been performed.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 412052321472..2a4bb5057ebc 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -488,19 +488,41 @@ static void r4k___flush_cache_all(void)
 	r4k_on_each_cpu(R4K_INDEX, local_r4k___flush_cache_all, NULL);
 }
 
-static inline int has_valid_asid(const struct mm_struct *mm)
+/**
+ * has_valid_asid() - Determine if an mm already has an ASID.
+ * @mm:		Memory map.
+ * @type:	R4K_HIT or R4K_INDEX, type of cache op.
+ *
+ * Determines whether @mm already has an ASID on any of the CPUs which cache ops
+ * of type @type within an r4k_on_each_cpu() call will affect. If
+ * r4k_on_each_cpu() does an SMP call to a single VPE in each core, then the
+ * scope of the operation is confined to sibling CPUs, otherwise all online CPUs
+ * will need to be checked.
+ *
+ * Must be called in non-preemptive context.
+ *
+ * Returns:	1 if the CPUs affected by @type cache ops have an ASID for @mm.
+ *		0 otherwise.
+ */
+static inline int has_valid_asid(const struct mm_struct *mm, unsigned int type)
 {
-#ifdef CONFIG_MIPS_MT_SMP
-	int i;
+	unsigned int i;
+	const cpumask_t *mask = cpu_present_mask;
 
-	for_each_online_cpu(i)
+	/* cpu_sibling_map[] undeclared when !CONFIG_SMP */
+#ifdef CONFIG_SMP
+	/*
+	 * If r4k_on_each_cpu does SMP calls, it does them to a single VPE in
+	 * each foreign core, so we only need to worry about siblings.
+	 * Otherwise we need to worry about all present CPUs.
+	 */
+	if (r4k_op_needs_ipi(type))
+		mask = &cpu_sibling_map[smp_processor_id()];
+#endif
+	for_each_cpu(i, mask)
 		if (cpu_context(i, mm))
 			return 1;
-
 	return 0;
-#else
-	return cpu_context(smp_processor_id(), mm);
-#endif
 }
 
 static void r4k__flush_cache_vmap(void)
@@ -522,7 +544,7 @@ static inline void local_r4k_flush_cache_range(void * args)
 	struct vm_area_struct *vma = args;
 	int exec = vma->vm_flags & VM_EXEC;
 
-	if (!(has_valid_asid(vma->vm_mm)))
+	if (!has_valid_asid(vma->vm_mm, R4K_INDEX))
 		return;
 
 	/*
@@ -550,7 +572,7 @@ static inline void local_r4k_flush_cache_mm(void * args)
 {
 	struct mm_struct *mm = args;
 
-	if (!has_valid_asid(mm))
+	if (!has_valid_asid(mm, R4K_INDEX))
 		return;
 
 	/*
@@ -600,10 +622,10 @@ static inline void local_r4k_flush_cache_page(void *args)
 	void *vaddr;
 
 	/*
-	 * If ownes no valid ASID yet, cannot possibly have gotten
+	 * If owns no valid ASID yet, cannot possibly have gotten
 	 * this page into the cache.
 	 */
-	if (!has_valid_asid(mm))
+	if (!has_valid_asid(mm, R4K_HIT))
 		return;
 
 	addr &= PAGE_MASK;
@@ -851,7 +873,7 @@ static void local_r4k_flush_cache_sigtramp(void *args)
 	 * If owns no valid ASID yet, cannot possibly have gotten
 	 * this page into the cache.
 	 */
-	if (!has_valid_asid(mm))
+	if (!has_valid_asid(mm, R4K_HIT))
 		return;
 
 	if (mm == current->active_mm) {
-- 
2.4.10
