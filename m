Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 17:26:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42833 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993006AbcJaQ0i3UQI1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 17:26:38 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0942BBE25DAFF;
        Mon, 31 Oct 2016 16:26:29 +0000 (GMT)
Received: from [10.20.78.238] (10.20.78.238) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 31 Oct 2016
 16:26:31 +0000
Date:   Mon, 31 Oct 2016 16:26:24 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] MIPS: Remove FIR from ISA I FP signal context
In-Reply-To: <alpine.DEB.2.00.1610310319010.31859@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1610310345580.31859@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1610310319010.31859@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.238]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55611
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

Complement commit e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP ASE.") 
and remove the Floating Point Implementation Register (FIR) from the FP 
register set recorded in a signal context with MIPS I processors too, in 
line with the change applied to r4k_fpu.S.

The `sc_fpc_eir' slot is unused according to our current ABI and the FIR 
register is read-only and always directly accessible from user software.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-isa1-sig-fp-context-dsp.patch
Index: linux-sfr-test/arch/mips/kernel/r2300_fpu.S
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/r2300_fpu.S	2016-10-22 02:17:38.000000000 +0100
+++ linux-sfr-test/arch/mips/kernel/r2300_fpu.S	2016-10-22 02:19:40.565112000 +0100
@@ -64,13 +64,9 @@ LEAF(_save_fp_context)
 	EX(swc1 $f29,(SC_FPREGS+232)(a0))
 	EX(swc1 $f30,(SC_FPREGS+240)(a0))
 	EX(swc1 $f31,(SC_FPREGS+248)(a0))
-	EX(sw	t1,(SC_FPC_CSR)(a0))
-	cfc1	t0,$0				# implementation/version
 	jr	ra
+	 EX(sw	t1,(SC_FPC_CSR)(a0))
 	.set	pop
-	.set	nomacro
-	 EX(sw	t0,(SC_FPC_EIR)(a0))
-	.set	macro
 	END(_save_fp_context)
 
 /*
