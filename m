Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:32:37 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:44159 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010011AbaI1SbM7AV-Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:12 +0200
Received: by mail-lb0-f171.google.com with SMTP id l4so16609018lbv.2
        for <multiple recipients>; Sun, 28 Sep 2014 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JMcHOzBYTMiI3+864e0E07DZcdZ6pO07atSSVsTqIJQ=;
        b=AEQnhGUeHKi5kGZdMZ+4SCBA1a/5zS7YoCGPZ8623HvafyLAT9WZdgIxxzmT+CgrHD
         egFZ9Oecp1jhFDZyGCY3YyxDA5ta27mHMfMlTKj/Boxl8cCD10XKYRP+BKPYUxXHFtr4
         rhjnDJUUlYgNqYAmJn9liuR5BGWjJS4kehwz8VYH4HXGHb1K6oYQnGY40APNcVAp9OaE
         Zx0ZOZ5XrstI3j/Yy4snGToTDaMXi/rYzB8DlB7f5JQELtI9b1d7QlZfEvSuMyCirUZD
         m5FtuhyP34x3iQslxFZ4KqPPUFxmi0NZwZkaWODXO4zSRsw0qpvxLpY6cVsWnKXapNn6
         zesQ==
X-Received: by 10.152.163.66 with SMTP id yg2mr34176951lab.38.1411929067337;
        Sun, 28 Sep 2014 11:31:07 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.31.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:31:06 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 05/16] MIPS: ar231x: add early printk support
Date:   Sun, 28 Sep 2014 22:33:04 +0400
Message-Id: <1411929195-23775-6-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 arch/mips/Kconfig               |  1 +
 arch/mips/ar231x/Makefile       |  2 ++
 arch/mips/ar231x/early_printk.c | 45 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 arch/mips/ar231x/early_printk.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bd81f7a..b89bfdf 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -83,6 +83,7 @@ config AR231X
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select ARCH_REQUIRE_GPIOLIB
+	select SYS_HAS_EARLY_PRINTK
 	help
 	  Support for Atheros AR231x and Atheros AR531x based boards
 
diff --git a/arch/mips/ar231x/Makefile b/arch/mips/ar231x/Makefile
index 201b7d4..eabad7d 100644
--- a/arch/mips/ar231x/Makefile
+++ b/arch/mips/ar231x/Makefile
@@ -10,5 +10,7 @@
 
 obj-y += board.o prom.o devices.o
 
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
+
 obj-$(CONFIG_SOC_AR5312) += ar5312.o
 obj-$(CONFIG_SOC_AR2315) += ar2315.o
diff --git a/arch/mips/ar231x/early_printk.c b/arch/mips/ar231x/early_printk.c
new file mode 100644
index 0000000..393c5ab
--- /dev/null
+++ b/arch/mips/ar231x/early_printk.c
@@ -0,0 +1,45 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>
+ */
+
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/serial_reg.h>
+
+#include <ar2315_regs.h>
+#include <ar5312_regs.h>
+#include "devices.h"
+
+static inline void prom_uart_wr(void __iomem *base, unsigned reg,
+				unsigned char ch)
+{
+	__raw_writel(ch, base + 4 * reg);
+}
+
+static inline unsigned char prom_uart_rr(void __iomem *base, unsigned reg)
+{
+	return __raw_readl(base + 4 * reg);
+}
+
+void prom_putchar(unsigned char ch)
+{
+	static void __iomem *base;
+
+	if (unlikely(base == NULL)) {
+		if (is_2315())
+			base = (void __iomem *)(KSEG1ADDR(AR2315_UART0));
+		else
+			base = (void __iomem *)(KSEG1ADDR(AR5312_UART0));
+	}
+
+	while ((prom_uart_rr(base, UART_LSR) & UART_LSR_THRE) == 0)
+		;
+	prom_uart_wr(base, UART_TX, ch);
+	while ((prom_uart_rr(base, UART_LSR) & UART_LSR_THRE) == 0)
+		;
+}
+
-- 
1.8.5.5
