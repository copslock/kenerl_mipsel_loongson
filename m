Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jan 2007 15:50:43 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:5363 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28640979AbXAGPui (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jan 2007 15:50:38 +0000
Received: from localhost (p2249-ipad204funabasi.chiba.ocn.ne.jp [222.146.89.249])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 26F82EF12; Mon,  8 Jan 2007 00:50:34 +0900 (JST)
Date:	Mon, 08 Jan 2007 00:50:34 +0900 (JST)
Message-Id: <20070108.005034.104640508.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] SMTC build fix
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
X-archive-position: 13549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Pass "irq" to __DO_IRQ_SMTC_HOOK() macro.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/irq.h b/include/asm-mips/irq.h
index 6765708..386da82 100644
--- a/include/asm-mips/irq.h
+++ b/include/asm-mips/irq.h
@@ -31,14 +31,14 @@ static inline int irq_canonicalize(int i
  * functions will take over re-enabling the low-level mask.
  * Otherwise it will be done on return from exception.
  */
-#define __DO_IRQ_SMTC_HOOK()						\
+#define __DO_IRQ_SMTC_HOOK(irq)						\
 do {									\
 	if (irq_hwmask[irq] & 0x0000ff00)				\
 		write_c0_tccontext(read_c0_tccontext() &		\
 		                   ~(irq_hwmask[irq] & 0x0000ff00));	\
 } while (0)
 #else
-#define __DO_IRQ_SMTC_HOOK() do { } while (0)
+#define __DO_IRQ_SMTC_HOOK(irq) do { } while (0)
 #endif
 
 /*
@@ -52,7 +52,7 @@ do {									\
 #define do_IRQ(irq)							\
 do {									\
 	irq_enter();							\
-	__DO_IRQ_SMTC_HOOK();						\
+	__DO_IRQ_SMTC_HOOK(irq);					\
 	generic_handle_irq(irq);					\
 	irq_exit();							\
 } while (0)
