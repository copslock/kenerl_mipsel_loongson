Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 12:53:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22283 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026383AbbEMKwP6Go0K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 12:52:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6548E3FEA70B8;
        Wed, 13 May 2015 11:52:10 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 13 May 2015 11:51:09 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 13 May 2015 11:51:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 7/9] MIPS: dump_tlb: Take RI/XI bits into account
Date:   Wed, 13 May 2015 11:50:53 +0100
Message-ID: <1431514255-3030-8-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
References: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47368
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

The RI/XI bits when present are above the PFN field in the EntryLo
registers, at bits 63,62 when read with dmfc0, and bits 31,30 when read
with mfc0. This makes them appear as part of the physical address, since
the other bits are masked with PAGE_MASK, for example:

Index: 253 pgmask=16kb va=77b18000 asid=75
        [pa=1000744000 c=5 d=1 v=1 g=0] [pa=100134c000 c=5 d=1 v=1 g=0]

The physical addresses have bit 36 set, which corresponds to bit 30 of
EntryLo1, the XI bit.

Explicitly mask off the RI and XI bits from the printed physical
address, and print the RI and XI bits separately if they exist, giving
output more like this:

Index: 226 pgmask=16kb va=77be0000 asid=79
        [ri=0 xi=1 pa=01288000 c=5 d=1 v=1 g=0] [ri=0 xi=0 pa=010e4000 c=5 d=0 v=1 g=0]

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 11 +++++++++++
 arch/mips/lib/dump_tlb.c         | 27 ++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 764e2756b54d..22b10e044532 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -589,6 +589,17 @@
 /*  EntryHI bit definition */
 #define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
 
+/* EntryLo bit definitions */
+#ifdef CONFIG_64BIT
+/* as read by dmfc0 */
+#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 63)
+#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 62)
+#else
+/* as read by mfc0 */
+#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 31)
+#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 30)
+#endif
+
 /* CMGCRBase bit definitions */
 #define MIPS_CMGCRB_BASE	11
 #define MIPS_CMGCRF_BASE	(~_ULCAST_((1 << MIPS_CMGCRB_BASE) - 1))
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index f58962c11c75..b918646d6c8d 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -44,7 +44,7 @@ static inline const char *msk2str(unsigned int mask)
 static void dump_tlb(int first, int last)
 {
 	unsigned long s_entryhi, entryhi, asid;
-	unsigned long long entrylo0, entrylo1;
+	unsigned long long entrylo0, entrylo1, pa;
 	unsigned int s_index, s_pagemask, pagemask, c0, c1, i;
 #ifdef CONFIG_32BIT
 	int width = 8;
@@ -91,15 +91,28 @@ static void dump_tlb(int first, int last)
 		printk("va=%0*lx asid=%02lx\n",
 		       width, (entryhi & ~0x1fffUL),
 		       entryhi & 0xff);
-		printk("\t[pa=%0*llx c=%d d=%d v=%d g=%d] ",
-		       width,
-		       (entrylo0 << 6) & PAGE_MASK, c0,
+		/* RI/XI are in awkward places, so mask them off separately */
+		pa = entrylo0 & ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
+		pa = (pa << 6) & PAGE_MASK;
+		printk("\t[");
+		if (cpu_has_rixi)
+			printk("ri=%d xi=%d ",
+			       (entrylo0 & MIPS_ENTRYLO_RI) ? 1 : 0,
+			       (entrylo0 & MIPS_ENTRYLO_XI) ? 1 : 0);
+		printk("pa=%0*llx c=%d d=%d v=%d g=%d] [",
+		       width, pa, c0,
 		       (entrylo0 & 4) ? 1 : 0,
 		       (entrylo0 & 2) ? 1 : 0,
 		       (entrylo0 & 1) ? 1 : 0);
-		printk("[pa=%0*llx c=%d d=%d v=%d g=%d]\n",
-		       width,
-		       (entrylo1 << 6) & PAGE_MASK, c1,
+		/* RI/XI are in awkward places, so mask them off separately */
+		pa = entrylo1 & ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
+		pa = (pa << 6) & PAGE_MASK;
+		if (cpu_has_rixi)
+			printk("ri=%d xi=%d ",
+			       (entrylo1 & MIPS_ENTRYLO_RI) ? 1 : 0,
+			       (entrylo1 & MIPS_ENTRYLO_XI) ? 1 : 0);
+		printk("pa=%0*llx c=%d d=%d v=%d g=%d]\n",
+		       width, pa, c1,
 		       (entrylo1 & 4) ? 1 : 0,
 		       (entrylo1 & 2) ? 1 : 0,
 		       (entrylo1 & 1) ? 1 : 0);
-- 
2.3.6
