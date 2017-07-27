Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2017 18:12:12 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:57461 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993956AbdG0QLVgx0u9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jul 2017 18:11:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 1854A1A4700;
        Thu, 27 Jul 2017 18:11:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id E12B21A2258;
        Thu, 27 Jul 2017 18:11:15 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Subject: [PATCH v4 03/16] tty: goldfish: Implement support for kernel 'earlycon' parameter
Date:   Thu, 27 Jul 2017 18:08:46 +0200
Message-Id: <1501171791-23690-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1501171791-23690-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59287
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
