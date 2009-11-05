Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 18:55:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58907 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492947AbZKERzm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Nov 2009 18:55:42 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA5Hv1uu024925;
	Thu, 5 Nov 2009 18:57:02 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA5HuxEt024923;
	Thu, 5 Nov 2009 18:56:59 +0100
Message-Id: <20091105152702.606651698@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Thu, 05 Nov 2009 16:26:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] SERIAL: BCM63xx: Fix serial driver compile breakage.
References: <20091105152555.227009519@linux-mips.org>
Content-Disposition: inline; filename=0009.patch
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From: Maxime Bizon <mbizon@freebox.fr>

The driver missed an API change.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/serial/bcm63xx_uart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: upstream-linus/drivers/serial/bcm63xx_uart.c
===================================================================
--- upstream-linus.orig/drivers/serial/bcm63xx_uart.c
+++ upstream-linus/drivers/serial/bcm63xx_uart.c
@@ -242,7 +242,7 @@ static void bcm_uart_do_rx(struct uart_p
 	 * higher than fifo size anyway since we're much faster than
 	 * serial port */
 	max_count = 32;
-	tty = port->info->port.tty;
+	tty = port->state->port.tty;
 	do {
 		unsigned int iestat, c, cstat;
 		char flag;
@@ -318,7 +318,7 @@ static void bcm_uart_do_tx(struct uart_p
 		return;
 	}
 
-	xmit = &port->info->xmit;
+	xmit = &port->state->xmit;
 	if (uart_circ_empty(xmit))
 		goto txq_empty;
 
