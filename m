Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2007 16:45:09 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:32458 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030140AbXKBQo7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2007 16:44:59 +0000
Received: from localhost (p3147-ipad212funabasi.chiba.ocn.ne.jp [58.91.167.147])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2723C9FB6; Sat,  3 Nov 2007 01:44:48 +0900 (JST)
Date:	Sat, 03 Nov 2007 01:46:49 +0900 (JST)
Message-Id: <20071103.014649.122254137.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: WAIT vs. tickless kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071031163900.GB22871@linux-mips.org>
References: <20071031161333.GA22871@linux-mips.org>
	<20071101.013124.108121433.anemo@mba.ocn.ne.jp>
	<20071031163900.GB22871@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 31 Oct 2007 16:39:00 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > The only safe but ugly workaround is to change the return from exception
> > > code to detect if the EPC is in the range startin from the condition
> > > check in the idle loop to including the WAIT instruction and if so to
> > > patch the EPC to resume execution at the condition check or the
> > > instruction following the WAIT.
> > 
> > I'm also thinking of this approach.  Still wondering if it is worth to
> > implement.
> 
> The tickless kernel is very interesting for the low power fraction.  And
> it's especially those users who would suffer most the loss of the ability
> to use the WAIT instruction.  For a system running from two AAA cells the
> tradeoff is clear ...  So I think it's become a must.

Then, something like this?  Selecting in build-time is not so good,
but there are some CPUs which do not need this hack at all.
Synthesizing the ret_from_irq() at runtime might satisfy everyone?

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c8c47a2..621130c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -51,12 +51,17 @@ static void r39xx_wait(void)
  * But it is implementation-dependent wheter the pipelie restarts when
  * a non-enabled interrupt is requested.
  */
+#ifdef CONFIG_ROLLBACK_CPU_WAIT
+extern void cpu_wait_rollback(void);
+#define r4k_wait cpu_wait_rollback
+#else
 static void r4k_wait(void)
 {
 	__asm__("	.set	mips3			\n"
 		"	wait				\n"
 		"	.set	mips0			\n");
 }
+#endif
 
 /*
  * This variant is preferable as it allows testing need_resched and going to
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index e29598a..ffa043c 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -27,6 +27,20 @@
 #endif
 
 	.text
+#ifdef CONFIG_ROLLBACK_CPU_WAIT
+	.align	6
+FEXPORT(cpu_wait_rollback)
+	LONG_L	t0, TI_FLAGS($28)
+	andi	t0, _TIF_NEED_RESCHED
+	bnez	t0, 1f
+	.set	mips3
+	wait
+	.set	mips0
+1:
+	jr	ra
+	.align	6
+cpu_wait_rollback_end:
+#endif
 	.align	5
 #ifndef CONFIG_PREEMPT
 FEXPORT(ret_from_exception)
@@ -35,6 +49,14 @@ FEXPORT(ret_from_exception)
 #endif
 FEXPORT(ret_from_irq)
 	LONG_S	s0, TI_REGS($28)
+#ifdef CONFIG_ROLLBACK_CPU_WAIT
+	LONG_L	t0, PT_EPC(sp)
+	ori	t0, 0x3f
+	xori	t0, 0x3f
+	PTR_LA	t1, cpu_wait_rollback
+	bne	t0, t1, __ret_from_irq
+	LONG_S	t0, PT_EPC(sp)			# return to cpu_wait_rollback
+#endif
 FEXPORT(__ret_from_irq)
 	LONG_L	t0, PT_STATUS(sp)		# returning to kernel mode?
 	andi	t0, t0, KU_USER
