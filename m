Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2018 16:09:10 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46670 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994427AbeFGOI6ZAF11 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2018 16:08:58 +0200
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zi-FI; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaw-0002g7-VA; Thu, 07 Jun 2018 15:08:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Date:   Thu, 07 Jun 2018 15:05:20 +0100
Message-ID: <lsq.1528380320.295279124@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 001/410] MIPS: Normalise code flow in the CpU
 exception handler
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 27e28e8ec47a5ce335ebf25d34ca356c80635908 upstream.

Changes applied to `do_cpu' over time reduced the use of the SIGILL
issued with `force_sig' at the end to a single CU3 case only in the
switch statement there.  Move that `force_sig' call over to right where
required then and toss out the pile of gotos now not needed to skip over
the call, replacing them with regular breaks out of the switch.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9683/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/traps.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1247,7 +1247,7 @@ asmlinkage void do_cpu(struct pt_regs *r
 		status = -1;
 
 		if (unlikely(compute_return_epc(regs) < 0))
-			goto out;
+			break;
 
 		if (get_isa16_mode(regs->cp0_epc)) {
 			unsigned short mmop[2] = { 0 };
@@ -1280,7 +1280,7 @@ asmlinkage void do_cpu(struct pt_regs *r
 			force_sig(status, current);
 		}
 
-		goto out;
+		break;
 
 	case 3:
 		/*
@@ -1296,8 +1296,10 @@ asmlinkage void do_cpu(struct pt_regs *r
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
@@ -1320,16 +1322,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 		if (!process_fpemu_return(sig, fault_addr, fcr31) && !err)
 			mt_ase_fp_affinity();
 
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
 
