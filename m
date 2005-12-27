Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2005 16:25:17 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:26253 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133544AbVL0QZA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Dec 2005 16:25:00 +0000
Received: (qmail 19346 invoked from network); 27 Dec 2005 16:26:44 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 27 Dec 2005 16:26:44 -0000
Message-ID: <43B16BD3.9080108@ru.mvista.com>
Date:	Tue, 27 Dec 2005 19:29:07 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	rmk+serial@arm.linux.org.uk, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART
 used as a console
References: <43B06DB4.409@ru.mvista.com>	<20051227.144551.79070832.nemoto@toshiba-tops.co.jp>	<43B143EE.6070700@ru.mvista.com> <20051228.003457.74752441.anemo@mba.ocn.ne.jp>
In-Reply-To: <20051228.003457.74752441.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>>>>On Tue, 27 Dec 2005 16:38:54 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:

>>>The problem is not just only spin_lock_init.  The parameters of
>>>"console=" option (baudrate, etc.) are not passed for PCI UART.

> sshtylyov>     They are -- uart_add_one_port() calls console setup
> sshtylyov> once more when registering PCI UART with serial code.

> Yes, you are right.  I missed the register_console call in
> uart_add_one_port().  So your patch will fix the problem.  But I
> suppose the spinlock should be initialized in serial_core.  How about
> this?

> --- a/drivers/serial/serial_core.c
> +++ b/drivers/serial/serial_core.c
> @@ -2233,7 +2233,7 @@ int uart_add_one_port(struct uart_driver
>  	 * If this port is a console, then the spinlock is already
>  	 * initialised.
>  	 */
> -	if (!uart_console(port))
> +	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED)))
>  		spin_lock_init(&port->lock);
>  
>  	uart_configure_port(drv, state, port);

    I wouldn't object.

>>>--- a/drivers/serial/serial_txx9.c
>>>+++ b/drivers/serial/serial_txx9.c
>>>@@ -937,11 +942,6 @@ static int serial_txx9_console_setup(str
>>>return -ENODEV;
>>>
>>>/*
>>>-	 * Temporary fix.
>>>-	 */
>>>-	spin_lock_init(&port->lock);
>>>-
>>>-	/*
>>>*	Disable UART interrupts, set DTR and RTS high
>>>*	and set speed.
>>>*/

> sshtylyov> Can you tell me, how this is supposed to work with TX49xx
> sshtylyov> SOC UARTs? When that spinlock will be init'ed for the
> sshtylyov> console port? uart_add_one_port() won't do it, and your
> sshtylyov> added code below won't do it either, so I disagree with
> sshtylyov> this change (though with "empty" spinlock it will no doubt
> sshtylyov> work) since there's nothing to init.
> 
> The spinlock is initialized in uart_set_options() which is called
> from console setup function.

    I'm sorry, haven't dug that deep. :-)
    Thought explicit spinlock init was really necessary there...

WBR, Sergei
