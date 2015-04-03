Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:38:18 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025292AbbDCWcWKEytw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:32:22 +0200
Date:   Fri, 3 Apr 2015 23:32:22 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: DEC: Do not set up the FPU interrupt if no FPU
Message-ID: <alpine.LFD.2.11.1503041531460.18344@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Following the arrangement for processors that wire FPU exceptions to the
FPE CPU exception handle the case where no FPU is in use -- which for
DECstation systems will only ever happen when the "nofpu" kernel option
has been used -- do not register the FPU interrupt in such a case
either.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 This trivially depends on linux-mips-dec-kstat_irq_fpu.patch.

linux-mips-dec-nofpu.patch
Index: linux-20150220-3maxp/arch/mips/dec/setup.c
===================================================================
--- linux-20150220-3maxp.orig/arch/mips/dec/setup.c
+++ linux-20150220-3maxp/arch/mips/dec/setup.c
@@ -758,7 +758,7 @@ void __init arch_init_irq(void)
 		dec_interrupt[DEC_IRQ_HALT] = -1;
 
 	/* Register board interrupts: FPU and cascade. */
-	if (dec_interrupt[DEC_IRQ_FPU] >= 0) {
+	if (dec_interrupt[DEC_IRQ_FPU] >= 0 && cpu_has_fpu) {
 		struct irq_desc *desc_fpu;
 		int irq_fpu;
 
