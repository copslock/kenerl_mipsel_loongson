Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 00:20:02 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3664 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23916121AbYKZATa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 00:19:30 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492c95e80002>; Tue, 25 Nov 2008 19:18:48 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 16:18:46 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 16:18:46 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAQ0Igp5018334;
	Tue, 25 Nov 2008 16:18:42 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAQ0IgGD018333;
	Tue, 25 Nov 2008 16:18:42 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-serial@vger.kernel.org, akpm@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/5] 8250: Allow port type to specify bugs that are not probed for.
Date:	Tue, 25 Nov 2008 16:18:38 -0800
Message-Id: <1227658719-18297-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <492C94FC.9070906@caviumnetworks.com>
References: <492C94FC.9070906@caviumnetworks.com>
X-OriginalArrivalTime: 26 Nov 2008 00:18:46.0086 (UTC) FILETIME=[8BFB5660:01C94F5C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add a bugs field to the serial8250_config and propagate it to the
port's bugs field when the port is registered and configured.

This is a follow on to the previous patch.  Now that we can specify
the port type and don't have to probe for it, we can avoid probing for
bugs if they are known with certainty to exist.

The alternative is to load up 8250.c with a bunch of OCTEON specific
special cases in the probing code.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/serial/8250.c |    2 ++
 drivers/serial/8250.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 3ae4974..3bb8e30 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1212,6 +1212,7 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	up->port.fifosize = uart_config[up->port.type].fifo_size;
 	up->capabilities = uart_config[up->port.type].flags;
 	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
+	up->bugs |= uart_config[up->port.type].bugs;
 
 	if (up->port.type == PORT_UNKNOWN)
 		goto out;
@@ -3065,6 +3066,7 @@ int serial8250_register_port(struct uart_port *port)
 			uart->port.fifosize = uart_config[port->type].fifo_size;
 			uart->capabilities = uart_config[port->type].flags;
 			uart->tx_loadsz = uart_config[port->type].tx_loadsz;
+			uart->bugs = uart_config[port->type].bugs;
 		}
 
 		set_io_from_upio(&uart->port);
diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
index 5202603..c9b3002 100644
--- a/drivers/serial/8250.h
+++ b/drivers/serial/8250.h
@@ -34,6 +34,7 @@ struct serial8250_config {
 	const char	*name;
 	unsigned short	fifo_size;
 	unsigned short	tx_loadsz;
+	unsigned short	bugs;
 	unsigned char	fcr;
 	unsigned int	flags;
 };
-- 
1.5.6.5
