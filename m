Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:42:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53225 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011780AbbARWli4CR0N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:41:38 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3388586C0808A;
        Sun, 18 Jan 2015 22:41:28 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:41:31 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:41:24 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-serial@vger.kernel.org>
Subject: [PATCH 26/36] serial: 8250_jz47xx: support for Ingenic jz47xx UARTs
Date:   Sun, 18 Jan 2015 14:41:21 -0800
Message-ID: <1421620881-25136-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Introduce a driver suitable for use with the UARTs present in
Ingenic jz47xx series SoCs. These are described as being ns16550
compatible but aren't quite - they require the setting of an extra bit
in the FCR register to enable the UART module. The serial_out
implementation is the same as that in arch/mips/jz4740/serial.c - which
will shortly be removed.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/8250/8250_jz47xx.c | 228 ++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig       |   8 ++
 drivers/tty/serial/8250/Makefile      |   1 +
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_jz47xx.c

diff --git a/drivers/tty/serial/8250/8250_jz47xx.c b/drivers/tty/serial/8250/8250_jz47xx.c
new file mode 100644
index 0000000..85cf50b
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_jz47xx.c
@@ -0,0 +1,228 @@
+/*
+ * Copyright (C) 2010 Lars-Peter Clausen <lars@metafoo.de>
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Ingenic jz47xx series UART support
+ *
+ * This program is free software; you can redistribute	 it and/or modify it
+ * under  the terms of	 the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the	License, or (at your
+ * option) any later version.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+
+struct jz47xx_uart_data {
+	struct clk	*clk_module;
+	struct clk	*clk_baud;
+	int		line;
+};
+
+#define UART_FCR_UME	BIT(4)
+
+static struct earlycon_device *early_device;
+
+static uint8_t __init early_in(struct uart_port *port, int offset)
+{
+	return readl(port->membase + (offset << 2));
+}
+
+static void __init early_out(struct uart_port *port, int offset, uint8_t value)
+{
+	writel(value, port->membase + (offset << 2));
+}
+
+static void __init jz47xx_early_console_putc(struct uart_port *port, int c)
+{
+	uint8_t lsr;
+
+	do {
+		lsr = early_in(port, UART_LSR);
+	} while ((lsr & UART_LSR_TEMT) == 0);
+
+	early_out(port, UART_TX, c);
+}
+
+static void __init jz47xx_early_console_write(struct console *console,
+					      const char *s, unsigned int count)
+{
+	uart_console_write(&early_device->port, s, count, jz47xx_early_console_putc);
+}
+
+static int __init jz47xx_early_console_setup(struct earlycon_device *dev,
+					     const char *opt)
+{
+	struct uart_port *port = &dev->port;
+	unsigned int baud, divisor;
+
+	if (!dev->port.membase)
+		return -ENODEV;
+
+	baud = dev->baud ?: 115200;
+	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
+
+	early_out(port, UART_IER, 0);
+	early_out(port, UART_LCR, UART_LCR_DLAB | UART_LCR_WLEN8);
+	early_out(port, UART_DLL, 0);
+	early_out(port, UART_DLM, 0);
+	early_out(port, UART_LCR, UART_LCR_WLEN8);
+	early_out(port, UART_FCR, UART_FCR_UME | UART_FCR_CLEAR_XMIT |
+			UART_FCR_CLEAR_RCVR | UART_FCR_ENABLE_FIFO);
+	early_out(port, UART_MCR, UART_MCR_RTS | UART_MCR_DTR);
+
+	early_out(port, UART_LCR, UART_LCR_DLAB | UART_LCR_WLEN8);
+	early_out(port, UART_DLL, divisor & 0xff);
+	early_out(port, UART_DLM, (divisor >> 8) & 0xff);
+	early_out(port, UART_LCR, UART_LCR_WLEN8);
+
+	early_device = dev;
+	dev->con->write = jz47xx_early_console_write;
+
+	return 0;
+}
+EARLYCON_DECLARE(jz4740_uart, jz47xx_early_console_setup);
+OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart", jz47xx_early_console_setup);
+EARLYCON_DECLARE(jz4780_uart, jz47xx_early_console_setup);
+OF_EARLYCON_DECLARE(jz4780_uart, "ingenic,jz4780-uart", jz47xx_early_console_setup);
+
+static void jz47xx_serial_out(struct uart_port *p, int offset, int value)
+{
+	switch (offset) {
+	case UART_FCR:
+		/* UART module enable */
+		value |= UART_FCR_UME;
+		break;
+
+	case UART_IER:
+		value |= (value & 0x4) << 2;
+		break;
+
+	default:
+		break;
+	}
+
+	writeb(value, p->membase + (offset << p->regshift));
+}
+
+static int jz47xx_probe(struct platform_device *pdev)
+{
+	struct uart_8250_port uart = {};
+	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	struct jz47xx_uart_data *data;
+	int err;
+
+	if (!regs || !irq) {
+		dev_err(&pdev->dev, "no registers/irq defined\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&uart.port.lock);
+	uart.port.type = PORT_16550;
+	uart.port.flags = UPF_SKIP_TEST | UPF_IOREMAP | UPF_FIXED_TYPE;
+	uart.port.iotype = UPIO_MEM;
+	uart.port.mapbase = regs->start;
+	uart.port.regshift = 2;
+	uart.port.serial_out = jz47xx_serial_out;
+	uart.port.irq = irq->start;
+	uart.port.dev = &pdev->dev;
+
+	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
+					 resource_size(regs));
+	if (!uart.port.membase)
+		return -ENOMEM;
+
+	data->clk_module = devm_clk_get(&pdev->dev, "module");
+	if (IS_ERR(data->clk_module)) {
+		err = PTR_ERR(data->clk_module);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "unable to get module clock: %d\n", err);
+		return err;
+	}
+
+	data->clk_baud = devm_clk_get(&pdev->dev, "baud");
+	if (IS_ERR(data->clk_baud)) {
+		err = PTR_ERR(data->clk_baud);
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "unable to get baud clock: %d\n", err);
+		return err;
+	}
+
+	err = clk_prepare_enable(data->clk_module);
+	if (err) {
+		dev_err(&pdev->dev, "could not enable module clock: %d\n", err);
+		goto out;
+	}
+
+	err = clk_prepare_enable(data->clk_baud);
+	if (err) {
+		dev_err(&pdev->dev, "could not enable baud clock: %d\n", err);
+		goto out_disable_moduleclk;
+	}
+	uart.port.uartclk = clk_get_rate(data->clk_baud);
+
+	data->line = serial8250_register_8250_port(&uart);
+	if (data->line < 0) {
+		err = data->line;
+		goto out_disable_baudclk;
+	}
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+
+out_disable_baudclk:
+	clk_disable_unprepare(data->clk_baud);
+out_disable_moduleclk:
+	clk_disable_unprepare(data->clk_module);
+out:
+	return err;
+}
+
+static int jz47xx_remove(struct platform_device *pdev)
+{
+	struct jz47xx_uart_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+	clk_disable_unprepare(data->clk_module);
+	clk_disable_unprepare(data->clk_baud);
+	return 0;
+}
+
+static const struct of_device_id jz47xx_of_match[] = {
+	{ .compatible = "ingenic,jz4740-uart" },
+	{ .compatible = "ingenic,jz4780-uart" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jz47xx_of_match);
+
+static struct platform_driver jz47xx_platform_driver = {
+	.driver = {
+		.name		= "jz47xx-uart",
+		.owner		= THIS_MODULE,
+		.of_match_table	= jz47xx_of_match,
+	},
+	.probe			= jz47xx_probe,
+	.remove			= jz47xx_remove,
+};
+
+module_platform_driver(jz47xx_platform_driver);
+
+MODULE_AUTHOR("Paul Burton");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Ingenic jz47xx SoC series UART driver");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 0fcbcd2..5db322e 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -322,3 +322,11 @@ config SERIAL_8250_MT6577
 	help
 	  If you have a Mediatek based board and want to use the
 	  serial port, say Y to this option. If unsure, say N.
+
+config SERIAL_8250_JZ47XX
+	tristate "Support for Ingenic jz47xx series serial ports"
+	depends on SERIAL_8250
+	select SERIAL_EARLYCON
+	help
+	  If you have a system using an Ingenic jz47xx series SoC and wish to
+	  make use of its UARTs, say Y to this option. If unsure, say N.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 31e7cdc..ddbcb7a 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
 obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
 obj-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
 obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
+obj-$(CONFIG_SERIAL_8250_JZ47XX)	+= 8250_jz47xx.o
-- 
2.2.1
