Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jan 2013 19:09:00 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41596 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833523Ab3A0SGvNGy9J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Jan 2013 19:06:51 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 07/10] MIPS: ralink: adds early_printk support
Date:   Sun, 27 Jan 2013 19:03:59 +0100
Message-Id: <1359309842-31925-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
References: <1359309842-31925-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35575
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add the code needed to make early printk work.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/early_printk.c |   45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 arch/mips/ralink/early_printk.c

diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
new file mode 100644
index 0000000..7a9b474
--- /dev/null
+++ b/arch/mips/ralink/early_printk.c
@@ -0,0 +1,45 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011-2012 Gabor Juhos <juhosg@openwrt.org>
+ */
+
+#include <linux/io.h>
+#include <linux/serial_reg.h>
+
+#include <asm/addrspace.h>
+
+/* UART registers */
+#define EARLY_UART_BASE         0x10000c00
+
+#define UART_REG_RX             0
+#define UART_REG_TX             1
+#define UART_REG_IER            2
+#define UART_REG_IIR            3
+#define UART_REG_FCR            4
+#define UART_REG_LCR            5
+#define UART_REG_MCR            6
+#define UART_REG_LSR            7
+
+static __iomem void *uart_membase = (__iomem void *) KSEG1ADDR(EARLY_UART_BASE);
+
+static inline void uart_w32(u32 val, unsigned reg)
+{
+	__raw_writel(val, uart_membase + (4 * reg));
+}
+
+static inline u32 uart_r32(unsigned reg)
+{
+	return __raw_readl(uart_membase + (4 * reg));
+}
+
+void prom_putchar(unsigned char ch)
+{
+	while ((uart_r32(UART_REG_LSR) & UART_LSR_THRE) == 0)
+		;
+	uart_w32(ch, UART_REG_TX);
+	while ((uart_r32(UART_REG_LSR) & UART_LSR_THRE) == 0)
+		;
+}
-- 
1.7.10.4
