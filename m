Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:50:51 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53147 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903708Ab2D3LuV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:50:21 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH 11/14] MIPS: lantiq: fix early printk
Date:   Mon, 30 Apr 2012 13:33:06 +0200
Message-Id: <1335785589-32532-11-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The code was using a 32bit write operations in the early_printk code. This
resulted in 3 zero bytes also being written to the serial port. This patch
changes the memory access to 8bit.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    6 ++++++
 arch/mips/lantiq/early_printk.c                    |   17 ++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 8a3c6be..8bc9030 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -34,6 +34,12 @@
 #define LTQ_ASC1_BASE_ADDR	0x1E100C00
 #define LTQ_ASC_SIZE		0x400
 
+/*
+ * during early_printk no ioremap is possible
+ * lets use KSEG1 instead
+ */
+#define LTQ_EARLY_ASC		KSEG1ADDR(LTQ_ASC1_BASE_ADDR)
+
 /* RCU - reset control unit */
 #define LTQ_RCU_BASE_ADDR	0x1F203000
 #define LTQ_RCU_SIZE		0x1000
diff --git a/arch/mips/lantiq/early_printk.c b/arch/mips/lantiq/early_printk.c
index 972e05f..9b28d09 100644
--- a/arch/mips/lantiq/early_printk.c
+++ b/arch/mips/lantiq/early_printk.c
@@ -6,17 +6,16 @@
  *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
  */
 
-#include <linux/init.h>
 #include <linux/cpu.h>
-
-#include <lantiq.h>
 #include <lantiq_soc.h>
 
-/* no ioremap possible at this early stage, lets use KSEG1 instead  */
-#define LTQ_ASC_BASE	KSEG1ADDR(LTQ_ASC1_BASE_ADDR)
 #define ASC_BUF		1024
-#define LTQ_ASC_FSTAT	((u32 *)(LTQ_ASC_BASE + 0x0048))
-#define LTQ_ASC_TBUF	((u32 *)(LTQ_ASC_BASE + 0x0020))
+#define LTQ_ASC_FSTAT	((u32 *)(LTQ_EARLY_ASC + 0x0048))
+#ifdef __BIG_ENDIAN
+#define LTQ_ASC_TBUF	((u32 *)(LTQ_EARLY_ASC + 0x0020 + 3))
+#else
+#define LTQ_ASC_TBUF	((u32 *)(LTQ_EARLY_ASC + 0x0020))
+#endif
 #define TXMASK		0x3F00
 #define TXOFFSET	8
 
@@ -27,7 +26,7 @@ void prom_putchar(char c)
 	local_irq_save(flags);
 	do { } while ((ltq_r32(LTQ_ASC_FSTAT) & TXMASK) >> TXOFFSET);
 	if (c == '\n')
-		ltq_w32('\r', LTQ_ASC_TBUF);
-	ltq_w32(c, LTQ_ASC_TBUF);
+		ltq_w8('\r', LTQ_ASC_TBUF);
+	ltq_w8(c, LTQ_ASC_TBUF);
 	local_irq_restore(flags);
 }
-- 
1.7.9.1
