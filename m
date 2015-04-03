Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:29:04 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025277AbbDCWZIYSJ4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:08 +0200
Date:   Fri, 3 Apr 2015 23:25:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 19/48] MIPS: Normalise code flow in the CpU exception
 handler
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030323550.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46736
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

Changes applied to `do_cpu' over time reduced the use of the SIGILL 
issued with `force_sig' at the end to a single CU3 case only in the 
switch statement there.  Move that `force_sig' call over to right where 
required then and toss out the pile of gotos now not needed to skip over 
the call, replacing them with regular breaks out of the switch.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-cpu-switch.diff
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c	2015-04-02 20:27:53.911190000 +0100
+++ linux/arch/mips/kernel/traps.c	2015-04-02 20:27:54.637186000 +0100
@@ -1312,7 +1312,7 @@ asmlinkage void do_cpu(struct pt_regs *r
 		status = -1;
 
 		if (unlikely(compute_return_epc(regs) < 0))
-			goto out;
+			break;
 
 		if (get_isa16_mode(regs->cp0_epc)) {
 			unsigned short mmop[2] = { 0 };
@@ -1345,7 +1345,7 @@ asmlinkage void do_cpu(struct pt_regs *r
 			force_sig(status, current);
 		}
 
-		goto out;
+		break;
 
 	case 3:
 		/*
@@ -1361,8 +1361,10 @@ asmlinkage void do_cpu(struct pt_regs *r
 		 * erroneously too, so they are covered by this choice
 		 * as well.
 		 */
-		if (raw_cpu_has_fpu)
+		if (raw_cpu_has_fpu) {
+			force_sig(SIGILL, current);
 			break;
+		}
 		/* Fall through.  */
 
 	case 1:
@@ -1378,16 +1380,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 				mt_ase_fp_affinity();
 		}
 
-		goto out;
+		break;
 
 	case 2:
 		raw_notifier_call_chain(&cu2_chain, CU2_EXCEPTION, regs);
-		goto out;
+		break;
 	}
 
-	force_sig(SIGILL, current);
-
-out:
 	exception_exit(prev_state);
 }
 
