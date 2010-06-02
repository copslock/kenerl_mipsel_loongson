Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 21:12:26 +0200 (CEST)
Received: from blue-ld-261.synserver.de ([217.119.54.83]:40143 "EHLO
        smtp-out-182.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1492619Ab0FBTLK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 21:11:10 +0200
Received: (qmail 13423 invoked by uid 0); 2 Jun 2010 19:11:10 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 13236
Received: from port-91163.pppoe.wtnet.de (HELO localhost.localdomain) [84.46.68.144]
  by 217.119.54.87 with SMTP; 2 Jun 2010 19:11:10 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC][PATCH 12/26] MIPS: JZ4740: Add prom support
Date:   Wed,  2 Jun 2010 21:10:28 +0200
Message-Id: <1275505832-17185-4-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1275505397-16758-1-git-send-email-lars@metafoo.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
X-archive-position: 27016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1613

This patch adds support for initializing arcs_cmdline on JZ4740 based machines
and provides a prom_putchar implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/prom.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/jz4740/prom.c

diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
new file mode 100644
index 0000000..6518aee
--- /dev/null
+++ b/arch/mips/jz4740/prom.c
@@ -0,0 +1,69 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 SoC prom code
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <linux/serial_reg.h>
+
+#include <asm/bootinfo.h>
+#include <asm/mach-jz4740/base.h>
+
+void jz4740_init_cmdline(int argc, char *argv[])
+{
+	unsigned int count = COMMAND_LINE_SIZE - 1;
+	int i;
+	char *dst = &(arcs_cmdline[0]);
+	char *src;
+
+	for (i = 1; i < argc && count; ++i) {
+		src = argv[i];
+		while (*src && count) {
+			*dst++ = *src++;
+			--count;
+		}
+		*dst++ = ' ';
+	}
+	if (i > 1)
+		--dst;
+
+	*dst = 0;
+}
+
+void __init prom_init(void)
+{
+	jz4740_init_cmdline((int)fw_arg0, (char **)fw_arg1);
+	mips_machtype = MACH_INGENIC_JZ4740;
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+#define UART_REG(_reg) ((void __iomem *)(JZ4740_UART0_BASE_ADDR + (_reg << 2)))
+
+void prom_putchar(char c)
+{
+	uint8_t lsr;
+
+	do {
+		lsr = readb(UART_REG(UART_LSR));
+	} while ((lsr & UART_LSR_TEMT) == 0);
+
+	writeb(c, UART_REG(UART_TX));
+}
-- 
1.5.6.5
