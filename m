Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 09:50:12 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:46027
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011046AbaJJHtytk3Dc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 09:49:54 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/4] MIPS: ralink: cleanup early_printk
Date:   Fri, 10 Oct 2014 09:49:45 +0200
Message-Id: <1412927388-60721-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412927388-60721-1-git-send-email-blogic@openwrt.org>
References: <1412927388-60721-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add support for the new MT7621/8 SoC and kill ifdefs.
Cleanup some whitespace error while we are at it.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/early_printk.c |   45 ++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
index b46d041..255d695 100644
--- a/arch/mips/ralink/early_printk.c
+++ b/arch/mips/ralink/early_printk.c
@@ -12,21 +12,24 @@
 #include <asm/addrspace.h>
 
 #ifdef CONFIG_SOC_RT288X
-#define EARLY_UART_BASE         0x300c00
+#define EARLY_UART_BASE		0x300c00
+#define CHIPID_BASE		0x300004
+#elif defined(CONFIG_SOC_MT7621)
+#define EARLY_UART_BASE		0x1E000c00
+#define CHIPID_BASE		0x1E000004
 #else
-#define EARLY_UART_BASE         0x10000c00
+#define EARLY_UART_BASE		0x10000c00
+#define CHIPID_BASE		0x10000004
 #endif
 
-#define UART_REG_RX             0x00
-#define UART_REG_TX             0x04
-#define UART_REG_IER            0x08
-#define UART_REG_IIR            0x0c
-#define UART_REG_FCR            0x10
-#define UART_REG_LCR            0x14
-#define UART_REG_MCR            0x18
-#define UART_REG_LSR            0x1c
+#define MT7628_CHIP_NAME1	0x20203832
+
+#define UART_REG_TX		0x04
+#define UART_REG_LSR		0x14
+#define UART_REG_LSR_RT2880	0x1c
 
 static __iomem void *uart_membase = (__iomem void *) KSEG1ADDR(EARLY_UART_BASE);
+static __iomem void *chipid_membase = (__iomem void *) KSEG1ADDR(CHIPID_BASE);
 
 static inline void uart_w32(u32 val, unsigned reg)
 {
@@ -38,11 +41,23 @@ static inline u32 uart_r32(unsigned reg)
 	return __raw_readl(uart_membase + reg);
 }
 
+static inline int soc_is_mt7628(void)
+{
+	return IS_ENABLED(CONFIG_SOC_MT7620) &&
+		(__raw_readl(chipid_membase) == MT7628_CHIP_NAME1);
+}
+
 void prom_putchar(unsigned char ch)
 {
-	while ((uart_r32(UART_REG_LSR) & UART_LSR_THRE) == 0)
-		;
-	uart_w32(ch, UART_REG_TX);
-	while ((uart_r32(UART_REG_LSR) & UART_LSR_THRE) == 0)
-		;
+	if (IS_ENABLED(CONFIG_SOC_MT7621) || soc_is_mt7628()) {
+		uart_w32(ch, UART_TX);
+		while ((uart_r32(UART_REG_LSR) & UART_LSR_THRE) == 0)
+			;
+	} else {
+		while ((uart_r32(UART_REG_LSR_RT2880) & UART_LSR_THRE) == 0)
+			;
+		uart_w32(ch, UART_REG_TX);
+		while ((uart_r32(UART_REG_LSR_RT2880) & UART_LSR_THRE) == 0)
+			;
+	}
 }
-- 
1.7.10.4
