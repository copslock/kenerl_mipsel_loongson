Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2006 13:43:37 +0100 (BST)
Received: from fri.itea.ntnu.no ([129.241.7.60]:57735 "HELO fri.itea.ntnu.no")
	by ftp.linux-mips.org with SMTP id S8133542AbWDTMn2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2006 13:43:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by fri.itea.ntnu.no (Postfix) with ESMTP id DDABE7EC3;
	Thu, 20 Apr 2006 14:56:00 +0200 (CEST)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.205.150])
	by fri.itea.ntnu.no (Postfix) with ESMTP;
	Thu, 20 Apr 2006 14:55:59 +0200 (CEST)
Received: from invalid.ed.ntnu.no (jonah@localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.13.6/8.13.6) with ESMTP id k3KCtxYf005084
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Thu, 20 Apr 2006 14:55:59 +0200 (CEST)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.13.6/8.13.6/Submit) with ESMTP id k3KCtxD3005081;
	Thu, 20 Apr 2006 14:55:59 +0200 (CEST)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date:	Thu, 20 Apr 2006 14:55:59 +0200 (CEST)
From:	Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To:	rmk+serial@arm.linux.org.uk
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] serial8250: set divisor register correctly for AMD Alchemy
 SoC uart. 3rd edition.
Message-ID: <20060420144509.V1601@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list: linux-mips

Alchemy SoC uart have got a non-standard divisor register that needs some
special handling.

This patch adds divisor read/write functions with test and special
handling for Alchemy internal uart.

Signed-off-by: Jon Anders Haugum <jonah@omegav.ntnu.no>

---

3rd edition:
- Removed section covering 16C850 autoconfig.


--- linux-2.6.16-rc5/drivers/serial/8250.c.orig	2006-03-03 02:12:10.000000000 +0100
+++ linux-2.6.16-rc5/drivers/serial/8250.c	2006-03-03 02:16:19.000000000 +0100
@@ -362,6 +362,40 @@ serial_out(struct uart_8250_port *up, in
 #define serial_inp(up, offset)		serial_in(up, offset)
 #define serial_outp(up, offset, value)	serial_out(up, offset, value)
 
+/* Uart divisor latch read */
+static inline int _serial_dl_read(struct uart_8250_port *up)
+{
+	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
+}
+
+/* Uart divisor latch write */
+static inline void _serial_dl_write(struct uart_8250_port *up, int value)
+{
+	serial_outp(up, UART_DLL, value & 0xff);
+	serial_outp(up, UART_DLM, value >> 8 & 0xff);
+}
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+/* Au1x00 haven't got a standard divisor latch */
+static int serial_dl_read(struct uart_8250_port *up)
+{
+	if (up->port.iotype == UPIO_AU)
+		return __raw_readl(up->port.membase + 0x28);
+	else
+		return _serial_dl_read(up);
+}
+
+static void serial_dl_write(struct uart_8250_port *up, int value)
+{
+	if (up->port.iotype == UPIO_AU)
+		__raw_writel(value, up->port.membase + 0x28);
+	else
+		_serial_dl_write(up, value);
+}
+#else
+#define serial_dl_read(up) _serial_dl_read(up)
+#define serial_dl_write(up, value) _serial_dl_write(up, value)
+#endif
 
 /*
  * For the 16C950
@@ -494,7 +528,8 @@ static void disable_rsa(struct uart_8250
  */
 static int size_fifo(struct uart_8250_port *up)
 {
-	unsigned char old_fcr, old_mcr, old_dll, old_dlm, old_lcr;
+	unsigned char old_fcr, old_mcr, old_lcr;
+	unsigned short old_dl;
 	int count;
 
 	old_lcr = serial_inp(up, UART_LCR);
@@ -505,10 +540,8 @@ static int size_fifo(struct uart_8250_po
 		    UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 	serial_outp(up, UART_MCR, UART_MCR_LOOP);
 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
-	old_dll = serial_inp(up, UART_DLL);
-	old_dlm = serial_inp(up, UART_DLM);
-	serial_outp(up, UART_DLL, 0x01);
-	serial_outp(up, UART_DLM, 0x00);
+	old_dl = serial_dl_read(up);
+	serial_dl_write(up, 0x0001);
 	serial_outp(up, UART_LCR, 0x03);
 	for (count = 0; count < 256; count++)
 		serial_outp(up, UART_TX, count);
@@ -519,8 +552,7 @@ static int size_fifo(struct uart_8250_po
 	serial_outp(up, UART_FCR, old_fcr);
 	serial_outp(up, UART_MCR, old_mcr);
 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
-	serial_outp(up, UART_DLL, old_dll);
-	serial_outp(up, UART_DLM, old_dlm);
+	serial_dl_write(up, old_dl);
 	serial_outp(up, UART_LCR, old_lcr);
 
 	return count;
@@ -750,8 +780,7 @@ static void autoconfig_16550a(struct uar
 
 			serial_outp(up, UART_LCR, 0xE0);
 
-			quot = serial_inp(up, UART_DLM) << 8;
-			quot += serial_inp(up, UART_DLL);
+			quot = serial_dl_read(up);
 			quot <<= 3;
 
 			status1 = serial_in(up, 0x04); /* EXCR1 */
@@ -759,8 +788,7 @@ static void autoconfig_16550a(struct uar
 			status1 |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
 			serial_outp(up, 0x04, status1);
 			
-			serial_outp(up, UART_DLL, quot & 0xff);
-			serial_outp(up, UART_DLM, quot >> 8);
+			serial_dl_write(up, quot);
 
 			serial_outp(up, UART_LCR, 0);
 
@@ -1862,8 +1890,7 @@ serial8250_set_termios(struct uart_port 
 		serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
 	}
 
-	serial_outp(up, UART_DLL, quot & 0xff);		/* LS of divisor */
-	serial_outp(up, UART_DLM, quot >> 8);		/* MS of divisor */
+	serial_dl_write(up, quot);
 
 	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
