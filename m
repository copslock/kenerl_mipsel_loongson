Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:32:37 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025295AbbDCW0V3gGVr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:26:21 +0200
Date:   Fri, 3 Apr 2015 23:26:21 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 31/48] MIPS: Correct MIPS16 BREAK code interpretation
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031625450.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46748
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

Correct the interpretation of the immediate MIPS16 BREAK instruction 
code embedded in the instruction word across bits 10:5 rather than 11:6 
as current code implies, fixing the interpretation of integer overflow 
and divide by zero traps.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-do-bp16.diff
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:27:54.637186000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:56.610207000 +0100
@@ -925,7 +925,7 @@ asmlinkage void do_bp(struct pt_regs *re
 			if (__get_user(instr[0],
 				       (u16 __user *)msk_isa16_mode(epc)))
 				goto out_sigsegv;
-			bcode = (instr[0] >> 6) & 0x3f;
+			bcode = (instr[0] >> 5) & 0x3f;
 			do_trap_or_bp(regs, bcode, "Break");
 			goto out;
 		}
