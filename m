Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 17:20:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:21502 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023824AbXEIQUj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 May 2007 17:20:39 +0100
Received: from localhost (p3015-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.15])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 98371B9AE; Thu, 10 May 2007 01:20:35 +0900 (JST)
Date:	Thu, 10 May 2007 01:20:30 +0900 (JST)
Message-Id: <20070510.012030.55487433.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Drop __devinit tag from allocate_irqno() and free_irqno()
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
X-archive-position: 15013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This fix these warnings:

WARNING: arch/mips/kernel/built-in.o - Section mismatch: reference to .init.text:free_irqno from __ksymtab_gpl between '__ksymtab_free_irqno' (at offset 0x0) and '__ksymtab_allocate_irqno'
WARNING: arch/mips/kernel/built-in.o - Section mismatch: reference to .init.text:allocate_irqno from __ksymtab_gpl after '__ksymtab_allocate_irqno' (at offset 0x8)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 2fe4c86..aeded6c 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -28,7 +28,7 @@
 
 static unsigned long irq_map[NR_IRQS / BITS_PER_LONG];
 
-int __devinit allocate_irqno(void)
+int allocate_irqno(void)
 {
 	int irq;
 
@@ -59,7 +59,7 @@ void __init alloc_legacy_irqno(void)
 		BUG_ON(test_and_set_bit(i, irq_map));
 }
 
-void __devinit free_irqno(unsigned int irq)
+void free_irqno(unsigned int irq)
 {
 	smp_mb__before_clear_bit();
 	clear_bit(irq, irq_map);
