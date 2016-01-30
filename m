Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 10:09:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34383 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010110AbcA3JIt1q-2N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 10:08:49 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 4A26BB9E0F56D;
        Sat, 30 Jan 2016 09:08:42 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Sat, 30 Jan 2016
 09:08:43 +0000
Date:   Sat, 30 Jan 2016 09:08:43 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 3/3] MIPS: traps.c: Verify the ISA for microMIPS RDHWR
 emulation
In-Reply-To: <alpine.DEB.2.00.1601300356250.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601300403230.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1601300356250.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Make sure it's the microMIPS rather than MIPS16 ISA before emulating 
microMIPS RDHWR.  Mostly needed as an optimisation for configurations 
where `cpu_has_mmips' is hardcoded to 0 and also a good measure in case 
we add further microMIPS instructions to emulate in the future, as the 
corresponding MIPS16 encoding is ADDIUSP, not supposed to trap.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-umips-rdhwr-isa.diff
Index: linux-sfr-test/arch/mips/kernel/traps.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/traps.c	2016-01-30 03:42:36.000000000 +0000
+++ linux-sfr-test/arch/mips/kernel/traps.c	2016-01-30 03:42:14.980343000 +0000
@@ -1116,19 +1116,7 @@ asmlinkage void do_ri(struct pt_regs *re
 	if (unlikely(compute_return_epc(regs) < 0))
 		goto out;
 
-	if (get_isa16_mode(regs->cp0_epc)) {
-		unsigned short mmop[2] = { 0 };
-
-		if (unlikely(get_user(mmop[0], (u16 __user *)epc + 0) < 0))
-			status = SIGSEGV;
-		if (unlikely(get_user(mmop[1], (u16 __user *)epc + 1) < 0))
-			status = SIGSEGV;
-		opcode = mmop[0];
-		opcode = (opcode << 16) | mmop[1];
-
-		if (status < 0)
-			status = simulate_rdhwr_mm(regs, opcode);
-	} else {
+	if (!get_isa16_mode(regs->cp0_epc)) {
 		if (unlikely(get_user(opcode, epc) < 0))
 			status = SIGSEGV;
 
@@ -1143,6 +1131,18 @@ asmlinkage void do_ri(struct pt_regs *re
 
 		if (status < 0)
 			status = simulate_fp(regs, opcode, old_epc, old31);
+	} else if (cpu_has_mmips) {
+		unsigned short mmop[2] = { 0 };
+
+		if (unlikely(get_user(mmop[0], (u16 __user *)epc + 0) < 0))
+			status = SIGSEGV;
+		if (unlikely(get_user(mmop[1], (u16 __user *)epc + 1) < 0))
+			status = SIGSEGV;
+		opcode = mmop[0];
+		opcode = (opcode << 16) | mmop[1];
+
+		if (status < 0)
+			status = simulate_rdhwr_mm(regs, opcode);
 	}
 
 	if (status < 0)
