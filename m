Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 10:52:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36327 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013542AbbESIvNLZAjP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 10:51:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 77DE3E6FCA95;
        Tue, 19 May 2015 09:51:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 19 May 2015 09:51:09 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 19 May 2015 09:51:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH v2 06/10] MIPS: dump_tlb: Make use of EntryLo bit definitions
Date:   Tue, 19 May 2015 09:50:34 +0100
Message-ID: <1432025438-26431-7-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com>
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47470
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

Make use of recently added EntryLo bit definitions in mipsregs.h when
dumping TLB contents.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Changes in v2:
- New patch (Maciej).
---
 arch/mips/lib/dump_tlb.c     | 16 ++++++++--------
 arch/mips/lib/r3k_dump_tlb.c |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 17d05caa776d..f02cc554d720 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -81,8 +81,8 @@ static void dump_tlb(int first, int last)
 		 */
 		printk("Index: %2d pgmask=%s ", i, msk2str(pagemask));
 
-		c0 = (entrylo0 >> 3) & 7;
-		c1 = (entrylo1 >> 3) & 7;
+		c0 = (entrylo0 & MIPS_ENTRYLO_C) >> MIPS_ENTRYLO_C_SHIFT;
+		c1 = (entrylo1 & MIPS_ENTRYLO_C) >> MIPS_ENTRYLO_C_SHIFT;
 
 		printk("va=%0*lx asid=%02lx\n",
 		       width, (entryhi & ~0x1fffUL),
@@ -90,15 +90,15 @@ static void dump_tlb(int first, int last)
 		printk("\t[pa=%0*llx c=%d d=%d v=%d g=%d] ",
 		       width,
 		       (entrylo0 << 6) & PAGE_MASK, c0,
-		       (entrylo0 & 4) ? 1 : 0,
-		       (entrylo0 & 2) ? 1 : 0,
-		       (entrylo0 & 1) ? 1 : 0);
+		       (entrylo0 & MIPS_ENTRYLO_D) ? 1 : 0,
+		       (entrylo0 & MIPS_ENTRYLO_V) ? 1 : 0,
+		       (entrylo0 & MIPS_ENTRYLO_G) ? 1 : 0);
 		printk("[pa=%0*llx c=%d d=%d v=%d g=%d]\n",
 		       width,
 		       (entrylo1 << 6) & PAGE_MASK, c1,
-		       (entrylo1 & 4) ? 1 : 0,
-		       (entrylo1 & 2) ? 1 : 0,
-		       (entrylo1 & 1) ? 1 : 0);
+		       (entrylo1 & MIPS_ENTRYLO_D) ? 1 : 0,
+		       (entrylo1 & MIPS_ENTRYLO_V) ? 1 : 0,
+		       (entrylo1 & MIPS_ENTRYLO_G) ? 1 : 0);
 	}
 	printk("\n");
 
diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index 975a13855116..e210f04b2bc3 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -47,10 +47,10 @@ static void dump_tlb(int first, int last)
 			       entryhi & PAGE_MASK,
 			       entryhi & ASID_MASK,
 			       entrylo0 & PAGE_MASK,
-			       (entrylo0 & (1 << 11)) ? 1 : 0,
-			       (entrylo0 & (1 << 10)) ? 1 : 0,
-			       (entrylo0 & (1 << 9)) ? 1 : 0,
-			       (entrylo0 & (1 << 8)) ? 1 : 0);
+			       (entrylo0 & R3K_ENTRYLO_N) ? 1 : 0,
+			       (entrylo0 & R3K_ENTRYLO_D) ? 1 : 0,
+			       (entrylo0 & R3K_ENTRYLO_V) ? 1 : 0,
+			       (entrylo0 & R3K_ENTRYLO_G) ? 1 : 0);
 		}
 	}
 	printk("\n");
-- 
2.3.6
