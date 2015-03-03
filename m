Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 19:50:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17184 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011567AbbCCStvHLF6M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 19:49:51 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5CCFC5F8672FC
        for <linux-mips@linux-mips.org>; Tue,  3 Mar 2015 18:49:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 3 Mar 2015 18:49:45 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Mar 2015 18:49:45 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 3/4] MIPS: kernel: entry.S: Set correct ISA level for mips_ihb
Date:   Tue, 3 Mar 2015 18:48:49 +0000
Message-ID: <1425408530-21613-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1425408530-21613-1-git-send-email-markos.chandras@imgtec.com>
References: <1425408530-21613-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46105
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

Commit 6ebb496ffc7e("MIPS: kernel: entry.S: Add MIPS R6 related
definitions") added the MIPSR6 definition but it did not update the
ISA level of the actual assembly code so a pre-MIPSR6 jr.hb instruction
was generated instead. Fix this by using the MISP_ISA_LEVEL_RAW macro.

Fixes: 6ebb496ffc7e("MIPS: kernel: entry.S: Add MIPS R6 related definitions")
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/entry.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index af41ba6db960..7791840cf22c 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -10,6 +10,7 @@
 
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
+#include <asm/compiler.h>
 #include <asm/regdef.h>
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
@@ -185,7 +186,7 @@ syscall_exit_work:
  * For C code use the inline version named instruction_hazard().
  */
 LEAF(mips_ihb)
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	jr.hb	ra
 	nop
 	END(mips_ihb)
-- 
2.3.1
