Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2006 16:57:24 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:38854 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8126483AbWF0P5O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jun 2006 16:57:14 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FvFrT-0000O6-Rc
	for linux-mips@linux-mips.org; Tue, 27 Jun 2006 17:52:24 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FvFwC-0002np-Ri
	for linux-mips@linux-mips.org; Tue, 27 Jun 2006 17:57:16 +0200
Date:	Tue, 27 Jun 2006 17:57:16 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060627155716.GC10595@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: au1x00 UARTs power management
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

the attached patch adds support for power management for UART
interfaces.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-UARTs-pm-support

diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index 482de93..30bfccf 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -92,11 +92,13 @@ static uint	sleep_gpio2_dir;
 static uint	sleep_gpio2_output;
 static uint	sleep_gpio2_enable;
 static uint	sleep_gpio2_inten;
-static uint	sleep_uart0_inten;
-static uint	sleep_uart0_fifoctl;
-static uint	sleep_uart0_linectl;
-static uint	sleep_uart0_clkdiv;
-static uint	sleep_uart0_enable;
+static struct sleep_uart_s {
+	uint	inten;
+	uint	fifoctl;
+	uint	linectl;
+	uint	clkdiv;
+	uint	enable;
+} sleep_uart[4];
 static uint	sleep_usbhost_enable;
 static uint	sleep_usbdev_enable;
 static uint	sleep_static_memctlr[4][3];
@@ -152,11 +154,34 @@ save_core_regs(void)
 	 * standard serial driver doesn't understand our Au1xxx
 	 * unique registers.
 	 */
-	sleep_uart0_inten = au_readl(UART0_ADDR + UART_IER);
-	sleep_uart0_fifoctl = au_readl(UART0_ADDR + UART_FCR);
-	sleep_uart0_linectl = au_readl(UART0_ADDR + UART_LCR);
-	sleep_uart0_clkdiv = au_readl(UART0_ADDR + UART_CLK);
-	sleep_uart0_enable = au_readl(UART0_ADDR + UART_MOD_CNTRL);
+#ifdef UART0_ADDR
+	sleep_uart[0].inten = au_readl(UART0_ADDR + UART_IER);
+	sleep_uart[0].fifoctl = au_readl(UART0_ADDR + UART_FCR);
+	sleep_uart[0].linectl = au_readl(UART0_ADDR + UART_LCR);
+	sleep_uart[0].clkdiv = au_readl(UART0_ADDR + UART_CLK);
+	sleep_uart[0].enable = au_readl(UART0_ADDR + UART_MOD_CNTRL);
+#endif
+#ifdef UART1_ADDR
+	sleep_uart[1].inten = au_readl(UART1_ADDR + UART_IER);
+	sleep_uart[1].fifoctl = au_readl(UART1_ADDR + UART_FCR);
+	sleep_uart[1].linectl = au_readl(UART1_ADDR + UART_LCR);
+	sleep_uart[1].clkdiv = au_readl(UART1_ADDR + UART_CLK);
+	sleep_uart[1].enable = au_readl(UART1_ADDR + UART_MOD_CNTRL);
+#endif
+#ifdef UART2_ADDR
+	sleep_uart[2].inten = au_readl(UART2_ADDR + UART_IER);
+	sleep_uart[2].fifoctl = au_readl(UART2_ADDR + UART_FCR);
+	sleep_uart[2].linectl = au_readl(UART2_ADDR + UART_LCR);
+	sleep_uart[2].clkdiv = au_readl(UART2_ADDR + UART_CLK);
+	sleep_uart[2].enable = au_readl(UART2_ADDR + UART_MOD_CNTRL);
+#endif
+#ifdef UART3_ADDR
+	sleep_uart[3].inten = au_readl(UART3_ADDR + UART_IER);
+	sleep_uart[3].fifoctl = au_readl(UART3_ADDR + UART_FCR);
+	sleep_uart[3].linectl = au_readl(UART3_ADDR + UART_LCR);
+	sleep_uart[3].clkdiv = au_readl(UART3_ADDR + UART_CLK);
+	sleep_uart[3].enable = au_readl(UART3_ADDR + UART_MOD_CNTRL);
+#endif
 
 	/* Shutdown USB host/device.
 	*/
