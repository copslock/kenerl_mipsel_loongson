Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2016 02:26:39 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25157 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992028AbcKLB0c2E8B5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2016 02:26:32 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 22E99DCE8A4F0;
        Sat, 12 Nov 2016 01:26:25 +0000 (GMT)
Received: from localhost (10.100.200.252) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 12 Nov
 2016 01:26:25 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Mask out limit field when calculating wired entry count
Date:   Sat, 12 Nov 2016 01:26:07 +0000
Message-ID: <20161112012607.15955-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.252]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Since MIPSr6 the Wired register is split into 2 fields, with the upper
16 bits of the register indicating a limit on the value that the wired
entry count in the bottom 16 bits of the register can take. This means
that simply reading the wired register doesn't get us a valid TLB entry
index any longer, and we instead need to retrieve only the lower 16 bits
of the register. Introduce a new num_wired_entries() function which does
this on MIPSr6 or higher and simply returns the value of the wired
register on older architecture revisions, and make use of it when
reading the number of wired entries.

Since commit e710d6668309 ("MIPS: tlb-r4k: If there are wired entries,
don't use TLBINVF") we have been using a non-zero number of wired
entries to determine whether we should avoid use of the tlbinvf
instruction (which would invalidate wired entries) and instead loop over
TLB entries in local_flush_tlb_all(). This loop begins with the number
of wired entries, or before this patch some large bogus TLB index on
MIPSr6 systems. Thus since the aforementioned commit some MIPSr6 systems
with FTLBs have been prone to leaving stale address translations in the
FTLB & crashing in various weird & wonderful ways when we later observe
the wrong memory.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Ralf: We could use this one in v4.9 presuming you're OK with it, as it
      breaks MIPSr6 systems pretty badly. Please merge ASAP.
---
 arch/mips/include/asm/mipsregs.h |  6 ++++++
 arch/mips/include/asm/tlb.h      | 13 +++++++++++++
 arch/mips/mm/init.c              |  4 ++--
 arch/mips/mm/tlb-r4k.c           |  6 +++---
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 7dd2dd4..df78b2c 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -215,6 +215,12 @@
 #endif
 
 /*
+ * Wired register bits
+ */
+#define MIPSR6_WIRED_LIMIT	(_ULCAST_(0xffff) << 16)
+#define MIPSR6_WIRED_WIRED	(_ULCAST_(0xffff) << 0)
+
+/*
  * Values used for computation of new tlb entries
  */
 #define PL_4K		12
diff --git a/arch/mips/include/asm/tlb.h b/arch/mips/include/asm/tlb.h
index 4a23493..dd179fd 100644
--- a/arch/mips/include/asm/tlb.h
+++ b/arch/mips/include/asm/tlb.h
@@ -1,6 +1,9 @@
 #ifndef __ASM_TLB_H
 #define __ASM_TLB_H
 
+#include <asm/cpu-features.h>
+#include <asm/mipsregs.h>
+
 /*
  * MIPS doesn't need any special per-pte or per-vma handling, except
  * we need to flush cache for area to be unmapped.
@@ -22,6 +25,16 @@
 		((CKSEG0 + ((idx) << (PAGE_SHIFT + 1))) |		\
 		 (cpu_has_tlbinv ? MIPS_ENTRYHI_EHINV : 0))
 
+static inline unsigned int num_wired_entries(void)
+{
+	unsigned int wired = read_c0_wired();
+
+	if (cpu_has_mips_r6)
+		wired &= MIPSR6_WIRED_WIRED;
+
+	return wired;
+}
+
 #include <asm-generic/tlb.h>
 
 #endif /* __ASM_TLB_H */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3a6edec..e86ebcf 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -118,7 +118,7 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 		writex_c0_entrylo1(entrylo);
 	}
 #endif
-	tlbidx = read_c0_wired();
+	tlbidx = num_wired_entries();
 	write_c0_wired(tlbidx + 1);
 	write_c0_index(tlbidx);
 	mtc0_tlbw_hazard();
@@ -147,7 +147,7 @@ void kunmap_coherent(void)
 
 	local_irq_save(flags);
 	old_ctx = read_c0_entryhi();
-	wired = read_c0_wired() - 1;
+	wired = num_wired_entries() - 1;
 	write_c0_wired(wired);
 	write_c0_index(wired);
 	write_c0_entryhi(UNIQUE_ENTRYHI(wired));
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index bba9c14..0596505 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -65,7 +65,7 @@ void local_flush_tlb_all(void)
 	write_c0_entrylo0(0);
 	write_c0_entrylo1(0);
 
-	entry = read_c0_wired();
+	entry = num_wired_entries();
 
 	/*
 	 * Blast 'em all away.
@@ -385,7 +385,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 	old_ctx = read_c0_entryhi();
 	htw_stop();
 	old_pagemask = read_c0_pagemask();
-	wired = read_c0_wired();
+	wired = num_wired_entries();
 	write_c0_wired(wired + 1);
 	write_c0_index(wired);
 	tlbw_use_hazard();	/* What is the hazard here? */
@@ -449,7 +449,7 @@ __init int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 	htw_stop();
 	old_ctx = read_c0_entryhi();
 	old_pagemask = read_c0_pagemask();
-	wired = read_c0_wired();
+	wired = num_wired_entries();
 	if (--temp_tlb_entry < wired) {
 		printk(KERN_WARNING
 		       "No TLB space left for add_temporary_entry\n");
-- 
2.10.2
