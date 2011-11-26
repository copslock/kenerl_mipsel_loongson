Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Nov 2011 15:39:35 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:37399 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903658Ab1KZOj2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Nov 2011 15:39:28 +0100
Received: by wwo1 with SMTP id 1so6446531wwo.24
        for <multiple recipients>; Sat, 26 Nov 2011 06:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=e114vOw5sgHF6kmChDnTFL4Swt/KKOLsrKDW3AWXOPo=;
        b=jaZxlSyGuK5q3J/Z7Euvw19clQ3FVy0of+V6uvX9JuxUYGfNRlTlCI/x5tt5nzidT6
         zivWBp/gKAh7G2qA6gGLWIqWeocSpGA4K/TMcrv6AICcvm+4G5tf1y6n9CPSvSx3gcCP
         kvKcFXXEcfuuTFNYPdCOPJoTgOCUTbZMYN/Ag=
MIME-Version: 1.0
Received: by 10.216.132.130 with SMTP id o2mr634972wei.69.1322318363505; Sat,
 26 Nov 2011 06:39:23 -0800 (PST)
Received: by 10.216.69.74 with HTTP; Sat, 26 Nov 2011 06:39:23 -0800 (PST)
Date:   Sat, 26 Nov 2011 22:39:23 +0800
Message-ID: <CAJd=RBBWia26FaPjn5-RvmAy9MBRtF0Bthkc0f7kxEWcFz6=oQ@mail.gmail.com>
Subject: [PATCH 2/3] MIPS: changes in mm for adding THP
From:   Hillf Danton <dhillf@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21853

Based on the current work of huge TLB, no code is added for THP but info gcc
to compile the huge TLB code for THP. That is the second factor why the present
bit is selected.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---

--- a/arch/mips/include/asm/page.h	Thu Nov 24 21:17:10 2011
+++ b/arch/mips/include/asm/page.h	Sat Nov 26 21:35:51 2011
@@ -33,7 +33,7 @@
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))

-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 #define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
 #define HPAGE_SIZE	(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
--- a/arch/mips/mm/tlb-r4k.c	Thu Nov 24 21:21:10 2011
+++ b/arch/mips/mm/tlb-r4k.c	Sat Nov 26 21:48:31 2011
@@ -305,7 +305,7 @@ void __update_tlb(struct vm_area_struct
 	pudp = pud_offset(pgdp, address);
 	pmdp = pmd_offset(pudp, address);
 	idx = read_c0_index();
-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	/* this could be a huge page  */
 	if (pmd_huge(*pmdp)) {
 		unsigned long lo;
--- a/arch/mips/mm/tlbex.c	Thu Nov 24 21:21:42 2011
+++ b/arch/mips/mm/tlbex.c	Sat Nov 26 21:52:09 2011
@@ -156,7 +156,7 @@ enum label_id {
 	label_smp_pgtable_change,
 	label_r3000_write_probe_fail,
 	label_large_segbits_fault,
-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	label_tlb_huge_update,
 #endif
 };
@@ -175,7 +175,7 @@ UASM_L_LA(_nopage_tlbm)
 UASM_L_LA(_smp_pgtable_change)
 UASM_L_LA(_r3000_write_probe_fail)
 UASM_L_LA(_large_segbits_fault)
-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 UASM_L_LA(_tlb_huge_update)
 #endif

@@ -595,7 +595,7 @@ static __cpuinit __maybe_unused void bui
 	}
 }

-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)

 static __cpuinit void build_restore_pagemask(u32 **p,
 					     struct uasm_reloc **r,
@@ -1154,7 +1154,7 @@ build_fast_tlb_refill_handler (u32 **p,
 	/* Adjust the context during the load latency. */
 	build_adjust_context(p, tmp);

-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	uasm_il_bbit1(p, r, scratch, ilog2(_PAGE_HUGE), label_tlb_huge_update);
 	/*
 	 * The in the LWX case we don't want to do the load in the
@@ -1270,7 +1270,7 @@ static void __cpuinit build_r4000_tlb_re
 		build_get_pgde32(&p, K0, K1); /* get pgd in K1 */
 #endif

-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 		build_is_huge_pte(&p, &r, K0, K1, label_tlb_huge_update);
 #endif

@@ -1280,7 +1280,7 @@ static void __cpuinit build_r4000_tlb_re
 		uasm_l_leave(&l, p);
 		uasm_i_eret(&p); /* return from trap */
 	}
-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	uasm_l_tlb_huge_update(&l, p);
 	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
 	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
@@ -1325,7 +1325,7 @@ static void __cpuinit build_r4000_tlb_re
 		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
 		final_len = p - tlb_handler;
 	} else {
-#if defined(CONFIG_HUGETLB_PAGE)
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 		const enum label_id ls = label_tlb_huge_update;
 #else
 		const enum label_id ls = label_vmalloc;
@@ -1800,7 +1800,7 @@ build_r4000_tlbchange_handler_head(u32 *
 	build_get_pgde32(p, wr.r1, wr.r2); /* get pgd in ptr */
 #endif

-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	/*
 	 * For huge tlb entries, pmd doesn't contain an address but
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
@@ -1916,7 +1916,7 @@ static void __cpuinit build_r4000_tlb_lo
 	build_make_valid(&p, &r, wr.r1, wr.r2);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);

-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	/*
 	 * This is the entry point when build_r4000_tlbchange_handler_head
 	 * spots a huge page.
@@ -2009,7 +2009,7 @@ static void __cpuinit build_r4000_tlb_st
 	build_make_write(&p, &r, wr.r1, wr.r2);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);

-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	/*
 	 * This is the entry point when
 	 * build_r4000_tlbchange_handler_head spots a huge page.
@@ -2057,7 +2057,7 @@ static void __cpuinit build_r4000_tlb_mo
 	build_make_write(&p, &r, wr.r1, wr.r2);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);

-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	/*
 	 * This is the entry point when
 	 * build_r4000_tlbchange_handler_head spots a huge page.
