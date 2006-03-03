Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Mar 2006 13:48:51 +0000 (GMT)
Received: from merke.itea.ntnu.no ([129.241.7.61]:64709 "EHLO
	merke.itea.ntnu.no") by ftp.linux-mips.org with ESMTP
	id S8133432AbWCCNsm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Mar 2006 13:48:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by merke.itea.ntnu.no (Postfix) with ESMTP id 91DD313C667;
	Fri,  3 Mar 2006 14:56:42 +0100 (CET)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.205.150])
	by merke.itea.ntnu.no (Postfix) with ESMTP;
	Fri,  3 Mar 2006 14:56:42 +0100 (CET)
Received: from invalid.ed.ntnu.no (jonah@localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.13.3/8.13.3) with ESMTP id k23DugO1096506
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Fri, 3 Mar 2006 14:56:42 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.13.3/8.13.3/Submit) with ESMTP id k23DuctF096503;
	Fri, 3 Mar 2006 14:56:41 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date:	Fri, 3 Mar 2006 14:56:38 +0100 (CET)
From:	Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To:	rmk+serial@arm.linux.org.uk
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] serial8250: set divisor register correctly for AMD Alchemy
 SoC uart
Message-ID: <20060303140428.T96056@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10729
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
@@ -533,22 +565,20 @@ static int size_fifo(struct uart_8250_po
   */
  static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
  {
-	unsigned char old_dll, old_dlm, old_lcr;
+	unsigned char old_lcr;
  	unsigned int id;
+	unsigned short old_dl;

  	old_lcr = serial_inp(p, UART_LCR);
  	serial_outp(p, UART_LCR, UART_LCR_DLAB);

-	old_dll = serial_inp(p, UART_DLL);
-	old_dlm = serial_inp(p, UART_DLM);
+	old_dl = serial_dl_read(p);

-	serial_outp(p, UART_DLL, 0);
-	serial_outp(p, UART_DLM, 0);
+	serial_dl_write(p, 0);

-	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
+	id = serial_dl_read(p);

-	serial_outp(p, UART_DLL, old_dll);
-	serial_outp(p, UART_DLM, old_dlm);
+	serial_dl_write(p, old_dl);
  	serial_outp(p, UART_LCR, old_lcr);

  	return id;
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
