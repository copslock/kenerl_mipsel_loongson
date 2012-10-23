Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:50:53 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34312 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825709Ab2JWRsFLiN2d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:05 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so520825lbb.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=97x/32vcnAk3o5auve0uP+xao8Ot/MW5S6zglfxU3g8=;
        b=k6LJwCJ4CEMZBXPzvqH4T1b7WHNG4wiKBJkSUPTnNeDpktg6jLtvLG56pxsv1cBsCp
         zY9SmoHcF63EfgbH8fu9cOeMCcKx9r3fJQtKX7oA8wVzSUntg55X0cPcUtVszJFMtg19
         P6JxLcTeezJAPUDbwqd/rkSt0QOkdBUO9rvKzvlAwIwFDM7GPC8821JK/rxZCg5t6PsA
         FKlmsfxATAb6KWfXttfb8qLmyRUo0xHHeuqsVFDbpJ5QO6MrYJ6TPdPmwChlIbuWINsR
         E2fiA27UHiw4hoYVvzk/Z5lADPDS2WW2CSzFyf90aRy/FZTdxXc+jqvp3R1HyRomAmVF
         12HQ==
Received: by 10.152.103.18 with SMTP id fs18mr11996162lab.32.1351014484449;
        Tue, 23 Oct 2012 10:48:04 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.48.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:48:03 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 09/13] MIPS: JZ4750D: Add prom support
Date:   Tue, 23 Oct 2012 21:43:57 +0400
Message-Id: <1351014241-3207-10-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Add support for initializing arcs_cmdline on JZ4750D based machines and
provides a prom_putchar implementation.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/jz4750d/prom.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 arch/mips/jz4750d/prom.c

diff --git a/arch/mips/jz4750d/prom.c b/arch/mips/jz4750d/prom.c
new file mode 100644
index 0000000..60cd1fc
--- /dev/null
+++ b/arch/mips/jz4750d/prom.c
@@ -0,0 +1,67 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D SoC prom code
+ *
+ *  based on JZ4740 SoC prom code
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <linux/serial_reg.h>
+
+#include <asm/bootinfo.h>
+#include <asm/mach-jz4750d/base.h>
+
+static __init void jz4750d_init_cmdline(int argc, char *argv[])
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
+	jz4750d_init_cmdline((int)fw_arg0, (char **)fw_arg1);
+	mips_machtype = MACH_INGENIC_JZ4750D;
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+#define UART_REG(_reg) ((void __iomem *)CKSEG1ADDR(JZ4750D_UART1_BASE_ADDR + (_reg << 2)))
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
1.7.10.4
