Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 20:01:48 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:26006 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039417AbXBOUBn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 20:01:43 +0000
Received: (qmail 12208 invoked by uid 101); 15 Feb 2007 19:27:07 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 15 Feb 2007 19:27:07 -0000
Received: from pasqua.pmc-sierra.bc.ca (pasqua.pmc-sierra.bc.ca [134.87.183.161])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1FJR6i3020628;
	Thu, 15 Feb 2007 11:27:06 -0800
From:	Marc St-Jean <stjeanma@pmc-sierra.com>
Received: (from stjeanma@localhost)
	by pasqua.pmc-sierra.bc.ca (8.13.4/8.12.11) id l1FJQT2o020816;
	Thu, 15 Feb 2007 13:26:29 -0600
Date:	Thu, 15 Feb 2007 13:26:29 -0600
Message-Id: <200702151926.l1FJQT2o020816@pasqua.pmc-sierra.bc.ca>
To:	akpm@linux-foundation.org
Subject: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org
Return-Path: <stjeanma@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stjeanma@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Seventh attempt at the serial driver patch for the PMC-Sierra
MSP71xx devices.

There are three different fixes:
1. Fix for DesignWare APB THRE errata:
In brief, this is a non-standard 16550 in that the THRE interrupt
will not re-assert itself simply by disabling and re-enabling the
THRI bit in the IER, it is only re-enabled if a character is actually
sent out.
It appears that the "8250-uart-backup-timer.patch" in the "mm" tree also
fixes it so we have dropped our initial workaround.
This patch now needs to be applied on top of that "mm" patch.

2. Fix for Busy Detect on LCR write:
The DesignWare APB UART has a feature which causes a new Busy Detect
interrupt to be generated if it's busy when the LCR is written. This
fix saves the value of the LCR and rewrites it after clearing the
interrupt.

3. Workaround for interrupt/data concurrency issue:
The SoC needs to ensure that writes that can cause interrupts to be
cleared reach the UART before returning from the ISR. This fix reads
a non-destructive register on the UART so the read transaction
completion ensures the previously queued write transaction has
also completed.


The differences from the last attempt is dropping the call to
in_irq() and including more detailed description of the fixes.

Thanks,
Marc

Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>


diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 3d91bfc..bfaacc5 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -308,6 +308,7 @@ static unsigned int serial_in(struct uar
 		return inb(up->port.iobase + 1);
 
 	case UPIO_MEM:
+	case UPIO_DWAPB:
 		return readb(up->port.membase + offset);
 
 	case UPIO_MEM32:
@@ -333,6 +334,8 @@ #endif
 static void
 serial_out(struct uart_8250_port *up, int offset, int value)
 {
+	/* Save the offset before it's remapped */
+	int save_offset = offset;
 	offset = map_8250_out_reg(up, offset) << up->port.regshift;
 
 	switch (up->port.iotype) {
@@ -359,6 +362,18 @@ #endif
 			writeb(value, up->port.membase + offset);
 		break;
 
+	case UPIO_DWAPB:
+		/* Save the LCR value so it can be re-written when a
+		 * Busy Detect interrupt occurs. */
+		if (save_offset == UART_LCR)
+			up->lcr = value;
+		writeb(value, up->port.membase + offset);
+		/* Read the IER to ensure any interrupt is cleared before
+		 * returning from ISR. */
+		if (save_offset == UART_TX || save_offset == UART_IER)
+			value = serial_in(up, UART_IER);
+		break;
+		
 	default:
 		outb(value, up->port.iobase + offset);
 	}
@@ -373,6 +388,7 @@ serial_out_sync(struct uart_8250_port *u
 #ifdef CONFIG_SERIAL_8250_AU1X00
 	case UPIO_AU:
 #endif
+	case UPIO_DWAPB:
 		serial_out(up, offset, value);
 		(void)serial_in(up, UART_LCR); /* safe, no side-effects */
 		break;
@@ -1383,6 +1399,19 @@ static irqreturn_t serial8250_interrupt(
 			handled = 1;
 
 			end = NULL;
+		} else if (up->port.iotype == UPIO_DWAPB &&
+			  (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
+			/* The DesignWare APB UART has an Busy Detect (0x07)
+			 * interrupt meaning an LCR write attempt occured while the
+			 * UART was busy. The interrupt must be cleared by reading
+			 * the UART status register (USR) and the LCR re-written. */
+			unsigned int status;
+			status = *(volatile u32 *)up->port.private_data;
+			serial_out(up, UART_LCR, up->lcr);
+
+			handled = 1;
+
+			end = NULL;
 		} else if (end == NULL)
 			end = l;
 
@@ -2085,6 +2114,7 @@ static int serial8250_request_std_resour
 	case UPIO_TSI:
 	case UPIO_MEM32:
 	case UPIO_MEM:
+	case UPIO_DWAPB:
 		if (!up->port.mapbase)
 			break;
 
@@ -2122,6 +2152,7 @@ static void serial8250_release_std_resou
 	case UPIO_TSI:
 	case UPIO_MEM32:
 	case UPIO_MEM:
+	case UPIO_DWAPB:
 		if (!up->port.mapbase)
 			break;
 
@@ -2454,8 +2485,8 @@ int __init serial8250_start_console(stru
 
 	add_preferred_console("ttyS", line, options);
 	printk("Adding console on ttyS%d at %s 0x%lx (options '%s')\n",
-		line, port->iotype == UPIO_MEM ? "MMIO" : "I/O port",
-		port->iotype == UPIO_MEM ? (unsigned long) port->mapbase :
+		line, port->iotype >= UPIO_MEM ? "MMIO" : "I/O port",
+		port->iotype >= UPIO_MEM ? (unsigned long) port->mapbase :
 		    (unsigned long) port->iobase, options);
 	if (!(serial8250_console.flags & CON_ENABLED)) {
 		serial8250_console.flags &= ~CON_PRINTBUFFER;
diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index f84982e..f5b6036 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2057,6 +2057,7 @@ uart_report_port(struct uart_driver *drv
 	case UPIO_MEM32:
 	case UPIO_AU:
 	case UPIO_TSI:
+	case UPIO_DWAPB:
 		snprintf(address, sizeof(address),
 			 "MMIO 0x%lx", port->mapbase);
 		break;
@@ -2401,6 +2402,7 @@ int uart_match_port(struct uart_port *po
 	case UPIO_MEM32:
 	case UPIO_AU:
 	case UPIO_TSI:
+	case UPIO_DWAPB:
 		return (port1->mapbase == port2->mapbase);
 	}
 	return 0;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index cf23813..8cdd326 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -230,6 +230,7 @@ #define UPIO_MEM		(2)
 #define UPIO_MEM32		(3)
 #define UPIO_AU			(4)			/* Au1x00 type IO */
 #define UPIO_TSI		(5)			/* Tsi108/109 type IO */
+#define UPIO_DWAPB		(6)			/* DesignWare APB UART */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
@@ -276,6 +277,7 @@ #define UPF_USR_MASK		((__force upf_t) (
 	struct device		*dev;			/* parent device */
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		unused[3];
+	void			*private_data;		/* generic platform data pointer */
 };
 
 /*
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 3c8a6aa..1c5ed7d 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -38,6 +38,8 @@ #define UART_IIR_THRI		0x02 /* Transmitt
 #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
 #define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
 
+#define UART_IIR_BUSY		0x07 /* DesignWare APB Busy Detect */
+
 #define UART_FCR	2	/* Out: FIFO Control Register */
 #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
 #define UART_FCR_CLEAR_RCVR	0x02 /* Clear the RCVR FIFO */
