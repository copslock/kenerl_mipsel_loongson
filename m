Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:13:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58267 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992551AbcGMNNT3I8Nh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:19 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 02B95381E7743;
        Wed, 13 Jul 2016 14:13:10 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 01/13] MIPS: SMP: Clear ASID without confusing has_valid_asid()
Date:   Wed, 13 Jul 2016 14:12:44 +0100
Message-ID: <1468415576-12600-2-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54309
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

The SMP flush_tlb_*() functions may clear the memory map's ASIDs for
other CPUs if the mm has only a single user (the current CPU) in order
to avoid SMP calls. However this makes it appear to has_valid_asid(),
which is used by various cache flush functions, as if the CPUs have
never run in the mm, and therefore can't have cached any of its memory.

For flush_tlb_mm() this doesn't sound unreasonable.

flush_tlb_range() corresponds to flush_cache_range() which does do full
indexed cache flushes, but only on the icache if the specified mapping
is executable, otherwise it doesn't guarantee that there are no cache
contents left for the mm.

flush_tlb_page() corresponds to flush_cache_page(), which will perform
address based cache ops on the specified page only, and also only
touches the icache if the page is executable. It does not guarantee that
there are no cache contents left for the mm.

For example, this affects flush_cache_range() which uses the
has_valid_asid() optimisation. It is required to flush the icache when
mappings are made executable (e.g. using mprotect) so they are
immediately usable. If some code is changed to non executable in order
to be modified then it will not be flushed from the icache during that
time, but the ASID on other CPUs may still be cleared for TLB flushing.
When the code is changed back to executable, flush_cache_range() will
assume the code hasn't run on those other CPUs due to the zero ASID, and
won't invalidate the icache on them.

This is fixed by clearing the other CPUs ASIDs to 1 instead of 0 for the
above two flush_tlb_*() functions when the corresponding cache flushes
are likely to be incomplete (non executable range flush, or any page
flush). This ASID appears valid to has_valid_asid(), but still triggers
ASID regeneration due to the upper ASID version bits being 0, which is
less than the minimum ASID version of 1 and so always treated as stale.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/smp.c | 17 +++++++++++++++--
 arch/mips/mm/c-r4k.c   |  4 ++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f9d01e953acb..0c98b4a313be 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -512,10 +512,17 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned l
 		smp_on_other_tlbs(flush_tlb_range_ipi, &fd);
 	} else {
 		unsigned int cpu;
+		int exec = vma->vm_flags & VM_EXEC;
 
 		for_each_online_cpu(cpu) {
+			/*
+			 * flush_cache_range() will only fully flush icache if
+			 * the VMA is executable, otherwise we must invalidate
+			 * ASID without it appearing to has_valid_asid() as if
+			 * mm has been completely unused by that CPU.
+			 */
 			if (cpu != smp_processor_id() && cpu_context(cpu, mm))
-				cpu_context(cpu, mm) = 0;
+				cpu_context(cpu, mm) = !exec;
 		}
 	}
 	local_flush_tlb_range(vma, start, end);
@@ -560,8 +567,14 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 		unsigned int cpu;
 
 		for_each_online_cpu(cpu) {
+			/*
+			 * flush_cache_page() only does partial flushes, so
+			 * invalidate ASID without it appearing to
+			 * has_valid_asid() as if mm has been completely unused
+			 * by that CPU.
+			 */
 			if (cpu != smp_processor_id() && cpu_context(cpu, vma->vm_mm))
-				cpu_context(cpu, vma->vm_mm) = 0;
+				cpu_context(cpu, vma->vm_mm) = 1;
 		}
 	}
 	local_flush_tlb_page(vma, page);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 645c69c95c9c..9204d4e4f02f 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -484,6 +484,10 @@ static void r4k__flush_cache_vunmap(void)
 	r4k_blast_dcache();
 }
 
+/*
+ * Note: flush_tlb_range() assumes flush_cache_range() sufficiently flushes
+ * whole caches when vma is executable.
+ */
 static inline void local_r4k_flush_cache_range(void * args)
 {
 	struct vm_area_struct *vma = args;
-- 
2.4.10
