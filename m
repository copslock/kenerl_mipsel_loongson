Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 10:54:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54995 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013516AbbESIwSA0Jkh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 10:52:18 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 05E509B247F76;
        Tue, 19 May 2015 09:52:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 19 May 2015 09:51:09 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 19 May 2015 09:51:08 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 05/10] MIPS: dump_tlb: Refactor TLB matching
Date:   Tue, 19 May 2015 09:50:33 +0100
Message-ID: <1432025438-26431-6-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 47477
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

Refactor the TLB matching code in dump_tlb() slightly so that the
conditions which can cause a TLB entry to be skipped can be more easily
extended. This should prevent the match condition getting unwieldy once
it is updated to take further conditions into account.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lib/dump_tlb.c | 65 ++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index a62dfacb60f7..17d05caa776d 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -46,6 +46,11 @@ static void dump_tlb(int first, int last)
 	unsigned long s_entryhi, entryhi, asid;
 	unsigned long long entrylo0, entrylo1;
 	unsigned int s_index, s_pagemask, pagemask, c0, c1, i;
+#ifdef CONFIG_32BIT
+	int width = 8;
+#else
+	int width = 11;
+#endif
 
 	s_pagemask = read_c0_pagemask();
 	s_entryhi = read_c0_entryhi();
@@ -62,38 +67,38 @@ static void dump_tlb(int first, int last)
 		entrylo0 = read_c0_entrylo0();
 		entrylo1 = read_c0_entrylo1();
 
-		/* Unused entries have a virtual address of CKSEG0.  */
-		if ((entryhi & ~0x1ffffUL) != CKSEG0
-		    && (entryhi & 0xff) == asid) {
-#ifdef CONFIG_32BIT
-			int width = 8;
-#else
-			int width = 11;
-#endif
-			/*
-			 * Only print entries in use
-			 */
-			printk("Index: %2d pgmask=%s ", i, msk2str(pagemask));
+		/*
+		 * Prior to tlbinv, unused entries have a virtual address of
+		 * CKSEG0.
+		 */
+		if ((entryhi & ~0x1ffffUL) == CKSEG0)
+			continue;
+		if ((entryhi & 0xff) != asid)
+			continue;
 
-			c0 = (entrylo0 >> 3) & 7;
-			c1 = (entrylo1 >> 3) & 7;
+		/*
+		 * Only print entries in use
+		 */
+		printk("Index: %2d pgmask=%s ", i, msk2str(pagemask));
 
-			printk("va=%0*lx asid=%02lx\n",
-			       width, (entryhi & ~0x1fffUL),
-			       entryhi & 0xff);
-			printk("\t[pa=%0*llx c=%d d=%d v=%d g=%d] ",
-			       width,
-			       (entrylo0 << 6) & PAGE_MASK, c0,
-			       (entrylo0 & 4) ? 1 : 0,
-			       (entrylo0 & 2) ? 1 : 0,
-			       (entrylo0 & 1) ? 1 : 0);
-			printk("[pa=%0*llx c=%d d=%d v=%d g=%d]\n",
-			       width,
-			       (entrylo1 << 6) & PAGE_MASK, c1,
-			       (entrylo1 & 4) ? 1 : 0,
-			       (entrylo1 & 2) ? 1 : 0,
-			       (entrylo1 & 1) ? 1 : 0);
-		}
+		c0 = (entrylo0 >> 3) & 7;
+		c1 = (entrylo1 >> 3) & 7;
+
+		printk("va=%0*lx asid=%02lx\n",
+		       width, (entryhi & ~0x1fffUL),
+		       entryhi & 0xff);
+		printk("\t[pa=%0*llx c=%d d=%d v=%d g=%d] ",
+		       width,
+		       (entrylo0 << 6) & PAGE_MASK, c0,
+		       (entrylo0 & 4) ? 1 : 0,
+		       (entrylo0 & 2) ? 1 : 0,
+		       (entrylo0 & 1) ? 1 : 0);
+		printk("[pa=%0*llx c=%d d=%d v=%d g=%d]\n",
+		       width,
+		       (entrylo1 << 6) & PAGE_MASK, c1,
+		       (entrylo1 & 4) ? 1 : 0,
+		       (entrylo1 & 2) ? 1 : 0,
+		       (entrylo1 & 1) ? 1 : 0);
 	}
 	printk("\n");
 
-- 
2.3.6
