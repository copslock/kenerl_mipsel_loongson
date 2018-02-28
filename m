Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:16:28 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53711 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994577AbeB1QP3aPDYz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:15:29 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yt-0006Xi-HN; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-0008Vu-1Q; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paolo Bonzini" <pbonzini@redhat.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>, kvm@vger.kernel.org,
        "James Hogan" <james.hogan@imgtec.com>,
        "Gleb Natapov" <gleb@kernel.org>, linux-mips@linux-mips.org
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.231882522@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 093/254] MIPS: Clear [MSA]FPE CSR.Cause after
 notify_die()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62752
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 64bedffe496820dbb6b53302d80dd0f04db33d8e upstream.

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
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/kdebug.h |  3 ++-
 arch/mips/kernel/genex.S       | 14 ++++----------
 arch/mips/kernel/traps.c       | 16 +++++++++++++++-
 3 files changed, 21 insertions(+), 12 deletions(-)

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
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -744,6 +744,11 @@ asmlinkage void do_fpe(struct pt_regs *r
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
@@ -1295,13 +1300,22 @@ out:
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
 
