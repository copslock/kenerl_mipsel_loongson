Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 00:20:23 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:60828 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011793AbaJ1XTBhdDp2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 00:19:01 +0100
Received: by mail-lb0-f172.google.com with SMTP id n15so1544648lbi.17
        for <multiple recipients>; Tue, 28 Oct 2014 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ua4UuESTcQ/iIXhneRQzr0r2v1mnOT5zdZLOUcolRd8=;
        b=qiQzCj1iwKxllvuZowLBOdswMibJN7PZB0C33qAjHRBWX5I4lyeChLpyEdT++DUogd
         DGnnSV6LAPtuDBjGDtd2h7fzuIcRNpz217tdQAkRCwjJ7HGGTngPtBb/VKGSoocOO//t
         z50jQ3Hs2SRDjusXJQLIsFnW9PMWt3UHQXKlnGzWtjpJaEX0NDqIxuU+9Dq+ceNPKr1P
         Zj7L7mc4LwvpChhNr4FMZmcdMpmr72aBpWxWTO0J+PS4/MjN9vfM41Z8QGHJJ73vd2bF
         GS65EZcT/LLNAuSMF8ItB37MKPwl9sAbGL7uvvqNkzF1dzjQxFIPm0qkzr6lfCKv6PB9
         eiOA==
X-Received: by 10.112.48.3 with SMTP id h3mr7442078lbn.71.1414538336225;
        Tue, 28 Oct 2014 16:18:56 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id i6sm1173752laf.47.2014.10.28.16.18.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 16:18:55 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v3 05/13] MIPS: ath25: add early printk support
Date:   Wed, 29 Oct 2014 03:18:42 +0400
Message-Id: <1414538330-5548-6-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43656
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
index 3daeed5..f6ad0c8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -106,6 +106,7 @@ config ATH25
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_32BIT_KERNEL
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
index 0000000..c7cf432
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
+#include "devices.h"
+#include "ar2315_regs.h"
+#include "ar5312_regs.h"
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
+			base = (void __iomem *)(KSEG1ADDR(AR2315_UART0_BASE));
+		else
+			base = (void __iomem *)(KSEG1ADDR(AR5312_UART0_BASE));
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
