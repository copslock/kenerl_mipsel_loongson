Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2016 15:54:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54356 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027790AbcD2NxZ5nPNi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Apr 2016 15:53:25 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 5900DBAA65E92;
        Fri, 29 Apr 2016 14:53:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 29 Apr 2016 14:53:19 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 29 Apr 2016 14:53:19 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 5/6] MIPS: dump_tlb: Preserve and dump GuestID
Date:   Fri, 29 Apr 2016 14:53:07 +0100
Message-ID: <1461937988-13787-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1461937988-13787-1-git-send-email-james.hogan@imgtec.com>
References: <1461937988-13787-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53264
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

The GuestID for root TLB operations (GuestCtl1.RID) is modified by TLB
reads, so needs preserving by dump_tlb() like the ASID field of EntryHi.

Also dump the GuestID of each entry if it exists alongside the ASID, as
it forms an important part of the TLB entry when VZ guests are used.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lib/dump_tlb.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 92a37319efbe..38642dda4e09 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -72,7 +72,8 @@ static void dump_tlb(int first, int last)
 {
 	unsigned long s_entryhi, entryhi, asid;
 	unsigned long long entrylo0, entrylo1, pa;
-	unsigned int s_index, s_pagemask, pagemask, c0, c1, i;
+	unsigned int s_index, s_pagemask, s_guestctl1 = 0;
+	unsigned int pagemask, guestctl1 = 0, c0, c1, i;
 #ifdef CONFIG_32BIT
 	bool xpa = cpu_has_xpa && (read_c0_pagegrain() & PG_ELPA);
 	int pwidth = xpa ? 11 : 8;
@@ -87,6 +88,8 @@ static void dump_tlb(int first, int last)
 	s_entryhi = read_c0_entryhi();
 	s_index = read_c0_index();
 	asid = s_entryhi & 0xff;
+	if (cpu_has_guestid)
+		s_guestctl1 = read_c0_guestctl1();
 
 	for (i = first; i <= last; i++) {
 		write_c0_index(i);
@@ -97,6 +100,8 @@ static void dump_tlb(int first, int last)
 		entryhi	 = read_c0_entryhi();
 		entrylo0 = read_c0_entrylo0();
 		entrylo1 = read_c0_entrylo1();
+		if (cpu_has_guestid)
+			guestctl1 = read_c0_guestctl1();
 
 		/* EHINV bit marks entire entry as invalid */
 		if (cpu_has_tlbinv && entryhi & MIPS_ENTRYHI_EHINV)
@@ -126,15 +131,19 @@ static void dump_tlb(int first, int last)
 		c0 = (entrylo0 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
 		c1 = (entrylo1 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
 
-		printk("va=%0*lx asid=%02lx\n",
+		printk("va=%0*lx asid=%02lx",
 		       vwidth, (entryhi & ~0x1fffUL),
 		       entryhi & 0xff);
+		if (cpu_has_guestid)
+			printk(" gid=%02lx",
+			       (guestctl1 & MIPS_GCTL1_RID)
+					>> MIPS_GCTL1_RID_SHIFT);
 		/* RI/XI are in awkward places, so mask them off separately */
 		pa = entrylo0 & ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
 		if (xpa)
 			pa |= (unsigned long long)readx_c0_entrylo0() << 30;
 		pa = (pa << 6) & PAGE_MASK;
-		printk("\t[");
+		printk("\n\t[");
 		if (cpu_has_rixi)
 			printk("ri=%d xi=%d ",
 			       (entrylo0 & MIPS_ENTRYLO_RI) ? 1 : 0,
@@ -164,6 +173,8 @@ static void dump_tlb(int first, int last)
 	write_c0_entryhi(s_entryhi);
 	write_c0_index(s_index);
 	write_c0_pagemask(s_pagemask);
+	if (cpu_has_guestid)
+		write_c0_guestctl1(s_guestctl1);
 }
 
 void dump_tlb_all(void)
-- 
2.4.10
