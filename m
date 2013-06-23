Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jun 2013 20:16:43 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1173 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816022Ab3FWSQgmgBE9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Jun 2013 20:16:36 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 23 Jun 2013 11:07:08 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 23 Jun 2013 11:16:21 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 23 Jun 2013 11:16:21 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id BE952F2D76; Sun, 23
 Jun 2013 11:16:19 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 1/3] MIPS: Move generated code to .text for microMIPS
Date:   Sun, 23 Jun 2013 23:46:19 +0530
Message-ID: <1372011381-18600-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372011381-18600-1-git-send-email-jchandra@broadcom.com>
References: <1372011381-18600-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DD9E6C62L837159477-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Prepare of a next patch which will call tlbmiss_handler_setup_pgd on
microMIPS. MicroMIPS complains if the called code s not in the .text
section. To fix this we generate code into space reserved in
arch/mips/mm/tlb-funcs.S

While there, move the rest of the generated functions (handle_tlbl,
handle_tlbs, handle_tlbm) to the same file.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mmu_context.h |    6 +--
 arch/mips/mm/Makefile               |    2 +-
 arch/mips/mm/tlb-funcs.S            |   37 +++++++++++++++
 arch/mips/mm/tlbex.c                |   84 ++++++++++++++++++-----------------
 4 files changed, 83 insertions(+), 46 deletions(-)
 create mode 100644 arch/mips/mm/tlb-funcs.S

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 516e6e9..3b29079 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -28,11 +28,7 @@
 
 #define TLBMISS_HANDLER_SETUP_PGD(pgd)					\
 do {									\
-	void (*tlbmiss_handler_setup_pgd)(unsigned long);		\
-	extern u32 tlbmiss_handler_setup_pgd_array[16];			\
-									\
-	tlbmiss_handler_setup_pgd =					\
-		(__typeof__(tlbmiss_handler_setup_pgd)) tlbmiss_handler_setup_pgd_array; \
+	extern void tlbmiss_handler_setup_pgd(unsigned long);		\
 	tlbmiss_handler_setup_pgd((unsigned long)(pgd));		\
 } while (0)
 
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index e87aae1..7f4f93a 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -4,7 +4,7 @@
 
 obj-y				+= cache.o dma-default.o extable.o fault.o \
 				   gup.o init.o mmap.o page.o page-funcs.o \
-				   tlbex.o tlbex-fault.o uasm-mips.o
+				   tlbex.o tlbex-fault.o tlb-funcs.o uasm-mips.o
 
 obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
diff --git a/arch/mips/mm/tlb-funcs.S b/arch/mips/mm/tlb-funcs.S
new file mode 100644
index 0000000..30a494d
--- /dev/null
+++ b/arch/mips/mm/tlb-funcs.S
@@ -0,0 +1,37 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Micro-assembler generated tlb handler functions.
+ *
+ * Copyright (C) 2013  Broadcom Corporation.
+ *
+ * Based on mm/page-funcs.c
+ * Copyright (C) 2012  MIPS Technologies, Inc.
+ * Copyright (C) 2012  Ralf Baechle <ralf@linux-mips.org>
+ */
+#include <asm/asm.h>
+#include <asm/regdef.h>
+
+#define FASTPATH_SIZE	128
+
+LEAF(tlbmiss_handler_setup_pgd)
+	.space		16 * 4
+END(tlbmiss_handler_setup_pgd)
+EXPORT(tlbmiss_handler_setup_pgd_end)
+
+LEAF(handle_tlbm)
+	.space		FASTPATH_SIZE * 4
+END(handle_tlbm)
+EXPORT(handle_tlbm_end)
+
+LEAF(handle_tlbs)
+	.space		FASTPATH_SIZE * 4
+END(handle_tlbs)
+EXPORT(handle_tlbs_end)
+
+LEAF(handle_tlbl)
+	.space		FASTPATH_SIZE * 4
+END(handle_tlbl)
+EXPORT(handle_tlbl_end)
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index f1eabe7..b5e9363 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1455,27 +1455,25 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	dump_handler("r4000_tlb_refill", (u32 *)ebase, 64);
 }
 
-/*
- * 128 instructions for the fastpath handler is generous and should
- * never be exceeded.
- */
-#define FASTPATH_SIZE 128
+extern u32 handle_tlbl[], handle_tlbl_end[];
+extern u32 handle_tlbs[], handle_tlbs_end[];
+extern u32 handle_tlbm[], handle_tlbm_end[];
 
