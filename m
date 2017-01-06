Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:36:39 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46373 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992986AbdAFBdkt1jDu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3882A604A4693;
        Fri,  6 Jan 2017 01:33:31 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:31 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <kvm@vger.kernel.org>
Subject: [PATCH 4/30] MIPS: Export some tlbex internals for KVM to use
Date:   Fri, 6 Jan 2017 01:32:36 +0000
Message-ID: <3007c32a817fa8ab6f1b20069d595d5f853c3545.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56181
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

Export to TLB exception code generating functions so that KVM can
construct a fast TLB refill handler for guest context without
reinventing the wheel quite so much.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/tlbex.h | 26 ++++++++++++++++++++++++++
 arch/mips/mm/tlbex.c          | 33 ++++++++++++++++-----------------
 2 files changed, 42 insertions(+), 17 deletions(-)
 create mode 100644 arch/mips/include/asm/tlbex.h

diff --git a/arch/mips/include/asm/tlbex.h b/arch/mips/include/asm/tlbex.h
new file mode 100644
index 000000000000..53050e9dd2c9
--- /dev/null
+++ b/arch/mips/include/asm/tlbex.h
@@ -0,0 +1,26 @@
+#ifndef __ASM_TLBEX_H
+#define __ASM_TLBEX_H
+
+#include <asm/uasm.h>
+
+/*
+ * Write random or indexed TLB entry, and care about the hazards from
+ * the preceding mtc0 and for the following eret.
+ */
+enum tlb_write_entry {
+	tlb_random,
+	tlb_indexed
+};
+
+extern int pgd_reg;
+
+void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
+		      unsigned int tmp, unsigned int ptr);
+void build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr);
+void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr);
+void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep);
+void build_tlb_write_entry(u32 **p, struct uasm_label **l,
+			   struct uasm_reloc **r,
+			   enum tlb_write_entry wmode);
+
+#endif /* __ASM_TLBEX_H */
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index dc7bb1506103..2465f83c79c3 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -35,6 +35,7 @@
 #include <asm/war.h>
 #include <asm/uasm.h>
 #include <asm/setup.h>
+#include <asm/tlbex.h>
 
 static int mips_xpa_disabled;
 
@@ -345,7 +346,8 @@ static int allocate_kscratch(void)
 }
 
 static int scratch_reg;
-static int pgd_reg;
+int pgd_reg;
+EXPORT_SYMBOL_GPL(pgd_reg);
 enum vmalloc64_mode {not_refill, refill_scratch, refill_noscratch};
 
 static struct work_registers build_get_work_registers(u32 **p)
@@ -497,15 +499,9 @@ static void __maybe_unused build_tlb_probe_entry(u32 **p)
 	}
 }
 
-/*
- * Write random or indexed TLB entry, and care about the hazards from
- * the preceding mtc0 and for the following eret.
- */
-enum tlb_write_entry { tlb_random, tlb_indexed };
-
-static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
-				  struct uasm_reloc **r,
-				  enum tlb_write_entry wmode)
+void build_tlb_write_entry(u32 **p, struct uasm_label **l,
+			   struct uasm_reloc **r,
+			   enum tlb_write_entry wmode)
 {
 	void(*tlbw)(u32 **) = NULL;
 
@@ -628,6 +624,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		break;
 	}
 }
+EXPORT_SYMBOL_GPL(build_tlb_write_entry);
 
 static __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 							unsigned int reg)
@@ -782,9 +779,8 @@ static void build_huge_handler_tail(u32 **p, struct uasm_reloc **r,
  * TMP and PTR are scratch.
  * TMP will be clobbered, PTR will hold the pmd entry.
  */
-static void
-build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
-		 unsigned int tmp, unsigned int ptr)
+void build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
+		      unsigned int tmp, unsigned int ptr)
 {
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 	long pgdc = (long)pgd_current;
@@ -860,6 +856,7 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pmd offset */
 #endif
 }
+EXPORT_SYMBOL_GPL(build_get_pmde64);
 
 /*
  * BVADDR is the faulting address, PTR is scratch.
@@ -935,8 +932,7 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
  * TMP and PTR are scratch.
  * TMP will be clobbered, PTR will hold the pgd entry.
  */
-static void __maybe_unused
-build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
+void build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 {
 	if (pgd_reg != -1) {
 		/* pgd is in pgd_reg */
@@ -961,6 +957,7 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
 	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
 }
+EXPORT_SYMBOL_GPL(build_get_pgde32);
 
 #endif /* !CONFIG_64BIT */
 
@@ -990,7 +987,7 @@ static void build_adjust_context(u32 **p, unsigned int ctx)
 	uasm_i_andi(p, ctx, ctx, mask);
 }
 
-static void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
+void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 {
 	/*
 	 * Bug workaround for the Nevada. It seems as if under certain
@@ -1014,8 +1011,9 @@ static void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 	build_adjust_context(p, tmp);
 	UASM_i_ADDU(p, ptr, ptr, tmp); /* add in offset */
 }
+EXPORT_SYMBOL_GPL(build_get_ptep);
 
-static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
+void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 {
 	int pte_off_even = 0;
 	int pte_off_odd = sizeof(pte_t);
@@ -1064,6 +1062,7 @@ static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 		UASM_i_MTC0(p, 0, C0_ENTRYLO1);
 	UASM_i_MTC0(p, ptep, C0_ENTRYLO1); /* load it */
 }
+EXPORT_SYMBOL_GPL(build_update_entries);
 
 struct mips_huge_tlb_info {
 	int huge_pte;
-- 
git-series 0.8.10
