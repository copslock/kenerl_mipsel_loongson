Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2008 23:50:49 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15292 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24038104AbYLAXtx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Dec 2008 23:49:53 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493478130003>; Mon, 01 Dec 2008 18:49:39 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Dec 2008 15:49:36 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Dec 2008 15:49:35 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB1NnWKx005575;
	Mon, 1 Dec 2008 15:49:32 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB1NnWaK005574;
	Mon, 1 Dec 2008 15:49:32 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-serial@vger.kernel.org, akpm@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 4/4] Serial: UART driver changes for Cavium OCTEON.
Date:	Mon,  1 Dec 2008 15:49:28 -0800
Message-Id: <1228175368-5536-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <4934774E.6080805@caviumnetworks.com>
References: <4934774E.6080805@caviumnetworks.com>
X-OriginalArrivalTime: 01 Dec 2008 23:49:35.0602 (UTC) FILETIME=[77172D20:01C9540F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Cavium UART implementation is not covered by existing uart_configS.
Define a new uart_config (PORT_OCTEON) which is specified by OCTEON
platform device registration code.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/serial/8250.c       |    7 +++++++
 include/linux/serial_core.h |    3 ++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 3ae4974..daa0056 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -279,6 +279,13 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_OCTEON] = {
+		.name		= "OCTEON",
+		.fifo_size	= 64,
+		.tx_loadsz	= 64,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 #if defined (CONFIG_SERIAL_8250_AU1X00)
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
