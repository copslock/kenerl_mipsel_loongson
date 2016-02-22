Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 19:10:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46255 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013423AbcBVSKJBmjIv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 19:10:09 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 04BF01023F4DC;
        Mon, 22 Feb 2016 18:10:00 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 22 Feb 2016 18:10:02 +0000
Received: from localhost (10.100.200.218) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 22 Feb
 2016 18:10:01 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] MIPS: Add barriers between dcache & icache flushes
Date:   Mon, 22 Feb 2016 18:09:44 +0000
Message-ID: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.218]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52155
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

Index-based cache operations may be arbitrarily reordered by out of
order CPUs. Thus code which writes back the dcache & then invalidates
the icache using indexed cache ops must include a barrier between
operating on the 2 caches in order to prevent the scenario in which:

  - icache invalidation occurs.

  - icache fetch occurs, due to speculation.

  - dcache writeback occurs.

If the above were allowed to happen then the icache would contain stale
data. Forcing the dcache writeback to complete before the icache
invalidation avoids this.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
---

 arch/mips/mm/c-r4k.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index caac3d7..a49010c 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -449,6 +449,7 @@ static inline void local_r4k___flush_cache_all(void * args)
 
 	default:
 		r4k_blast_dcache();
+		mb(); /* cache instructions may be reordered */
 		r4k_blast_icache();
 		break;
 	}
@@ -493,8 +494,10 @@ static inline void local_r4k_flush_cache_range(void * args)
 		return;
 
 	r4k_blast_dcache();
-	if (exec)
+	if (exec) {
+		mb(); /* cache instructions may be reordered */
 		r4k_blast_icache();
+	}
 }
 
 static void r4k_flush_cache_range(struct vm_area_struct *vma,
@@ -599,8 +602,13 @@ static inline void local_r4k_flush_cache_page(void *args)
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
 		vaddr ? r4k_blast_dcache_page(addr) :
 			r4k_blast_dcache_user_page(addr);
-		if (exec && !cpu_icache_snoops_remote_store)
+		if (exec)
+			mb(); /* cache instructions may be reordered */
+
+		if (exec && !cpu_icache_snoops_remote_store) {
 			r4k_blast_scache_page(addr);
+			mb(); /* cache instructions may be reordered */
+		}
 	}
 	if (exec) {
 		if (vaddr && cpu_has_vtag_icache && mm == current->active_mm) {
@@ -660,6 +668,7 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 			R4600_HIT_CACHEOP_WAR_IMPL;
 			protected_blast_dcache_range(start, end);
 		}
+		mb(); /* cache instructions may be reordered */
 	}
 
 	if (end - start > icache_size)
@@ -798,6 +807,8 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
 		protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
 	if (!cpu_icache_snoops_remote_store && scache_size)
 		protected_writeback_scache_line(addr & ~(sc_lsize - 1));
+	if ((dc_lsize || scache_size) && ic_lsize)
+		mb(); /* cache instructions may be reordered */
 	if (ic_lsize)
 		protected_flush_icache_line(addr & ~(ic_lsize - 1));
 	if (MIPS4K_ICACHE_REFILL_WAR) {
-- 
2.7.1
