Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2004 03:39:07 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:56071
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224989AbUJJCjD>;
	Sun, 10 Oct 2004 03:39:03 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9A2ctu31731;
	Sat, 9 Oct 2004 19:38:56 -0700
Message-ID: <4168A0B9.7030801@embeddedalley.com>
Date: Sat, 09 Oct 2004 19:38:49 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: greg.nutt@cadenux.com
CC: linux-mips@linux-mips.org
Subject: Re: Au1100 Serial Driver
References: <1097074271.9253.8.camel@spudrun> <1097074752.9253.17.camel@spudrun>
In-Reply-To: <1097074752.9253.17.camel@spudrun>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Gregory Nutt wrote:

>I think I see an error in the serial driver for the Au1100.  In the
>function serial8250_isa_init_ports() there is the line:
>
>  up->port.uartclk  = get_au1x00_uart_baud_base();
>
>Shouldn't this be:
>
>  up->port.uartclk  = get_au1x00_uart_baud_base() * 16;
>
>Isn't the UART clock (normally) 16x the baud_base for this (and most)
>UARTs?
>
>Also... beware of:
>
>  baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
>  quot = serial8250_get_divisor(port, baud);
>  quot = 0x35; /* FIXME */
>
>For me, 0x35 is not correct.  For me, the above 16x fix eliminates
>the need for this kind of FIXME.
>  
>
Looks like an old hack that someone forgot to revisit :) Thanks for the 
patch.

Pete
