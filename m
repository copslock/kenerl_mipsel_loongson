Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 17:23:07 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:7422 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854773AbaEIPVhigO79 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 17:21:37 +0200
X-IronPort-AV: E=Sophos;i="4.97,1018,1389772800"; 
   d="scan'208";a="28919406"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw1-out.broadcom.com with ESMTP; 09 May 2014 09:37:20 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 9 May 2014 08:21:31 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Fri, 9 May 2014 08:21:31 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 578FC5D819;    Fri,  9 May 2014 08:21:30 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 4/4] MIPS: Netlogic: Map kernel with 1G/4G pages on XLPII
Date:   Fri, 9 May 2014 20:58:24 +0530
Message-ID: <1399649304-25856-5-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399649304-25856-1-git-send-email-jchandra@broadcom.com>
References: <1399649304-25856-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40059
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

XLP2XX and XLP9XX support 1G and 4G pages. Use this for mapping
physical memory in Mapped Kernel support.

Reduces the number of WIRED entries in systems with more RAM.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/memory.c |  237 ++++++++++++++++++++++++------------
 1 file changed, 159 insertions(+), 78 deletions(-)

diff --git a/arch/mips/netlogic/common/memory.c b/arch/mips/netlogic/common/memory.c
index 6d967ce..83aeb7c 100644
--- a/arch/mips/netlogic/common/memory.c
+++ b/arch/mips/netlogic/common/memory.c
@@ -34,6 +34,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/sizes.h>
 
 #include <asm/bootinfo.h>
 #include <asm/pgtable.h>
@@ -41,100 +42,187 @@
 #include <asm/tlb.h>
 
 #include <asm/netlogic/common.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
 
-#define TLBSZ		(256 * 1024 * 1024)
-#define PM_TLBSZ	PM_256M
-#define PTE_MAPKERN(pa)	(((pa >> 12) << 6) | 0x2f)
+#define SZ_4G		(4ull * 1024 * 1024 * 1024)
+#define PM_4G		0x1ffffe000
+#define MINPGSZ		SZ_256M
+
+#define PTE_MAPKERN(pa)	((((pa) >> 12) << 6) | 0x2f)
 #define TLB_MAXWIRED	28
 
 static const int prefetch_backup = 512;
 
 #if defined(CONFIG_MAPPED_KERNEL) && defined(CONFIG_64BIT)
