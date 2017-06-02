Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 00:39:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61275 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993929AbdFBWjRQIkr3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 00:39:17 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 66F5EFFC27172;
        Fri,  2 Jun 2017 23:39:06 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 23:39:10
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/6] MIPS: Handle tlbex-tlbp race condition
Date:   Fri, 2 Jun 2017 15:38:02 -0700
Message-ID: <20170602223806.5078-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602223806.5078-1-paul.burton@imgtec.com>
References: <20170602223806.5078-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58166
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

In systems where there are multiple actors updating the TLB, the
potential exists for a race condition wherein a CPU hits a TLB exception
but by the time it reaches a TLBP instruction the affected TLB entry may
have been replaced. This can happen if, for example, a CPU shares the
TLB between hardware threads (VPs) within a core and one of them
replaces the entry that another has just taken a TLB exception for.

We handle this race in the case of the Hardware Table Walker (HTW) being
the other actor already, but didn't take into account the potential for
multiple threads racing. Include the code for aborting TLB exception
handling in affected multi-threaded systems, those being the I6400 &
I6500 CPUs which share TLB entries between VPs.

In the case of using RiXi without dedicated exceptions we have never
handled this race even for HTW. This patch adds WARN()s to these cases
which ought never to be hit because all CPUs with either HTW or shared
FTLB RAMs also include dedicated RiXi exceptions, but the WARN()s will
ensure this is always the case.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/mm/tlbex.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ed1c5297547a..e6499209b81c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2015,6 +2015,26 @@ static void build_r3000_tlb_modify_handler(void)
 }
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
 
+static bool cpu_has_tlbex_tlbp_race(void)
+{
+	/*
+	 * When a Hardware Table Walker is running it can replace TLB entries
+	 * at any time, leading to a race between it & the CPU.
+	 */
+	if (cpu_has_htw)
+		return true;
+
+	/*
+	 * If the CPU shares FTLB RAM with its siblings then our entry may be
+	 * replaced at any time by a sibling performing a write to the FTLB.
+	 */
+	if (cpu_has_shared_ftlb_ram)
+		return true;
+
+	/* In all other cases there ought to be no race condition to handle */
+	return false;
+}
+
 /*
  * R4000 style TLB load/store/modify handlers.
  */
@@ -2051,7 +2071,7 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 	iPTE_LW(p, wr.r1, wr.r2); /* get even pte */
 	if (!m4kc_tlbp_war()) {
 		build_tlb_probe_entry(p);
-		if (cpu_has_htw) {
+		if (cpu_has_tlbex_tlbp_race()) {
 			/* race condition happens, leaving */
 			uasm_i_ehb(p);
 			uasm_i_mfc0(p, wr.r3, C0_INDEX);
@@ -2125,6 +2145,14 @@ static void build_r4000_tlb_load_handler(void)
 		}
 		uasm_i_nop(&p);
 
+		/*
+		 * Warn if something may race with us & replace the TLB entry
+		 * before we read it here. Everything with such races should
+		 * also have dedicated RiXi exception handlers, so this
+		 * shouldn't be hit.
+		 */
+		WARN(cpu_has_tlbex_tlbp_race(), "Unhandled race in RiXi path");
+
 		uasm_i_tlbr(&p);
 
 		switch (current_cpu_type()) {
@@ -2192,6 +2220,14 @@ static void build_r4000_tlb_load_handler(void)
 		}
 		uasm_i_nop(&p);
 
+		/*
+		 * Warn if something may race with us & replace the TLB entry
+		 * before we read it here. Everything with such races should
+		 * also have dedicated RiXi exception handlers, so this
+		 * shouldn't be hit.
+		 */
+		WARN(cpu_has_tlbex_tlbp_race(), "Unhandled race in RiXi path");
+
 		uasm_i_tlbr(&p);
 
 		switch (current_cpu_type()) {
-- 
2.13.0