-u32 handle_tlbl[FASTPATH_SIZE] __cacheline_aligned;
-u32 handle_tlbs[FASTPATH_SIZE] __cacheline_aligned;
-u32 handle_tlbm[FASTPATH_SIZE] __cacheline_aligned;
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-u32 tlbmiss_handler_setup_pgd_array[16] __cacheline_aligned;
+extern u32 tlbmiss_handler_setup_pgd[], tlbmiss_handler_setup_pgd_end[];
 
 static void __cpuinit build_r4000_setup_pgd(void)
 {
 	const int a0 = 4;
 	const int a1 = 5;
 	u32 *p = tlbmiss_handler_setup_pgd_array;
+	const int tlbmiss_handler_setup_pgd_size =
+		tlbmiss_handler_setup_pgd_end - tlbmiss_handler_setup_pgd;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 
-	memset(tlbmiss_handler_setup_pgd_array, 0, sizeof(tlbmiss_handler_setup_pgd_array));
+	memset(tlbmiss_handler_setup_pgd, 0, tlbmiss_handler_setup_pgd_size *
+					sizeof(tlbmiss_handler_setup_pgd[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
@@ -1503,15 +1501,15 @@ static void __cpuinit build_r4000_setup_pgd(void)
 		uasm_i_jr(&p, 31);
 		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
 	}
-	if (p - tlbmiss_handler_setup_pgd_array > ARRAY_SIZE(tlbmiss_handler_setup_pgd_array))
-		panic("tlbmiss_handler_setup_pgd_array space exceeded");
+	if (p >= tlbmiss_handler_setup_pgd_end)
+		panic("tlbmiss_handler_setup_pgd space exceeded");
+
 	uasm_resolve_relocs(relocs, labels);
-	pr_debug("Wrote tlbmiss_handler_setup_pgd_array (%u instructions).\n",
-		 (unsigned int)(p - tlbmiss_handler_setup_pgd_array));
+	pr_debug("Wrote tlbmiss_handler_setup_pgd (%u instructions).\n",
+		 (unsigned int)(p - tlbmiss_handler_setup_pgd));
 
-	dump_handler("tlbmiss_handler",
-		     tlbmiss_handler_setup_pgd_array,
-		     ARRAY_SIZE(tlbmiss_handler_setup_pgd_array));
+	dump_handler("tlbmiss_handler", tlbmiss_handler_setup_pgd,
+					tlbmiss_handler_setup_pgd_size);
 }
 #endif
 
@@ -1756,10 +1754,11 @@ build_r3000_tlbchange_handler_head(u32 **p, unsigned int pte,
 static void __cpuinit build_r3000_tlb_load_handler(void)
 {
 	u32 *p = handle_tlbl;
+	const int handle_tlbl_size = handle_tlbl_end - handle_tlbl;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 
-	memset(handle_tlbl, 0, sizeof(handle_tlbl));
+	memset(handle_tlbl, 0, handle_tlbl_size * sizeof(handle_tlbl[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
@@ -1773,23 +1772,24 @@ static void __cpuinit build_r3000_tlb_load_handler(void)
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
 	uasm_i_nop(&p);
 
-	if ((p - handle_tlbl) > FASTPATH_SIZE)
+	if (p >= handle_tlbl_end)
 		panic("TLB load handler fastpath space exceeded");
 
 	uasm_resolve_relocs(relocs, labels);
 	pr_debug("Wrote TLB load handler fastpath (%u instructions).\n",
 		 (unsigned int)(p - handle_tlbl));
 
-	dump_handler("r3000_tlb_load", handle_tlbl, ARRAY_SIZE(handle_tlbl));
+	dump_handler("r3000_tlb_load", handle_tlbl, handle_tlbl_size);
 }
 
 static void __cpuinit build_r3000_tlb_store_handler(void)
 {
 	u32 *p = handle_tlbs;
+	const int handle_tlbs_size = handle_tlbs_end - handle_tlbs;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 
-	memset(handle_tlbs, 0, sizeof(handle_tlbs));
+	memset(handle_tlbs, 0, handle_tlbs_size * sizeof(handle_tlbs[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
@@ -1803,23 +1803,24 @@ static void __cpuinit build_r3000_tlb_store_handler(void)
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
 
-	if ((p - handle_tlbs) > FASTPATH_SIZE)
+	if (p >= handle_tlbs)
 		panic("TLB store handler fastpath space exceeded");
 
 	uasm_resolve_relocs(relocs, labels);
 	pr_debug("Wrote TLB store handler fastpath (%u instructions).\n",
 		 (unsigned int)(p - handle_tlbs));
 
-	dump_handler("r3000_tlb_store", handle_tlbs, ARRAY_SIZE(handle_tlbs));
+	dump_handler("r3000_tlb_store", handle_tlbs, handle_tlbs_size);
 }
 
 static void __cpuinit build_r3000_tlb_modify_handler(void)
 {
 	u32 *p = handle_tlbm;
+	const int handle_tlbm_size = handle_tlbm_end - handle_tlbm;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 
-	memset(handle_tlbm, 0, sizeof(handle_tlbm));
+	memset(handle_tlbm, 0, handle_tlbm_size * sizeof(handle_tlbm[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
@@ -1833,14 +1834,14 @@ static void __cpuinit build_r3000_tlb_modify_handler(void)
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
 
-	if ((p - handle_tlbm) > FASTPATH_SIZE)
+	if (p >= handle_tlbm_end)
 		panic("TLB modify handler fastpath space exceeded");
 
 	uasm_resolve_relocs(relocs, labels);
 	pr_debug("Wrote TLB modify handler fastpath (%u instructions).\n",
 		 (unsigned int)(p - handle_tlbm));
 
-	dump_handler("r3000_tlb_modify", handle_tlbm, ARRAY_SIZE(handle_tlbm));
+	dump_handler("r3000_tlb_modify", handle_tlbm, handle_tlbm_size);
 }
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
 
@@ -1904,11 +1905,12 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
 static void __cpuinit build_r4000_tlb_load_handler(void)
 {
 	u32 *p = handle_tlbl;
+	const int handle_tlbl_size = handle_tlbl_end - handle_tlbl;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 	struct work_registers wr;
 
-	memset(handle_tlbl, 0, sizeof(handle_tlbl));
+	memset(handle_tlbl, 0, handle_tlbl_size * sizeof(handle_tlbl[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
@@ -2073,24 +2075,25 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
 	uasm_i_nop(&p);
 
-	if ((p - handle_tlbl) > FASTPATH_SIZE)
+	if (p >= handle_tlbl_end)
 		panic("TLB load handler fastpath space exceeded");
 
 	uasm_resolve_relocs(relocs, labels);
 	pr_debug("Wrote TLB load handler fastpath (%u instructions).\n",
 		 (unsigned int)(p - handle_tlbl));
 
-	dump_handler("r4000_tlb_load", handle_tlbl, ARRAY_SIZE(handle_tlbl));
+	dump_handler("r4000_tlb_load", handle_tlbl, handle_tlbl_size);
 }
 
 static void __cpuinit build_r4000_tlb_store_handler(void)
 {
 	u32 *p = handle_tlbs;
+	const int handle_tlbs_size = handle_tlbs_end - handle_tlbs;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 	struct work_registers wr;
 
-	memset(handle_tlbs, 0, sizeof(handle_tlbs));
+	memset(handle_tlbs, 0, handle_tlbs_size * sizeof(handle_tlbs[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
@@ -2127,24 +2130,25 @@ static void __cpuinit build_r4000_tlb_store_handler(void)
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
 
-	if ((p - handle_tlbs) > FASTPATH_SIZE)
+	if (p >= handle_tlbs_end)
 		panic("TLB store handler fastpath space exceeded");
 
 	uasm_resolve_relocs(relocs, labels);
 	pr_debug("Wrote TLB store handler fastpath (%u instructions).\n",
 		 (unsigned int)(p - handle_tlbs));
 
-	dump_handler("r4000_tlb_store", handle_tlbs, ARRAY_SIZE(handle_tlbs));
+	dump_handler("r4000_tlb_store", handle_tlbs, handle_tlbs_size);
 }
 
 static void __cpuinit build_r4000_tlb_modify_handler(void)
 {
 	u32 *p = handle_tlbm;
+	const int handle_tlbm_size = handle_tlbm_end - handle_tlbm;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 	struct work_registers wr;
 
-	memset(handle_tlbm, 0, sizeof(handle_tlbm));
+	memset(handle_tlbm, 0, handle_tlbm_size * sizeof(handle_tlbm[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
@@ -2182,14 +2186,14 @@ static void __cpuinit build_r4000_tlb_modify_handler(void)
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
 
-	if ((p - handle_tlbm) > FASTPATH_SIZE)
+	if (p >= handle_tlbm_end)
 		panic("TLB modify handler fastpath space exceeded");
 
 	uasm_resolve_relocs(relocs, labels);
 	pr_debug("Wrote TLB modify handler fastpath (%u instructions).\n",
 		 (unsigned int)(p - handle_tlbm));
 
-	dump_handler("r4000_tlb_modify", handle_tlbm, ARRAY_SIZE(handle_tlbm));
+	dump_handler("r4000_tlb_modify", handle_tlbm, handle_tlbm_size);
 }
 
 void __cpuinit build_tlb_refill_handler(void)
@@ -2261,13 +2265,13 @@ void __cpuinit build_tlb_refill_handler(void)
 void __cpuinit flush_tlb_handlers(void)
 {
 	local_flush_icache_range((unsigned long)handle_tlbl,
-			   (unsigned long)handle_tlbl + sizeof(handle_tlbl));
+			   (unsigned long)handle_tlbl_end);
 	local_flush_icache_range((unsigned long)handle_tlbs,
-			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
+			   (unsigned long)handle_tlbs_end);
 	local_flush_icache_range((unsigned long)handle_tlbm,
-			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
+			   (unsigned long)handle_tlbm_end);
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd_array,
-			   (unsigned long)tlbmiss_handler_setup_pgd_array + sizeof(handle_tlbm));
+	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd,
+			   (unsigned long)tlbmiss_handler_setup_pgd_end);
 #endif
 }
-- 
1.7.9.5
