Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 01:18:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18904 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994800AbdFOXS1ajz7r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 01:18:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CBA7013592ABC;
        Fri, 16 Jun 2017 00:18:16 +0100 (IST)
Received: from [10.20.78.209] (10.20.78.209) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Jun 2017
 00:18:20 +0100
Date:   Fri, 16 Jun 2017 00:18:11 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 10/10] MIPS: Use `pr_debug' for messages from
 `__compute_return_epc_for_insn'
In-Reply-To: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1706150201350.23046@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706150032240.23046@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.209]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58493
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

Reduce the log level for branch emulation error messages issued before 
sending SIGILL by `__compute_return_epc_for_insn' as these are triggered 
by user software and are not an event that would normally require any 
attention.  The same signal sent from elsewhere does not actually leave
any trace in the kernel log at all.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
New in v2.

linux-mips-epc-for-insn-sigill-pr-debug.diff
Index: linux-sfr-test/arch/mips/kernel/branch.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/branch.c	2017-06-05 19:40:09.000000000 +0100
+++ linux-sfr-test/arch/mips/kernel/branch.c	2017-06-15 00:42:08.603934000 +0100
@@ -816,18 +816,18 @@ int __compute_return_epc_for_insn(struct
 	return ret;
 
 sigill_dsp:
-	pr_info("%s: DSP branch but not DSP ASE - sending SIGILL.\n",
-		current->comm);
+	pr_debug("%s: DSP branch but not DSP ASE - sending SIGILL.\n",
+		 current->comm);
 	force_sig(SIGILL, current);
 	return -EFAULT;
 sigill_r2r6:
-	pr_info("%s: R2 branch but r2-to-r6 emulator is not present - sending SIGILL.\n",
-		current->comm);
+	pr_debug("%s: R2 branch but r2-to-r6 emulator is not present - sending SIGILL.\n",
+		 current->comm);
 	force_sig(SIGILL, current);
 	return -EFAULT;
 sigill_r6:
-	pr_info("%s: R6 branch but no MIPSr6 ISA support - sending SIGILL.\n",
-		current->comm);
+	pr_debug("%s: R6 branch but no MIPSr6 ISA support - sending SIGILL.\n",
+		 current->comm);
 	force_sig(SIGILL, current);
 	return -EFAULT;
 }
