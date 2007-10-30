Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 20:43:41 +0000 (GMT)
Received: from host175-171-dynamic.9-87-r.retail.telecomitalia.it ([87.9.171.175]:46982
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20024079AbXJ3Unc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 20:43:32 +0000
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with smtp (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Imxsn-00013Q-9g; Tue, 30 Oct 2007 21:40:19 +0100
Date:	Tue, 30 Oct 2007 21:40:15 +0100
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	mips kernel list <linux-mips@linux-mips.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>
Subject: Preliminary patch for ip32 ttyS* device
Message-Id: <20071030214015.050b7950.giuseppe@eppesuigoccas.homedns.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi all,
this is a patch that make ttyS0 and ttyS1 work on my SGI O2. I don't know if it is enough good for a general use since I am also changing code drivers/serial/serial_core.c. Probably the best solution would be to use mapbase instead of membase in arch/mips/sgi-ip32/ip32-platform.c.

Any comments?

Bye,
Giuseppe

---
diff --git a/arch/mips/sgi-ip32/ip32-platform.c b/arch/mips/sgi-ip32/ip32-platform.c
index 7309e48..77febd6 100644
--- a/arch/mips/sgi-ip32/ip32-platform.c
+++ b/arch/mips/sgi-ip32/ip32-platform.c
@@ -42,7 +42,7 @@ static struct platform_device uart8250_device = {
 static int __init uart8250_init(void)
 {
 	uart8250_data[0].membase = (void __iomem *) &mace->isa.serial1;
-	uart8250_data[1].membase = (void __iomem *) &mace->isa.serial1;
+	uart8250_data[1].membase = (void __iomem *) &mace->isa.serial2;
 
 	return platform_device_register(&uart8250_device);
 }
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 3bb5d24..7caa877 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2455,6 +2455,8 @@ int uart_match_port(struct uart_port *port1, struct uart_port *port2)
 	case UPIO_AU:
 	case UPIO_TSI:
 	case UPIO_DWAPB:
+		if (port1->mapbase==0 && port2->mapbase==0)
+			return (port1->membase == port2->membase);
 		return (port1->mapbase == port2->mapbase);
 	}
 	return 0;
