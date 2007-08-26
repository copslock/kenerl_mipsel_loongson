Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Aug 2007 18:51:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11482 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026468AbXHZRv1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Aug 2007 18:51:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7QHpOUN016623;
	Sun, 26 Aug 2007 18:51:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7QHpMtd016622;
	Sun, 26 Aug 2007 18:51:22 +0100
Date:	Sun, 26 Aug 2007 18:51:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: [PATCH] IOC3: Program UART predividers.
Message-ID: <20070826175122.GA16430@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The IOC3 driver's UART detection bits used to rely on the the firmware
setting the UART pre-divider in a way that's apropriate for the 8250
driver which doesn't currently program this register.  This happens
to work for the console but not rarely for additional ports.

While at it, also program the UART to RS-232 PIO mode; it the UART might
have been in mac-serial and/or DMA mode though that hasn't actually been
observed in practice.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/net/ioc3-eth.c b/drivers/net/ioc3-eth.c
index a36e95c..c030030 100644
--- a/drivers/net/ioc3-eth.c
+++ b/drivers/net/ioc3-eth.c
@@ -48,6 +48,7 @@
 #ifdef CONFIG_SERIAL_8250
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
 #endif
 
 #include <linux/netdevice.h>
@@ -1146,13 +1147,41 @@ static int ioc3_is_menet(struct pci_dev *pdev)
  * Also look in ip27-pci.c:pci_fixup_ioc3() for some comments on working
  * around ioc3 oddities in this respect.
  *
- * The IOC3 serials use a 22MHz clock rate with an additional divider by 3.
+ * The IOC3 serials use a 22MHz clock rate with an additional divider which
+ * can be programmed in the SCR register if the DLAB bit is set.
+ *
+ * Register to interrupt zero because we share the interrupt with
+ * the serial driver which we don't properly support yet.
+ *
+ * Can't use UPF_IOREMAP as the whole of IOC3 resources have already been
+ * registered.
  */
+static void __devinit ioc3_8250_register(struct ioc3_uartregs __iomem *uart)
+{
+#define COSMISC_CONSTANT 6
+
+	struct uart_port port = {
+		.irq		= 0,
+		.flags		= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 0,
+		.uartclk	= (22000000 << 1) / COSMISC_CONSTANT,
+
+		.membase	= (unsigned char __iomem *) uart,
+		.mapbase	= (unsigned long) uart,
+	};
+	unsigned char lcr;
+
+	lcr = uart->iu_lcr;
+	uart->iu_lcr = lcr | UART_LCR_DLAB;
+	uart->iu_scr = COSMISC_CONSTANT,
+	uart->iu_lcr = lcr;
+	uart->iu_lcr;
+	serial8250_register_port(&port);
+}
 
 static void __devinit ioc3_serial_probe(struct pci_dev *pdev, struct ioc3 *ioc3)
 {
-	struct uart_port port;
-
 	/*
 	 * We need to recognice and treat the fourth MENET serial as it
 	 * does not have an SuperIO chip attached to it, therefore attempting
@@ -1166,24 +1195,35 @@ static void __devinit ioc3_serial_probe(struct pci_dev *pdev, struct ioc3 *ioc3)
 		return;
 
 	/*
-	 * Register to interrupt zero because we share the interrupt with
-	 * the serial driver which we don't properly support yet.
-	 *
-	 * Can't use UPF_IOREMAP as the whole of IOC3 resources have already
-	 * been registered.
+	 * Switch IOC3 to PIO mode.  It probably already was but let's be
+	 * paranoid
 	 */
-	memset(&port, 0, sizeof(port));
-	port.irq      = 0;
-	port.flags    = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-	port.iotype   = UPIO_MEM;
-	port.regshift = 0;
-	port.uartclk  = 22000000 / 3;
-
-	port.membase  = (unsigned char *) &ioc3->sregs.uarta;
-	serial8250_register_port(&port);
-
-	port.membase  = (unsigned char *) &ioc3->sregs.uartb;
-	serial8250_register_port(&port);
+	ioc3->gpcr_s = GPCR_UARTA_MODESEL | GPCR_UARTB_MODESEL;
+	ioc3->gpcr_s;
+	ioc3->gppr_6 = 0;
+	ioc3->gppr_6;
+	ioc3->gppr_7 = 0;
+	ioc3->gppr_7;
+	ioc3->sscr_a = ioc3->sscr_a & ~SSCR_DMA_EN;
+	ioc3->sscr_a;
+	ioc3->sscr_b = ioc3->sscr_b & ~SSCR_DMA_EN;
+	ioc3->sscr_b;
+	/* Disable all SA/B interrupts except for SA/B_INT in SIO_IEC. */
+	ioc3->sio_iec &= ~ (SIO_IR_SA_TX_MT | SIO_IR_SA_RX_FULL |
+			    SIO_IR_SA_RX_HIGH | SIO_IR_SA_RX_TIMER |
+			    SIO_IR_SA_DELTA_DCD | SIO_IR_SA_DELTA_CTS |
+			    SIO_IR_SA_TX_EXPLICIT | SIO_IR_SA_MEMERR);
+	ioc3->sio_iec |= SIO_IR_SA_INT;
+	ioc3->sscr_a = 0;
+	ioc3->sio_iec &= ~ (SIO_IR_SB_TX_MT | SIO_IR_SB_RX_FULL |
+			    SIO_IR_SB_RX_HIGH | SIO_IR_SB_RX_TIMER |
+			    SIO_IR_SB_DELTA_DCD | SIO_IR_SB_DELTA_CTS |
+			    SIO_IR_SB_TX_EXPLICIT | SIO_IR_SB_MEMERR);
+	ioc3->sio_iec |= SIO_IR_SB_INT;
+	ioc3->sscr_b = 0;
+
+	ioc3_8250_register(&ioc3->sregs.uarta);
+	ioc3_8250_register(&ioc3->sregs.uartb);
 }
 #endif
 
