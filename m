Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 01:05:10 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:50033 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012105AbaJUXDp6hCL- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 01:03:45 +0200
Received: by mail-la0-f46.google.com with SMTP id gi9so1997224lab.33
        for <multiple recipients>; Tue, 21 Oct 2014 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/Vc6fld5Ec9ynVAFbGmk8sIXLHBeoICLLKh4Esopd8=;
        b=oDw/3XeIGpMFGP6DXlMdOOPjQDftuw6h6auKwEvu3JFOByNIZi4MxYylyzYsZMfRoD
         vYcTFYWNQlXMSTEyxZbIgJ0A3+p5ZkxRrMi2+SgbwDi9mOipg8CP7vCkuS4s20KppyG8
         PeZPWGI+eXPthtVDAvtYkVkWLaHH7fDWfpUSHLgx4TEagtzsu1jF1zbw7s50eArXO0XK
         YVLtvSjLlXCzX5e6vJSxTrJA3Ma/BS2IDuWH7P3ss+ml9gZ6lnpBaa9DhFhDQ/vVnt1T
         7MLRyak2BoYHhslXyx4Kxo35+SmpZZJzYmWxhlYL60V6LgCG1c2cOcE7SHhoYGTErGFu
         lkMg==
X-Received: by 10.152.243.8 with SMTP id wu8mr37782091lac.21.1413932620365;
        Tue, 21 Oct 2014 16:03:40 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id lk5sm5077133lac.45.2014.10.21.16.03.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 16:03:39 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v2 05/13] MIPS: ath25: add early printk support
Date:   Wed, 22 Oct 2014 03:03:43 +0400
Message-Id: <1413932631-12866-6-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43452
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

Changes since v1:
  - rename MIPS machine ar231x -> ath25

 arch/mips/Kconfig              |  1 +
 arch/mips/ath25/Makefile       |  2 ++
 arch/mips/ath25/early_printk.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 arch/mips/ath25/early_printk.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index baa1c5b..b7466f1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -106,6 +106,7 @@ config ATH25
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select ARCH_REQUIRE_GPIOLIB
+	select SYS_HAS_EARLY_PRINTK
 	help
 	  Support for Atheros AR231x and Atheros AR531x based boards
 
diff --git a/arch/mips/ath25/Makefile b/arch/mips/ath25/Makefile
index 201b7d4..eabad7d 100644
--- a/arch/mips/ath25/Makefile
+++ b/arch/mips/ath25/Makefile
@@ -10,5 +10,7 @@
 
 obj-y += board.o prom.o devices.o
 
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
+
 obj-$(CONFIG_SOC_AR5312) += ar5312.o
 obj-$(CONFIG_SOC_AR2315) += ar2315.o
diff --git a/arch/mips/ath25/early_printk.c b/arch/mips/ath25/early_printk.c
new file mode 100644
index 0000000..31ef23e
--- /dev/null
+++ b/arch/mips/ath25/early_printk.c
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
+		if (is_ar2315())
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