-static void nlm_tlb_align(struct boot_mem_map_entry *map)
+
+/* To track the allocated area of a boot_mem_map segment */
+struct alloc_entry {
+	/* Start and end of the va mapped */
+	unsigned long long start;
+	unsigned long long end;
+
+	/* When just one of lo0/lo1 is used, the valid area is half of above */
+	unsigned long long astart;
+	unsigned long long aend;
+} alloc_map[32];
+
+static inline int addtlb(phys_addr_t pa, u64 pgsz, u64 pmask,
+	unsigned int validmask, struct alloc_entry *ae)
 {
-	phys_t astart, aend, start, end;
+	phys_addr_t endpa;
+	u64 *t;
+	u32 *tlbcount;
+	int ntlb;
+
+	tlbcount = (u32 *)nlm_get_boot_data(BOOT_NTLBS);
+	ntlb = *tlbcount;
+	endpa = pa + 2 * pgsz;
 
-	start = map->addr;
-	end = start + map->size;
+	pr_debug("%2d - pa0 %llx pa1 %llx pgsz %llx valid %x\n",
+				ntlb, pa, endpa, pgsz, validmask);
+	if (ntlb == TLB_MAXWIRED) {
+		pr_err("Ran out of TLB entries pa %llx pgsz %llx\n", pa, pgsz);
+		return -1;
+	}
 
-	/* fudge first entry for now  */
-	if (start < 0x10000000) {
-		start = 0;
-		end = 0x10000000;
+	t = nlm_get_boot_data(BOOT_TLBS_START);
+	t += ntlb * (BOOT_TLB_SIZE / sizeof(t[0]));
+	t[BOOT_TLB_ENTRYHI] = pa + PAGE_OFFSET;
+	t[BOOT_TLB_ENTRYLO0] = (validmask & 0x1) ? PTE_MAPKERN(pa) : 1;
+	t[BOOT_TLB_ENTRYLO1] = (validmask & 0x2) ? PTE_MAPKERN(pa + pgsz) : 1;
+	t[BOOT_TLB_PAGEMASK] = pmask;
+
+	if (pa < ae->start) {
+		ae->astart = ae->start = pa;
+		if ((validmask & 0x1) == 0)
+			ae->astart += pgsz;
 	}
-	astart = round_up(start, TLBSZ);
-	aend = round_down(end, TLBSZ);
-	if (aend <= astart) {
-		pr_info("Boot mem map: discard seg %lx-%lx\n",
-				(unsigned long)start, (unsigned long)end);
-		map->size = 0;
-		return;
+	if (endpa > ae->end) {
+		ae->aend = ae->end = endpa;
+		if ((validmask & 0x2) == 0)
+			ae->aend -= pgsz;
 	}
-	if (astart != start || aend != end) {
-		if (start != 0) {
-			map->addr = astart;
-			map->size = aend - astart;
-		}
-		pr_info("Boot mem map: %lx - %lx -> %lx-%lx\n",
-			(unsigned long)start, (unsigned long)end,
-			(unsigned long)astart, (unsigned long)aend);
-	} else
-		pr_info("Boot mem map: added %lx - %lx\n",
-			(unsigned long)astart, (unsigned long)aend);
+	*tlbcount = ntlb + 1;
+	return 0;
 }
 
+/*
+ * Calculate the TLB entries needed to wire dowm the memory map
+ *
+ * Tries to use the largest pagesizes possible, discards memory which
+ * cannot be mapped
+ */
 static void nlm_calc_wired_tlbs(void)
 {
-	u64 *tlbarr;
-	u32 *tlbcount;
-	u64 lo0, lo1, vaddr;
-	phys_addr_t astart, aend, p;
-	unsigned long bootdata = CKSEG1ADDR(RESET_DATA_PHYS);
-	int i, pos;
+	u64 pgsz, pgmask, p;
+	phys_addr_t astart, aend, pend, nstart;
+	phys_addr_t tstart, tend, mstart, mend;
+	struct boot_mem_map_entry *bmap;
+	int i, nr_map;
+
+	nr_map = boot_mem_map.nr_map;
+	bmap = boot_mem_map.map;
+
+	for (i = 0; i < nr_map; i++) {
+		alloc_map[i].start = alloc_map[i].astart = ~0ull;
+		alloc_map[i].end = alloc_map[i].aend = 0;
+	}
 
-	tlbarr = (u64 *)(bootdata + BOOT_TLBS_START);
-	tlbcount = (u32 *)(bootdata + BOOT_NTLBS);
+	/* force the first entry with one 256M lo0 page */
+	addtlb(0, 0x10000000, PM_256M, 0x1, &alloc_map[0]);
 
-	pos = 0;
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
-			continue;
-		astart = boot_mem_map.map[i].addr;
-		aend =	astart + boot_mem_map.map[i].size;
+	/* starting page size and page mask */
+	if (cpu_is_xlpii()) {
+		pgsz = SZ_4G;
+		pgmask = PM_4G;
+	} else {
+		pgsz = SZ_256M;
+		pgmask = PM_256M;
+	}
 
-		/* fudge first entry for now  */
-		if (astart < 0x10000000) {
-			astart = 0;
-			aend = 0x10000000;
-		}
-		for (p = round_down(astart, 2 * TLBSZ);
-			p < round_up(aend, 2 * TLBSZ);) {
-				vaddr = PAGE_OFFSET + p;
-				lo0 = (p >= astart) ? PTE_MAPKERN(p) : 1;
-				p += TLBSZ;
-				lo1 = (p < aend) ? PTE_MAPKERN(p) : 1;
-				p += TLBSZ;
-
-				tlbarr[BOOT_TLB_ENTRYHI] = vaddr;
-				tlbarr[BOOT_TLB_ENTRYLO0] = lo0;
-				tlbarr[BOOT_TLB_ENTRYLO1] = lo1;
-				tlbarr[BOOT_TLB_PAGEMASK] = PM_TLBSZ;
-				tlbarr += (BOOT_TLB_SIZE / sizeof(tlbarr[0]));
-
-				if (++pos >= TLB_MAXWIRED) {
-					pr_err("Ran out of TLBs at %llx, ",
-							(unsigned long long)p);
-					pr_err("Discarding rest of memory!\n");
-					boot_mem_map.nr_map = i + 1;
-					boot_mem_map.map[i].size = p -
-						boot_mem_map.map[i].addr;
+	/* do multiple passes with successively smaller page sizes */
+	for (; pgsz >= MINPGSZ; pgsz /= 4, pgmask = (pgmask >> 2) ^ 0x1800) {
+		for (i = 0; i < nr_map; i++) {
+			if (bmap[i].type != BOOT_MEM_RAM)
+				continue;
+
+			/* previous mapping end and next mapping start */
+			pend = alloc_map[i - 1].end;
+			nstart = (i == nr_map - 1) ? ~0ull : bmap[i + 1].addr;
+
+			/* mem block start and end */
+			mstart = round_up(bmap[i].addr, MINPGSZ);
+			mend = round_down(bmap[i].addr + bmap[i].size, MINPGSZ);
+
+			/* allocated area in the memory block, start and end */
+			astart = alloc_map[i].start;
+			aend = alloc_map[i].end;
+
+			/* skip fully mapped blocks */
+			if (mstart >= astart && mend <= aend)
+				continue;
+
+			/* boundaries aligned to the current page size */
+			tstart = round_up(mstart, 2 * pgsz);
+			tend = round_down(mend, 2 * pgsz);
+			if (tstart > tend)
+				continue;
+
+			/* use LO1 of a TLB entry */
+			if (mstart + pgsz == tstart && pend <= mstart - pgsz)
+				if (addtlb(mstart - pgsz, pgsz,
+						pgmask, 0x2, &alloc_map[i]))
 					goto out;
+
+			for (p = tstart; p < tend;) {
+				if (astart < aend && p == astart) {
+					p = aend;
+					continue;
 				}
+				if (addtlb(p, pgsz, pgmask, 0x3, &alloc_map[i]))
+					goto out;
+				p += 2 * pgsz;
+			}
+
+			/* use LO0 of a TLB entry */
+			if (tend + pgsz == mend && nstart >= mend + pgsz)
+				if (addtlb(tend, pgsz,
+						pgmask, 0x1, &alloc_map[i]))
+					goto out;
 		}
 	}
 out:
-	*tlbcount = pos;
-	pr_info("%d TLB entires used for mapped kernel.\n", pos);
+	for (i = 0; i < nr_map; i++) {
+		mstart = bmap[i].addr;
+		mend = bmap[i].addr + bmap[i].size;
+		astart = alloc_map[i].astart;
+		aend = alloc_map[i].aend;
+
+		pr_info("%2d alloc: %10llx %10llx mem %10llx %10llx\n", i,
+						astart, aend, bmap[i].addr,
+						bmap[i].addr + bmap[i].size);
+		if (astart >= aend) {
+			bmap[i].size = 0;
+			pr_info("%2d: Discarded %#10llx - %#10llx\n", i,
+				(unsigned long long)mstart,
+				(unsigned long long)mend);
+			continue;
+		}
+		if (bmap[i].addr < astart) {
+			bmap[i].addr = astart;
+			pr_info("%2d: Discarded %#10llx - %#10llx\n", i,
+				(unsigned long long)bmap[i].addr,
+				(unsigned long long)astart);
+		}
+		if (mend > aend) {
+			bmap[i].size = aend - bmap[i].addr;
+			pr_info("%2d: Discarded %#10llx - %#10llx\n", i,
+				(unsigned long long)aend,
+				(unsigned long long)mend);
+		}
+	}
+	pr_info("%d TLB entires used for mapped kernel.\n",
+				*(u32 *)nlm_get_boot_data(BOOT_NTLBS));
 }
 #endif
 
@@ -143,13 +231,6 @@ void __init plat_mem_fixup(void)
 	int i;
 
 #if defined(CONFIG_MAPPED_KERNEL) && defined(CONFIG_64BIT)
-	/* trim memory regions to PM_TLBSZ boundaries */
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
-			continue;
-		nlm_tlb_align(&boot_mem_map.map[i]);
-	}
-
 	/* calculate and save wired TLB entries */
 	nlm_calc_wired_tlbs();
 
-- 
1.7.9.5
