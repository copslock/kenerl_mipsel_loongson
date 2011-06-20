Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:28:41 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35880 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491151Ab1FTT1M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:12 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 146A514021E;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 8AC02140217;
        Mon, 20 Jun 2011 21:27:06 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 03/13] MIPS: ath79: add early printk support for the AR933X SoCs
Date:   Mon, 20 Jun 2011 21:26:03 +0200
Message-Id: <1308597973-6037-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A13172AE59B | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16494

The AR933X SoCs are using a different UART, thus require
different code for early printk support.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/early_printk.c                 |   76 +++++++++++++++++++++---
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 +
 arch/mips/include/asm/mach-ath79/ar933x_uart.h |   67 +++++++++++++++++++++
 3 files changed, 137 insertions(+), 9 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ath79/ar933x_uart.h

diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
index 7499b0e..6a51ced 100644
--- a/arch/mips/ath79/early_printk.c
+++ b/arch/mips/ath79/early_printk.c
@@ -1,7 +1,7 @@
 /*
- *  Atheros AR71XX/AR724X/AR913X SoC early printk support
+ *  Atheros AR7XXX/AR9XXX SoC early printk support
  *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
  *  This program is free software; you can redistribute it and/or modify it
@@ -10,27 +10,85 @@
  */
 
 #include <linux/io.h>
+#include <linux/errno.h>
 #include <linux/serial_reg.h>
 #include <asm/addrspace.h>
 
+#include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
+#include <asm/mach-ath79/ar933x_uart.h>
 
-static inline void prom_wait_thre(void __iomem *base)
+static void (*_prom_putchar) (unsigned char);
+
+static inline void prom_putchar_wait(void __iomem *reg, u32 mask, u32 val)
 {
-	u32 lsr;
+	u32 t;
 
 	do {
-		lsr = __raw_readl(base + UART_LSR * 4);
-		if (lsr & UART_LSR_THRE)
+		t = __raw_readl(reg);
+		if ((t & mask) == val)
 			break;
 	} while (1);
 }
 
-void prom_putchar(unsigned char ch)
+static void prom_putchar_ar71xx(unsigned char ch)
 {
 	void __iomem *base = (void __iomem *)(KSEG1ADDR(AR71XX_UART_BASE));
 
-	prom_wait_thre(base);
+	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_THRE, UART_LSR_THRE);
 	__raw_writel(ch, base + UART_TX * 4);
