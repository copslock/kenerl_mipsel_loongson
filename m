Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 17:19:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4175 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011207AbbGOPR57VdfK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 17:17:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C9BDD584C9B6D;
        Wed, 15 Jul 2015 16:17:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 15 Jul 2015 16:17:52 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 15 Jul 2015 16:17:51 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH 4/6] MIPS: dump_tlb: Only dump PageGrain if interesting
Date:   Wed, 15 Jul 2015 16:17:45 +0100
Message-ID: <1436973467-3877-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1436973467-3877-1-git-send-email-james.hogan@imgtec.com>
References: <1436973467-3877-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48311
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

The PageGrain register may not exist if certain architectural features
aren't present, therefore only print out its value when dumping the TLB
registers if it is expected to contain fields relevant to the TLB.

Fixes: d1e9a4f54735 ("MIPS: Add SysRq operation to dump TLBs on all CPUs")
Reported-by: Joshua Kinard <kumba@gentoo.org>
Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Joshua Kinard <kumba@gentoo.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lib/dump_tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 519ededbf9a4..2ab83be14ffa 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -23,7 +23,8 @@ void dump_tlb_regs(void)
 	pr_info("EntryLo0 : %0*lx\n", field, read_c0_entrylo0());
 	pr_info("EntryLo1 : %0*lx\n", field, read_c0_entrylo1());
 	pr_info("Wired    : %0x\n", read_c0_wired());
-	pr_info("PageGrain: %0x\n", read_c0_pagegrain());
+	if (cpu_has_small_pages || cpu_has_rixi || cpu_has_xpa)
+		pr_info("PageGrain: %0x\n", read_c0_pagegrain());
 	if (cpu_has_htw) {
 		pr_info("PWField  : %0*lx\n", field, read_c0_pwfield());
 		pr_info("PWSize   : %0*lx\n", field, read_c0_pwsize());
-- 
2.3.6
