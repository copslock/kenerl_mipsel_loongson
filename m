Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 14:00:19 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:46230 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993514AbeGTL6vy1AWA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 13:58:51 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 07/25] MIPS: ath79: enable uart during early_prink
Date:   Fri, 20 Jul 2018 13:58:24 +0200
Message-Id: <20180720115842.8406-8-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

From: Gabor Juhos <juhosg@openwrt.org>

This patch ensures, that the poinmux register is properly setup for the
boot console uart when early_printk is enabled.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/early_printk.c | 44 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
index d6c892cf01b1..2024a0bb9144 100644
--- a/arch/mips/ath79/early_printk.c
+++ b/arch/mips/ath79/early_printk.c
@@ -58,6 +58,46 @@ static void prom_putchar_dummy(unsigned char ch)
 	/* nothing to do */
 }
 
+static void prom_enable_uart(u32 id)
+{
+	void __iomem *gpio_base;
+	u32 uart_en;
+	u32 t;
+
+	switch (id) {
+	case REV_ID_MAJOR_AR71XX:
+		uart_en = AR71XX_GPIO_FUNC_UART_EN;
+		break;
+
+	case REV_ID_MAJOR_AR7240:
+	case REV_ID_MAJOR_AR7241:
+	case REV_ID_MAJOR_AR7242:
+		uart_en = AR724X_GPIO_FUNC_UART_EN;
+		break;
+
+	case REV_ID_MAJOR_AR913X:
+		uart_en = AR913X_GPIO_FUNC_UART_EN;
+		break;
+
+	case REV_ID_MAJOR_AR9330:
+	case REV_ID_MAJOR_AR9331:
+		uart_en = AR933X_GPIO_FUNC_UART_EN;
+		break;
+
+	case REV_ID_MAJOR_AR9341:
+	case REV_ID_MAJOR_AR9342:
+	case REV_ID_MAJOR_AR9344:
+		/* TODO */
+	default:
+		return;
+	}
+
+	gpio_base = (void __iomem *)(KSEG1ADDR(AR71XX_GPIO_BASE));
+	t = __raw_readl(gpio_base + AR71XX_GPIO_REG_FUNC);
+	t |= uart_en;
+	__raw_writel(t, gpio_base + AR71XX_GPIO_REG_FUNC);
+}
+
 static void prom_putchar_init(void)
 {
 	void __iomem *base;
@@ -92,8 +132,10 @@ static void prom_putchar_init(void)
 
 	default:
 		_prom_putchar = prom_putchar_dummy;
-		break;
+		return;
 	}
+
+	prom_enable_uart(id);
 }
 
 void prom_putchar(unsigned char ch)
-- 
2.11.0
