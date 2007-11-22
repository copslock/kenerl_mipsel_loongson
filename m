Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2007 15:42:09 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:60908 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025159AbXKVPmA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2007 15:42:00 +0000
Received: from localhost (p8045-ipad307funabasi.chiba.ocn.ne.jp [123.217.186.45])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1EF0C9521; Fri, 23 Nov 2007 00:41:54 +0900 (JST)
Date:	Fri, 23 Nov 2007 00:44:06 +0900 (JST)
Message-Id: <20071123.004406.108119126.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] qemu: do not enable IP7 blindly
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
X-archive-position: 17561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

IP7 will be enabled automatically in mips_clockevent_init(), if it was
available.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/qemu/q-irq.c b/arch/mips/qemu/q-irq.c
index 11f9847..7df36db 100644
--- a/arch/mips/qemu/q-irq.c
+++ b/arch/mips/qemu/q-irq.c
@@ -33,5 +33,5 @@ void __init arch_init_irq(void)
 
 	mips_cpu_irq_init();
 	init_i8259_irqs();
-	set_c0_status(0x8400);
+	set_c0_status(0x400);
 }
