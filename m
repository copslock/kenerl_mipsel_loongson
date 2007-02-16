Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 17:40:46 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:47049 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038999AbXBPRkl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Feb 2007 17:40:41 +0000
Received: (qmail 16922 invoked by uid 101); 16 Feb 2007 17:39:34 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 16 Feb 2007 17:39:34 -0000
Received: from pasqua.pmc-sierra.bc.ca (pasqua.pmc-sierra.bc.ca [134.87.183.161])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1GHdX95024411;
	Fri, 16 Feb 2007 09:39:33 -0800
From:	Marc St-Jean <stjeanma@pmc-sierra.com>
Received: (from stjeanma@localhost)
	by pasqua.pmc-sierra.bc.ca (8.13.4/8.12.11) id l1GHdIvZ021610;
	Fri, 16 Feb 2007 11:39:18 -0600
Date:	Fri, 16 Feb 2007 11:39:18 -0600
Message-Id: <200702161739.l1GHdIvZ021610@pasqua.pmc-sierra.bc.ca>
To:	akpm@linux-foundation.org
Subject: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org
Return-Path: <stjeanma@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stjeanma@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Serial driver patch for the PMC-Sierra MSP71xx devices.

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

Thanks,
Marc

Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
---

Try number eigth, changes since last patch:
-Dropped fix to serial8250_start_console for port->iotype >= UPIO_MEM
since we don't absolutely need this.
-Added platform file initializing the serial ports to patch.

 arch/mips/pmc-sierra/msp71xx/msp_serial.c |  165 ++++++++++++++++++++++++++++++
 drivers/serial/8250.c                     |   31 +++++
 drivers/serial/8250.h                     |    0 
 drivers/serial/serial_core.c              |    2 
 include/linux/serial_core.h               |    2 
 include/linux/serial_reg.h                |    2 
 6 files changed, 202 insertions(+)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 3d91bfc..d224c35 100644
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
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
new file mode 100644
index 0000000..c1afa90
--- /dev/null
+++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
@@ -0,0 +1,165 @@
+/*
+ * The setup file for serial related hardware on PMC-Sierra MSP processors.
+ *
+ * Copyright 2005 PMC-Sierra, Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+
+#include <asm/bootinfo.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/serial.h>
+
+#include <msp_prom.h>
+#include <msp_int.h>
+#include <msp_regs.h>
+
+#ifdef CONFIG_KGDB
+/*
+ * kgdb uses serial port 1 so the console can remain on port 0.
+ * To use port 0 change the definition to read as follows:
+ * #define DEBUG_PORT_BASE KSEG1ADDR(MSP_UART0_BASE)
+ */
+#define DEBUG_PORT_BASE KSEG1ADDR(MSP_UART1_BASE)
+
+int putDebugChar(char c)
+{
+	volatile uint32_t *uart = (volatile uint32_t *)DEBUG_PORT_BASE;
+	uint32_t val = (uint32_t)c;
+	
+	local_irq_disable();
+	while( !(uart[5] & 0x20) ); /* Wait for TXRDY */
+	uart[0] = val;
+	while( !(uart[5] & 0x20) ); /* Wait for TXRDY */
+	local_irq_enable();
+	
+	return 1;
+}
+
+char getDebugChar(void)
+{
+	volatile uint32_t *uart = (volatile uint32_t *)DEBUG_PORT_BASE;
+	uint32_t val;
+	
+	while( !(uart[5] & 0x01) ); /* Wait for RXRDY */
+	val = uart[0];
+	
+	return (char)val;
+}
+
+void initDebugPort(unsigned int uartclk, unsigned int baudrate)
+{
+	unsigned int baud_divisor = (uartclk + 8 * baudrate)/(16 * baudrate);
+	
+	/* Enable FIFOs */
+	writeb(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
+			UART_FCR_CLEAR_XMIT | UART_FCR_TRIGGER_4,
+		(char *)DEBUG_PORT_BASE + (UART_FCR * 4));
+	
+	/* Select brtc divisor */
+	writeb(UART_LCR_DLAB, (char *)DEBUG_PORT_BASE + (UART_LCR * 4));
+	
+	/* Store divisor lsb */
+	writeb(baud_divisor, (char *)DEBUG_PORT_BASE + (UART_TX * 4));
+
+	/* Store divisor msb */
+	writeb(baud_divisor >> 8, (char *)DEBUG_PORT_BASE + (UART_IER * 4));
+	
+	/* Set 8N1 mode */
+	writeb(UART_LCR_WLEN8, (char *)DEBUG_PORT_BASE + (UART_LCR * 4));
+	
+	/* Disable flow control */
+	writeb(0, (char *)DEBUG_PORT_BASE + (UART_MCR * 4));
+	
+	/* Disable receive interrupt(!) */
+	writeb(0, (char *)DEBUG_PORT_BASE + (UART_IER * 4));
+}
+#endif
+
+void __init msp_serial_setup(void)
+{
+	char    *s;
+	char    *endp;
+	struct uart_port up;
+	unsigned int uartclk;
+
+	memset(&up, 0, sizeof(up));
+
+	/* Check if clock was specified in environment */
+	s = prom_getenv("uartfreqhz");
+	if(!(s && *s && (uartclk = simple_strtoul(s, &endp, 10)) && *endp == 0))
+		uartclk = MSP_BASE_BAUD;
+	ppfinit("UART clock set to %d\n", uartclk);
+
+	/* Initialize first serial port */
+	up.mapbase      = MSP_UART0_BASE;
+	up.membase      = ioremap_nocache(up.mapbase,MSP_UART_REG_LEN);
+	up.irq          = MSP_INT_UART0;
+	up.uartclk      = uartclk;
+	up.regshift     = 2;
+	up.iotype       = UPIO_DWAPB; /* UPIO_MEM like */
+	up.flags        = STD_COM_FLAGS;
+	up.type         = PORT_16550A;
+	up.line         = 0;
+	up.private_data		= (void*)UART0_STATUS_REG;
+	if (early_serial_setup(&up))
+		printk(KERN_ERR "Early serial init of port 0 failed\n");
+
+	/* Initialize the second serial port, if one exists */
+	switch (mips_machtype) {
+		case MACH_MSP4200_EVAL:
+		case MACH_MSP4200_GW:
+		case MACH_MSP4200_FPGA:
+		case MACH_MSP7120_EVAL:
+		case MACH_MSP7120_GW:
+		case MACH_MSP7120_FPGA:
+			/* Enable UART1 on MSP4200 and MSP7120 */
+			*GPIO_CFG2_REG = 0x00002299;
+	
+#ifdef CONFIG_KGDB
+			/* Initialize UART1 for kgdb since PMON doesn't */
+			if( DEBUG_PORT_BASE == KSEG1ADDR(MSP_UART1_BASE) ) {
+				if( mips_machtype == MACH_MSP4200_FPGA
+				 || mips_machtype == MACH_MSP7120_FPGA )
+					initDebugPort(uartclk,19200);
+				else
+					initDebugPort(uartclk,57600);
+			}
+#endif
+			break;
+
+		default:
+			return; /* No second serial port, good-bye. */
+	}
+
+	up.mapbase      = MSP_UART1_BASE;
+	up.membase      = ioremap_nocache(up.mapbase,MSP_UART_REG_LEN);
+	up.irq          = MSP_INT_UART1;
+	up.line         = 1;
+	up.private_data		= (void*)UART1_STATUS_REG;
+	if (early_serial_setup(&up))
+		printk(KERN_ERR "Early serial init of port 1 failed\n");
+}
