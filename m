Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2015 17:18:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61506 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013217AbbBSQSIZIOuX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Feb 2015 17:18:08 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D62F444C4FF3D
        for <linux-mips@linux-mips.org>; Thu, 19 Feb 2015 16:17:58 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 19 Feb
 2015 16:18:01 +0000
Received: from solomon.ba.imgtec.org (10.20.78.13) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 19 Feb
 2015 08:17:59 -0800
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH V2 3/3] MIPS: Fix I-cache flushing for kmap'd pages.
Date:   Thu, 19 Feb 2015 10:17:44 -0600
Message-ID: <1424362664-30303-4-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com>
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.13]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Make the I-cache flush pages while taking into account the
address color by using kmap_coherent() when there is
I-cache aliasing present.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h |    3 +++
 arch/mips/mm/c-r4k.c                 |   17 ++++++++++++++---
 arch/mips/mm/init.c                  |    2 --
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 25ababd..16b67e9 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -145,6 +145,9 @@
 #ifndef cpu_has_vtag_dcache
 #define cpu_has_vtag_dcache     (cpu_data[0].dcache.flags & MIPS_CACHE_VTAG)
 #endif
+#ifndef cpu_has_ic_aliases
+#define cpu_has_ic_aliases      (cpu_data[0].icache.flags & MIPS_CACHE_ALIASES)
+#endif
 #ifndef cpu_has_dc_aliases
 #define cpu_has_dc_aliases	(cpu_data[0].dcache.flags & MIPS_CACHE_ALIASES)
 #endif
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 779dcfa..3dbc14d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -552,6 +552,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 	pmd_t *pmdp;
 	pte_t *ptep;
 	void *vaddr;
+	int noflush = 0;
 
 	/*
 	 * If ownes no valid ASID yet, cannot possibly have gotten
@@ -611,6 +612,7 @@ static inline void local_r4k_flush_cache_page(void *args)
 
 			if (cpu_context(cpu, mm) != 0)
 				drop_mmu_context(mm, cpu);
+			noflush = 1;
 		} else
 			vaddr ? r4k_blast_icache_page(addr) :
 				r4k_blast_icache_user_page(addr);
@@ -622,6 +624,13 @@ static inline void local_r4k_flush_cache_page(void *args)
 		else
 			kunmap_atomic(vaddr);
 	}
+
+	/*  If we have I-cache aliasing, then blast it via coherent page. */
+	if (exec && cpu_has_ic_aliases && !noflush && !map_coherent) {
+		vaddr = kmap_coherent(page, addr);
+		r4k_blast_icache_page((unsigned long)vaddr);
+		kunmap_coherent();
+	}
 }
 
 static void r4k_flush_cache_page(struct vm_area_struct *vma,
@@ -1318,10 +1327,12 @@ static void probe_pcache(void)
 		c->icache.ways = 1;
 	}
 
-	printk("Primary instruction cache %ldkB, %s, %s, linesize %d bytes.\n",
-	       icache_size >> 10,
+	printk("Primary instruction cache %ldkB, %s, %s, %slinesize %d bytes.\n",
+	       icache_size >> 10, way_string[c->icache.ways],
 	       c->icache.flags & MIPS_CACHE_VTAG ? "VIVT" : "VIPT",
-	       way_string[c->icache.ways], c->icache.linesz);
+	       (c->icache.flags & MIPS_CACHE_ALIASES) ?
+			"I-cache aliases, " : "",
+	       c->icache.linesz);
 
 	printk("Primary data cache %ldkB, %s, %s, %s, linesize %d bytes\n",
 	       dcache_size >> 10, way_string[c->dcache.ways],
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 0dc604a..b1584d6 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -88,8 +88,6 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 	pte_t pte;
 	int tlbidx;
 
-	BUG_ON(Page_dcache_dirty(page));
-
 	pagefault_disable();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
 	idx += in_interrupt() ? FIX_N_COLOURS : 0;
-- 
1.7.10.4
