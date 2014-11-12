Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:22:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35556 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013472AbaKLJWz0hxMn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:22:55 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5DB9F4B9B6745
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 09:22:46 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 12 Nov
 2014 09:22:48 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 12 Nov 2014 09:22:48 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.149) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 12 Nov 2014 09:22:47 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 2/3] MIPS: kernel: traps: Dump the HTW registers on a MC exception
Date:   Wed, 12 Nov 2014 09:22:42 +0000
Message-ID: <1415784162-6408-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1415636404-11979-3-git-send-email-markos.chandras@imgtec.com>
References: <1415636404-11979-3-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44045
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
Changes since v1:
- Replace pr_info() with pr_err()
---
 arch/mips/kernel/traps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 88075fecf306..bced37c0a188 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1385,6 +1385,11 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
 		pr_err("EntryHi : %0*lx\n", field, read_c0_entryhi());
 		pr_err("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
 		pr_err("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
+		if (cpu_has_htw) {
+			pr_err("PWField : %0*lx\n", field, read_c0_pwfield());
+			pr_err("PWSize  : %0*lx\n", field, read_c0_pwsize());
+			pr_err("PWCtl   : %0x\n", read_c0_pwctl());
+		}
 		pr_err("\n");
 		dump_tlb_all();
 	}
-- 
2.1.3
