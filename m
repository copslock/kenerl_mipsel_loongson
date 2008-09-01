Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2008 14:23:04 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:3037 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031001AbYIANWm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2008 14:22:42 +0100
Received: from localhost.localdomain (p5198-ipad203funabasi.chiba.ocn.ne.jp [222.146.84.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 707B2B339; Mon,  1 Sep 2008 22:22:37 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/6] TXx9: Microoptimize interrupt handlers
Date:	Mon,  1 Sep 2008 22:22:37 +0900
Message-Id: <1220275361-5001-2-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The IOC interrupt status register on RBTX49XX only have 8 bits.  Use
8-bit version of __fls() to optimize interrupt handlers.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/rbtx4927/irq.c   |    6 +++---
 arch/mips/txx9/rbtx4938/irq.c   |    8 ++++----
 include/asm-mips/txx9/generic.h |   18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/mips/txx9/rbtx4927/irq.c b/arch/mips/txx9/rbtx4927/irq.c
index 22076e3..9c14ebb 100644
--- a/arch/mips/txx9/rbtx4927/irq.c
+++ b/arch/mips/txx9/rbtx4927/irq.c
@@ -133,9 +133,9 @@ static int toshiba_rbtx4927_irq_nested(int sw_irq)
 	u8 level3;
 
 	level3 = readb(rbtx4927_imstat_addr) & 0x1f;
-	if (level3)
-		sw_irq = RBTX4927_IRQ_IOC + fls(level3) - 1;
-	return sw_irq;
+	if (unlikely(!level3))
+		return -1;
+	return RBTX4927_IRQ_IOC + __fls8(level3);
 }
 
 static void __init toshiba_rbtx4927_irq_ioc_init(void)
diff --git a/arch/mips/txx9/rbtx4938/irq.c b/arch/mips/txx9/rbtx4938/irq.c
index ca2f830..7d21bef 100644
--- a/arch/mips/txx9/rbtx4938/irq.c
+++ b/arch/mips/txx9/rbtx4938/irq.c
@@ -85,10 +85,10 @@ static int toshiba_rbtx4938_irq_nested(int sw_irq)
 	u8 level3;
 
 	level3 = readb(rbtx4938_imstat_addr);
-	if (level3)
-		/* must use fls so onboard ATA has priority */
-		sw_irq = RBTX4938_IRQ_IOC + fls(level3) - 1;
-	return sw_irq;
+	if (unlikely(!level3))
+		return -1;
+	/* must use fls so onboard ATA has priority */
+	return RBTX4938_IRQ_IOC + __fls8(level3);
 }
 
 static void __init
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index 1e1a9f2..dc85515 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -64,4 +64,22 @@ struct physmap_flash_data;
 void txx9_physmap_flash_init(int no, unsigned long addr, unsigned long size,
 			     const struct physmap_flash_data *pdata);
 
+/* 8 bit version of __fls(): find first bit set (returns 0..7) */
+static inline unsigned int __fls8(unsigned char x)
+{
+	int r = 7;
+
+	if (!(x & 0xf0)) {
+		r -= 4;
+		x <<= 4;
+	}
+	if (!(x & 0xc0)) {
+		r -= 2;
+		x <<= 2;
+	}
+	if (!(x & 0x80))
+		r -= 1;
+	return r;
+}
+
 #endif /* __ASM_TXX9_GENERIC_H */
-- 
1.5.6.3
