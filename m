Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Feb 2007 15:58:51 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:10238 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038812AbXBCP6q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Feb 2007 15:58:46 +0000
Received: from localhost (p3165-ipad210funabasi.chiba.ocn.ne.jp [58.88.122.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A5886B80C; Sun,  4 Feb 2007 00:57:25 +0900 (JST)
Date:	Sun, 04 Feb 2007 00:57:25 +0900 (JST)
Message-Id: <20070204.005725.62338494.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix pb1200/irqmap.c and apply some missed patches
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
X-archive-position: 13914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

pb1200/irqmap.c had been broken a while due to non-named initializer
and had missed some recent IRQ related changes.  Apply these commits
to this file.

[MIPS] IRQ cleanups
commit 1603b5aca4f15b34848fb5594d0c7b6333b99144
[MIPS] use generic_handle_irq, handle_level_irq, handle_percpu_irq
commit 1417836e81c0ab8f5a0bfeafa90d3eaa41b2a067
[MIPS] Compile __do_IRQ() when really needed
commit e77c232cfc6e1250b2916a7c69225d6634d05a49

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/au1000/pb1200/irqmap.c b/arch/mips/au1000/pb1200/irqmap.c
index 91983ba..b73b2d1 100644
--- a/arch/mips/au1000/pb1200/irqmap.c
+++ b/arch/mips/au1000/pb1200/irqmap.c
@@ -137,33 +137,20 @@ static void pb1200_shutdown_irq( unsigne
 	return;
 }
 
-static inline void pb1200_mask_and_ack_irq(unsigned int irq_nr)
-{
-	pb1200_disable_irq( irq_nr );
-}
-
-static void pb1200_end_irq(unsigned int irq_nr)
-{
-	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))) {
-		pb1200_enable_irq(irq_nr);
-	}
-}
-
 static struct irq_chip external_irq_type =
 {
 #ifdef CONFIG_MIPS_PB1200
-	"Pb1200 Ext",
+	.name = "Pb1200 Ext",
 #endif
 #ifdef CONFIG_MIPS_DB1200
-	"Db1200 Ext",
+	.name = "Db1200 Ext",
 #endif
-	pb1200_startup_irq,
-	pb1200_shutdown_irq,
-	pb1200_enable_irq,
-	pb1200_disable_irq,
-	pb1200_mask_and_ack_irq,
-	pb1200_end_irq,
-	NULL
+	.startup  = pb1200_startup_irq,
+	.shutdown = pb1200_shutdown_irq,
+	.ack      = pb1200_disable_irq,
+	.mask     = pb1200_disable_irq,
+	.mask_ack = pb1200_disable_irq,
+	.unmask   = pb1200_enable_irq,
 };
 
 void _board_init_irq(void)
@@ -172,7 +159,8 @@ void _board_init_irq(void)
 
 	for (irq_nr = PB1200_INT_BEGIN; irq_nr <= PB1200_INT_END; irq_nr++)
 	{
-		irq_desc[irq_nr].chip = &external_irq_type;
+		set_irq_chip_and_handler(irq_nr, &external_irq_type,
+					 handle_level_irq);
 		pb1200_disable_irq(irq_nr);
 	}
 
