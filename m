Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 17:50:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:40664 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28588256AbYGRQuF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 17:50:05 +0100
Received: from localhost (p8181-ipad203funabasi.chiba.ocn.ne.jp [222.146.87.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C6750B382; Sat, 19 Jul 2008 01:50:01 +0900 (JST)
Date:	Sat, 19 Jul 2008 01:51:52 +0900 (JST)
Message-Id: <20080719.015152.10545752.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 3/3] txx9: Fix some sparse warnings
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
X-archive-position: 19891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c |    2 ++
 include/asm-mips/txx9/tx3927.h |   19 ++++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 3715a8f..8c60c78 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -19,7 +19,9 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <asm/bootinfo.h>
+#include <asm/time.h>
 #include <asm/txx9/generic.h>
 #ifdef CONFIG_CPU_TX49XX
 #include <asm/txx9/tx4938.h>
diff --git a/include/asm-mips/txx9/tx3927.h b/include/asm-mips/txx9/tx3927.h
index ca414c7..ea79e1b 100644
--- a/include/asm-mips/txx9/tx3927.h
+++ b/include/asm-mips/txx9/tx3927.h
@@ -10,17 +10,18 @@
 
 #include <asm/txx9/txx927.h>
 
-#define TX3927_SDRAMC_REG	0xfffe8000
-#define TX3927_ROMC_REG		0xfffe9000
-#define TX3927_DMA_REG		0xfffeb000
-#define TX3927_IRC_REG		0xfffec000
-#define TX3927_PCIC_REG		0xfffed000
-#define TX3927_CCFG_REG		0xfffee000
+#define TX3927_REG_BASE	0xfffe0000UL
+#define TX3927_SDRAMC_REG	(TX3927_REG_BASE + 0x8000)
+#define TX3927_ROMC_REG		(TX3927_REG_BASE + 0x9000)
+#define TX3927_DMA_REG		(TX3927_REG_BASE + 0xb000)
+#define TX3927_IRC_REG		(TX3927_REG_BASE + 0xc000)
+#define TX3927_PCIC_REG		(TX3927_REG_BASE + 0xd000)
+#define TX3927_CCFG_REG		(TX3927_REG_BASE + 0xe000)
 #define TX3927_NR_TMR	3
-#define TX3927_TMR_REG(ch)	(0xfffef000 + (ch) * 0x100)
+#define TX3927_TMR_REG(ch)	(TX3927_REG_BASE + 0xf000 + (ch) * 0x100)
 #define TX3927_NR_SIO	2
-#define TX3927_SIO_REG(ch)	(0xfffef300 + (ch) * 0x100)
-#define TX3927_PIO_REG		0xfffef500
+#define TX3927_SIO_REG(ch)	(TX3927_REG_BASE + 0xf300 + (ch) * 0x100)
+#define TX3927_PIO_REG		(TX3927_REG_BASE + 0xf500)
 
 struct tx3927_sdramc_reg {
 	volatile unsigned long cr[8];
