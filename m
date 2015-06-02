Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 18:51:04 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007050AbbFBQu7ZqEY4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 18:50:59 +0200
Date:   Tue, 2 Jun 2015 17:50:59 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Joshua Kinard <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Avoid an FPE exception in FCSR mask probing
Message-ID: <alpine.LFD.2.11.1506021739230.6751@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47795
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

Use the default FCSR value in mask probing, avoiding an FPE exception 
where reset has left any exception enable and their corresponding cause 
bits set and the register is then rewritten with these bits active.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-fcsr-mask-fix.diff
Index: linux-org-test/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-org-test.orig/arch/mips/kernel/cpu-probe.c	2015-06-01 00:43:32.000000000 +0100
+++ linux-org-test/arch/mips/kernel/cpu-probe.c	2015-06-02 12:14:10.088786000 +0100
@@ -74,13 +74,12 @@ static inline void cpu_set_fpu_fcsr_mask
 {
 	unsigned long sr, mask, fcsr, fcsr0, fcsr1;
 
+	fcsr = c->fpu_csr31;
 	mask = FPU_CSR_ALL_X | FPU_CSR_ALL_E | FPU_CSR_ALL_S | FPU_CSR_RM;
 
 	sr = read_c0_status();
 	__enable_fpu(FPU_AS_IS);
 
-	fcsr = read_32bit_cp1_register(CP1_STATUS);
-
 	fcsr0 = fcsr & mask;
 	write_32bit_cp1_register(CP1_STATUS, fcsr0);
 	fcsr0 = read_32bit_cp1_register(CP1_STATUS);
