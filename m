Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 17:20:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61840 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013243AbaKJQUTWPtyG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 17:20:19 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 08D11EF09D25E
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 16:20:11 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 10 Nov 2014 16:20:13 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.149) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 10 Nov 2014 16:20:13 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/3] MIPS: kernel: traps: Dump the HTW registers on a MC exception
Date:   Mon, 10 Nov 2014 16:20:03 +0000
Message-ID: <1415636404-11979-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1415636404-11979-1-git-send-email-markos.chandras@imgtec.com>
References: <1415636404-11979-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The HTW registers can be useful to debug a MC exception.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 51fa5c3aa4fe..32feb481a67a 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1385,6 +1385,11 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
 		pr_info("EntryHi : %0*lx\n", field, read_c0_entryhi());
 		pr_info("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
 		pr_info("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
+		if (cpu_has_htw) {
+			pr_info("PWField : %0*lx\n", field, read_c0_pwfield());
+			pr_info("PWSize  : %0*lx\n", field, read_c0_pwsize());
+			pr_info("PWCtl   : %0x\n", read_c0_pwctl());
+		}
 		pr_info("\n");
 		dump_tlb_all();
 	}
-- 
2.1.3
