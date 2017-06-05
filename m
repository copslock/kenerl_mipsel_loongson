Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 01:16:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58891 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993870AbdFEXQlpqQTM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 01:16:41 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id D533475FBA31E;
        Tue,  6 Jun 2017 00:16:29 +0100 (IST)
Received: from [10.20.78.130] (10.20.78.130) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 6 Jun 2017
 00:16:34 +0100
Date:   Tue, 6 Jun 2017 00:16:25 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 3/9] MIPS: Fix unaligned PC interpretation in
 `compute_return_epc'
In-Reply-To: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1706050247310.10864@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.130]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58235
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

Fix a regression introduced with commit fb6883e5809c ("MIPS: microMIPS:
Support handling of delay slots.") and defer to `__compute_return_epc'
if the ISA bit is set in EPC with non-MIPS16, non-microMIPS hardware,
which will then arrange for a SIGBUS due to an unaligned instruction
reference.  Returning EPC here is never correct as the API defines this
function's result to be either a negative error code on failure or one
of 0 and BRANCH_LIKELY_TAKEN on success.

Cc: stable@vger.kernel.org # 3.9+
Fixes: fb6883e5809c ("MIPS: microMIPS: Support handling of delay slots.")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-compute-return-epc-unaligned.diff
Index: linux-sfr-test/arch/mips/include/asm/branch.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/branch.h	2016-10-22 10:43:21.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/branch.h	2016-11-08 04:55:33.724746000 +0000
@@ -74,10 +74,7 @@ static inline int compute_return_epc(str
 			return __microMIPS_compute_return_epc(regs);
 		if (cpu_has_mips16)
 			return __MIPS16e_compute_return_epc(regs);
-		return regs->cp0_epc;
-	}
-
-	if (!delay_slot(regs)) {
+	} else if (!delay_slot(regs)) {
 		regs->cp0_epc += 4;
 		return 0;
 	}
