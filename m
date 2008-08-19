Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:58:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:9681 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580947AbYHSNzY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:24 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9BA8CB86B; Tue, 19 Aug 2008 22:55:18 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 08/14] TXx9: Raise priority of interrupts for errors, timers, sio
Date:	Tue, 19 Aug 2008 22:55:12 +0900
Message-Id: <1219154118-21193-8-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/irq_tx4927.c |   11 +++++++++++
 arch/mips/txx9/generic/irq_tx4938.c |   11 +++++++++++
 include/asm-mips/txx9/tx4927.h      |   11 +++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/irq_tx4927.c b/arch/mips/txx9/generic/irq_tx4927.c
index cbea1fd..60ef8f2 100644
--- a/arch/mips/txx9/generic/irq_tx4927.c
+++ b/arch/mips/txx9/generic/irq_tx4927.c
@@ -30,8 +30,19 @@
 
 void __init tx4927_irq_init(void)
 {
+	int i;
+
 	mips_cpu_irq_init();
 	txx9_irq_init(TX4927_IRC_REG & 0xfffffffffULL);
 	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4927_IRC_INT,
 				handle_simple_irq);
+	/* raise priority for errors, timers, sio */
+	txx9_irq_set_pri(TX4927_IR_ECCERR, 7);
+	txx9_irq_set_pri(TX4927_IR_WTOERR, 7);
+	txx9_irq_set_pri(TX4927_IR_PCIERR, 7);
+	txx9_irq_set_pri(TX4927_IR_PCIPME, 7);
+	for (i = 0; i < TX4927_NUM_IR_TMR; i++)
+		txx9_irq_set_pri(TX4927_IR_TMR(i), 6);
+	for (i = 0; i < TX4927_NUM_IR_SIO; i++)
+		txx9_irq_set_pri(TX4927_IR_SIO(i), 5);
 }
diff --git a/arch/mips/txx9/generic/irq_tx4938.c b/arch/mips/txx9/generic/irq_tx4938.c
index 6eac684..ed5ec57 100644
--- a/arch/mips/txx9/generic/irq_tx4938.c
+++ b/arch/mips/txx9/generic/irq_tx4938.c
@@ -18,8 +18,19 @@
 
 void __init tx4938_irq_init(void)
 {
+	int i;
+
 	mips_cpu_irq_init();
 	txx9_irq_init(TX4938_IRC_REG & 0xfffffffffULL);
 	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4938_IRC_INT,
 				handle_simple_irq);
+	/* raise priority for errors, timers, sio */
+	txx9_irq_set_pri(TX4938_IR_ECCERR, 7);
+	txx9_irq_set_pri(TX4938_IR_WTOERR, 7);
+	txx9_irq_set_pri(TX4938_IR_PCIERR, 7);
+	txx9_irq_set_pri(TX4938_IR_PCIPME, 7);
+	for (i = 0; i < TX4938_NUM_IR_TMR; i++)
+		txx9_irq_set_pri(TX4938_IR_TMR(i), 6);
+	for (i = 0; i < TX4938_NUM_IR_SIO; i++)
+		txx9_irq_set_pri(TX4938_IR_SIO(i), 5);
 }
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
index 36a9241..7d813f1 100644
--- a/include/asm-mips/txx9/tx4927.h
+++ b/include/asm-mips/txx9/tx4927.h
@@ -50,12 +50,23 @@
 #define TX4927_SIO_REG(ch)	(TX4927_REG_BASE + 0xf300 + (ch) * 0x100)
 #define TX4927_PIO_REG		(TX4927_REG_BASE + 0xf500)
 
+#define TX4927_IR_ECCERR	0
+#define TX4927_IR_WTOERR	1
+#define TX4927_NUM_IR_INT	6
 #define TX4927_IR_INT(n)	(2 + (n))
+#define TX4927_NUM_IR_SIO	2
 #define TX4927_IR_SIO(n)	(8 + (n))
+#define TX4927_NUM_IR_DMA	4
+#define TX4927_IR_DMA(n)	(10 + (n))
+#define TX4927_IR_PIO		14
+#define TX4927_IR_PDMAC		15
 #define TX4927_IR_PCIC		16
 #define TX4927_NUM_IR_TMR	3
 #define TX4927_IR_TMR(n)	(17 + (n))
 #define TX4927_IR_PCIERR	22
+#define TX4927_IR_PCIPME	23
+#define TX4927_IR_ACLC		24
+#define TX4927_IR_ACLCPME	25
 #define TX4927_NUM_IR	32
 
 #define TX4927_IRC_INT	2	/* IP[2] in Status register */
-- 
1.5.6.3
