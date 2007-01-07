Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jan 2007 16:27:48 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:17105 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28576383AbXAGQ1n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jan 2007 16:27:43 +0000
Received: from localhost (p2249-ipad204funabasi.chiba.ocn.ne.jp [222.146.89.249])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 66C41C8ED; Mon,  8 Jan 2007 01:27:39 +0900 (JST)
Date:	Mon, 08 Jan 2007 01:27:40 +0900 (JST)
Message-Id: <20070108.012740.30187488.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix build errors on SEAD
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
X-archive-position: 13550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Quick and dirty fix for build errors on SEAD.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index e4604c7..a3c3a1d 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -47,6 +47,9 @@
 #ifdef CONFIG_MIPS_MALTA
 #include <asm/mips-boards/maltaint.h>
 #endif
+#ifdef CONFIG_MIPS_SEAD
+#include <asm/mips-boards/seadint.h>
+#endif
 
 unsigned long cpu_khz;
 
@@ -263,11 +266,13 @@ void __init mips_time_init(void)
 
 void __init plat_timer_setup(struct irqaction *irq)
 {
+#ifdef MSC01E_INT_BASE
 	if (cpu_has_veic) {
 		set_vi_handler (MSC01E_INT_CPUCTR, mips_timer_dispatch);
 		mips_cpu_timer_irq = MSC01E_INT_BASE + MSC01E_INT_CPUCTR;
-	}
-	else {
+	} else
+#endif
+	{
 		if (cpu_has_vint)
 			set_vi_handler (MIPSCPU_INT_CPUCTR, mips_timer_dispatch);
 		mips_cpu_timer_irq = MIPSCPU_INT_BASE + MIPSCPU_INT_CPUCTR;
diff --git a/arch/mips/mips-boards/sead/sead_int.c b/arch/mips/mips-boards/sead/sead_int.c
index f445fcd..874ccb0 100644
--- a/arch/mips/mips-boards/sead/sead_int.c
+++ b/arch/mips/mips-boards/sead/sead_int.c
@@ -21,7 +21,7 @@
  * Sead board.
  */
 #include <linux/init.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
@@ -108,7 +108,7 @@ asmlinkage void plat_irq_dispatch(void)
 	if (irq >= 0)
 		do_IRQ(MIPSCPU_INT_BASE + irq);
 	else
-		spurious_interrupt(regs);
+		spurious_interrupt();
 }
 
 void __init arch_init_irq(void)