-	prom_wait_thre(base);
+	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_THRE, UART_LSR_THRE);
+}
+
+static void prom_putchar_ar933x(unsigned char ch)
+{
+	void __iomem *base = (void __iomem *)(KSEG1ADDR(AR933X_UART_BASE));
+
+	prom_putchar_wait(base + AR933X_UART_DATA_REG, AR933X_UART_DATA_TX_CSR,
+			  AR933X_UART_DATA_TX_CSR);
+	__raw_writel(AR933X_UART_DATA_TX_CSR | ch, base + AR933X_UART_DATA_REG);
+	prom_putchar_wait(base + AR933X_UART_DATA_REG, AR933X_UART_DATA_TX_CSR,
+			  AR933X_UART_DATA_TX_CSR);
+}
+
+static void prom_putchar_dummy(unsigned char ch)
+{
+	/* nothing to do */
+}
+
+static void prom_putchar_init(void)
+{
+	void __iomem *base;
+	u32 id;
+
+	base = (void __iomem *)(KSEG1ADDR(AR71XX_RESET_BASE));
+	id = __raw_readl(base + AR71XX_RESET_REG_REV_ID);
+	id &= REV_ID_MAJOR_MASK;
+
+	switch (id) {
+	case REV_ID_MAJOR_AR71XX:
+	case REV_ID_MAJOR_AR7240:
+	case REV_ID_MAJOR_AR7241:
+	case REV_ID_MAJOR_AR7242:
+	case REV_ID_MAJOR_AR913X:
+		_prom_putchar = prom_putchar_ar71xx;
+		break;
+
+	case REV_ID_MAJOR_AR9330:
+	case REV_ID_MAJOR_AR9331:
+		_prom_putchar = prom_putchar_ar933x;
+		break;
+
+	default:
+		_prom_putchar = prom_putchar_dummy;
+		break;
+	}
+}
+
+void prom_putchar(unsigned char ch)
+{
+	if (!_prom_putchar)
+		prom_putchar_init();
+
+	_prom_putchar(ch);
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 929be06..90223f2 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -53,6 +53,9 @@
 #define AR913X_WMAC_BASE	(AR71XX_APB_BASE + 0x000C0000)
 #define AR913X_WMAC_SIZE	0x30000
 
+#define AR933X_UART_BASE	(AR71XX_APB_BASE + 0x00020000)
+#define AR933X_UART_SIZE	0x14
+
 /*
  * DDR_CTRL block
  */
diff --git a/arch/mips/include/asm/mach-ath79/ar933x_uart.h b/arch/mips/include/asm/mach-ath79/ar933x_uart.h
new file mode 100644
index 0000000..5273055
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/ar933x_uart.h
@@ -0,0 +1,67 @@
+/*
+ *  Atheros AR933X UART defines
+ *
+ *  Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef __AR933X_UART_H
+#define __AR933X_UART_H
+
+#define AR933X_UART_REGS_SIZE		20
+#define AR933X_UART_FIFO_SIZE		16
+
+#define AR933X_UART_DATA_REG		0x00
+#define AR933X_UART_CS_REG		0x04
+#define AR933X_UART_CLOCK_REG		0x08
+#define AR933X_UART_INT_REG		0x0c
+#define AR933X_UART_INT_EN_REG		0x10
+
+#define AR933X_UART_DATA_TX_RX_MASK	0xff
+#define AR933X_UART_DATA_RX_CSR		BIT(8)
+#define AR933X_UART_DATA_TX_CSR		BIT(9)
+
+#define AR933X_UART_CS_PARITY_S		0
+#define AR933X_UART_CS_PARITY_M		0x3
+#define   AR933X_UART_CS_PARITY_NONE	0
+#define   AR933X_UART_CS_PARITY_ODD	1
+#define   AR933X_UART_CS_PARITY_EVEN	2
+#define AR933X_UART_CS_IF_MODE_S	2
+#define AR933X_UART_CS_IF_MODE_M	0x3
+#define   AR933X_UART_CS_IF_MODE_NONE	0
+#define   AR933X_UART_CS_IF_MODE_DTE	1
+#define   AR933X_UART_CS_IF_MODE_DCE	2
+#define AR933X_UART_CS_FLOW_CTRL_S	4
+#define AR933X_UART_CS_FLOW_CTRL_M	0x3
+#define AR933X_UART_CS_DMA_EN		BIT(6)
+#define AR933X_UART_CS_TX_READY_ORIDE	BIT(7)
+#define AR933X_UART_CS_RX_READY_ORIDE	BIT(8)
+#define AR933X_UART_CS_TX_READY		BIT(9)
+#define AR933X_UART_CS_RX_BREAK		BIT(10)
+#define AR933X_UART_CS_TX_BREAK		BIT(11)
+#define AR933X_UART_CS_HOST_INT		BIT(12)
+#define AR933X_UART_CS_HOST_INT_EN	BIT(13)
+#define AR933X_UART_CS_TX_BUSY		BIT(14)
+#define AR933X_UART_CS_RX_BUSY		BIT(15)
+
+#define AR933X_UART_CLOCK_STEP_M	0xffff
+#define AR933X_UART_CLOCK_SCALE_M	0xfff
+#define AR933X_UART_CLOCK_SCALE_S	16
+#define AR933X_UART_CLOCK_STEP_M	0xffff
+
+#define AR933X_UART_INT_RX_VALID	BIT(0)
+#define AR933X_UART_INT_TX_READY	BIT(1)
+#define AR933X_UART_INT_RX_FRAMING_ERR	BIT(2)
+#define AR933X_UART_INT_RX_OFLOW_ERR	BIT(3)
+#define AR933X_UART_INT_TX_OFLOW_ERR	BIT(4)
+#define AR933X_UART_INT_RX_PARITY_ERR	BIT(5)
+#define AR933X_UART_INT_RX_BREAK_ON	BIT(6)
+#define AR933X_UART_INT_RX_BREAK_OFF	BIT(7)
+#define AR933X_UART_INT_RX_FULL		BIT(8)
+#define AR933X_UART_INT_TX_EMPTY	BIT(9)
+#define AR933X_UART_INT_ALLINTS		0x3ff
+
+#endif /* __AR933X_UART_H */
-- 
1.7.2.1
