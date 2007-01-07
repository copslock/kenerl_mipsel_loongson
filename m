Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jan 2007 15:20:32 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:4288 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28576110AbXAGPU1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jan 2007 15:20:27 +0000
Received: from localhost (p2249-ipad204funabasi.chiba.ocn.ne.jp [222.146.89.249])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EB3F5E9BB; Mon,  8 Jan 2007 00:20:23 +0900 (JST)
Date:	Mon, 08 Jan 2007 00:20:24 +0900 (JST)
Message-Id: <20070108.002024.75184927.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Remove unused rm9k_cpu_irq_disable()
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
X-archive-position: 13548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

rm9k_cpu_irq_disable() is unused since commit
1603b5aca4f15b34848fb5594d0c7b6333b99144.  Remove it.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/irq-rm9000.c b/arch/mips/kernel/irq-rm9000.c
index 0e6f4c5..2e68e4b 100644
--- a/arch/mips/kernel/irq-rm9000.c
+++ b/arch/mips/kernel/irq-rm9000.c
@@ -39,15 +39,6 @@ static inline void rm9k_cpu_irq_enable(u
 	local_irq_restore(flags);
 }
 
-static void rm9k_cpu_irq_disable(unsigned int irq)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	mask_rm9k_irq(irq);
-	local_irq_restore(flags);
-}
-
 /*
  * Performance counter interrupts are global on all processors.
  */
