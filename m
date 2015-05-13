Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 12:52:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7960 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013293AbbEMKvOAtoul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 12:51:14 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ABF0FDA5F445A;
        Wed, 13 May 2015 11:51:08 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 13 May 2015 11:51:10 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 13 May 2015 11:51:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 8/9] MIPS: dump_tlb: Take XPA into account
Date:   Wed, 13 May 2015 11:50:54 +0100
Message-ID: <1431514255-3030-9-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 47363
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

XPA extends the physical addresses on MIPS32, including the EntryLo
registers. Update dump_tlb() to concatenate the PFNX field from the high
end of the EntryLo registers (as read by mfhc0).

The width of physical and virtual addresses are also separated to show
only 8 nibbles of virtual but 11 nibbles of physical with XPA.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lib/dump_tlb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index b918646d6c8d..0be4b8f8a666 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -47,9 +47,13 @@ static void dump_tlb(int first, int last)
 	unsigned long long entrylo0, entrylo1, pa;
 	unsigned int s_index, s_pagemask, pagemask, c0, c1, i;
 #ifdef CONFIG_32BIT
-	int width = 8;
+	bool xpa = cpu_has_xpa && (read_c0_pagegrain() & PG_ELPA);
+	int pwidth = xpa ? 11 : 8;
+	int vwidth = 8;
 #else
-	int width = 11;
+	bool xpa = false;
+	int pwidth = 11;
+	int vwidth = 11;
 #endif
 
 	s_pagemask = read_c0_pagemask();
@@ -89,10 +93,12 @@ static void dump_tlb(int first, int last)
 		c1 = (entrylo1 >> 3) & 7;
 
 		printk("va=%0*lx asid=%02lx\n",
-		       width, (entryhi & ~0x1fffUL),
+		       vwidth, (entryhi & ~0x1fffUL),
 		       entryhi & 0xff);
 		/* RI/XI are in awkward places, so mask them off separately */
 		pa = entrylo0 & ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
+		if (xpa)
+			pa |= (unsigned long long)readx_c0_entrylo0() << 30;
 		pa = (pa << 6) & PAGE_MASK;
 		printk("\t[");
 		if (cpu_has_rixi)
@@ -100,19 +106,21 @@ static void dump_tlb(int first, int last)
 			       (entrylo0 & MIPS_ENTRYLO_RI) ? 1 : 0,
 			       (entrylo0 & MIPS_ENTRYLO_XI) ? 1 : 0);
 		printk("pa=%0*llx c=%d d=%d v=%d g=%d] [",
-		       width, pa, c0,
+		       pwidth, pa, c0,
 		       (entrylo0 & 4) ? 1 : 0,
 		       (entrylo0 & 2) ? 1 : 0,
 		       (entrylo0 & 1) ? 1 : 0);
 		/* RI/XI are in awkward places, so mask them off separately */
 		pa = entrylo1 & ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
+		if (xpa)
+			pa |= (unsigned long long)readx_c0_entrylo1() << 30;
 		pa = (pa << 6) & PAGE_MASK;
 		if (cpu_has_rixi)
 			printk("ri=%d xi=%d ",
 			       (entrylo1 & MIPS_ENTRYLO_RI) ? 1 : 0,
 			       (entrylo1 & MIPS_ENTRYLO_XI) ? 1 : 0);
 		printk("pa=%0*llx c=%d d=%d v=%d g=%d]\n",
-		       width, pa, c1,
+		       pwidth, pa, c1,
 		       (entrylo1 & 4) ? 1 : 0,
 		       (entrylo1 & 2) ? 1 : 0,
 		       (entrylo1 & 1) ? 1 : 0);
-- 
2.3.6
