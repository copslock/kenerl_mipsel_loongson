Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Aug 2013 21:10:50 +0200 (CEST)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:61161 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822679Ab3HSTKsLUrk9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Aug 2013 21:10:48 +0200
Received: by mail-ob0-f173.google.com with SMTP id ta17so5962441obb.4
        for <multiple recipients>; Mon, 19 Aug 2013 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pfUDpZyqqywdUq/3pUyw171CjNzzektEqpCqOkxE/Dg=;
        b=ueVI78EyxPCEOJpIM2dgrTVNHW3UfJI+X2atSon6ZnhBdSNbw7TDD3d/PuD4NgXhlV
         NC/zOop7GK3WT1ISgsbkI/Z19s5RdgzyCgP27ngP1XxmDDM9up6TtdajtTQPcf79VQX6
         3V5lOsLSWg9iV5bu6PxrxzNMxKYkYzfkwuFSLPqbgoLCmgynXyGz0vUqV7J6FDPStcNO
         XFwsCNXzNCT0Evhl1n4e1kwxggE0pTvmjJT9vfu81fWVjyRpluY4N14wHAQNRKOnLGua
         jbzGUPyAj177QiVscVkgTxHZjUjKSVlpqraRCuvaV7+F/mkyQ2etv76jVtORuT0x6iVT
         bXTA==
X-Received: by 10.60.135.196 with SMTP id pu4mr33962oeb.89.1376939441846;
        Mon, 19 Aug 2013 12:10:41 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id hl3sm18726033obb.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 Aug 2013 12:10:40 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r7JJAdQb019801;
        Mon, 19 Aug 2013 12:10:39 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r7JJAcwc019800;
        Mon, 19 Aug 2013 12:10:38 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: Handle OCTEON BBIT instructions in FPU emulator.
Date:   Mon, 19 Aug 2013 12:10:34 -0700
Message-Id: <1376939435-19761-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1376939435-19761-1-git-send-email-ddaney.cavm@gmail.com>
References: <1376939435-19761-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The branch emulation needs to handle the OCTEON BBIT instructions,
otherwise we get SIGILL instead of emulation.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/math-emu/cp1emu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index e773659..46048d2 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -803,6 +803,32 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.next_pc_inc;
 		return 1;
 		break;
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	case lwc2_op: /* This is bbit0 on Octeon */
+		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt)) == 0)
+			*contpc = regs->cp0_epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			*contpc = regs->cp0_epc + 8;
+		return 1;
+	case ldc2_op: /* This is bbit032 on Octeon */
+		if ((regs->regs[insn.i_format.rs] & (1ull<<(insn.i_format.rt + 32))) == 0)
+			*contpc = regs->cp0_epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			*contpc = regs->cp0_epc + 8;
+		return 1;
+	case swc2_op: /* This is bbit1 on Octeon */
+		if (regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt))
+			*contpc = regs->cp0_epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			*contpc = regs->cp0_epc + 8;
+		return 1;
+	case sdc2_op: /* This is bbit132 on Octeon */
+		if (regs->regs[insn.i_format.rs] & (1ull<<(insn.i_format.rt + 32)))
+			*contpc = regs->cp0_epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			*contpc = regs->cp0_epc + 8;
+		return 1;
+#endif
 	case cop0_op:
 	case cop1_op:
 	case cop2_op:
-- 
1.7.11.7
