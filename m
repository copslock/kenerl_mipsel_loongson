Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2018 16:57:12 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:35695 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990520AbeD3O5ExOrcA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Apr 2018 16:57:04 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Mon, 30 Apr 2018 14:56:59 +0000
Received: from [10.20.78.156] (10.20.78.156) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 30
 Apr 2018 07:57:19 -0700
Date:   Mon, 30 Apr 2018 15:56:47 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <james.hogan@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: ptrace: expose FIR register through FP regset
Message-ID: <alpine.DEB.2.00.1804301510100.11756@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.156]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1525100219-637138-23387-178484-1
X-BESS-VER: 2018.5-r1804261738
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192547
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
X-archive-position: 63831
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

Correct commit 7aeb753b5353 ("MIPS: Implement task_user_regset_view.") 
and expose the FIR register using the unused 4 bytes at the end of the 
NT_PRFPREG regset.  Without that register included clients cannot use 
the PTRACE_GETREGSET request to retrieve the complete FPU register set
and have to resort to one of the older interfaces, either PTRACE_PEEKUSR 
or PTRACE_GETFPREGS, to retrieve the missing piece of data.  Also the 
register is irreversibly missing from core dumps.

This register is architecturally hardwired and read-only so the write
path does not matter.  Ignore data supplied on writes then.

Cc: stable@vger.kernel.org # v3.13+
Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
Signed-off-by: James Hogan <james.hogan@mips.com>
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
 arch/mips/kernel/ptrace.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

linux-mips-nt-prfpreg-fir.diff
Index: linux-sfr-test/arch/mips/kernel/ptrace.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/ptrace.c	2017-12-08 16:22:17.000000000 +0000
+++ linux-sfr-test/arch/mips/kernel/ptrace.c	2017-12-08 16:22:59.299112000 +0000
@@ -454,7 +454,7 @@ static int fpr_get_msa(struct task_struc
 /*
  * Copy the floating-point context to the supplied NT_PRFPREG buffer.
  * Choose the appropriate helper for general registers, and then copy
- * the FCSR register separately.
+ * the FCSR and FIR registers separately.
  */
 static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
@@ -462,6 +462,7 @@ static int fpr_get(struct task_struct *t
 		   void *kbuf, void __user *ubuf)
 {
 	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	const int fir_pos = fcr31_pos + sizeof(u32);
 	int err;
 
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
@@ -474,6 +475,12 @@ static int fpr_get(struct task_struct *t
 	err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  &target->thread.fpu.fcr31,
 				  fcr31_pos, fcr31_pos + sizeof(u32));
+	if (err)
+		return err;
+
+	err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &boot_cpu_data.fpu_id,
+				  fir_pos, fir_pos + sizeof(u32));
 
 	return err;
 }
@@ -522,7 +529,8 @@ static int fpr_set_msa(struct task_struc
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context.
  * Choose the appropriate helper for general registers, and then copy
- * the FCSR register separately.
+ * the FCSR register separately.  Ignore the incoming FIR register
+ * contents though, as the register is read-only.
  *
  * We optimize for the case where `count % sizeof(elf_fpreg_t) == 0',
  * which is supposed to have been guaranteed by the kernel before
@@ -536,6 +544,7 @@ static int fpr_set(struct task_struct *t
 		   const void *kbuf, const void __user *ubuf)
 {
 	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	const int fir_pos = fcr31_pos + sizeof(u32);
 	u32 fcr31;
 	int err;
 
@@ -563,6 +572,11 @@ static int fpr_set(struct task_struct *t
 		ptrace_setfcr31(target, fcr31);
 	}
 
+	if (count > 0)
+		err = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+						fir_pos,
+						fir_pos + sizeof(u32));
+
 	return err;
 }
 
