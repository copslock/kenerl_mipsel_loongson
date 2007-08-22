Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 13:48:21 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16540 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022543AbXHVMsT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Aug 2007 13:48:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7MCmIbk029328
	for <linux-mips@linux-mips.org>; Wed, 22 Aug 2007 13:48:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7MCmI61029327
	for linux-mips@linux-mips.org; Wed, 22 Aug 2007 13:48:18 +0100
Date:	Wed, 22 Aug 2007 13:48:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [ths@networkno.de: [PATCH] Maintain si_code field properly for FP
	exceptions]
Message-ID: <20070822124818.GA7715@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

----- Forwarded message from Thiemo Seufer <ths@networkno.de> -----

From: Thiemo Seufer <ths@networkno.de>
Date: Wed, 22 Aug 2007 01:42:04 +0100
To: ralf@linux-mips.org
Subject: [PATCH] Maintain si_code field properly for FP exceptions
Content-Type: text/plain; charset=us-ascii

The appended patch adds code to update siginfo_t's si_code field. It
fixes e.g. a floating point overflow regression in the SBCL testsuite.


Thiemo


Signed-Off-By: Thiemo Seufer <ths@linux-mips.org>

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 5ce5582..20ddf6d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -606,6 +606,8 @@ asmlinkage void do_ov(struct pt_regs *regs)
  */
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
+	siginfo_t info;
+
 	die_if_kernel("FP exception in kernel code", regs);
 
 	if (fcr31 & FPU_CSR_UNI_X) {
@@ -641,9 +643,22 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 			force_sig(sig, current);
 
 		return;
-	}
-
-	force_sig(SIGFPE, current);
+	} else if (fcr31 & FPU_CSR_INV_X)
+		info.si_code = FPE_FLTINV;
+	else if (fcr31 & FPU_CSR_DIV_X)
+		info.si_code = FPE_FLTDIV;
+	else if (fcr31 & FPU_CSR_OVF_X)
+		info.si_code = FPE_FLTOVF;
+	else if (fcr31 & FPU_CSR_UDF_X)
+		info.si_code = FPE_FLTUND;
+	else if (fcr31 & FPU_CSR_INE_X)
+		info.si_code = FPE_FLTRES;
+	else
+		info.si_code = __SI_FAULT;
+	info.si_signo = SIGFPE;
+	info.si_errno = 0;
+	info.si_addr = (void __user *) regs->cp0_epc;
+	force_sig_info(SIGFPE, &info, current);
 }
 
 asmlinkage void do_bp(struct pt_regs *regs)

----- End forwarded message -----

  Ralf
