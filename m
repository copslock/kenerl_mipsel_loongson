Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:23:01 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43573 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827312AbaA0UVbCzhi3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:21:31 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 08/58] MIPS: kernel: traps: Whitespace clean up
Date:   Mon, 27 Jan 2014 20:18:55 +0000
Message-ID: <1390853985-14246-9-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_21_26
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39126
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

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e0b4996..3e5e700 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -10,6 +10,7 @@
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2002, 2003, 2004, 2005, 2007  Maciej W. Rozycki
  * Copyright (C) 2000, 2001, 2012 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2014, Imagination Technologies Ltd.
  */
 #include <linux/bug.h>
 #include <linux/compiler.h>
@@ -870,17 +871,19 @@ asmlinkage void do_bp(struct pt_regs *regs)
 			if ((__get_user(instr[0], (u16 __user *)msk_isa16_mode(epc)) ||
 			    (__get_user(instr[1], (u16 __user *)msk_isa16_mode(epc + 2)))))
 				goto out_sigsegv;
-		    opcode = (instr[0] << 16) | instr[1];
+			opcode = (instr[0] << 16) | instr[1];
 		} else {
-		    /* MIPS16e mode */
-		    if (__get_user(instr[0], (u16 __user *)msk_isa16_mode(epc)))
+			/* MIPS16e mode */
+			if (__get_user(instr[0],
+				       (u16 __user *)msk_isa16_mode(epc)))
 				goto out_sigsegv;
-		    bcode = (instr[0] >> 6) & 0x3f;
-		    do_trap_or_bp(regs, bcode, "Break");
-		    goto out;
+			bcode = (instr[0] >> 6) & 0x3f;
+			do_trap_or_bp(regs, bcode, "Break");
+			goto out;
 		}
 	} else {
-		if (__get_user(opcode, (unsigned int __user *) exception_epc(regs)))
+		if (__get_user(opcode,
+			       (unsigned int __user *) exception_epc(regs)))
 			goto out_sigsegv;
 	}
 
-- 
1.8.5.3
