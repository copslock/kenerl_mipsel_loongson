Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:51:11 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48628 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825708Ab2JWRsG1kZxf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:06 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so520790lbb.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=o32+fnKCwwgBdDQ8sOrc62qR7Nk7B+2HEZL6q86pass=;
        b=BXq4iIIbJ9+XHU1H55i5KIr7Omia3k7ZfjU0ftMi6eP1UBJZ/eujQU1laPZzmdQCxY
         uXvDQ0L1qB0xOrA3m7FF7l4Hrlq9no1iwQntOqxVz7+QW52yAcMVpe1uLO+S9N8VTxrU
         qSBkfizsDbocQhIQZHrrb/t1C/eUpUexlgkYbLze6uYBaTCLCUu6W2OouwX5AzNV3INf
         H5gIAzoquRqrAGX0Mi+UNkUXBWjtlEeUULBWLZpBYtHyEo2KPJGAz1rTrqBAFbR2LWk6
         w/Jac6e8RlfSf3yiVyyStuTlKYQZAyheVqdohWEwRVMzZuP29dAU97xq+xdYO3iabaI8
         7wwQ==
Received: by 10.112.39.170 with SMTP id q10mr5021470lbk.120.1351014485846;
        Tue, 23 Oct 2012 10:48:05 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.48.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:48:05 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 10/13] MIPS: JZ4750D: Add platform UART devices
Date:   Tue, 23 Oct 2012 21:43:58 +0400
Message-Id: <1351014241-3207-11-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34760
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

Add platform devices for the JZ4750D platform UART drivers.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/include/asm/mach-jz4750d/platform.h |   22 +++++++
 arch/mips/jz4750d/platform.c                  |   84 +++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-jz4750d/platform.h
 create mode 100644 arch/mips/jz4750d/platform.c

diff --git a/arch/mips/include/asm/mach-jz4750d/platform.h b/arch/mips/include/asm/mach-jz4750d/platform.h
new file mode 100644
index 0000000..255a165
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4750d/platform.h
@@ -0,0 +1,22 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D platform device definitions
+ *
+ *  based on JZ4740 platform device definitions
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __JZ4750D_PLATFORM_H__
+#define __JZ4750D_PLATFORM_H__
+
+#include <linux/platform_device.h>
+
+void jz4750d_serial_device_register(void);
+
+#endif /* __JZ4750D_PLATFORM_H__ */
diff --git a/arch/mips/jz4750d/platform.c b/arch/mips/jz4750d/platform.c
new file mode 100644
index 0000000..5ac083d
--- /dev/null
+++ b/arch/mips/jz4750d/platform.c
@@ -0,0 +1,84 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D platform devices
+ *
+ *  based on JZ4740 platform devices
+ *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+
+#include <linux/dma-mapping.h>
+
+#include <asm/mach-jz4750d/platform.h>
+#include <asm/mach-jz4750d/base.h>
+#include <asm/mach-jz4750d/irq.h>
+
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+
+#include "serial.h"
+#include "clock.h"
+
+/* Serial */
+#define JZ4750D_UART_DATA(_id) \
+	{ \
+		.flags = UPF_SKIP_TEST | UPF_IOREMAP | UPF_FIXED_TYPE, \
+		.iotype = UPIO_MEM, \
+		.regshift = 2, \
+		.serial_out = jz4750d_serial_out, \
+		.type = PORT_16550, \
+		.mapbase = JZ4750D_UART ## _id ## _BASE_ADDR, \
+		.irq = JZ4750D_IRQ_UART ## _id, \
+	}
+
+static struct plat_serial8250_port jz4750d_uart_data[] = {
+	JZ4750D_UART_DATA(0),
+	JZ4750D_UART_DATA(1),
+	{},
+};
+
+static struct platform_device jz4750d_uart_device = {
+	.name = "serial8250",
+	.id = 0,
+	.dev = {
+		.platform_data = jz4750d_uart_data,
+	},
+};
+
+#define JZ_REG_CLOCK_CTRL	0x00
+#define JZ_CLOCK_CTRL_KO_ENABLE	BIT(30)
+
+void jz4750d_serial_device_register(void)
+{
+	void __iomem *cpm_base = ioremap(JZ4750D_CPM_BASE_ADDR, 0x100);
+	struct plat_serial8250_port *p;
+	int uart_rate;
+
+	uart_rate = jz4750d_clock_bdata.ext_rate;
+
+	/*
+	 * FIXME
+	 * ECS bit selects the clock source between EXCLK and EXCLK/2 output
+	 * This bit is only used to APB device such as UART I2S I2C SSI SADC UDC_PHY etc.
+	 */
+
+	if (readl(cpm_base + JZ_REG_CLOCK_CTRL) & JZ_CLOCK_CTRL_KO_ENABLE) {
+		uart_rate >>= 1;
+	}
+
+	for (p = jz4750d_uart_data; p->flags != 0; ++p)
+		p->uartclk = uart_rate;
+
+	platform_device_register(&jz4750d_uart_device);
+}
-- 
1.7.10.4
