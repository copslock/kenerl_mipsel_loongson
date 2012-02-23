Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:09:09 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47376 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903754Ab2BWQDf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:03:35 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 10/14] MIPS: lantiq: convert falcon debug uart to clkdev api
Date:   Thu, 23 Feb 2012 17:03:09 +0100
Message-Id: <1330012993-13510-10-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Falcon SoCs we have a secondary serial port that can be used to help
debug the voice core. For the port to work several clocking bits need to
be activated. We convert the code to clkdev api.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/prom.c |   11 +----------
 drivers/tty/serial/lantiq.c    |   23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/mips/lantiq/falcon/prom.c b/arch/mips/lantiq/falcon/prom.c
index b50d6f9..2a4eea17 100644
--- a/arch/mips/lantiq/falcon/prom.c
+++ b/arch/mips/lantiq/falcon/prom.c
@@ -27,9 +27,6 @@
 #define TYPE_SHIFT	26
 #define TYPE_MASK	0x3C000000
 
-#define MUXC_SIF_RX_PIN		112
-#define MUXC_SIF_TX_PIN		113
-
 /* this parameter allows us enable/disable asc1 via commandline */
 static int register_asc1;
 static int __init
@@ -46,14 +43,8 @@ ltq_soc_setup(void)
 	ltq_register_asc(0);
 	ltq_register_wdt();
 	falcon_register_gpio();
-	if (register_asc1) {
+	if (register_asc1)
 		ltq_register_asc(1);
-		if (ltq_gpio_request(MUXC_SIF_RX_PIN, 3, 0, "asc1-rx"))
-			pr_err("failed to request asc1-rx");
-		if (ltq_gpio_request(MUXC_SIF_TX_PIN, 3, 1, "asc1-tx"))
-			pr_err("failed to request asc1-tx");
-		ltq_sysctl_activate(SYSCTL_SYS1, ACTS_ASC1_ACT);
-	}
 }
 
 void __init
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 99fb70f..cf88afd 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -107,6 +107,9 @@
 #define ASCFSTAT_TXFREEMASK	0x3F000000
 #define ASCFSTAT_TXFREEOFF	24
 
+#define MUXC_SIF_RX_PIN         112
+#define MUXC_SIF_TX_PIN         113
+
 static void lqasc_tx_chars(struct uart_port *port);
 static struct ltq_uart_port *lqasc_port[MAXPORTS];
 static struct uart_driver lqasc_reg;
@@ -114,6 +117,7 @@ static DEFINE_SPINLOCK(ltq_asc_lock);
 
 struct ltq_uart_port {
 	struct uart_port	port;
+	struct clk		*fpiclk;
 	struct clk		*clk;
 	unsigned int		tx_irq;
 	unsigned int		rx_irq;
@@ -316,7 +320,7 @@ lqasc_startup(struct uart_port *port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 	int retval;
 
-	port->uartclk = clk_get_rate(ltq_port->clk);
+	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
 	ltq_w32_mask(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
@@ -529,6 +533,19 @@ lqasc_request_port(struct uart_port *port)
 		if (port->membase == NULL)
 			return -ENOMEM;
 	}
+
+	if (ltq_is_falcon() && (port->line == 1)) {
+		struct ltq_uart_port *ltq_port = lqasc_port[pdev->id];
+		if (ltq_gpio_request(&pdev->dev, MUXC_SIF_RX_PIN,
+				3, 0, "asc1-rx") ||
+			ltq_gpio_request(&pdev->dev, MUXC_SIF_TX_PIN,
+				3, 1, "asc1-tx"))
+			return -EBUSY;
+		ltq_port->clk = clk_get(&pdev->dev, NULL);
+		if (!ltq_port->clk)
+			return -ENOENT;
+		clk_enable(ltq_port->clk);
+	}
 	return 0;
 }
 
@@ -630,7 +647,7 @@ lqasc_console_setup(struct console *co, char *options)
 
 	port = &ltq_port->port;
 
-	port->uartclk = clk_get_rate(ltq_port->clk);
+	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -715,7 +732,7 @@ lqasc_probe(struct platform_device *pdev)
 	port->irq	= tx_irq; /* unused, just to be backward-compatibe */
 	port->mapbase	= mmres->start;
 
-	ltq_port->clk	= clk;
+	ltq_port->fpiclk = clk;
 
 	ltq_port->tx_irq = tx_irq;
 	ltq_port->rx_irq = rx_irq;
-- 
1.7.7.1
