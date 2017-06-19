Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:59:18 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58938 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994771AbdFSPuaUpl7H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:30 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 2AA931A46A0;
        Mon, 19 Jun 2017 17:50:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 0A90E1A46A7;
        Mon, 19 Jun 2017 17:50:20 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 8/8] tty: goldfish: Implement support for kernel 'earlycon' parameter
Date:   Mon, 19 Jun 2017 17:50:15 +0200
Message-Id: <1497887415-13825-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

Add early console functionality to the Goldfish tty driver.

When 'earlycon' kernel command line parameter is used with no options,
the early console is determined by the 'stdout-path' property in device
tree's 'chosen' node. This is illustrated in the following device tree
source example:

Device tree example:

    chosen {
        stdout-path = "/goldfish_tty@1f004000";
    };

    goldfish_tty@1f004000 {
        interrupts = <0xc>;
        reg = <0x1f004000 0x0 0x1000>;
        compatible = "google,goldfish-tty", "generic,goldfish-tty";
    };

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 drivers/tty/Kconfig    |  3 +++
 drivers/tty/goldfish.c | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 9510305..873e0ba 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -392,6 +392,9 @@ config PPC_EARLY_DEBUG_EHV_BC_HANDLE
 config GOLDFISH_TTY
 	tristate "Goldfish TTY Driver"
 	depends on GOLDFISH
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 	help
 	  Console and system TTY driver for the Goldfish virtual platform.
 
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index acd50fa..22b7ad5 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2007 Google, Inc.
  * Copyright (C) 2012 Intel, Inc.
+ * Copyright (C) 2017 Imagination Technologies Ltd.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -24,6 +25,7 @@
 #include <linux/goldfish.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
+#include <linux/serial_core.h>
 
 enum {
 	GOLDFISH_TTY_PUT_CHAR       = 0x00,
@@ -427,6 +429,30 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void gf_early_console_putchar(struct uart_port *port, int ch)
+{
+	__raw_writel(ch, port->membase);
+}
+
+static void gf_early_write(struct console *con, const char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, gf_early_console_putchar);
+}
+
+static int __init gf_earlycon_setup(struct earlycon_device *device,
+					const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = gf_early_write;
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(early_gf_tty, "google,goldfish-tty", gf_earlycon_setup);
+
 static const struct of_device_id goldfish_tty_of_match[] = {
 	{ .compatible = "google,goldfish-tty", },
 	{},
-- 
2.7.4
