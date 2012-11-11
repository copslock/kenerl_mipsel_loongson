Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:54:33 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:64857 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826608Ab2KKMuyu4ugY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:54 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053456bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=D6fyUFnLyBiwzw+T4eM91mawZ/63KXyv+JSqexnM3bY=;
        b=UPTSubSawolkXjsGk+tRmj+tIYW02Pj+Giwz9yDD4Z51uju7vSX9UCFbH9Mt2jz9t1
         Z+QQK0RzLrJLNaPI7lsWMgmce97bnbHeldWt+0Z840mDP8mPTP6OBIJ65EPg+vHZClq8
         kULnff6yr4V+JFCdNxXS3DdOBFP8Nb3gTSnJaViq+RMdz9kB2z+SCRdCgUXS5FZbHxkh
         fgCurMolu0v1ffc85XvT1hVjJ5aco6vsX6lB9dh6lFt4pIvBYqeJHfFGK69rCdhDrkEA
         v/3xGcXZvb9yg3hMxd5lTW+YYUSYEjM2conoUWDhysfSG/ySD6XdNSI/xBVPaRVNVvA8
         nMQQ==
Received: by 10.204.147.89 with SMTP id k25mr5846211bkv.127.1352638254627;
        Sun, 11 Nov 2012 04:50:54 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.52
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:53 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] serial: bcm63xx_uart: allow probing through Device Tree
Date:   Sun, 11 Nov 2012 13:50:46 +0100
Message-Id: <1352638249-29298-13-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Add support for probing the serial ports through Device Tree.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 .../bindings/tty/serial/bcm63xx-uart.txt           |   17 +++++++++
 drivers/tty/serial/bcm63xx_uart.c                  |   35 ++++++++++++++------
 2 files changed, 42 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/bcm63xx-uart.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/bcm63xx-uart.txt b/Documentation/devicetree/bindings/tty/serial/bcm63xx-uart.txt
new file mode 100644
index 0000000..7623604
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/bcm63xx-uart.txt
@@ -0,0 +1,17 @@
+* Broadcom BCM63XX UART
+
+Required properties:
+- compatible: "brcm,bcm63xx-uart"
+  Compatible with all BCM63XX SoCs.
+
+- reg: address and length of the register block.
+
+- interrupts: the uart's interrupt number.
+
+Example:
+
+	uart0: serial@100 {
+		compatible = "brcm,bcm63xx";
+		reg = <0x100 0x18>;
+		interrupts = <2>;
+	};
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 0187aff..4521a52 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -802,23 +802,32 @@ static struct uart_driver bcm_uart_driver = {
  */
 static int __devinit bcm_uart_probe(struct platform_device *pdev)
 {
-	struct resource *res_mem, *res_irq;
+	struct resource *res_mem;
 	struct uart_port *port;
 	struct clk *clk;
-	int ret;
+	int ret, irq;
 
-	if (pdev->id < 0 || pdev->id >= BCM63XX_NR_UARTS)
-		return -EINVAL;
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_mem)
+		return -ENODEV;
+
+	if (pdev->id < 0)  {
+		void __iomem *membase;
+
+		membase = ioremap(res_mem->start, resource_size(res_mem));
+		if (membase == (void *)bcm63xx_regset_address(RSET_UART0))
+			pdev->id = 0;
+		else
+			pdev->id = 1;
+		iounmap(membase);
+	}
 
 	if (ports[pdev->id].membase)
 		return -EBUSY;
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res_mem)
-		return -ENODEV;
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_irq)
+	irq = platform_get_irq(pdev, 0);
+	if (!irq)
 		return -ENODEV;
 
 	clk = clk_get(&pdev->dev, "periph");
@@ -829,7 +838,7 @@ static int __devinit bcm_uart_probe(struct platform_device *pdev)
 	memset(port, 0, sizeof(*port));
 	port->iotype = UPIO_MEM;
 	port->mapbase = res_mem->start;
-	port->irq = res_irq->start;
+	port->irq = irq;
 	port->ops = &bcm_uart_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = &pdev->dev;
@@ -862,12 +871,18 @@ static int __devexit bcm_uart_remove(struct platform_device *pdev)
 /*
  * platform driver stuff
  */
+static const struct of_device_id bcm_uart_match[] = {
+	{ .compatible = "brcm,bcm63xx-uart" },
+	{ },
+};
+
 static struct platform_driver bcm_uart_platform_driver = {
 	.probe	= bcm_uart_probe,
 	.remove	= __devexit_p(bcm_uart_remove),
 	.driver	= {
 		.owner = THIS_MODULE,
 		.name  = "bcm63xx_uart",
+		.of_match_table = bcm_uart_match,
 	},
 };
 
-- 
1.7.2.5
