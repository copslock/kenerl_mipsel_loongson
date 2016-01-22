Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 11:59:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5309 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009519AbcAVK6obVKVh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 11:58:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id EED23ED17EEE2;
        Fri, 22 Jan 2016 10:58:36 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 22 Jan 2016 10:58:38 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 22 Jan 2016 10:58:37 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Manuel Lauss <manuel.lauss@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: c-r4k: Sync icache when it fills from dcache
Date:   Fri, 22 Jan 2016 10:58:25 +0000
Message-ID: <1453460306-8505-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51300
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

It is still necessary to handle icache coherency in flush_cache_range()
and copy_to_user_page() when the icache fills from the dcache, even
though the dcache does not need to be written back. However when this
handling was added in commit 2eaa7ec286db ("[MIPS] Handle I-cache
coherency in flush_cache_range()"), it did not do any icache flushing
when it fills from dcache.

Therefore fix r4k_flush_cache_range() to run
local_r4k_flush_cache_range() without taking into account whether icache
fills from dcache, so that the icache coherency gets handled. Checks are
also added in local_r4k_flush_cache_range() so that the dcache blast
doesn't take place when icache fills from dcache.

A test to mmap a page PROT_READ|PROT_WRITE, modify code in it, and
mprotect it to VM_READ|VM_EXEC (similar to case described in above
commit) can hit this case quite easily to verify the fix.

A similar check was added in commit f8829caee311 ("[MIPS] Fix aliasing
bug in copy_to_user_page / copy_from_user_page"), so also fix
copy_to_user_page() similarly, to call flush_cache_page() without taking
into account whether icache fills from dcache, since flush_cache_page()
already takes that into account to avoid performing a dcache flush.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/c-r4k.c | 11 +++++++++--
 arch/mips/mm/init.c  |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index caac3d747a90..fc7289dfaf5a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -492,7 +492,14 @@ static inline void local_r4k_flush_cache_range(void * args)
 	if (!(has_valid_asid(vma->vm_mm)))
 		return;
 
-	r4k_blast_dcache();
+	/*
+	 * If dcache can alias, we must blast it since mapping is changing.
+	 * If executable, we must ensure any dirty lines are written back far
+	 * enough to be visible to icache.
+	 */
+	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
+		r4k_blast_dcache();
+	/* If executable, blast stale lines from icache */
 	if (exec)
 		r4k_blast_icache();
 }
@@ -502,7 +509,7 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
 {
 	int exec = vma->vm_flags & VM_EXEC;
 
-	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
+	if (cpu_has_dc_aliases || exec)
 		r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
 }
 
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 7e5fa0938c21..6c6a843b0d17 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -196,7 +196,7 @@ void copy_to_user_page(struct vm_area_struct *vma,
 		if (cpu_has_dc_aliases)
 			SetPageDcacheDirty(page);
 	}
-	if ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc)
+	if (vma->vm_flags & VM_EXEC)
 		flush_cache_page(vma, vaddr, page_to_pfn(page));
 }
 
-- 
2.4.10
