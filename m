Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 16:52:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59887 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029025AbcEKOu5jivXz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 16:50:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 3578E9B2E42CF;
        Wed, 11 May 2016 15:50:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 15:50:51 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 11 May 2016 15:50:51 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 5/6] MIPS: dump_tlb: Preserve and dump GuestID
Date:   Wed, 11 May 2016 15:50:31 +0100
Message-ID: <1462978232-10670-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1462978232-10670-1-git-send-email-james.hogan@imgtec.com>
References: <1462978232-10670-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53378
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
Changes in v2:
- Rebased to resolve conflicts with extended ASID patchset.
---
 arch/mips/lib/dump_tlb.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 3283aa7423e4..2cb10dba8838 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -72,7 +72,8 @@ static void dump_tlb(int first, int last)
 {
 	unsigned long s_entryhi, entryhi, asid;
 	unsigned long long entrylo0, entrylo1, pa;
-	unsigned int s_index, s_pagemask, pagemask, c0, c1, i;
+	unsigned int s_index, s_pagemask, s_guestctl1 = 0;
+	unsigned int pagemask, guestctl1 = 0, c0, c1, i;
 	unsigned long asidmask = cpu_asid_mask(&current_cpu_data);
 	int asidwidth = DIV_ROUND_UP(ilog2(asidmask) + 1, 4);
 #ifdef CONFIG_32BIT
@@ -89,6 +90,8 @@ static void dump_tlb(int first, int last)
 	s_entryhi = read_c0_entryhi();
 	s_index = read_c0_index();
 	asid = s_entryhi & asidmask;
+	if (cpu_has_guestid)
+		s_guestctl1 = read_c0_guestctl1();
 
 	for (i = first; i <= last; i++) {
 		write_c0_index(i);
@@ -99,6 +102,8 @@ static void dump_tlb(int first, int last)
 		entryhi	 = read_c0_entryhi();
 		entrylo0 = read_c0_entrylo0();
 		entrylo1 = read_c0_entrylo1();
+		if (cpu_has_guestid)
+			guestctl1 = read_c0_guestctl1();
 
 		/* EHINV bit marks entire entry as invalid */
 		if (cpu_has_tlbinv && entryhi & MIPS_ENTRYHI_EHINV)
@@ -128,15 +133,19 @@ static void dump_tlb(int first, int last)
 		c0 = (entrylo0 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
 		c1 = (entrylo1 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
 
-		printk("va=%0*lx asid=%0*lx\n",
+		printk("va=%0*lx asid=%0*lx",
 		       vwidth, (entryhi & ~0x1fffUL),
 		       asidwidth, entryhi & asidmask);
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
@@ -166,6 +175,8 @@ static void dump_tlb(int first, int last)
 	write_c0_entryhi(s_entryhi);
 	write_c0_index(s_index);
 	write_c0_pagemask(s_pagemask);
+	if (cpu_has_guestid)
+		write_c0_guestctl1(s_guestctl1);
 }
 
 void dump_tlb_all(void)
-- 
2.4.10
