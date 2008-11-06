Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 21:03:16 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11421 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298275AbYKFU55 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:57:57 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49135a290000>; Thu, 06 Nov 2008 15:57:18 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:57:12 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:57:12 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6Kv98k027840;
	Thu, 6 Nov 2008 12:57:09 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6Kv9ao027839;
	Thu, 6 Nov 2008 12:57:09 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	akpm@linux-foundation.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 26/29] 8250: Allow port type to specify bugs that are not probed for.
Date:	Thu,  6 Nov 2008 12:57:04 -0800
Message-Id: <1226005025-27804-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:57:12.0397 (UTC) FILETIME=[3DBB97D0:01C94052]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21219
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
index 9d16abb..474ab89 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1212,6 +1212,7 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	up->port.fifosize = uart_config[up->port.type].fifo_size;
 	up->capabilities = uart_config[up->port.type].flags;
 	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
+	up->bugs |= uart_config[up->port.type].bugs;
 
 	if (up->port.type == PORT_UNKNOWN)
 		goto out;
@@ -3062,6 +3063,7 @@ int serial8250_register_port(struct uart_port *port)
 			uart->port.fifosize = uart_config[port->type].fifo_size;
 			uart->capabilities = uart_config[port->type].flags;
 			uart->tx_loadsz = uart_config[port->type].tx_loadsz;
+			uart->bugs = uart_config[port->type].bugs;
 		}
 
 		set_io_fns_from_upio(&uart->port);
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
