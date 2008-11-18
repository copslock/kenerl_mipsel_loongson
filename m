Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:33:31 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:44079 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23754615AbYKRWYw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 22:24:52 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492340970004>; Tue, 18 Nov 2008 17:24:23 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:24:21 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:24:20 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAIMOI8q004944;
	Tue, 18 Nov 2008 14:24:18 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAIMOI3V004943;
	Tue, 18 Nov 2008 14:24:18 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	akpm@linux-foundation.org
Cc:	linux-kernel@vger.kernel.org,
	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 21/26] Serial: Allow port type to be specified when calling serial8250_register_port.
Date:	Tue, 18 Nov 2008 14:24:15 -0800
Message-Id: <1227047057-4911-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <49233FDE.3010404@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
X-OriginalArrivalTime: 18 Nov 2008 22:24:20.0853 (UTC) FILETIME=[6717AA50:01C949CC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add flag value UPF_FIXED_TYPE which specifies that the UART type is
known and should not be probed.  For this case the UARTs properties
are just copied out of the uart_config entry.

This allows us to keep SOC specific 8250 probe code out of 8250.c.  In
this case we know the serial hardware will not be changing as it is on
the same silicon as the CPU, and we can specify it with certainty in
the board/cpu setup code.

The alternative is to load up 8250.c with a bunch of OCTEON specific
special cases in the probing code.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/serial/8250.c        |    9 +++++++++
 drivers/serial/serial_core.c |    7 +++++--
 include/linux/serial_8250.h  |    1 +
 include/linux/serial_core.h  |    2 ++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 564edd1..37a6f4c 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2903,6 +2903,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.mapbase		= p->mapbase;
 		port.hub6		= p->hub6;
 		port.private_data	= p->private_data;
+		port.type		= p->type;
 		port.serial_in_fn	= p->serial_in_fn;
 		port.serial_out_fn	= p->serial_out_fn;
 		port.dev		= &dev->dev;
@@ -3058,6 +3059,14 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.private_data = port->private_data;
 		if (port->dev)
 			uart->port.dev = port->dev;
+
+		if (port->flags & UPF_FIXED_TYPE) {
+			uart->port.type = port->type;
+			uart->port.fifosize = uart_config[port->type].fifo_size;
+			uart->capabilities = uart_config[port->type].flags;
+			uart->tx_loadsz = uart_config[port->type].tx_loadsz;
+		}
+
 		set_io_fns_from_upio(&uart->port);
 		/* Possibly override default I/O functions.  */
 		if (port->serial_in_fn)
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 874786a..7fef45e 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2198,11 +2198,14 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 	 * Now do the auto configuration stuff.  Note that config_port
 	 * is expected to claim the resources and map the port for us.
 	 */
-	flags = UART_CONFIG_TYPE;
+	flags = 0;
 	if (port->flags & UPF_AUTO_IRQ)
 		flags |= UART_CONFIG_IRQ;
 	if (port->flags & UPF_BOOT_AUTOCONF) {
-		port->type = PORT_UNKNOWN;
+		if (!(port->flags & UPF_FIXED_TYPE)) {
+			port->type = PORT_UNKNOWN;
+			flags |= UART_CONFIG_TYPE;
+		}
 		port->ops->config_port(port, flags);
 	}
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index eb08b04..92c06af 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -28,6 +28,7 @@ struct plat_serial8250_port {
 	unsigned char	iotype;		/* UPIO_* */
 	unsigned char	hub6;
 	upf_t		flags;		/* UPF_* flags */
+	unsigned int	type;		/* If UPF_FIXED_TYPE */
 	unsigned int	(*serial_in_fn)(struct uart_port *, int);
 	void		(*serial_out_fn)(struct uart_port *, int, int);
 };
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 6e70ff4..4a72a7b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -293,6 +293,8 @@ struct uart_port {
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
+/* The exact UART type is known and should not be probed.  */
+#define UPF_FIXED_TYPE		((__force upf_t) (1 << 27))
 #define UPF_BOOT_AUTOCONF	((__force upf_t) (1 << 28))
 #define UPF_FIXED_PORT		((__force upf_t) (1 << 29))
 #define UPF_DEAD		((__force upf_t) (1 << 30))
-- 
1.5.6.5
