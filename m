Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 17:19:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48050 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011206AbbGOPR62GjzK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 17:17:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 54CE0FF4DCCD3;
        Wed, 15 Jul 2015 16:17:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 15 Jul 2015 16:17:52 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 15 Jul 2015 16:17:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH 5/6] MIPS: dump_tlb: Dump FrameMask register if exists
Date:   Wed, 15 Jul 2015 16:17:46 +0100
Message-ID: <1436973467-3877-6-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 48312
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

The FrameMask register is relevant to the TLB so it should be dumped by
dump_tlb_regs(), however it is only present in certain cores (r10000,
r12000, r14000, r16000). Add dumping of it, conditional upon
current_cpu_type().

Suggested-by: Joshua Kinard <kumba@gentoo.org>
Suggested-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Joshua Kinard <kumba@gentoo.org>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lib/dump_tlb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 2ab83be14ffa..64f90f626681 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -23,6 +23,14 @@ void dump_tlb_regs(void)
 	pr_info("EntryLo0 : %0*lx\n", field, read_c0_entrylo0());
 	pr_info("EntryLo1 : %0*lx\n", field, read_c0_entrylo1());
 	pr_info("Wired    : %0x\n", read_c0_wired());
+	switch (current_cpu_type()) {
+	case CPU_R10000:
+	case CPU_R12000:
+	case CPU_R14000:
+	case CPU_R16000:
+		pr_info("FrameMask: %0x\n", read_c0_framemask());
+		break;
+	}
 	if (cpu_has_small_pages || cpu_has_rixi || cpu_has_xpa)
 		pr_info("PageGrain: %0x\n", read_c0_pagegrain());
 	if (cpu_has_htw) {
-- 
2.3.6
