Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 00:19:34 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:44367 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23916115AbYKZAS6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 00:18:58 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492c95ea0000>; Tue, 25 Nov 2008 19:18:50 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 16:18:48 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 16:18:48 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAQ0IhS5018338;
	Tue, 25 Nov 2008 16:18:43 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAQ0IhFD018337;
	Tue, 25 Nov 2008 16:18:43 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-serial@vger.kernel.org, akpm@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 5/5] Serial: UART driver changes for Cavium OCTEON.
Date:	Tue, 25 Nov 2008 16:18:39 -0800
Message-Id: <1227658719-18297-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <492C94FC.9070906@caviumnetworks.com>
References: <492C94FC.9070906@caviumnetworks.com>
X-OriginalArrivalTime: 26 Nov 2008 00:18:48.0383 (UTC) FILETIME=[8D59D4F0:01C94F5C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Cavium UART implementation won't work with the standard 8250 driver
as-is.  Define a new uart_config (PORT_OCTEON) and use it to enable
special handling required by the OCTEON's serial port.  Two new bug
types are defined.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/serial/8250.c       |   10 +++++++++-
 drivers/serial/8250.h       |    1 +
 include/linux/serial_core.h |    3 ++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 3bb8e30..63dbbb6 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -279,6 +279,14 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_OCTEON] = {
+		.name		= "OCTEON",
+		.fifo_size	= 64,
+		.tx_loadsz	= 64,
+		.bugs		= UART_BUG_TIMEOUT,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 #if defined (CONFIG_SERIAL_8250_AU1X00)
@@ -1714,7 +1722,7 @@ static void serial8250_timeout(unsigned long data)
 	unsigned int iir;
 
 	iir = serial_in(up, UART_IIR);
-	if (!(iir & UART_IIR_NO_INT))
+	if (!(iir & UART_IIR_NO_INT) || (up->bugs & UART_BUG_TIMEOUT))
 		serial8250_handle_port(up);
 	mod_timer(&up->timer, jiffies + poll_timeout(up->port.timeout));
 }
diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
index c9b3002..17dc459 100644
--- a/drivers/serial/8250.h
+++ b/drivers/serial/8250.h
@@ -49,6 +49,7 @@ struct serial8250_config {
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
+#define UART_BUG_TIMEOUT (1 << 4)	/* UART should always handle timeout */
 
 #define PROBE_RSA	(1 << 0)
 #define PROBE_ANY	(~0)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b9e7756..fd772b5 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -40,7 +40,8 @@
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
-#define PORT_MAX_8250	16	/* max port ID */
+#define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
+#define PORT_MAX_8250	17	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
-- 
1.5.6.5
