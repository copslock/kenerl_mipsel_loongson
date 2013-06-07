Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:07:32 +0200 (CEST)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46863 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835157Ab3FGXDzlRmDt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:55 +0200
Received: by mail-ie0-f177.google.com with SMTP id u16so12140647iet.36
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1Z1+tQ24LuxqTNiQt2rbDa7d+VjYC3p6sYHpFwTQb5k=;
        b=I4X0RTgX62DKwMZeQnHdNV66XsRP/2AE0itKJMWaQZpbSUABjJBGX4bHhUmJ/CzCVl
         ne8NweuHTMMThF/fRSoYr4398nMFVeQMb8O/z3E+V3R2eBEz8o3j4szihNmvwzzIDgU6
         mpsZwnEjh2Fz8k53ANtMKT/RBzdXNfnbHkDF1x9NYVrQz7vvV3u1a764KtXlEx4JOf0Z
         c5EHc54b+C/XuWsRP3b7UlD2iv/OGQjqbaci88IXpMBDboP+2ccUsvZiPUpIl6wpRIRo
         MjcYh7AWFRU3u4YAPWsweMsN3Grpi+VezZkqV+aQjoZpPVAvx+1Dqop4VcuYlr/E5iHN
         EkeA==
X-Received: by 10.50.22.106 with SMTP id c10mr2242144igf.14.1370646229555;
        Fri, 07 Jun 2013 16:03:49 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id l14sm1146143igf.9.2013.06.07.16.03.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:48 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3kgd006654;
        Fri, 7 Jun 2013 16:03:46 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3keM006653;
        Fri, 7 Jun 2013 16:03:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 11/31] MIPS: Rearrange branch.c so it can be used by kvm code.
Date:   Fri,  7 Jun 2013 16:03:15 -0700
Message-Id: <1370646215-6543-12-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Introduce __compute_return_epc_for_insn0() entry point.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/branch.h |  7 +++++
 arch/mips/kernel/branch.c      | 63 +++++++++++++++++++++++++++++++-----------
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/branch.h b/arch/mips/include/asm/branch.h
index e28a3e0..b3de685 100644
--- a/arch/mips/include/asm/branch.h
+++ b/arch/mips/include/asm/branch.h
@@ -37,6 +37,13 @@ static inline unsigned long exception_epc(struct pt_regs *regs)
 
 #define BRANCH_LIKELY_TAKEN 0x0001
 
+extern int __compute_return_epc(struct pt_regs *regs);
+extern int __compute_return_epc_for_insn(struct pt_regs *regs,
+					 union mips_instruction insn);
+extern int __compute_return_epc_for_insn0(struct pt_regs *regs,
+					  union mips_instruction insn,
+					  unsigned int (*get_fcr31)(void));
+
 static inline int compute_return_epc(struct pt_regs *regs)
 {
 	if (get_isa16_mode(regs->cp0_epc)) {
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 46c2ad0..e47145b 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -195,17 +195,18 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
 }
 
 /**
- * __compute_return_epc_for_insn - Computes the return address and do emulate
+ * __compute_return_epc_for_insn0 - Computes the return address and do emulate
  *				    branch simulation, if required.
  *
  * @regs:	Pointer to pt_regs
  * @insn:	branch instruction to decode
- * @returns:	-EFAULT on error and forces SIGBUS, and on success
+ * @returns:	-EFAULT on error, and on success
  *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
  *		evaluating the branch.
  */
-int __compute_return_epc_for_insn(struct pt_regs *regs,
-				   union mips_instruction insn)
+int __compute_return_epc_for_insn0(struct pt_regs *regs,
+				   union mips_instruction insn,
+				   unsigned int (*get_fcr31)(void))
 {
 	unsigned int bit, fcr31, dspcontrol;
 	long epc = regs->cp0_epc;
@@ -281,7 +282,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 
 		case bposge32_op:
 			if (!cpu_has_dsp)
-				goto sigill;
+				return -EFAULT;
 
 			dspcontrol = rddsp(0x01);
 
@@ -364,13 +365,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	 * And now the FPA/cp1 branch instructions.
 	 */
 	case cop1_op:
-		preempt_disable();
-		if (is_fpu_owner())
-			asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
-		else
-			fcr31 = current->thread.fpu.fcr31;
-		preempt_enable();
-
+		fcr31 = get_fcr31();
 		bit = (insn.i_format.rt >> 2);
 		bit += (bit != 0);
 		bit += 23;
@@ -434,11 +429,47 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 	}
 
 	return ret;
+}
+EXPORT_SYMBOL_GPL(__compute_return_epc_for_insn0);
 
-sigill:
-	printk("%s: DSP branch but not DSP ASE - sending SIGBUS.\n", current->comm);
-	force_sig(SIGBUS, current);
-	return -EFAULT;
+static unsigned int __get_fcr31(void)
+{
+	unsigned int fcr31;
+
+	preempt_disable();
+	if (is_fpu_owner())
+		asm volatile(
+			".set push\n"
+			"\t.set mips1\n"
+			"\tcfc1\t%0,$31\n"
+			"\t.set pop" : "=r" (fcr31));
+	else
+		fcr31 = current->thread.fpu.fcr31;
+	preempt_enable();
+	return fcr31;
+}
+
+/**
+ * __compute_return_epc_for_insn - Computes the return address and do emulate
+ *				    branch simulation, if required.
+ *
+ * @regs:	Pointer to pt_regs
+ * @insn:	branch instruction to decode
+ * @returns:	-EFAULT on error and forces SIGBUS, and on success
+ *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
+ *		evaluating the branch.
+ */
+int __compute_return_epc_for_insn(struct pt_regs *regs,
+				   union mips_instruction insn)
+{
+	int r =  __compute_return_epc_for_insn0(regs, insn, __get_fcr31);
+
+	if (r < 0) {
+		printk("%s: DSP branch but not DSP ASE - sending SIGBUS.\n", current->comm);
+		force_sig(SIGBUS, current);
+	}
+
+	return r;
 }
 EXPORT_SYMBOL_GPL(__compute_return_epc_for_insn);
 
-- 
1.7.11.7
