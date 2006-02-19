Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 21:51:09 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:37644 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133604AbWBSVuz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 21:50:55 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9D13F64D3D; Sun, 19 Feb 2006 21:57:47 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 6692E8D5D; Sun, 19 Feb 2006 21:57:40 +0000 (GMT)
Date:	Sun, 19 Feb 2006 21:57:40 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>, rmk+serial@arm.linux.org.uk
Cc:	linux-mips@linux-mips.org,
	Stanislaw Skowronek <skylark@linux-mips.org>
Subject: Re: Merging Skylark's IOC3 patch
Message-ID: <20060219215740.GQ10266@deprecation.cyrius.com>
References: <20060219211527.GA12848@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219211527.GA12848@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-19 21:15]:
> Can you please review and/or merge Skylark's IOC3 patch from
> ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/linux-mips-2.6.14-ioc3-r26.patch.bz2
> 
> From my basic understanding I believe that this patch needs to be split up
> and submitted to different sub-system maintainers.

(Russell, this is only a RFC for now since the main support patch
for IOC3 has not been merged yet.  But please do comment)


From: Stanislaw Skowronek <skylark@linux-mips.org>

[PATCH 4/6] serial: UART support for SGI IOC3 bridge

Add UART support for the SGI IOC3 bridge, used in Origin and Octane
machines.

Signed-off-by: Stanislaw Skowronek <skylark@linux-mips.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 drivers/serial/8250.c        |   17 ++++-
 drivers/serial/Kconfig       |    7 ++
 drivers/serial/Makefile      |    1 
 drivers/serial/ioc3uart.c    |  135 +++++++++++++++++++++++++++++++++++++++++++
 drivers/serial/serial_core.c |   12 ++-
 include/linux/serial.h       |    1 
 include/linux/serial_core.h  |    1 
 7 files changed, 169 insertions(+), 5 deletions(-)

