Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 15:48:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16498 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013339AbbCKOsKooy8S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 15:48:10 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 190723FDFAEE0;
        Wed, 11 Mar 2015 14:48:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 11 Mar 2015 14:48:05 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 11 Mar 2015 14:48:04 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>
Subject: [PATCH 02/20] MIPS: Clear [MSA]FPE CSR.Cause after notify_die()
Date:   Wed, 11 Mar 2015 14:44:38 +0000
Message-ID: <1426085096-12932-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When handling floating point exceptions (FPEs) and MSA FPEs the Cause
bits of the appropriate control and status register (FCSR for FPEs and
MSACSR for MSA FPEs) are read and cleared before enabling interrupts,
presumably so that it doesn't have to go through the pain of restoring
those bits if the process is pre-empted, since writing those bits would
cause another immediate exception while still in the kernel.

The bits aren't normally ever restored again, since userland never
expects to see them set.

However for virtualisation it is necessary for the kernel to be able to
restore these Cause bits, as the guest may have been interrupted in an
FP exception handler but before it could read the Cause bits. This can
be done by registering a die notifier, to get notified of the exception
when such a value is restored, and if the PC was at the instruction
which is used to restore the guest state, the handler can step over it
and continue execution. The Cause bits can then remain set without
causing further exceptions.

For this to work safely a few changes are made:
- __build_clear_fpe and __build_clear_msa_fpe no longer clear the Cause
  bits, and now return from exception level with interrupts disabled
  instead of enabled.
- do_fpe() now clears the Cause bits and enables interrupts after
  notify_die() is called, so that the notifier can chose to return from
  exception without this happening.
- do_msa_fpe() acts similarly, but now actually makes use of the second
  argument (msacsr) and calls notify_die() with the new DIE_MSAFP,
  allowing die notifiers to be informed of MSA FPEs too.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kdebug.h |  3 ++-
 arch/mips/kernel/genex.S       | 14 ++++----------
 arch/mips/kernel/traps.c       | 16 +++++++++++++++-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/kdebug.h b/arch/mips/include/asm/kdebug.h
index 6a9af5fcb5d7..cba22ab7ad4d 100644
--- a/arch/mips/include/asm/kdebug.h
+++ b/arch/mips/include/asm/kdebug.h
@@ -10,7 +10,8 @@ enum die_val {
 	DIE_RI,
 	DIE_PAGE_FAULT,
 	DIE_BREAK,
-	DIE_SSTEPBP
+	DIE_SSTEPBP,
+	DIE_MSAFP
 };
 
 #endif /* _ASM_MIPS_KDEBUG_H */
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 86e22422d08c..af42e7003f12 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -360,21 +360,15 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	mips1
 	SET_HARDFLOAT
 	cfc1	a1, fcr31
-	li	a2, ~(0x3f << 12)
-	and	a2, a1
-	ctc1	a2, fcr31
 	.set	pop
-	TRACE_IRQS_ON
-	STI
+	CLI
+	TRACE_IRQS_OFF
 	.endm
 
 	.macro	__build_clear_msa_fpe
 	_cfcmsa	a1, MSA_CSR
-	li	a2, ~(0x3f << 12)
-	and	a1, a1, a2
-	_ctcmsa	MSA_CSR, a1
-	TRACE_IRQS_ON
-	STI
+	CLI
+	TRACE_IRQS_OFF
 	.endm
 
 	.macro	__build_clear_ade
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8943ebe4d154..5b4d711f878d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -788,6 +788,11 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 	if (notify_die(DIE_FP, "FP exception", regs, 0, regs_to_trapnr(regs),
 		       SIGFPE) == NOTIFY_STOP)
 		goto out;
+
+	/* Clear FCSR.Cause before enabling interrupts */
+	write_32bit_cp1_register(CP1_STATUS, fcr31 & ~FPU_CSR_ALL_X);
+	local_irq_enable();
+
 	die_if_kernel("FP exception in kernel code", regs);
 
 	if (fcr31 & FPU_CSR_UNI_X) {
@@ -1393,13 +1398,22 @@ out:
 	exception_exit(prev_state);
 }
 
-asmlinkage void do_msa_fpe(struct pt_regs *regs)
+asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
 {
 	enum ctx_state prev_state;
 
 	prev_state = exception_enter();
+	if (notify_die(DIE_MSAFP, "MSA FP exception", regs, 0,
+		       regs_to_trapnr(regs), SIGFPE) == NOTIFY_STOP)
+		goto out;
+
+	/* Clear MSACSR.Cause before enabling interrupts */
+	write_msa_csr(msacsr & ~MSA_CSR_CAUSEF);
+	local_irq_enable();
+
 	die_if_kernel("do_msa_fpe invoked from kernel context!", regs);
 	force_sig(SIGFPE, current);
+out:
 	exception_exit(prev_state);
 }
 
-- 
2.0.5
