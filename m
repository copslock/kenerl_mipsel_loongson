Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 21:07:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33024 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992544AbcJUTGxdzLqp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2016 21:06:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4C492112A09E0;
        Fri, 21 Oct 2016 20:06:42 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 21 Oct 2016 20:06:46 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        "Maciej W . Rozycki" <macro@imgtec.com>
Subject: [PATCH] MIPS: dump_tlb: Fix printk continuations
Date:   Fri, 21 Oct 2016 20:06:40 +0100
Message-ID: <dcfde84a37e7536b6a145d12e4021bb7d25cf058.1477076684.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55545
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

Since commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing
continuation lines") the output from TLB dumps on MIPS has been
pretty unreadable due to the lack of KERN_CONT markers. Use pr_cont to
provide the appropriate markers & restore the expected output.

Continuation is also used for the second line of each TLB entry printed
in dump_tlb.c even though it has a newline, since it is a continuation
of the interpretation of the same TLB entry. For example:

[   46.371884] Index:  0 pgmask=16kb va=77654000 asid=73 gid=00
        [ri=0 xi=0 pa=ffc18000 c=5 d=0 v=1 g=0] [ri=0 xi=0 pa=ffc1c000 c=5 d=0 v=1 g=0]
[   46.385380] Index: 12 pgmask=16kb va=004b4000 asid=73 gid=00
        [ri=0 xi=0 pa=00000000 c=0 d=0 v=0 g=0] [ri=0 xi=0 pa=ffb00000 c=5 d=1 v=1 g=0]

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Maciej W. Rozycki <macro@imgtec.com>
---
 arch/mips/lib/dump_tlb.c     | 44 ++++++++++++++++++-------------------
 arch/mips/lib/r3k_dump_tlb.c | 18 +++++++--------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 0f80b936e75e..6eb50a7137db 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -135,42 +135,42 @@ static void dump_tlb(int first, int last)
 		c0 = (entrylo0 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
 		c1 = (entrylo1 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
 
-		printk("va=%0*lx asid=%0*lx",
-		       vwidth, (entryhi & ~0x1fffUL),
-		       asidwidth, entryhi & asidmask);
+		pr_cont("va=%0*lx asid=%0*lx",
+			vwidth, (entryhi & ~0x1fffUL),
+			asidwidth, entryhi & asidmask);
 		if (cpu_has_guestid)
-			printk(" gid=%02lx",
-			       (guestctl1 & MIPS_GCTL1_RID)
+			pr_cont(" gid=%02lx",
+				(guestctl1 & MIPS_GCTL1_RID)
 					>> MIPS_GCTL1_RID_SHIFT);
 		/* RI/XI are in awkward places, so mask them off separately */
 		pa = entrylo0 & ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
 		if (xpa)
 			pa |= (unsigned long long)readx_c0_entrylo0() << 30;
 		pa = (pa << 6) & PAGE_MASK;
-		printk("\n\t[");
+		pr_cont("\n\t[");
 		if (cpu_has_rixi)
-			printk("ri=%d xi=%d ",
-			       (entrylo0 & MIPS_ENTRYLO_RI) ? 1 : 0,
-			       (entrylo0 & MIPS_ENTRYLO_XI) ? 1 : 0);
-		printk("pa=%0*llx c=%d d=%d v=%d g=%d] [",
-		       pwidth, pa, c0,
-		       (entrylo0 & ENTRYLO_D) ? 1 : 0,
-		       (entrylo0 & ENTRYLO_V) ? 1 : 0,
-		       (entrylo0 & ENTRYLO_G) ? 1 : 0);
+			pr_cont("ri=%d xi=%d ",
+				(entrylo0 & MIPS_ENTRYLO_RI) ? 1 : 0,
+				(entrylo0 & MIPS_ENTRYLO_XI) ? 1 : 0);
+		pr_cont("pa=%0*llx c=%d d=%d v=%d g=%d] [",
+			pwidth, pa, c0,
+			(entrylo0 & ENTRYLO_D) ? 1 : 0,
+			(entrylo0 & ENTRYLO_V) ? 1 : 0,
+			(entrylo0 & ENTRYLO_G) ? 1 : 0);
 		/* RI/XI are in awkward places, so mask them off separately */
 		pa = entrylo1 & ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
 		if (xpa)
 			pa |= (unsigned long long)readx_c0_entrylo1() << 30;
 		pa = (pa << 6) & PAGE_MASK;
 		if (cpu_has_rixi)
-			printk("ri=%d xi=%d ",
-			       (entrylo1 & MIPS_ENTRYLO_RI) ? 1 : 0,
-			       (entrylo1 & MIPS_ENTRYLO_XI) ? 1 : 0);
-		printk("pa=%0*llx c=%d d=%d v=%d g=%d]\n",
-		       pwidth, pa, c1,
-		       (entrylo1 & ENTRYLO_D) ? 1 : 0,
-		       (entrylo1 & ENTRYLO_V) ? 1 : 0,
-		       (entrylo1 & ENTRYLO_G) ? 1 : 0);
+			pr_cont("ri=%d xi=%d ",
+				(entrylo1 & MIPS_ENTRYLO_RI) ? 1 : 0,
+				(entrylo1 & MIPS_ENTRYLO_XI) ? 1 : 0);
+		pr_cont("pa=%0*llx c=%d d=%d v=%d g=%d]\n",
+			pwidth, pa, c1,
+			(entrylo1 & ENTRYLO_D) ? 1 : 0,
+			(entrylo1 & ENTRYLO_V) ? 1 : 0,
+			(entrylo1 & ENTRYLO_G) ? 1 : 0);
 	}
 	printk("\n");
 
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 744f4a7bc49d..85b4086e553e 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -53,15 +53,15 @@ static void dump_tlb(int first, int last)
 			 */
 			printk("Index: %2d ", i);
 
-			printk("va=%08lx asid=%08lx"
-			       "  [pa=%06lx n=%d d=%d v=%d g=%d]",
-			       entryhi & PAGE_MASK,
-			       entryhi & asid_mask,
-			       entrylo0 & PAGE_MASK,
-			       (entrylo0 & R3K_ENTRYLO_N) ? 1 : 0,
-			       (entrylo0 & R3K_ENTRYLO_D) ? 1 : 0,
-			       (entrylo0 & R3K_ENTRYLO_V) ? 1 : 0,
-			       (entrylo0 & R3K_ENTRYLO_G) ? 1 : 0);
+			pr_cont("va=%08lx asid=%08lx"
+				"  [pa=%06lx n=%d d=%d v=%d g=%d]",
+				entryhi & PAGE_MASK,
+				entryhi & asid_mask,
+				entrylo0 & PAGE_MASK,
+				(entrylo0 & R3K_ENTRYLO_N) ? 1 : 0,
+				(entrylo0 & R3K_ENTRYLO_D) ? 1 : 0,
+				(entrylo0 & R3K_ENTRYLO_V) ? 1 : 0,
+				(entrylo0 & R3K_ENTRYLO_G) ? 1 : 0);
 		}
 	}
 	printk("\n");
-- 
git-series 0.8.10
