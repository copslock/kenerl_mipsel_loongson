Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2016 09:20:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30693 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992126AbcJ1HUYCXLHs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Oct 2016 09:20:24 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 648D52D659C14;
        Fri, 28 Oct 2016 08:20:16 +0100 (IST)
Received: from [10.20.78.229] (10.20.78.229) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 28 Oct 2016
 08:20:17 +0100
Date:   Fri, 28 Oct 2016 08:20:09 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: ptrace: Also initialize the FP context on individual
 FCSR writes
In-Reply-To: <alpine.DEB.2.00.1610272159160.31859@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1610272243220.31859@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1610272159160.31859@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.229]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55588
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

Complement commit ac9ad83bc318 ("MIPS: prevent FP context set via ptrace 
being discarded") and also initialize the FP context whenever FCSR alone 
is written with a PTRACE_POKEUSR request addressing FPC_CSR, rather than
along with the full FPU register set in the case of the PTRACE_SETFPREGS
request.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Hi,

 This is tricky to verify with modern user software as these days it all 
uses PTRACE_SETFPREGS.  I suppose I could tweak and rebuild `gdbserver' to 
disable modern code and let it use fallback legacy support still present 
there, but frankly I think the change is obviously correct.

 Please apply.

  Maciej

linux-mips-ptrace-fcsr-init-fp-ctx.diff
Index: linux-sfr-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2016-10-22 01:29:44.000000000 +0100
+++ linux-sfr-test/arch/mips/kernel/ptrace.c	2016-10-22 01:44:38.740202000 +0100
@@ -817,6 +818,7 @@ long arch_ptrace(struct task_struct *chi
 			break;
 #endif
 		case FPC_CSR:
+			init_fp_ctx(child);
 			ptrace_setfcr31(child, data);
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