--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -310,6 +310,9 @@ static unsigned int serial_in(struct uar
 	case UPIO_MEM:
 		return readb(up->port.membase + offset);
 
+	case UPIO_IOC3:
+		return readb(up->port.membase + (offset^3));
+
 	case UPIO_MEM32:
 		return readl(up->port.membase + offset);
 
@@ -338,6 +341,10 @@ serial_out(struct uart_8250_port *up, in
 		writeb(value, up->port.membase + offset);
 		break;
 
+	case UPIO_IOC3:
+		writeb(value, up->port.membase + (offset^3));
+		break;
+
 	case UPIO_MEM32:
 		writel(value, up->port.membase + offset);
 		break;
@@ -1906,6 +1913,8 @@ static int serial8250_request_std_resour
 	int ret = 0;
 
 	switch (up->port.iotype) {
+	case UPIO_IOC3:
+		break;
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
@@ -1938,6 +1947,8 @@ static void serial8250_release_std_resou
 	unsigned int size = 8 << up->port.regshift;
 
 	switch (up->port.iotype) {
+	case UPIO_IOC3:
+		break;
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
@@ -2300,8 +2311,10 @@ int __init serial8250_start_console(stru
 
 	add_preferred_console("ttyS", line, options);
 	printk("Adding console on ttyS%d at %s 0x%lx (options '%s')\n",
-		line, port->iotype == UPIO_MEM ? "MMIO" : "I/O port",
-		port->iotype == UPIO_MEM ? (unsigned long) port->mapbase :
+		line, port->iotype == UPIO_MEM ? "MMIO" : 
+		port->iotype == UPIO_IOC3 ? "IOC3" : "I/O port",
+		(port->iotype == UPIO_MEM || port->iotype == UPIO_IOC3) ?
+		    (unsigned long) port->mapbase :
 		    (unsigned long) port->iobase, options);
 	if (!(serial8250_console.flags & CON_ENABLED)) {
 		serial8250_console.flags &= ~CON_PRINTBUFFER;
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index baa8417..0f1102f 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -225,6 +225,13 @@ config SERIAL_8250_AU1X00
 	  to this option.  The driver can handle 1 or 2 serial ports.
 	  If unsure, say N.
 
+config SGI_IOC3_UART
+	bool "SGI IOC3 UART support"
+	depends on SGI_IOC3 && SERIAL_8250
+	help
+	  Enable this if you have a SGI Origin or Octane machine. This module
+	  provides serial port support for IOC3 chips on those systems.
+
 comment "Non-8250 serial port support"
 
 config SERIAL_AMBA_PL010
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 738f0a0..5ea2e3e 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_ETRAX_SERIAL) += crisv10.o
 obj-$(CONFIG_SERIAL_JSM) += jsm/
 obj-$(CONFIG_SERIAL_TXX9) += serial_txx9.o
 obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
+obj-$(CONFIG_SGI_IOC3_UART) += ioc3uart.o
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
 obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 95fb493..40db05c 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1636,9 +1636,10 @@ static int uart_line_info(char *buf, str
 
 	ret = sprintf(buf, "%d: uart:%s %s%08lX irq:%d",
 			port->line, uart_type(port),
-			port->iotype == UPIO_MEM ? "mmio:0x" : "port:",
-			port->iotype == UPIO_MEM ? port->mapbase :
-						(unsigned long) port->iobase,
+			port->iotype == UPIO_MEM ? "mmio:0x" :
+			  port->iotype == UPIO_IOC3 ? "ioc3:0x" : "port:",
+			(port->iotype == UPIO_MEM || port->iotype == UPIO_IOC3) ?
+			  port->mapbase : (unsigned long) port->iobase,
 			port->irq);
 
 	if (port->type == PORT_UNKNOWN) {
@@ -1981,6 +1982,10 @@ uart_report_port(struct uart_driver *drv
 		snprintf(address, sizeof(address),
 			 "MMIO 0x%lx", port->mapbase);
 		break;
+	case UPIO_IOC3:
+		snprintf(address, sizeof(address), "IOC3 0x%lx",
+			 port->mapbase);
+		break;
 	default:
 		strlcpy(address, "*unknown*", sizeof(address));
 		break;
@@ -2311,6 +2316,7 @@ int uart_match_port(struct uart_port *po
 		return (port1->iobase == port2->iobase) &&
 		       (port1->hub6   == port2->hub6);
 	case UPIO_MEM:
+	case UPIO_IOC3:
 		return (port1->mapbase == port2->mapbase);
 	}
 	return 0;
diff --git a/include/linux/serial.h b/include/linux/serial.h
index c69c6b9..a3ee515 100644
--- a/include/linux/serial.h
+++ b/include/linux/serial.h
@@ -82,6 +82,7 @@ struct serial_struct {
 #define SERIAL_IO_PORT	0
 #define SERIAL_IO_HUB6	1
 #define SERIAL_IO_MEM	2
+#define SERIAL_IO_IOC3	3
 
 struct serial_uart_config {
 	char	*name;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4041122..9441c90 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -221,6 +221,7 @@ struct uart_port {
 #define UPIO_MEM		(2)
 #define UPIO_MEM32		(3)
 #define UPIO_AU			(4)			/* Au1x00 type IO */
+#define UPIO_IOC3		(5)
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
--- /dev/null	2006-02-13 15:11:07.474148640 +0000
+++ b/drivers/serial/ioc3uart.c	2006-02-19 21:26:13.000000000 +0000
@@ -0,0 +1,135 @@
+/*
+ * SGI IOC3 bridge for UARTs
+ *
+ * Copyright (C) 2005 Stanislaw Skowronek <skylark@linux-mips.org>
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/serio.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/pci.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <linux/ioc3.h>
+
+#include <linux/serial.h>
+#include <asm/serial.h>
+
+#include "8250.h"
+
+#define IOC3_UARTCLK (22000000 / 3)
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI IOC3 UART driver");
+MODULE_LICENSE("GPL");
+
+/* !!! write dynirq support for IP27 !!! */
+#ifdef CONFIG_SGI_IP30
+int new_dynamic_irq(void);
+void call_dynamic_irq(int irq, struct pt_regs *regs);
+void delete_dynamic_irq(int irq);
+#else
+int new_dynamic_irq(void) { return 0; }
+void call_dynamic_irq(int irq, struct pt_regs *regs) { }
+void delete_dynamic_irq(int irq) { }
+#endif
+
+struct ioc3uart_data {
+	int line_a, line_b;
+	int irq;
+};
+
+static int ioc3uart_intr(struct ioc3_submodule *is, struct ioc3_driver_data *idd, unsigned int irq, struct pt_regs *regs)
+{
+	struct ioc3uart_data *d = (struct ioc3uart_data *)(idd->data[is->id]);
+
+	ioc3_ack(is, idd, irq);
+	call_dynamic_irq(d->irq, regs);
+
+	return 0;
+}
+
+static int ioc3uart_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	struct uart_port port;
+	struct ioc3uart_data *d;
+
+	/* check for UART-less add-on boards */
+	if(idd->class == IOC3_CLASS_MENET_4 || idd->class == IOC3_CLASS_CADDUO)
+		return 1;
+
+	/* set PIO mode for SuperIO UARTs */
+	idd->vma->sscr_a = 0;
+	idd->vma->sscr_b = 0;
+	udelay(1000);
+	idd->vma->sregs.uarta.iu_fcr = 0;
+	idd->vma->sregs.uartb.iu_fcr = 0;
+	udelay(1000);
+
+	d = kmalloc(sizeof(struct ioc3uart_data), GFP_KERNEL);
+	idd->data[is->id] = d;
+	d->irq = new_dynamic_irq();
+
+	/* register serial ports with 8250.c */
+	memset(&port, 0, sizeof(struct uart_port));
+	port.irq = d->irq;
+	port.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	port.uartclk = IOC3_UARTCLK;
+	port.iotype = UPIO_IOC3;
+	port.regshift = 0;
+	port.dev = &(idd->pdev->dev);
+
+	port.membase = (unsigned char *) &idd->vma->sregs.uarta;
+	port.mapbase = ((unsigned long) port.membase) & 0xFFFFFFFFFF;
+	d->line_a = serial8250_register_port(&port);
+
+	port.membase = (unsigned char *) &idd->vma->sregs.uartb;
+	port.mapbase = ((unsigned long) port.membase) & 0xFFFFFFFFFF;
+	d->line_b = serial8250_register_port(&port);
+
+	ioc3_enable(is, idd);
+	return 0;
+}
+
+static int ioc3uart_remove(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	struct ioc3uart_data *d = (struct ioc3uart_data *)(idd->data[is->id]);
+	serial8250_unregister_port(d->line_a);
+	serial8250_unregister_port(d->line_b);
+	delete_dynamic_irq(d->irq);
+	kfree(d);
+	idd->data[is->id] = NULL;
+	return 0;
+}
+
+static struct ioc3_submodule ioc3uart_submodule = {
+	.name = "uart",
+	.probe = ioc3uart_probe,
+	.remove = ioc3uart_remove,
+	.irq_mask = SIO_IR_SA_INT | SIO_IR_SB_INT,
+	.intr = ioc3uart_intr,
+	.owner = THIS_MODULE,
+};
+
+static int __init ioc3uart_init(void)
+{
+	ioc3_register_submodule(&ioc3uart_submodule);
+	return 0;
+}
+
+static void __exit ioc3uart_exit(void)
+{
+	ioc3_unregister_submodule(&ioc3uart_submodule);
+}
+
+module_init(ioc3uart_init);
+module_exit(ioc3uart_exit);

-- 
Martin Michlmayr
http://www.cyrius.com/
