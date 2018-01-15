Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 13:38:41 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994628AbeAOMg7H4dNK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2018 13:36:59 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AE75711E9;
        Mon, 15 Jan 2018 12:36:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        James Hogan <james.hogan@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Dave Martin <Dave.Martin@arm.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.18 11/46] MIPS: Guard against any partial write attempt with PTRACE_SETREGSET
Date:   Mon, 15 Jan 2018 13:33:19 +0100
Message-Id: <20180115123328.567280393@linuxfoundation.org>
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
X-archive-position: 62114
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

commit dc24d0edf33c3e15099688b6bbdf7bdc24bf6e91 upstream.

Complement commit d614fd58a283 ("mips/ptrace: Preserve previous
registers for short regset write") and ensure that no partial register
write attempt is made with PTRACE_SETREGSET, as we do not preinitialize
any temporaries used to hold incoming register data and consequently
random data could be written.

It is the responsibility of the caller, such as `ptrace_regset', to
arrange for writes to span whole registers only, so here we only assert
that it has indeed happened.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: 72b22bbad1e7 ("MIPS: Don't assume 64-bit FP registers for FP regset")
Cc: James Hogan <james.hogan@mips.com>
Cc: Paul Burton <Paul.Burton@mips.com>
Cc: Alex Smith <alex@alex-smith.me.uk>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17926/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -497,7 +497,15 @@ static int fpr_set_msa(struct task_struc
 	return 0;
 }
 
-/* Copy the supplied NT_PRFPREG buffer to the floating-point context.  */
+/*
+ * Copy the supplied NT_PRFPREG buffer to the floating-point context.
+ *
+ * We optimize for the case where `count % sizeof(elf_fpreg_t) == 0',
+ * which is supposed to have been guaranteed by the kernel before
+ * calling us, e.g. in `ptrace_regset'.  We enforce that requirement,
+ * so that we can safely avoid preinitializing temporaries for
+ * partial register writes.
+ */
 static int fpr_set(struct task_struct *target,
 		   const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
@@ -505,6 +513,8 @@ static int fpr_set(struct task_struct *t
 {
 	int err;
 
+	BUG_ON(count % sizeof(elf_fpreg_t));
+
 	/* XXX fcr31  */
 
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
