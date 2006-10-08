Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2006 17:22:15 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:48857 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039406AbWJHQWN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Oct 2006 17:22:13 +0100
Received: from localhost (p7241-ipad29funabasi.chiba.ocn.ne.jp [221.184.74.241])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 91309A614; Mon,  9 Oct 2006 01:22:08 +0900 (JST)
Date:	Mon, 09 Oct 2006 01:24:23 +0900 (JST)
Message-Id: <20061009.012423.59032950.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] ret_from_irq adjustment
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make sure that RA on top of interrupt stack is an address of
ret_from_irq, so that dump_stack etc. can trace info interrupted
context.

Also this patch fixes except_vec_vi_handler and __smtc_ipi_vector
which seems broken.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 dec/int-handler.S |   11 ++++-------
 kernel/entry.S    |   14 +++++++++-----
 kernel/genex.S    |    8 +++-----
 kernel/smtc-asm.S |    9 +++------
 4 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/mips/dec/int-handler.S b/arch/mips/dec/int-handler.S
index 55d60d5..31dd47d 100644
--- a/arch/mips/dec/int-handler.S
+++ b/arch/mips/dec/int-handler.S
@@ -266,10 +266,8 @@ #endif
 handle_it:
 		LONG_L	s0, TI_REGS($28)
 		LONG_S	sp, TI_REGS($28)
-		jal	do_IRQ
-		LONG_S	s0, TI_REGS($28)
-
-		j	ret_from_irq
+		PTR_LA	ra, ret_from_irq
+		j	do_IRQ
 		 nop
 
 #ifdef CONFIG_32BIT
@@ -279,9 +277,8 @@ fpu:
 #endif
 
 spurious:
-		jal	spurious_interrupt
-		 nop
-		j	ret_from_irq
+		PTR_LA	ra, _ret_from_irq
+		j	spurious_interrupt
 		 nop
 		END(plat_irq_dispatch)
 
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index e93e43e..417c08a 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -20,10 +20,7 @@ #ifdef CONFIG_MIPS_MT_SMTC
 #include <asm/mipsmtregs.h>
 #endif
 
-#ifdef CONFIG_PREEMPT
-	.macro	preempt_stop
-	.endm
-#else
+#ifndef CONFIG_PREEMPT
 	.macro	preempt_stop
 	local_irq_disable
 	.endm
@@ -32,9 +29,16 @@ #endif
 
 	.text
 	.align	5
+FEXPORT(ret_from_irq)
+	LONG_S	s0, TI_REGS($28)
+#ifdef CONFIG_PREEMPT
+FEXPORT(ret_from_exception)
+#else
+	b	_ret_from_irq
 FEXPORT(ret_from_exception)
 	preempt_stop
-FEXPORT(ret_from_irq)
+#endif
+FEXPORT(_ret_from_irq)
 	LONG_L	t0, PT_STATUS(sp)		# returning to kernel mode?
 	andi	t0, t0, KU_USER
 	beqz	t0, resume_kernel
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 50ed772..5baca16 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -133,9 +133,8 @@ NESTED(handle_int, PT_SIZE, sp)
 
 	LONG_L	s0, TI_REGS($28)
 	LONG_S	sp, TI_REGS($28)
-	jal	plat_irq_dispatch
-	LONG_S	s0, TI_REGS($28)
-	j	ret_from_irq
+	PTR_LA	ra, ret_from_irq
+	j	plat_irq_dispatch
 	END(handle_int)
 
 	__INIT
@@ -224,9 +223,8 @@ #endif /* CONFIG_MIPS_MT_SMTC */
 
 	LONG_L	s0, TI_REGS($28)
 	LONG_S	sp, TI_REGS($28)
-	jalr	v0
-	LONG_S	s0, TI_REGS($28)
 	PTR_LA	ra, ret_from_irq
+	jr	v0
 	END(except_vec_vi_handler)
 
 /*
diff --git a/arch/mips/kernel/smtc-asm.S b/arch/mips/kernel/smtc-asm.S
index 76cb31d..1cb9441 100644
--- a/arch/mips/kernel/smtc-asm.S
+++ b/arch/mips/kernel/smtc-asm.S
@@ -97,15 +97,12 @@ FEXPORT(__smtc_ipi_vector)
 	SAVE_ALL
 	CLI
 	TRACE_IRQS_OFF
-	move	a0,sp
 	/* Function to be invoked passed stack pad slot 5 */
 	lw	t0,PT_PADSLOT5(sp)
 	/* Argument from sender passed in stack pad slot 4 */
-	lw	a1,PT_PADSLOT4(sp)
-	jalr	t0
-	nop
-	j	ret_from_irq
-	nop
+	lw	a0,PT_PADSLOT4(sp)
+	PTR_LA	ra, _ret_from_irq
+	jr	t0
 
 /*
  * Called from idle loop to provoke processing of queued IPIs
