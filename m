Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2008 17:00:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:33499 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022151AbYGIQAb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2008 17:00:31 +0100
Received: from localhost (p5236-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.236])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 014D1AE89; Thu, 10 Jul 2008 01:00:23 +0900 (JST)
Date:	Thu, 10 Jul 2008 01:02:08 +0900 (JST)
Message-Id: <20080710.010208.39154926.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make gpio_txx9 entirely spinlock-safe
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
X-archive-position: 19749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

TXx9 GPIO set/get routines are spinlock-safe.  This patch make
gpio_direction_{input,output} routines also spinlock-safe so that they
can be used during early board setup.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/gpio_txx9.c b/arch/mips/kernel/gpio_txx9.c
index b1436a8..c6854d9 100644
--- a/arch/mips/kernel/gpio_txx9.c
+++ b/arch/mips/kernel/gpio_txx9.c
@@ -47,23 +47,25 @@ static void txx9_gpio_set(struct gpio_chip *chip, unsigned int offset,
 
 static int txx9_gpio_dir_in(struct gpio_chip *chip, unsigned int offset)
 {
-	spin_lock_irq(&txx9_gpio_lock);
+	unsigned long flags;
+	spin_lock_irqsave(&txx9_gpio_lock, flags);
 	__raw_writel(__raw_readl(&txx9_pioptr->dir) & ~(1 << offset),
 		     &txx9_pioptr->dir);
 	mmiowb();
-	spin_unlock_irq(&txx9_gpio_lock);
+	spin_unlock_irqrestore(&txx9_gpio_lock, flags);
 	return 0;
 }
 
 static int txx9_gpio_dir_out(struct gpio_chip *chip, unsigned int offset,
 			     int value)
 {
-	spin_lock_irq(&txx9_gpio_lock);
+	unsigned long flags;
+	spin_lock_irqsave(&txx9_gpio_lock, flags);
 	txx9_gpio_set_raw(offset, value);
 	__raw_writel(__raw_readl(&txx9_pioptr->dir) | (1 << offset),
 		     &txx9_pioptr->dir);
 	mmiowb();
-	spin_unlock_irq(&txx9_gpio_lock);
+	spin_unlock_irqrestore(&txx9_gpio_lock, flags);
 	return 0;
 }
 
