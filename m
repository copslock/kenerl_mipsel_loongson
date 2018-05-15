Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 00:35:19 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:35826 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992841AbeEOWfLbscMS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2018 00:35:11 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 15 May 2018 22:34:18 +0000
Received: from [10.20.78.107] (10.20.78.107) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 15
 May 2018 15:34:02 -0700
Date:   Tue, 15 May 2018 23:33:26 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 2/3] MIPS: Correct the 64-bit DSP accumulator register size
In-Reply-To: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1805102026260.10896@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526423657-637138-23752-17153-2
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193020
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
X-archive-position: 63968
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

Use the `unsigned long' rather than `__u32' type for DSP accumulator 
registers, like with the regular MIPS multiply/divide accumulator and 
general-purpose registers, as all are 64-bit in 64-bit implementations 
and using a 32-bit data type leads to contents truncation on context 
saving.

Update `arch_ptrace' and `compat_arch_ptrace' accordingly, removing 
casts that are similarly not used with multiply/divide accumulator or 
general-purpose register accesses.

Cc: stable@vger.kernel.org # 2.6.15+
Fixes: e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP ASE.")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
Hi,

 I have no 64-bit DSP hardware handy to verify this change, however some 
surely exists and is used to run Linux, as indicated by GDB PR gdb/22286, 
<https://sourceware.org/bugzilla/show_bug.cgi?id=22286>, so we better get 
it right before people start screaming.

  Maciej
---
 arch/mips/include/asm/processor.h |    2 +-
 arch/mips/kernel/ptrace.c         |    2 +-
 arch/mips/kernel/ptrace32.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

linux-mips-dsp64.diff
Index: linux-jhogan-test/arch/mips/include/asm/processor.h
===================================================================
--- linux-jhogan-test.orig/arch/mips/include/asm/processor.h	2018-03-21 17:13:52.000000000 +0000
+++ linux-jhogan-test/arch/mips/include/asm/processor.h	2018-05-09 22:35:33.248559000 +0100
@@ -141,7 +141,7 @@ struct mips_fpu_struct {
 
 #define NUM_DSP_REGS   6
 
-typedef __u32 dspreg_t;
+typedef unsigned long dspreg_t;
 
 struct mips_dsp_state {
 	dspreg_t	dspr[NUM_DSP_REGS];
Index: linux-jhogan-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-jhogan-test.orig/arch/mips/kernel/ptrace.c	2018-05-09 22:34:00.000000000 +0100
+++ linux-jhogan-test/arch/mips/kernel/ptrace.c	2018-05-09 22:37:45.416608000 +0100
@@ -856,7 +856,7 @@ long arch_ptrace(struct task_struct *chi
 				goto out;
 			}
 			dregs = __get_dsp_regs(child);
-			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp = dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:
Index: linux-jhogan-test/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-jhogan-test.orig/arch/mips/kernel/ptrace32.c	2018-03-21 17:13:52.000000000 +0000
+++ linux-jhogan-test/arch/mips/kernel/ptrace32.c	2018-05-09 22:45:50.924418000 +0100
@@ -142,7 +142,7 @@ long compat_arch_ptrace(struct task_stru
 				goto out;
 			}
 			dregs = __get_dsp_regs(child);
-			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp = dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:
