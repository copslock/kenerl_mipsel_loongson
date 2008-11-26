Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 00:19:08 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:42831 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23911919AbYKZAS6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 00:18:58 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492c95e80001>; Tue, 25 Nov 2008 19:18:48 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 16:18:46 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 16:18:46 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAQ0IeB5018322;
	Tue, 25 Nov 2008 16:18:41 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAQ0IdSn018319;
	Tue, 25 Nov 2008 16:18:39 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-serial@vger.kernel.org, akpm@linux-foundation.org,
	alan@lxorguk.ukuu.org.uk
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 1/5] 8250: Don't clobber spinlocks.
Date:	Tue, 25 Nov 2008 16:18:35 -0800
Message-Id: <1227658719-18297-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <492C94FC.9070906@caviumnetworks.com>
References: <492C94FC.9070906@caviumnetworks.com>
X-OriginalArrivalTime: 26 Nov 2008 00:18:46.0086 (UTC) FILETIME=[8BFB5660:01C94F5C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

In serial8250_isa_init_ports(), the port's lock is initialized.  We
should not overwrite it.  In early_serial_setup(), only copy in the
fields we need.  Since the early console code only uses a subset of
the fields, these are sufficient.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
---
 drivers/serial/8250.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 303272a..8e28750 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2752,12 +2752,23 @@ static struct uart_driver serial8250_reg = {
  */
 int __init early_serial_setup(struct uart_port *port)
 {
+	struct uart_port *p;
+
 	if (port->line >= ARRAY_SIZE(serial8250_ports))
 		return -ENODEV;
 
 	serial8250_isa_init_ports();
-	serial8250_ports[port->line].port	= *port;
-	serial8250_ports[port->line].port.ops	= &serial8250_pops;
+	p = &serial8250_ports[port->line].port;
+	p->iobase       = port->iobase;
+	p->membase      = port->membase;
+	p->irq          = port->irq;
+	p->uartclk      = port->uartclk;
+	p->fifosize     = port->fifosize;
+	p->regshift     = port->regshift;
+	p->iotype       = port->iotype;
+	p->flags        = port->flags;
+	p->mapbase      = port->mapbase;
+	p->private_data = port->private_data;
 	return 0;
 }
 
-- 
1.5.6.5
