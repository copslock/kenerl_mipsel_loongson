Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 01:15:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34563 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994787AbdFOXPj1Gvkr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 01:15:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C1B769A5F482E;
        Fri, 16 Jun 2017 00:15:27 +0100 (IST)
Received: from [10.20.78.209] (10.20.78.209) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Jun 2017
 00:15:31 +0100
Date:   Fri, 16 Jun 2017 00:15:22 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 08/10] MIPS: Fix a typo: s/preset/present/ in r2-to-r6
 emulation error message
In-Reply-To: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1706150156170.23046@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.209]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58491
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

This is a user-visible message, so we want it to be spelled correctly.

Cc: stable@vger.kernel.org # 3.19+
Fixes: 5f9f41c474be ("MIPS: kernel: Prepare the JR instruction for emulation on MIPS R6")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Changes from v1:

- add justification.

linux-mips-epc-for-insn-sigill-r2r6-typo.diff
Index: linux-sfr-test/arch/mips/kernel/branch.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/branch.c	2017-06-05 05:11:05.340498000 +0100
+++ linux-sfr-test/arch/mips/kernel/branch.c	2017-06-05 05:30:41.432034000 +0100
@@ -821,7 +821,7 @@ int __compute_return_epc_for_insn(struct
 	force_sig(SIGILL, current);
 	return -EFAULT;
 sigill_r2r6:
-	pr_info("%s: R2 branch but r2-to-r6 emulator is not preset - sending SIGILL.\n",
+	pr_info("%s: R2 branch but r2-to-r6 emulator is not present - sending SIGILL.\n",
 		current->comm);
 	force_sig(SIGILL, current);
 	return -EFAULT;
