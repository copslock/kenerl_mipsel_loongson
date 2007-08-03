Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 15:33:52 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:460 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023916AbXHCOdu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2007 15:33:50 +0100
Received: from localhost (p3243-ipad26funabasi.chiba.ocn.ne.jp [220.104.89.243])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B5B11B51B; Fri,  3 Aug 2007 23:32:30 +0900 (JST)
Date:	Fri, 03 Aug 2007 23:33:38 +0900 (JST)
Message-Id: <20070803.233338.126142727.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Remove dead code from irq_txx9.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 16056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/irq_txx9.c b/arch/mips/kernel/irq_txx9.c
index 172e14b..a4d1462 100644
--- a/arch/mips/kernel/irq_txx9.c
+++ b/arch/mips/kernel/irq_txx9.c
@@ -105,13 +105,9 @@ static void txx9_irq_mask_ack(unsigned int irq)
 	unsigned int irq_nr = irq - TXX9_IRQ_BASE;
 
 	txx9_irq_mask(irq);
-	if (TXx9_IRCR_EDGE(txx9irq[irq_nr].mode)) {
-		/* clear edge detection */
-		u32 cr = __raw_readl(&txx9_ircptr->cr[irq_nr / 8]);
-		cr = (cr >> ((irq_nr & (8 - 1)) * 2)) & 3;
-		__raw_writel(TXx9_IRSCR_EIClrE | irq_nr,
-			     &txx9_ircptr->scr);
-	}
+	/* clear edge detection */
+	if (unlikely(TXx9_IRCR_EDGE(txx9irq[irq_nr].mode)))
+		__raw_writel(TXx9_IRSCR_EIClrE | irq_nr, &txx9_ircptr->scr);
 }
 
 static int txx9_irq_set_type(unsigned int irq, unsigned int flow_type)
