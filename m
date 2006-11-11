Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Nov 2006 16:02:27 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50423 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038917AbWKKQCZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 11 Nov 2006 16:02:25 +0000
Received: from localhost (p7022-ipad11funabasi.chiba.ocn.ne.jp [219.162.42.22])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BD430B729; Sun, 12 Nov 2006 01:02:20 +0900 (JST)
Date:	Sun, 12 Nov 2006 01:04:57 +0900 (JST)
Message-Id: <20061112.010457.29576510.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] mips irq cleanups
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
References: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 02 Nov 2006 02:08:36 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> This is a big irq cleanup patch.
> 
> * Use set_irq_chip() to register irq_chip.
> * Initialize .mask, .unmask, .mask_ack field.  Functions for these
>   method are already exist in most case.
> * Do not initialize .startup, .shutdown, .enable, .disable fields if
>   default routines provided by irq_chip_set_defaults() were suitable.
> * Remove redundant irq_desc initializations.
> * Remove unnecessary local_irq_save/local_irq_restore, spin_lock.

I missed some cleanups in irq_cpu.c.  Here is a patch against the
patch.  I can send revised whole patch if you want.


Subject: [PATCH] mips irq cleanups (missing bits in irq_cpu.c)

remove unneeded mips_cpu_irq_ack and initialize .mask_ack of
mips_cpu_irq_controller and mips_mt_cpu_irq_controller.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 79fea0f..3b7cfa4 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -50,15 +50,6 @@ static inline void mask_mips_irq(unsigne
 	irq_disable_hazard();
 }
 
-/*
- * While we ack the interrupt interrupts are disabled and thus we don't need
- * to deal with concurrency issues.  Same for mips_cpu_irq_end.
- */
-static void mips_cpu_irq_ack(unsigned int irq)
-{
-	mask_mips_irq(irq);
-}
-
 static void mips_cpu_irq_end(unsigned int irq)
 {
 	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
@@ -67,8 +58,9 @@ static void mips_cpu_irq_end(unsigned in
 
 static struct irq_chip mips_cpu_irq_controller = {
 	.typename	= "MIPS",
-	.ack		= mips_cpu_irq_ack,
+	.ack		= mask_mips_irq,
 	.mask		= mask_mips_irq,
+	.mask_ack	= mask_mips_irq,
 	.unmask		= unmask_mips_irq,
 	.end		= mips_cpu_irq_end,
 };
@@ -110,6 +102,7 @@ static struct irq_chip mips_mt_cpu_irq_c
 	.startup	= mips_mt_cpu_irq_startup,
 	.ack		= mips_mt_cpu_irq_ack,
 	.mask		= mask_mips_mt_irq,
+	.mask_ack	= mips_mt_cpu_irq_ack,
 	.unmask		= unmask_mips_mt_irq,
 	.end		= mips_mt_cpu_irq_end,
 };
