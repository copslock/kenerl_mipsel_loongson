Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 10:08:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37128 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009873AbcA3JIeFcG-N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 10:08:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id B756FC4754296;
        Sat, 30 Jan 2016 09:08:26 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Sat, 30 Jan 2016
 09:08:28 +0000
Date:   Sat, 30 Jan 2016 09:08:28 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 2/3] MIPS: traps.c: Correct microMIPS RDHWR emulation
In-Reply-To: <alpine.DEB.2.00.1601300356250.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601300403100.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1601300356250.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51546
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

Fix the code to fetch and decode the whole 32-bit instruction.  This 
only really matters with the `noulri' kernel parameter as all microMIPS 
processors are supposed to have all the hardware registers we support.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-umips-rdhwr-opcode.diff
Index: linux-sfr-test/arch/mips/kernel/traps.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/traps.c	2016-01-30 03:39:20.000000000 +0000
+++ linux-sfr-test/arch/mips/kernel/traps.c	2016-01-30 03:40:58.944753000 +0000
@@ -663,7 +663,7 @@ static int simulate_rdhwr_normal(struct 
 	return -1;
 }
 
-static int simulate_rdhwr_mm(struct pt_regs *regs, unsigned short opcode)
+static int simulate_rdhwr_mm(struct pt_regs *regs, unsigned int opcode)
 {
 	if ((opcode & MM_POOL32A_FUNC) == MM_RDHWR) {
 		int rd = (opcode & MM_RS) >> 16;
@@ -1119,11 +1119,12 @@ asmlinkage void do_ri(struct pt_regs *re
 	if (get_isa16_mode(regs->cp0_epc)) {
 		unsigned short mmop[2] = { 0 };
 
-		if (unlikely(get_user(mmop[0], epc) < 0))
+		if (unlikely(get_user(mmop[0], (u16 __user *)epc + 0) < 0))
 			status = SIGSEGV;
-		if (unlikely(get_user(mmop[1], epc) < 0))
+		if (unlikely(get_user(mmop[1], (u16 __user *)epc + 1) < 0))
 			status = SIGSEGV;
-		opcode = (mmop[0] << 16) | mmop[1];
+		opcode = mmop[0];
+		opcode = (opcode << 16) | mmop[1];
 
 		if (status < 0)
 			status = simulate_rdhwr_mm(regs, opcode);
