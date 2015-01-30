Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 16:41:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44962 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012311AbbA3PknJz5yC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 16:40:43 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0FCEE7172C1C2;
        Fri, 30 Jan 2015 15:40:35 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 15:40:37 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 30 Jan 2015 15:40:36 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: traps: Fix inline asm ctc1 missing .set hardfloat
Date:   Fri, 30 Jan 2015 15:40:20 +0000
Message-ID: <1422632420-4973-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1422632420-4973-1-git-send-email-james.hogan@imgtec.com>
References: <1422632420-4973-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45579
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

Commit 842dfc11ea9a ("MIPS: Fix build with binutils 2.24.51+") in v3.18
enabled -msoft-float and sprinkled ".set hardfloat" where necessary to
use FP instructions. However it missed enable_restore_fp_context() which
since v3.17 does a ctc1 with inline assembly, causing the following
assembler errors on Mentor's 2014.05 toolchain:

{standard input}: Assembler messages:
{standard input}:2913: Error: opcode not supported on this processor: mips32r2 (mips32r2) `ctc1 $2,$31'
scripts/Makefile.build:257: recipe for target 'arch/mips/kernel/traps.o' failed

Fix that to use the new write_32bit_cp1_register() macro so that ".set
hardfloat" is automatically added when -msoft-float is in use.

Fixes 842dfc11ea9a ("MIPS: Fix build with binutils 2.24.51+")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.18+, depends on "MIPS: mipsregs.h: Add write_32bit_cp1_register()"
---
 arch/mips/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index dc209a4a1b8b..c8677b842d78 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1232,7 +1232,8 @@ static int enable_restore_fp_context(int msa)
 
 		/* Restore the scalar FP control & status register */
 		if (!was_fpu_owner)
-			asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
+			write_32bit_cp1_register(CP1_STATUS,
+						 current->thread.fpu.fcr31);
 	}
 
 out:
-- 
2.0.5
