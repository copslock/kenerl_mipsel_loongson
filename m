Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 13:37:45 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994039AbeAOMg34Gi0K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2018 13:36:29 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 898B911EC;
        Mon, 15 Jan 2018 12:36:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        James Hogan <james.hogan@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Dave Martin <Dave.Martin@arm.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.18 15/46] MIPS: Also verify sizeof `elf_fpreg_t with PTRACE_SETREGSET
Date:   Mon, 15 Jan 2018 13:33:23 +0100
Message-Id: <20180115123329.145102408@linuxfoundation.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180115123327.303455538@linuxfoundation.org>
References: <20180115123327.303455538@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62112
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit 006501e039eec411842bb3150c41358867d320c2 upstream.

Complement commit d614fd58a283 ("mips/ptrace: Preserve previous
registers for short regset write") and like with the PTRACE_GETREGSET
ptrace(2) request also apply a BUILD_BUG_ON check for the size of the
`elf_fpreg_t' type in the PTRACE_SETREGSET request handler.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: d614fd58a283 ("mips/ptrace: Preserve previous registers for short regset write")
Cc: James Hogan <james.hogan@mips.com>
Cc: Paul Burton <Paul.Burton@mips.com>
Cc: Alex Smith <alex@alex-smith.me.uk>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17929/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -428,6 +428,7 @@ static int fpr_get_msa(struct task_struc
 	u64 fpr_val;
 	int err;
 
+	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
 	for (i = 0; i < NUM_FPU_REGS; i++) {
 		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
 		err = user_regset_copyout(pos, count, kbuf, ubuf,
