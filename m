Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 17:31:41 +0200 (CEST)
Received: from relay1.mentorg.com ([192.94.38.131]:51584 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817975Ab3EWPbjLNWQu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 17:31:39 +0200
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
        by relay1.mentorg.com with esmtp 
        id 1UfXUJ-00042U-DO from Maciej_Rozycki@mentor.com ; Thu, 23 May 2013 08:31:31 -0700
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 May 2013 08:31:31 -0700
Received: from [172.30.64.76] (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server id 14.2.247.3; Thu, 23 May 2013
 16:31:28 +0100
Date:   Thu, 23 May 2013 16:31:23 +0100
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Trap exception handling fixes
Message-ID: <alpine.DEB.1.10.1305230253140.26443@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-OriginalArrivalTime: 23 May 2013 15:31:31.0218 (UTC) FILETIME=[99978F20:01CE57CA]
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

2a0b24f56c2492b932f1aed617ae80fb23500d21 broke Trap exception handling in 
the standard MIPS mode.  Additionally the microMIPS-mode trap code mask is 
wrong, as it's a 4-bit field.  Here's a fix.

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
Ralf, please apply.  Also the mention of: "A few NOP instructions are used 
to maintain the correct alignment[...]" in the commit referred makes me 
feel scared -- there is that .align pseudo-op, you know...  Maciej

linux-mips-do-tr.diff

 arch/mips/kernel/traps.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e3be670..a75ae40 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -897,22 +897,24 @@ out_sigsegv:
 
 asmlinkage void do_tr(struct pt_regs *regs)
 {
-	unsigned int opcode, tcode = 0;
+	u32 opcode, tcode = 0;
 	u16 instr[2];
-	unsigned long epc = exception_epc(regs);
+	unsigned long epc = msk_isa16_mode(exception_epc(regs));
 
-	if ((__get_user(instr[0], (u16 __user *)msk_isa16_mode(epc))) ||
-		(__get_user(instr[1], (u16 __user *)msk_isa16_mode(epc + 2))))
+	if (get_isa16_mode(regs->cp0_epc)) {
+		if (__get_user(instr[0], (u16 __user *)(epc + 0)) ||
+		    __get_user(instr[1], (u16 __user *)(epc + 2)))
 			goto out_sigsegv;
-	opcode = (instr[0] << 16) | instr[1];
-
-	/* Immediate versions don't provide a code.  */
-	if (!(opcode & OPCODE)) {
-		if (get_isa16_mode(regs->cp0_epc))
-			/* microMIPS */
-			tcode = (opcode >> 12) & 0x1f;
-		else
-			tcode = ((opcode >> 6) & ((1 << 10) - 1));
+		opcode = (instr[0] << 16) | instr[1];
+		/* Immediate versions don't provide a code.  */
+		if (!(opcode & OPCODE))
+			tcode = (opcode >> 12) & ((1 << 4) - 1);
+	} else {
+		if (__get_user(opcode, (u32 __user *)epc))
+			goto out_sigsegv;
+		/* Immediate versions don't provide a code.  */
+		if (!(opcode & OPCODE))
+			tcode = (opcode >> 6) & ((1 << 10) - 1);
 	}
 
 	do_trap_or_bp(regs, tcode, "Trap");
