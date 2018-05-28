Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 12:14:35 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:55768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994601AbeE1KO1bDKhl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 12:14:27 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A761020843;
        Mon, 28 May 2018 10:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527502461;
        bh=qGSC3lDlhsBVRiFF+wsnkz13WKxnB98rQJo/KbArNGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsB0ksMJJziMDUFTqoIKUgm18CUF+S9uWC2oq6vDezgt5+PhKlqZme4qG18+6ZYT5
         uxR5ytd1WGFwSl6bUcZEjv4nP4CuA7JqBHGFo8dmQ2GzL/Xkh2NZRgmr65HIYuys3x
         UT2bTft4s1TckjKABi3RbX3ti6/B3HS3JUqH8a5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 001/268] MIPS: ptrace: Expose FIR register through FP regset
Date:   Mon, 28 May 2018 11:59:35 +0200
Message-Id: <20180528100202.174811317@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit 71e909c0cdad28a1df1fa14442929e68615dee45 upstream.

Correct commit 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
and expose the FIR register using the unused 4 bytes at the end of the
NT_PRFPREG regset.  Without that register included clients cannot use
the PTRACE_GETREGSET request to retrieve the complete FPU register set
and have to resort to one of the older interfaces, either PTRACE_PEEKUSR
or PTRACE_GETFPREGS, to retrieve the missing piece of data.  Also the
register is irreversibly missing from core dumps.

This register is architecturally hardwired and read-only so the write
path does not matter.  Ignore data supplied on writes then.

Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.13+
Patchwork: https://patchwork.linux-mips.org/patch/19273/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -483,7 +483,7 @@ static int fpr_get_msa(struct task_struc
 /*
  * Copy the floating-point context to the supplied NT_PRFPREG buffer.
  * Choose the appropriate helper for general registers, and then copy
- * the FCSR register separately.
+ * the FCSR and FIR registers separately.
  */
 static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
@@ -491,6 +491,7 @@ static int fpr_get(struct task_struct *t
 		   void *kbuf, void __user *ubuf)
 {
 	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	const int fir_pos = fcr31_pos + sizeof(u32);
 	int err;
 
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
@@ -503,6 +504,12 @@ static int fpr_get(struct task_struct *t
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
@@ -551,7 +558,8 @@ static int fpr_set_msa(struct task_struc
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context.
  * Choose the appropriate helper for general registers, and then copy
- * the FCSR register separately.
+ * the FCSR register separately.  Ignore the incoming FIR register
+ * contents though, as the register is read-only.
  *
  * We optimize for the case where `count % sizeof(elf_fpreg_t) == 0',
  * which is supposed to have been guaranteed by the kernel before
@@ -565,6 +573,7 @@ static int fpr_set(struct task_struct *t
 		   const void *kbuf, const void __user *ubuf)
 {
 	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	const int fir_pos = fcr31_pos + sizeof(u32);
 	u32 fcr31;
 	int err;
 
@@ -592,6 +601,11 @@ static int fpr_set(struct task_struct *t
 		ptrace_setfcr31(target, fcr31);
 	}
 
+	if (count > 0)
+		err = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+						fir_pos,
+						fir_pos + sizeof(u32));
+
 	return err;
 }
 
