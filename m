Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 17:55:16 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:12343 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133676AbVLFRy4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 17:54:56 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB6Hsat18141;
	Tue, 6 Dec 2005 21:54:36 +0400
Message-ID: <4395D05C.9060408@ru.mvista.com>
Date:	Tue, 06 Dec 2005 20:54:36 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org, ppopov@embeddedalley.com
Subject: [PATCH] Philips PNX8550 ip3106 driver deadlock fix
Content-Type: multipart/mixed;
 boundary="------------060108000006010507080008"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060108000006010507080008
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Hello Ralf,

This is a patch that fixes spin_lock deadlock in serial ip3106 driver.
The spin_lock_irq(&port->lock,flags) is already called in generic driver 
serial_core.c before
port->ops->start_tx().
So the second call of spin_lock_irq(&port->lock, flags) leads to 
deadlock. This could be verified in PREEMPT_DESCTOP case when
these options are enabled:
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_SPINLOCK=y

Vladimir


--------------060108000006010507080008
Content-Type: text/plain;
 name="ip3106_uart.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip3106_uart.diff"

--- linux-2.6.15/drivers/serial/ip3106_uart.c	2005-12-02 16:37:59.000000000 +0300
+++ linux-2.6.15/drivers/serial/ip3106_uart.c	2005-12-06 20:40:15.000000000 +0300
@@ -149,19 +149,14 @@ static void ip3106_stop_tx(struct uart_p
 static void ip3106_start_tx(struct uart_port *port, unsigned int tty_start)
 {
 	struct ip3106_port *sport = (struct ip3106_port *)port;
-	unsigned long flags;
 	u32 ien;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
-
 	/* Clear all pending TX intr */
 	serial_out(sport, IP3106_ICLR, IP3106_UART_INT_ALLTX);
 
 	/* Enable TX intr */
 	ien = serial_in(sport, IP3106_IEN);
 	serial_out(sport, IP3106_IEN, ien | IP3106_UART_INT_ALLTX);
-
-	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 /*

--------------060108000006010507080008--
