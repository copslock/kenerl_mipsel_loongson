Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 14:11:35 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:60448 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493264AbZKDNL3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Nov 2009 14:11:29 +0100
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 4F159E081EC;
	Wed,  4 Nov 2009 14:11:20 +0100 (CET)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 387D5E0811D;
	Wed,  4 Nov 2009 14:11:17 +0100 (CET)
Subject: [PATCH] MIPS: BCM63xx: Fix serial driver compile breakage.
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Organization: Freebox
Date:	Wed, 04 Nov 2009 14:11:15 +0100
Message-ID: <1257340275.2926.7.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


Hi Ralf,

bcm63xx does not compile on current linus' tree, could you please apply
the attached patch and send it to linus ? Thanks !



The driver missed a small API change while sitting in Ralf's tree, this
patch makes it compile again.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/serial/bcm63xx_uart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/bcm63xx_uart.c b/drivers/serial/bcm63xx_uart.c
index beddaa6..37ad0c4 100644
--- a/drivers/serial/bcm63xx_uart.c
+++ b/drivers/serial/bcm63xx_uart.c
@@ -242,7 +242,7 @@ static void bcm_uart_do_rx(struct uart_port *port)
 	 * higher than fifo size anyway since we're much faster than
 	 * serial port */
 	max_count = 32;
-	tty = port->info->port.tty;
+	tty = port->state->port.tty;
 	do {
 		unsigned int iestat, c, cstat;
 		char flag;
@@ -318,7 +318,7 @@ static void bcm_uart_do_tx(struct uart_port *port)
 		return;
 	}
 
-	xmit = &port->info->xmit;
+	xmit = &port->state->xmit;
 	if (uart_circ_empty(xmit))
 		goto txq_empty;
 
-- 
1.6.3.3




-- 
Maxime
