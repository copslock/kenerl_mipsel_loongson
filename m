Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 19:39:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40888 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991986AbcKGSjiIHo5T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 19:39:38 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 8B7D599C3F502;
        Mon,  7 Nov 2016 18:39:28 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 18:39:31 +0000
Received: from [127.0.1.1] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 7 Nov 2016
 10:39:28 -0800
Subject: [PATCH] MIPS: R2-on-R6 emulation bugfix of BLEZL and BGTZL
 instructions
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <yamada.masahiro@socionext.com>, <macro@imgtec.com>
Date:   Mon, 7 Nov 2016 10:39:28 -0800
Message-ID: <20161107183928.27456.13089.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

MIPS R2 emulation doesn't take into account that BLEZL and BGTZL instructions
require register RT = 0. If it is not zero it can be some legitimate MIPS R6
instruction.

Problem happens after emulation optimization then emulation routine tries
to pipeline emulation and after emulation of one instruction it picks up
a next candidate. In single pass strategy it does not happen because CPU
doesn't trap on branch-compacts which share opcode space with BLEZL/BGTZL
(but has RT != 0, of course).

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Reported-by: Douglas Leung <Douglas.Leung@imgtec.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index 22dedd62818a..b0c86b08c0b9 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -919,6 +919,7 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 		BUG();
 		return SIGEMT;
 	}
+	err = 0;
 	pr_debug("Emulating the 0x%08x R2 instruction @ 0x%08lx (pass=%d))\n",
 		 inst, epc, pass);
 
@@ -1096,10 +1097,16 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 		}
 		break;
 
-	case beql_op:
-	case bnel_op:
 	case blezl_op:
 	case bgtzl_op:
+		/* return MIPS R6 instruction to CPU execution */
+		if (MIPSInst_RT(inst)) {
+			err = SIGILL;
+			break;
+		}
+
+	case beql_op:
+	case bnel_op:
 		if (delay_slot(regs)) {
 			err = SIGILL;
 			break;
