Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2012 21:45:45 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:53575 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831636Ab2LCUpoOvw-L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Dec 2012 21:45:44 +0100
Received: by mail-da0-f49.google.com with SMTP id v40so1254200dad.36
        for <multiple recipients>; Mon, 03 Dec 2012 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=m+HJq0Wq33Ox8SSh3LJc1eZ1UdkikjWZTanMcBGfa6E=;
        b=JCJcdEMD6G7xVijHZjQZ1JLrYevrcytt6S5d/Aft5v6ivRSPx4KxLQaV3ATW2nfkk5
         HU7f+ALML5bedn9hcC8zMU2VMR2TTmXe9Q1/ciLcgShl1gaM5dZqBl51mYBSeJoXVKsR
         gddBC6dJZ9qbjQkkutSVS9lkXRL4KWYBwDT61XKhI3MLD0TlW8QihvvN+EG4FoTMi9bO
         XeUkPEplVNUY/zz4QNrfBC/b9WTE4uSl3FU28ooIGRAmLCcWVAYi8WsVbaB0bR7+1ngK
         L252NxgP0vx1KKulTLgm9abnwKTf5mtzq557wkrJeiJ4tpetNcR6e0S8jfV+D7i1k2br
         MHRQ==
Received: by 10.68.241.136 with SMTP id wi8mr32648551pbc.95.1354567537076;
        Mon, 03 Dec 2012 12:45:37 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id is3sm8586189pbc.6.2012.12.03.12.45.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Dec 2012 12:45:34 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id qB3KiWYS023605;
        Mon, 3 Dec 2012 12:44:32 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id qB3KiSH2023603;
        Mon, 3 Dec 2012 12:44:28 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Cc:     Hillf Danton <dhillf@gmail.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Avoid Machine Check by flushing entire page range in huge_ptep_set_access_flags().
Date:   Mon,  3 Dec 2012 12:44:26 -0800
Message-Id: <1354567466-23571-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 35174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Problem:

1) Huge page mapping of anonymous memory is initially invalid.  Will be
   faulted in by copy-on-write mechanism.

2) Userspace attempts store at the end of the huge mapping.

3) TLB Refill exception handler fill TLB with a normal (4K sized)
   invalid page at the end of the huge mapping virtual address range.

4) Userspace restarted, and re-attempts the store at the end of the
   huge mapping.

5) Page from #3 is invalid, we get a fault and go to the hugepage
   fault handler.  This tries to map a huge page and calls
   huge_ptep_set_access_flags() to install the mapping.

6) We just call the generic ptep_set_access_flags() to set up the page
   tables, but the flush there assumes a normal (4K sized) page and
   only tries to flush the first part of the huge page virtual address
   out of the TLB, since the existing entry from step #3 doesn't
   conflict, nothing is flushed.

7) We attempt to load the mapping into the TLB, but because it
   conflicts with the entry from step #3, we get a Machine Check
   exception.

The fix: Flush the entire rage covered by the huge page in
huge_ptep_set_access_flags(), and remove the optimization in
local_flush_tlb_range() so that the flush actually does the correct
thing.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/hugetlb.h | 12 +++++++++++-
 arch/mips/mm/tlb-r4k.c          | 18 ++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index 58d3688..68670b1 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -95,7 +95,17 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     pte_t *ptep, pte_t pte,
 					     int dirty)
 {
-	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+	int changed = !pte_same(*ptep, pte);
+
+	if (changed) {
+		set_pte_at(vma->vm_mm, addr, ptep, pte);
+		/*
+		 * There could be some standard sized pages in there,
+		 * get them all.
+		 */
+		flush_tlb_range(vma, addr, addr + HPAGE_SIZE);
+	}
+	return changed;
 }
 
 static inline pte_t huge_ptep_get(pte_t *ptep)
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index d2572cb..1df4d2f 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -120,18 +120,11 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 	if (cpu_context(cpu, mm) != 0) {
 		unsigned long size, flags;
-		int huge = is_vm_hugetlb_page(vma);
 
 		ENTER_CRITICAL(flags);
-		if (huge) {
-			start = round_down(start, HPAGE_SIZE);
-			end = round_up(end, HPAGE_SIZE);
-			size = (end - start) >> HPAGE_SHIFT;
-		} else {
-			start = round_down(start, PAGE_SIZE << 1);
-			end = round_up(end, PAGE_SIZE << 1);
-			size = (end - start) >> (PAGE_SHIFT + 1);
-		}
+		start = round_down(start, PAGE_SIZE << 1);
+		end = round_up(end, PAGE_SIZE << 1);
+		size = (end - start) >> (PAGE_SHIFT + 1);
 		if (size <= current_cpu_data.tlbsize/2) {
 			int oldpid = read_c0_entryhi();
 			int newpid = cpu_asid(cpu, mm);
@@ -140,10 +133,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 				int idx;
 
 				write_c0_entryhi(start | newpid);
-				if (huge)
-					start += HPAGE_SIZE;
-				else
-					start += (PAGE_SIZE << 1);
+				start += (PAGE_SIZE << 1);
 				mtc0_tlbw_hazard();
 				tlb_probe();
 				tlb_probe_hazard();
-- 
1.7.11.7
