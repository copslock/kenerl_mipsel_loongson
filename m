Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 15:47:26 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:46335 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20032089AbYGYOrY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 15:47:24 +0100
Received: from localhost (p3225-ipad203funabasi.chiba.ocn.ne.jp [222.146.82.225])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5E208ACB9; Fri, 25 Jul 2008 23:47:19 +0900 (JST)
Date:	Fri, 25 Jul 2008 23:49:14 +0900 (JST)
Message-Id: <20080725.234914.41630045.anemo@mba.ocn.ne.jp>
To:	Jason Wessel <jason.wessel@windriver.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] kgdb: kgdboc serial_txx9 I/O module
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Implement the serial polling hooks for the serial_txx9 uart for use
with kgdboc.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/serial/serial_txx9.c |  113 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 92 insertions(+), 21 deletions(-)

diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index 8fcb4c5..6f18215 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -461,6 +461,94 @@ static void serial_txx9_break_ctl(struct uart_port *port, int break_state)
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
+#if defined(CONFIG_SERIAL_TXX9_CONSOLE) || (CONFIG_CONSOLE_POLL)
+/*
+ *	Wait for transmitter & holding register to empty
+ */
+static void wait_for_xmitr(struct uart_txx9_port *up)
+{
+	unsigned int tmout = 10000;
+
+	/* Wait up to 10ms for the character(s) to be sent. */
+	while (--tmout &&
+	       !(sio_in(up, TXX9_SICISR) & TXX9_SICISR_TXALS))
+		udelay(1);
+
+	/* Wait up to 1s for flow control if necessary */
+	if (up->port.flags & UPF_CONS_FLOW) {
+		tmout = 1000000;
+		while (--tmout &&
+		       (sio_in(up, TXX9_SICISR) & TXX9_SICISR_CTSS))
+			udelay(1);
+	}
+}
+#endif
+
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * Console polling routines for writing and reading from the uart while
+ * in an interrupt or debug context.
+ */
+
+static int serial_txx9_get_poll_char(struct uart_port *port)
+{
+	unsigned int ier;
+	unsigned char c;
+	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
+
+	/*
+	 *	First save the IER then disable the interrupts
+	 */
+	ier = sio_in(up, TXX9_SIDICR);
+	sio_out(up, TXX9_SIDICR, 0);
+
+	while (sio_in(up, TXX9_SIDISR) & TXX9_SIDISR_UVALID)
+		;
+
+	c = sio_in(up, TXX9_SIRFIFO);
+
+	/*
+	 *	Finally, clear RX interrupt status
+	 *	and restore the IER
+	 */
+	sio_mask(up, TXX9_SIDISR, TXX9_SIDISR_RDIS);
+	sio_out(up, TXX9_SIDICR, ier);
+	return c;
+}
+
+
+static void serial_txx9_put_poll_char(struct uart_port *port, unsigned char c)
+{
+	unsigned int ier;
+	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
+
+	/*
+	 *	First save the IER then disable the interrupts
+	 */
+	ier = sio_in(up, TXX9_SIDICR);
+	sio_out(up, TXX9_SIDICR, 0);
+
+	wait_for_xmitr(up);
+	/*
+	 *	Send the character out.
+	 *	If a LF, also do CR...
+	 */
+	sio_out(up, TXX9_SITFIFO, c);
+	if (c == 10) {
+		wait_for_xmitr(up);
+		sio_out(up, TXX9_SITFIFO, 13);
+	}
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	wait_for_xmitr(up);
+	sio_out(up, TXX9_SIDICR, ier);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static int serial_txx9_startup(struct uart_port *port)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
@@ -781,6 +869,10 @@ static struct uart_ops serial_txx9_pops = {
 	.release_port	= serial_txx9_release_port,
 	.request_port	= serial_txx9_request_port,
 	.config_port	= serial_txx9_config_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= serial_txx9_get_poll_char,
+	.poll_put_char	= serial_txx9_put_poll_char,
+#endif
 };
 
 static struct uart_txx9_port serial_txx9_ports[UART_NR];
@@ -803,27 +895,6 @@ static void __init serial_txx9_register_ports(struct uart_driver *drv,
 
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 
-/*
- *	Wait for transmitter & holding register to empty
- */
-static inline void wait_for_xmitr(struct uart_txx9_port *up)
-{
-	unsigned int tmout = 10000;
-
-	/* Wait up to 10ms for the character(s) to be sent. */
-	while (--tmout &&
-	       !(sio_in(up, TXX9_SICISR) & TXX9_SICISR_TXALS))
-		udelay(1);
-
-	/* Wait up to 1s for flow control if necessary */
-	if (up->port.flags & UPF_CONS_FLOW) {
-		tmout = 1000000;
-		while (--tmout &&
-		       (sio_in(up, TXX9_SICISR) & TXX9_SICISR_CTSS))
-			udelay(1);
-	}
-}
-
 static void serial_txx9_console_putchar(struct uart_port *port, int ch)
 {
 	struct uart_txx9_port *up = (struct uart_txx9_port *)port;
-- 
1.5.5.5
