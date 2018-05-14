Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 17:50:04 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:34716 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992521AbeENPt4nrwro (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 17:49:56 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Mon, 14 May 2018 15:49:51 +0000
Received: from [10.20.78.96] (10.20.78.96) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 14
 May 2018 08:50:19 -0700
Date:   Mon, 14 May 2018 16:49:43 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <james.hogan@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses
 to o32 FGRs
Message-ID: <alpine.DEB.2.00.1805141537210.10896@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.96]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526312991-321457-24569-35339-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192979
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Check the TIF_32BIT_FPREGS task setting of the tracee rather than the 
tracer in determining the layout of floating-point general registers in 
the floating-point context, correcting access to odd-numbered registers 
for o32 tracees where the setting disagrees between the two processes.

Cc: stable@vger.kernel.org # 3.14+
Fixes: 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
Hi,

 These are not the usual requests used by GDB to access the floating-point 
context, which is likely why it went unnoticed so long.  They are only 
used as a fallback in the case where PTRACE_GETFPREGS and PTRACE_SETFPREGS 
requests are not supported, i.e. with ancient kernels.

 However to verify an unrelated GDB bug fix I have tweaked GDB to always 
use PTRACE_PEEKUSR and PTRACE_POKEUSR, and then discovered this issue in 
native GDB regression testing, as it showed regressions from corrupt FGR 
contents across numerous tests compared to the usual results.  This fix 
removed those regressions then.

 Not being typically used does not mean we ought to keep the interface 
broken.  Therefore please apply.

  Maciej
---
 arch/mips/kernel/ptrace.c   |    4 ++--
 arch/mips/kernel/ptrace32.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

linux-mips-ptrace-test-thread-flag.diff
Index: linux/arch/mips/kernel/ptrace.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace.c	2018-05-12 22:52:19.000000000 +0100
+++ linux/arch/mips/kernel/ptrace.c	2018-05-12 22:56:07.893993000 +0100
@@ -1059,7 +1059,7 @@ long arch_ptrace(struct task_struct *chi
 			fregs = get_fpu_regs(child);
 
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -1154,7 +1154,7 @@ long arch_ptrace(struct task_struct *chi
 
 			init_fp_ctx(child);
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
Index: linux-mipsswbrd038/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-mipsswbrd038.orig/arch/mips/kernel/ptrace32.c	2018-05-12 22:52:19.000000000 +0100
+++ linux-mipsswbrd038/arch/mips/kernel/ptrace32.c	2018-05-12 22:55:20.906637000 +0100
@@ -99,7 +99,7 @@ long compat_arch_ptrace(struct task_stru
 				break;
 			}
 			fregs = get_fpu_regs(child);
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -212,7 +212,7 @@ long compat_arch_ptrace(struct task_stru
 				       sizeof(child->thread.fpu));
 				child->thread.fpu.fcr31 = 0;
 			}
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
