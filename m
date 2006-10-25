Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2006 15:54:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:21501 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039701AbWJYOyp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2006 15:54:45 +0100
Received: from localhost (p7104-ipad03funabasi.chiba.ocn.ne.jp [219.160.87.104])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1D82A94CA; Wed, 25 Oct 2006 23:54:39 +0900 (JST)
Date:	Wed, 25 Oct 2006 23:57:04 +0900 (JST)
Message-Id: <20061025.235704.41197811.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] do_IRQ cleanup
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
X-archive-position: 13095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Now we have both function and macro version of do_IRQ() and the former
is used only by DEC and non-preemptive kernel.  This patch makes
everyone use the macro version and removes the function version.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/dec/int-handler.S |    2 +-
 arch/mips/dec/setup.c       |    6 ++++++
 arch/mips/kernel/irq.c      |   19 -------------------
 include/asm-mips/irq.h      |    6 ------
 4 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/arch/mips/dec/int-handler.S b/arch/mips/dec/int-handler.S
index 31dd47d..b251ef8 100644
--- a/arch/mips/dec/int-handler.S
+++ b/arch/mips/dec/int-handler.S
@@ -267,7 +267,7 @@ handle_it:
 		LONG_L	s0, TI_REGS($28)
 		LONG_S	sp, TI_REGS($28)
 		PTR_LA	ra, ret_from_irq
-		j	do_IRQ
+		j	dec_irq_dispatch
 		 nop
 
 #ifdef CONFIG_32BIT
diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index 6b7481e..d34032a 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -761,3 +761,9 @@ void __init arch_init_irq(void)
 	if (dec_interrupt[DEC_IRQ_HALT] >= 0)
 		setup_irq(dec_interrupt[DEC_IRQ_HALT], &haltirq);
 }
+
+asmlinkage unsigned int dec_irq_dispatch(unsigned int irq)
+{
+	do_IRQ(irq);
+	return 0;
+}
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index dd24434..07b3f46 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -46,25 +46,6 @@ #ifdef CONFIG_MIPS_MT_SMTC
 unsigned long irq_hwmask[NR_IRQS];
 #endif /* CONFIG_MIPS_MT_SMTC */
 
-#undef do_IRQ
-
-/*
- * do_IRQ handles all normal device IRQ's (the special
- * SMP cross-CPU interrupts have their own specific
- * handlers).
- */
-asmlinkage unsigned int do_IRQ(unsigned int irq)
-{
-	irq_enter();
-
-	__DO_IRQ_SMTC_HOOK();
-	__do_IRQ(irq);
-
-	irq_exit();
-
-	return 1;
-}
-
 /*
  * Generic, controller-independent functions:
  */
diff --git a/include/asm-mips/irq.h b/include/asm-mips/irq.h
index 0ce2a80..4be2e9b 100644
--- a/include/asm-mips/irq.h
+++ b/include/asm-mips/irq.h
@@ -24,8 +24,6 @@ #else
 #define irq_canonicalize(irq) (irq)	/* Sane hardware, sane code ... */
 #endif
 
-extern asmlinkage unsigned int do_IRQ(unsigned int irq);
-
 #ifdef CONFIG_MIPS_MT_SMTC
 /*
  * Clear interrupt mask handling "backstop" if irq_hwmask
@@ -43,8 +41,6 @@ #else
 #define __DO_IRQ_SMTC_HOOK() do { } while (0)
 #endif
 
-#ifdef CONFIG_PREEMPT
-
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -61,8 +57,6 @@ do {									\
 	irq_exit();							\
 } while (0)
 
-#endif
-
 extern void arch_init_irq(void);
 extern void spurious_interrupt(void);
 
