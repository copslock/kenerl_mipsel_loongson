Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 17:40:49 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:54697 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeEPPkmAOqlk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2018 17:40:42 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 16 May 2018 15:40:08 +0000
Received: from [10.20.78.133] (10.20.78.133) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 16
 May 2018 08:40:35 -0700
Date:   Wed, 16 May 2018 16:39:58 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Message-ID: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.133]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526485207-637138-23749-67371-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193036
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63975
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

Use 64-bit accesses for 64-bit floating-point general registers with 
PTRACE_PEEKUSR, removing the truncation of their upper halves in the 
FR=1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context 
access"), which inadvertently switched them to using 32-bit accesses.

The PTRACE_POKEUSR side is fine as it's never been broken and continues 
using 64-bit accesses.

Cc: <stable@vger.kernel.org> # 3.19+
Fixes: bbd426f542cb ("MIPS: Simplify FP context access")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
Hi,

 Here's another one, spotted in the course of GDB PR gdb/22286 regression 
testing with the n64 ABI.  Please apply.

  Maciej
---
 arch/mips/kernel/ptrace.c   |    2 +-
 arch/mips/kernel/ptrace32.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

linux-mips-ptrace-peekusr-fp64.diff
Index: linux/arch/mips/kernel/ptrace.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace.c	2018-05-15 17:44:25.000000000 +0100
+++ linux/arch/mips/kernel/ptrace.c	2018-05-16 11:22:00.714605000 +0100
@@ -1070,7 +1070,7 @@ long arch_ptrace(struct task_struct *chi
 				break;
 			}
 #endif
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
Index: linux/arch/mips/kernel/ptrace32.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace32.c	2018-05-15 17:45:16.000000000 +0100
+++ linux/arch/mips/kernel/ptrace32.c	2018-05-16 11:22:16.313698000 +0100
@@ -109,7 +109,7 @@ long compat_arch_ptrace(struct task_stru
 						addr & 1);
 				break;
 			}
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
