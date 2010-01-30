Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:43:03 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:43139 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492196Ab0A3Rm7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:42:59 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 30B0E551083; Sat, 30 Jan 2010 18:42:59 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 2/2] bcm63xx_uart: allow more than one uart to be registered.
Date:   Sat, 30 Jan 2010 18:42:57 +0100
Message-Id: <1264873377-28479-3-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1264873377-28479-1-git-send-email-mbizon@freebox.fr>
References: <1264873377-28479-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 25765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19476

The bcm6358 CPU has two uarts, make it possible to use the second one.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/serial/bcm63xx_uart.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/bcm63xx_uart.c b/drivers/serial/bcm63xx_uart.c
index f78ede8..6ab959a 100644
--- a/drivers/serial/bcm63xx_uart.c
+++ b/drivers/serial/bcm63xx_uart.c
@@ -35,7 +35,7 @@
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
 
-#define BCM63XX_NR_UARTS	1
+#define BCM63XX_NR_UARTS	2
 
 static struct uart_port ports[BCM63XX_NR_UARTS];
 
@@ -784,7 +784,7 @@ static struct uart_driver bcm_uart_driver = {
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
-	.nr		= 1,
+	.nr		= 2,
 	.cons		= BCM63XX_CONSOLE,
 };
 
@@ -826,6 +826,7 @@ static int __devinit bcm_uart_probe(struct platform_device *pdev)
 	port->dev = &pdev->dev;
 	port->fifosize = 16;
 	port->uartclk = clk_get_rate(clk) / 2;
+	port->line = pdev->id;
 	clk_put(clk);
 
 	ret = uart_add_one_port(&bcm_uart_driver, port);
-- 
1.6.3.3
