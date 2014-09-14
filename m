Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:33:18 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:57638 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008890AbaINTbyD1la1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:31:54 +0200
Received: by mail-la0-f44.google.com with SMTP id mc6so3572959lab.3
        for <multiple recipients>; Sun, 14 Sep 2014 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eivrkcifzrfHtIP/tq9tu8Bw+jfTdwR2YTeG7DwuFus=;
        b=N9QC7MhvVuZNnBcOGy5Ce0peYFZmB0POvSzXZ5gVRCMhsvKxCRu+u/sY7Cz3Hi/urq
         3aOnzZWk9o2AHiBv0kF170d0OceQvttnOEOP9HNshCIMiRMBgu3TMGdbMdHZ8eMy9ufx
         c0sjum99MP5QkrZc/K1/ITkMyCUbKJ3DYq5LD2wryxH15uVuct7wpNjCkFS15al91S+Z
         DKLvLJeU0rsg3cwpyNTP3/IFPwENBGbm3IW03JHghvuMqdPMHx8KCVpdwVhc+729dSEK
         8/gTkXvDVa3QF/cNbVw5iwzsQU3h0vLuFIqiAV3tdYHDCjlQoQVwaeBgqxRt2xZABovj
         Tb2A==
X-Received: by 10.152.37.169 with SMTP id z9mr4500805laj.66.1410723108697;
        Sun, 14 Sep 2014 12:31:48 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.31.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:31:48 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [RFC 05/18] MIPS: ar231x: add early printk support
Date:   Sun, 14 Sep 2014 23:33:20 +0400
Message-Id: <1410723213-22440-6-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42548
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
1.8.1.5
