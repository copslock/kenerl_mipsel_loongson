Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:25:51 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025255AbbDCWYOoyW8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:14 +0200
Date:   Fri, 3 Apr 2015 23:24:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 08/48] MIPS: Correct the comment for FPU emulator traps
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030211530.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46725
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

Adjust the explanatory comment for FPU emulator traps according to 
ba3049ed [MIPS: Switch FPU emulator trap to BREAK instruction.]; 
originally coming from `do_ade'.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-brk-memu-comment.patch
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:18:52.208524000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:52.799182000 +0100
@@ -879,9 +879,9 @@ void do_trap_or_bp(struct pt_regs *regs,
 		break;
 	case BRK_MEMU:
 		/*
-		 * Address errors may be deliberately induced by the FPU
-		 * emulator to retake control of the CPU after executing the
-		 * instruction in the delay slot of an emulated branch.
+		 * This breakpoint code is used by the FPU emulator to retake
+		 * control of the CPU after executing the instruction from the
+		 * delay slot of an emulated branch.
 		 *
 		 * Terminate if exception was recognized as a delay slot return
 		 * otherwise handle as normal.
