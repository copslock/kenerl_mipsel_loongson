Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 18:47:47 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:2232 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20037753AbXBESrj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 18:47:39 +0000
Received: (qmail 18474 invoked by uid 101); 5 Feb 2007 18:46:08 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 5 Feb 2007 18:46:08 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l15Ik7oY004282;
	Mon, 5 Feb 2007 10:46:07 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <1CC7P2VK>; Mon, 5 Feb 2007 10:46:07 -0800
Message-ID: <45C77B61.1080209@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	linux-serial@vger.kernel.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Date:	Mon, 5 Feb 2007 10:45:53 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 05 Feb 2007 18:45:53.0270 (UTC) FILETIME=[DD083960:01C74955]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Third attempt at the serial driver patch for the PMC-Sierra MSP71xx device.

There are three different fixes:
1. Fix for DesignWare THRE errata
- Dropped our fix since the "8250-uart-backup-timer.patch" in the "mm"
tree also fixes it. This patch needs to be applied on top of it.

2. Fix for Busy Detect on LCR write
- Dropped the addition of UPIO_DWAPB iotype to 8250_early.c as Sergei
pointed out the fix wasn't complete and we don't require it.

3. Workaround for interrupt/data concurrency issue
- Fix must remain serial8250_interrupt() in order to mark interrupt as
handled.

Thanks,
Marc

Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 3d91bfc..489ff2b 100644
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
+		if ((save_offset == UART_TX || save_offset == UART_IER) && in_irq())
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
+		} else if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY &&
+				up->port.iotype == UPIO_DWAPB) {
+			/* The DesignWare APB UART has an Busy Detect (0x07)
+			 * interrupt meaning an LCR write attempt occured while the
+			 * UART was busy. The interrupt must be cleared by reading
+			 * the UART status register (USR) and the LCR re-written. */
+			unsigned int status;
+			status = *(volatile u32 *)up->port.data;
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

@@ -2454,9 +2485,12 @@ int __init serial8250_start_console(stru

  	add_preferred_console("ttyS", line, options);
  	printk("Adding console on ttyS%d at %s 0x%lx (options '%s')\n",
-		line, port->iotype == UPIO_MEM ? "MMIO" : "I/O port",
-		port->iotype == UPIO_MEM ? (unsigned long) port->mapbase :
-		    (unsigned long) port->iobase, options);
+		line,
+		(port->iotype == UPIO_MEM || port->iotype == UPIO_DWAPB)
+			? "MMIO" : "I/O port",
+		(port->iotype == UPIO_MEM || port->iotype == UPIO_DWAPB)
+			? (unsigned long) port->mapbase : (unsigned long) port->iobase,
+		options);
  	if (!(serial8250_console.flags & CON_ENABLED)) {
  		serial8250_console.flags &= ~CON_PRINTBUFFER;
  		register_console(&serial8250_console);
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
index cf23813..9cb9b3b 100644
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
+	void				*data;			/* generic platform data pointer */
  };

  /*
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 3c8a6aa..b3550cc 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -37,6 +37,7 @@ #define UART_IIR_MSI		0x00 /* Modem stat
  #define UART_IIR_THRI		0x02 /* Transmitter holding register empty */
  #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
  #define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
+#define UART_IIR_BUSY		0x07 /* DesignWare APB Busy Detect */

  #define UART_FCR	2	/* Out: FIFO Control Register */
  #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
