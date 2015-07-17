Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2015 11:38:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31051 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009572AbbGQJipZNcTb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jul 2015 11:38:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 609DC295428CE;
        Fri, 17 Jul 2015 10:38:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 17 Jul 2015 10:38:39 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 17 Jul 2015 10:38:39 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: math-emu: cp1emu: Emulate missing BC1{EQ,NE}Z instructions
Date:   Fri, 17 Jul 2015 10:38:32 +0100
Message-ID: <1437125912-12761-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48339
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

Commit c8a34581ec09 ("MIPS: Emulate the BC1{EQ,NE}Z FPU instructions")
added support for emulating the new R6 BC1{EQ,NE}Z branches but it missed
the case where the instruction that caused the exception was not on a DS.

Cc: <stable@vger.kernel.org> # 4.0+
Fixes: c8a34581ec09 ("MIPS: Emulate the BC1{EQ,NE}Z FPU instructions")
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 70e88efee45b..f0f1b98a5fde 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1181,6 +1181,24 @@ emul:
 			}
 			break;
 
+		case bc1eqz_op:
+		case bc1nez_op:
+			if (!cpu_has_mips_r6 || delay_slot(xcp))
+				return SIGILL;
+
+			cond = likely = 0;
+			switch (MIPSInst_RS(ir)) {
+			case bc1eqz_op:
+				if (get_fpr32(&current->thread.fpu.fpr[MIPSInst_RT(ir)], 0) & 0x1)
+				    cond = 1;
+				break;
+			case bc1nez_op:
+				if (!(get_fpr32(&current->thread.fpu.fpr[MIPSInst_RT(ir)], 0) & 0x1))
+				    cond = 1;
+				break;
+			}
+			goto branch_common;
+
 		case bc_op:
 			if (delay_slot(xcp))
 				return SIGILL;
@@ -1207,7 +1225,7 @@ emul:
 			case bct_op:
 				break;
 			}
-
+branch_common:
 			set_delay_slot(xcp);
 			if (cond) {
 				/*
-- 
2.4.5
