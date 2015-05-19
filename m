Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 10:52:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4142 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013550AbbESIvPwkhP4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 10:51:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 27294276F6E83;
        Tue, 19 May 2015 09:51:10 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 19 May 2015 09:51:12 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 19 May 2015 09:51:11 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH v2 10/10] MIPS: dump_tlb: Take XPA into account
Date:   Tue, 19 May 2015 09:50:38 +0100
Message-ID: <1432025438-26431-11-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 47472
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
index 1fefd38aba08..167f35634709 100644
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
@@ -96,10 +100,12 @@ static void dump_tlb(int first, int last)
 		c1 = (entrylo1 & MIPS_ENTRYLO_C) >> MIPS_ENTRYLO_C_SHIFT;
 
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
@@ -107,19 +113,21 @@ static void dump_tlb(int first, int last)
 			       (entrylo0 & MIPS_ENTRYLO_RI) ? 1 : 0,
 			       (entrylo0 & MIPS_ENTRYLO_XI) ? 1 : 0);
 		printk("pa=%0*llx c=%d d=%d v=%d g=%d] [",
-		       width, pa, c0,
+		       pwidth, pa, c0,
 		       (entrylo0 & MIPS_ENTRYLO_D) ? 1 : 0,
 		       (entrylo0 & MIPS_ENTRYLO_V) ? 1 : 0,
 		       (entrylo0 & MIPS_ENTRYLO_G) ? 1 : 0);
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
 		       (entrylo1 & MIPS_ENTRYLO_D) ? 1 : 0,
 		       (entrylo1 & MIPS_ENTRYLO_V) ? 1 : 0,
 		       (entrylo1 & MIPS_ENTRYLO_G) ? 1 : 0);
-- 
2.3.6
