Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2016 16:48:21 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:62363 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992196AbcIVOsOv9hLD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2016 16:48:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3AB3B8A55177B;
        Thu, 22 Sep 2016 15:48:05 +0100 (IST)
Received: from localhost (10.100.200.30) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 22 Sep
 2016 15:48:07 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Fix delay slot emulation count in debugfs
Date:   Thu, 22 Sep 2016 15:47:40 +0100
Message-ID: <20160922144740.4273-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.30]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55236
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

Commit 432c6bacbd0c ("MIPS: Use per-mm page to execute branch delay slot
instructions") accidentally removed use of the MIPS_FPU_EMU_INC_STATS
macro from do_dsemulret, leading to the ds_emul file in debugfs always
returning zero even though we perform delay slot emulations.

Fix this by re-adding the use of the MIPS_FPU_EMU_INC_STATS macro.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 432c6bacbd0c ("MIPS: Use per-mm page to execute branch delay slot instructions")
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/math-emu/dsemul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 72a4642..4a094f7 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -298,5 +298,6 @@ bool do_dsemulret(struct pt_regs *xcp)
 	/* Set EPC to return to post-branch instruction */
 	xcp->cp0_epc = current->thread.bd_emu_cont_pc;
 	pr_debug("dsemulret to 0x%08lx\n", xcp->cp0_epc);
+	MIPS_FPU_EMU_INC_STATS(ds_emul);
 	return true;
 }
-- 
2.10.0
