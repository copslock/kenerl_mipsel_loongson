Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2011 14:43:36 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56104 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491944Ab1HOMnL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Aug 2011 14:43:11 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7FCgRm4025628
        for <linux-mips@linux-mips.org>; Mon, 15 Aug 2011 13:42:27 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7FCgRFH025627
        for linux-mips@linux-mips.org; Mon, 15 Aug 2011 13:42:27 +0100
Resent-From: Ralf Baechle <ralf@linux-mips.org>
Resent-Date: Mon, 15 Aug 2011 13:42:27 +0100
Resent-Message-ID: <20110815124227.GB25536@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from vger.kernel.org ([209.132.180.67]:42299 "EHLO vger.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491938Ab1HOJSL (ORCPT <rfc822;ralf@linux-mips.org>);
        Mon, 15 Aug 2011 11:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674Ab1HOJSK (ORCPT <rfc822;ralf@linux-mips.org> + 1 other);
        Mon, 15 Aug 2011 05:18:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44113 "EHLO
        mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672Ab1HOJSJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Aug 2011 05:18:09 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so3358626wyg.19
        for <linux-serial@vger.kernel.org>; Mon, 15 Aug 2011 02:18:09 -0700 (PDT)
Received: by 10.216.156.137 with SMTP id m9mr3194125wek.55.1313399889013;
        Mon, 15 Aug 2011 02:18:09 -0700 (PDT)
Received: from localhost (gw-ba1.picochip.com [94.175.234.108])
        by mx.google.com with ESMTPS id b47sm3501138wed.46.2011.08.15.02.18.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Aug 2011 02:18:08 -0700 (PDT)
From:   Jamie Iles <jamie@jamieiles.com>
To:     linux-serial@vger.kernel.org
Cc:     arnd@arndb.de, Jamie Iles <jamie@jamieiles.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alan Cox <alan@linux.intel.com>
Subject: [PATCH 4/5] mips: msp71xx/serial: add workaround for DW UART
Date:   Mon, 15 Aug 2011 10:17:54 +0100
Message-Id: <1313399875-11006-5-git-send-email-jamie@jamieiles.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
X-archive-position: 30876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10803

The Synopsys DesignWare UART in pmc-sierra msp71xx has an extra feature
where the UART detects a write attempt to the LCR whilst busy and raises
an interrupt.  The driver needs to clear the interrupt and rewrite the
LCR.  Move this into platform code and out of the 8250 driver.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_serial.c |   69 +++++++++++++++++++++++++++--
 1 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
index c3247b5..a1c7c7d 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
@@ -27,6 +27,7 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
+#include <linux/slab.h>
 
 #include <asm/bootinfo.h>
 #include <asm/io.h>
@@ -38,6 +39,55 @@
 #include <msp_int.h>
 #include <msp_regs.h>
 
+struct msp_uart_data {
+	int	last_lcr;
+};
+
+static void msp_serial_out(struct uart_port *p, int offset, int value)
+{
+	struct msp_uart_data *d = p->private_data;
+
+	if (offset == UART_LCR)
+		d->last_lcr = value;
+
+	offset <<= p->regshift;
+	writeb(value, p->membase + offset);
+}
+
+static unsigned int msp_serial_in(struct uart_port *p, int offset)
+{
+	offset <<= p->regshift;
+
+	return readb(p->membase + offset);
+}
+
+static int msp_serial_handle_irq(struct uart_port *p)
+{
+	struct msp_uart_data *d = p->private_data;
+	unsigned int iir = readb(p->membase + (UART_IIR << p->regshift));
+
+	if (serial8250_handle_irq(p, iir)) {
+		return 1;
+	} else if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
+		/*
+		 * The DesignWare APB UART has an Busy Detect (0x07) interrupt
+		 * meaning an LCR write attempt occurred while the UART was
+		 * busy. The interrupt must be cleared by reading the UART
+		 * status register (USR) and the LCR re-written.
+		 *
+		 * Note: MSP reserves 0x20 bytes of address space for the UART
+		 * and the USR is mapped in a separate block at an offset of
+		 * 0xc0 from the start of the UART.
+		 */
+		(void)readb(p->membase + 0xc0);
+		writeb(d->last_lcr, p->membase + (UART_LCR << p->regshift));
+
+		return 1;
+	}
+
+	return 0;
+}
+
 void __init msp_serial_setup(void)
 {
 	char    *s;
@@ -59,13 +109,22 @@ void __init msp_serial_setup(void)
 	up.irq          = MSP_INT_UART0;
 	up.uartclk      = uartclk;
 	up.regshift     = 2;
-	up.iotype       = UPIO_DWAPB; /* UPIO_MEM like */
+	up.iotype       = UPIO_MEM;
 	up.flags        = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	up.type         = PORT_16550A;
 	up.line         = 0;
-	up.private_data		= (void*)UART0_STATUS_REG;
-	if (early_serial_setup(&up))
+	up.serial_out	= msp_serial_out;
+	up.serial_in	= msp_serial_in;
+	up.handle_irq	= msp_serial_handle_irq;
+	up.private_data	= kzalloc(sizeof(struct msp_uart_data), GFP_KERNEL);
+	if (!up.private_data) {
+		pr_err("failed to allocate uart private data\n");
+		return;
+	}
+	if (early_serial_setup(&up)) {
+		kfree(up.private_data);
 		pr_err("Early serial init of port 0 failed\n");
+	}
 
 	/* Initialize the second serial port, if one exists */
 	switch (mips_machtype) {
@@ -88,6 +147,8 @@ void __init msp_serial_setup(void)
 	up.irq          = MSP_INT_UART1;
 	up.line         = 1;
 	up.private_data		= (void*)UART1_STATUS_REG;
-	if (early_serial_setup(&up))
+	if (early_serial_setup(&up)) {
+		kfree(up.private_data);
 		pr_err("Early serial init of port 1 failed\n");
+	}
 }
-- 
1.7.4.1

