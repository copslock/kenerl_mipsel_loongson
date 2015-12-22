Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 14:56:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12342 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008443AbbLVN452esyV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 14:56:57 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 45A94939D4492;
        Tue, 22 Dec 2015 13:56:49 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 22 Dec 2015 13:56:51 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 22 Dec 2015 13:56:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: ptrace: Drop cp0_tcstatus from regoffset_table[]
Date:   Tue, 22 Dec 2015 13:56:39 +0000
Message-ID: <1450792599-3274-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50731
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

The cp0_tcstatus member of struct pt_regs was removed along with the
rest of SMTC in v3.16, commit b633648c5ad3 ("MIPS: MT: Remove SMTC
support"), however recent uprobes support in v4.3 added back a reference
to it in the regoffset_table[] in ptrace.c. Remove it.

Fixes: 40e084a506eb ("MIPS: Add uprobes support.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/ptrace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 4f0ac78d17f1..a5279b2f3198 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -548,9 +548,6 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REG_OFFSET_NAME(c0_badvaddr, cp0_badvaddr),
 	REG_OFFSET_NAME(c0_cause, cp0_cause),
 	REG_OFFSET_NAME(c0_epc, cp0_epc),
-#ifdef CONFIG_MIPS_MT_SMTC
-	REG_OFFSET_NAME(c0_tcstatus, cp0_tcstatus),
-#endif
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 	REG_OFFSET_NAME(mpl0, mpl[0]),
 	REG_OFFSET_NAME(mpl1, mpl[1]),
-- 
2.4.10
