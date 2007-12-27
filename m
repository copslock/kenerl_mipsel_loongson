Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2007 18:27:19 +0000 (GMT)
Received: from smtp-out114.alice.it ([85.37.17.114]:30989 "EHLO
	smtp-out114.alice.it") by ftp.linux-mips.org with ESMTP
	id S20035715AbXL0S1K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Dec 2007 18:27:10 +0000
Received: from FBCMMO02.fbc.local ([192.168.68.196]) by smtp-out114.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:27:04 +0100
Received: from FBCMCL01B08.fbc.local ([192.168.171.46]) by FBCMMO02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:27:04 +0100
Received: from [192.168.0.3] ([82.55.115.235]) by FBCMCL01B08.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:27:16 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][5/6]: AR7: serial hack
Date:	Thu, 27 Dec 2007 19:27:05 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <200712271919.23577.technoboy85@gmail.com>
In-Reply-To: <200712271919.23577.technoboy85@gmail.com>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712271927.06146.technoboy85@gmail.com>
X-OriginalArrivalTime: 27 Dec 2007 18:27:16.0328 (UTC) FILETIME=[1B892680:01C848B6]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Nicolas Thill <nico@openwrt.org>

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index f94109c..94253b7 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -267,6 +267,13 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_AR7] = {
+		.name		= "TI-AR7",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+	},
 };
 
 #if defined (CONFIG_SERIAL_8250_AU1X00)
@@ -2453,7 +2460,11 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 
+#ifdef CONFIG_AR7
+	wait_for_xmitr(up, BOTH_EMPTY);
+#else
 	wait_for_xmitr(up, UART_LSR_THRE);
+#endif
 	serial_out(up, UART_TX, ch);
 }
 
diff --git a/include/linux/serialP.h b/include/linux/serialP.h
index e811a61..cf71de9 100644
--- a/include/linux/serialP.h
+++ b/include/linux/serialP.h
@@ -135,6 +135,10 @@ struct rs_multiport_struct {
  * the interrupt line _up_ instead of down, so if we register the IRQ
  * while the UART is in that state, we die in an IRQ storm. */
 #define ALPHA_KLUDGE_MCR (UART_MCR_OUT2)
+#elif defined(CONFIG_AR7)
+/* This is how it is set up by bootloader... */
+#define ALPHA_KLUDGE_MCR (UART_MCR_OUT2 | UART_MCR_OUT1 \
+			| UART_MCR_RTS | UART_MCR_DTR)
 #else
 #define ALPHA_KLUDGE_MCR 0
 #endif
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9963f81..10af5a2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -40,6 +40,7 @@
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
+#define PORT_AR7	16
 #define PORT_MAX_8250	16	/* max port ID */
 
 /*
