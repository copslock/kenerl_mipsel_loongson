Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 15:59:10 +0100 (BST)
Received: from trump.cadenux-support.com ([IPv6:::ffff:66.135.34.142]:41866
	"EHLO cadenux.com") by linux-mips.org with ESMTP
	id <S8224942AbUJFO7F>; Wed, 6 Oct 2004 15:59:05 +0100
Received: from t32 (unknown [200.12.239.3])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by cadenux.com (Postfix) with ESMTP id 9EC4D3A005E
	for <linux-mips@linux-mips.org>; Wed,  6 Oct 2004 16:35:30 +0000 (UTC)
Subject: Au1100 Serial Driver
From: Gregory Nutt <greg.nutt@cadenux.com>
Reply-To: greg.nutt@cadenux.com
To: linux-mips@linux-mips.org
In-Reply-To: <1097074271.9253.8.camel@spudrun>
References: <1097074271.9253.8.camel@spudrun>
Content-Type: text/plain
Organization: Cadenux, LLC
Message-Id: <1097074752.9253.17.camel@spudrun>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 06 Oct 2004 08:59:12 -0600
Content-Transfer-Encoding: 7bit
Return-Path: <greg.nutt@cadenux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.nutt@cadenux.com
Precedence: bulk
X-list: linux-mips

I think I see an error in the serial driver for the Au1100.  In the
function serial8250_isa_init_ports() there is the line:

  up->port.uartclk  = get_au1x00_uart_baud_base();

Shouldn't this be:

  up->port.uartclk  = get_au1x00_uart_baud_base() * 16;

Isn't the UART clock (normally) 16x the baud_base for this (and most)
UARTs?

Also... beware of:

  baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
  quot = serial8250_get_divisor(port, baud);
  quot = 0x35; /* FIXME */

For me, 0x35 is not correct.  For me, the above 16x fix eliminates
the need for this kind of FIXME.

Greg
-- 
Gregory Nutt <greg.nutt@cadenux.com>
Cadenux, LLC
