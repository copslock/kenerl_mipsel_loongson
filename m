Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 11:51:13 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37383 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011153AbbKDKu3N-Qjw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 11:50:29 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id ADF4028098D;
        Wed,  4 Nov 2015 11:48:38 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 11:48:38 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 4/9] arch: mips: ralink: add tty detection
Date:   Wed,  4 Nov 2015 11:50:09 +0100
Message-Id: <1446634214-11564-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
References: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49830
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

MT7688 has several uarts that can be used for console. There are several
boards in the wild, that use ttyS1 or ttyS2. This patch applies a simply
autodetection routine to figure out which ttyS the bootloader used as
console. The uarts come up in 6 bit mode by default. The bootloader will
have set 8 bit mode on the console. Find that 8bit tty and use it.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/early_printk.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
index 255d695..36c2468 100644
--- a/arch/mips/ralink/early_printk.c
+++ b/arch/mips/ralink/early_printk.c
@@ -25,11 +25,13 @@
 #define MT7628_CHIP_NAME1	0x20203832
 
 #define UART_REG_TX		0x04
+#define UART_REG_LCR		0x0c
 #define UART_REG_LSR		0x14
 #define UART_REG_LSR_RT2880	0x1c
 
 static __iomem void *uart_membase = (__iomem void *) KSEG1ADDR(EARLY_UART_BASE);
 static __iomem void *chipid_membase = (__iomem void *) KSEG1ADDR(CHIPID_BASE);
+static int init_complete;
 
 static inline void uart_w32(u32 val, unsigned reg)
 {
@@ -47,8 +49,32 @@ static inline int soc_is_mt7628(void)
 		(__raw_readl(chipid_membase) == MT7628_CHIP_NAME1);
 }
 
+static inline void find_uart_base(void)
+{
+	int i;
+
+	if (!soc_is_mt7628())
+		return;
+
+	for (i = 0; i < 3; i++) {
+		u32 reg = uart_r32(UART_REG_LCR + (0x100 * i));
+
+		if (!reg)
+			continue;
+
+		uart_membase = (__iomem void *) KSEG1ADDR(EARLY_UART_BASE +
+							  (0x100 * i));
+		break;
+	}
+}
+
 void prom_putchar(unsigned char ch)
 {
+	if (!init_complete) {
+		find_uart_base();
+		init_complete = 1;
+	}
+
 	if (IS_ENABLED(CONFIG_SOC_MT7621) || soc_is_mt7628()) {
 		uart_w32(ch, UART_TX);
 		while ((uart_r32(UART_REG_LSR) & UART_LSR_THRE) == 0)
-- 
1.7.10.4
