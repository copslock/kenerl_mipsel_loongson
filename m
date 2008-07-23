Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 16:23:55 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:28904 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577886AbYGWPXd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 16:23:33 +0100
Received: from localhost.localdomain (p3049-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.49])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A1970AA08; Thu, 24 Jul 2008 00:23:27 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 01/10] txx9: Fix jmr3927 irq numbers
Date:	Thu, 24 Jul 2008 00:25:12 +0900
Message-Id: <1216826721-28259-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Fix wrong txx9_clockevent interrupt number
* Fix TXX9_IRQ_BASE for JMR3927+FPCIB case

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/jmr3927/setup.c |    2 +-
 include/asm-mips/txx9irq.h     |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 03647eb..57dc91e 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -85,7 +85,7 @@ static void jmr3927_machine_power_off(void)
 static void __init jmr3927_time_init(void)
 {
 	txx9_clockevent_init(TX3927_TMR_REG(0),
-			     TXX9_IRQ_BASE + JMR3927_IRQ_IRC_TMR(0),
+			     JMR3927_IRQ_IRC_TMR(0),
 			     JMR3927_IMCLK);
 	txx9_clocksource_init(TX3927_TMR_REG(1), JMR3927_IMCLK);
 }
diff --git a/include/asm-mips/txx9irq.h b/include/asm-mips/txx9irq.h
index 1c439e5..5620879 100644
--- a/include/asm-mips/txx9irq.h
+++ b/include/asm-mips/txx9irq.h
@@ -14,8 +14,12 @@
 #ifdef CONFIG_IRQ_CPU
 #define TXX9_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
 #else
+#ifdef CONFIG_I8259
+#define TXX9_IRQ_BASE	(I8259A_IRQ_BASE + 16)
+#else
 #define TXX9_IRQ_BASE	0
 #endif
+#endif
 
 #ifdef CONFIG_CPU_TX39XX
 #define TXx9_MAX_IR 16
-- 
1.5.5.5