@@ -240,15 +265,50 @@ restore_core_regs(void)
 	/* Enable the UART if it was enabled before sleep.
 	 * I guess I should define module control bits........
 	 */
-	if (sleep_uart0_enable & 0x02) {
+#ifdef UART0_ADDR
+	if (sleep_uart[0].enable & 0x02) {
 		au_writel(0, UART0_ADDR + UART_MOD_CNTRL); au_sync();
 		au_writel(1, UART0_ADDR + UART_MOD_CNTRL); au_sync();
 		au_writel(3, UART0_ADDR + UART_MOD_CNTRL); au_sync();
-		au_writel(sleep_uart0_inten, UART0_ADDR + UART_IER); au_sync();
-		au_writel(sleep_uart0_fifoctl, UART0_ADDR + UART_FCR); au_sync();
-		au_writel(sleep_uart0_linectl, UART0_ADDR + UART_LCR); au_sync();
-		au_writel(sleep_uart0_clkdiv, UART0_ADDR + UART_CLK); au_sync();
+		au_writel(sleep_uart[0].inten, UART0_ADDR + UART_IER); au_sync();
+		au_writel(sleep_uart[0].fifoctl, UART0_ADDR + UART_FCR); au_sync();
+		au_writel(sleep_uart[0].linectl, UART0_ADDR + UART_LCR); au_sync();
+		au_writel(sleep_uart[0].clkdiv, UART0_ADDR + UART_CLK); au_sync();
+	}
+#endif
+#ifdef UART1_ADDR
+	if (sleep_uart[1].enable & 0x02) {
+		au_writel(0, UART1_ADDR + UART_MOD_CNTRL); au_sync();
+		au_writel(1, UART1_ADDR + UART_MOD_CNTRL); au_sync();
+		au_writel(3, UART1_ADDR + UART_MOD_CNTRL); au_sync();
+		au_writel(sleep_uart[1].inten, UART1_ADDR + UART_IER); au_sync();
+		au_writel(sleep_uart[1].fifoctl, UART1_ADDR + UART_FCR); au_sync();
+		au_writel(sleep_uart[1].linectl, UART1_ADDR + UART_LCR); au_sync();
+		au_writel(sleep_uart[1].clkdiv, UART1_ADDR + UART_CLK); au_sync();
 	}
+#endif
+#ifdef UART2_ADDR
+	if (sleep_uart[2].enable & 0x02) {
+		au_writel(0, UART2_ADDR + UART_MOD_CNTRL); au_sync();
+		au_writel(1, UART2_ADDR + UART_MOD_CNTRL); au_sync();
+		au_writel(3, UART2_ADDR + UART_MOD_CNTRL); au_sync();
+		au_writel(sleep_uart[2].inten, UART2_ADDR + UART_IER); au_sync();
+		au_writel(sleep_uart[2].fifoctl, UART2_ADDR + UART_FCR); au_sync();
+		au_writel(sleep_uart[2].linectl, UART2_ADDR + UART_LCR); au_sync();
+		au_writel(sleep_uart[2].clkdiv, UART2_ADDR + UART_CLK); au_sync();
+	}
+#endif
+#ifdef UART3_ADDR
+	if (sleep_uart[3].enable & 0x02) {
+		au_writel(0, UART3_ADDR + UART_MOD_CNTRL); au_sync();
+		au_writel(1, UART3_ADDR + UART_MOD_CNTRL); au_sync();
+		au_writel(3, UART3_ADDR + UART_MOD_CNTRL); au_sync();
+		au_writel(sleep_uart[3].inten, UART3_ADDR + UART_IER); au_sync();
+		au_writel(sleep_uart[3].fifoctl, UART3_ADDR + UART_FCR); au_sync();
+		au_writel(sleep_uart[3].linectl, UART3_ADDR + UART_LCR); au_sync();
+		au_writel(sleep_uart[3].clkdiv, UART3_ADDR + UART_CLK); au_sync();
+	}
+#endif
 
 	restore_au1xxx_intctl();
 	wakeup_counter0_adjust();

--Bn2rw/3z4jIqBvZU--
