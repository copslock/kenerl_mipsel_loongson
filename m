Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2005 13:35:21 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:49338 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133529AbVL0NfD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Dec 2005 13:35:03 +0000
Received: (qmail 17108 invoked from network); 27 Dec 2005 13:36:32 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 27 Dec 2005 13:36:32 -0000
Message-ID: <43B143EE.6070700@ru.mvista.com>
Date:	Tue, 27 Dec 2005 16:38:54 +0300
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
References: <43B06DB4.409@ru.mvista.com> <20051227.144551.79070832.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20051227.144551.79070832.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:
>>>>>>On Tue, 27 Dec 2005 01:24:52 +0300, Sergei Shtylylov <sshtylyov@ru.mvista.com> said:
> 
> sshtylyov>         When a system console gets assigned to the UART
> sshtylyov> located on the Toshiba GOKU-S PCI card, the port spinlock
> sshtylyov> is not initialized at all -- uart_add_one_port() thinks
> sshtylyov> it's been initialized by the console setup code which is
> sshtylyov> called too early for being able to do that, before the PCI
> sshtylyov> card is even detected by the driver, and therefore
> sshtylyov> fails.

> The problem is not just only spin_lock_init.  The parameters of
> "console=" option (baudrate, etc.) are not passed for PCI UART.

    They are -- uart_add_one_port() calls console setup once more when 
registering PCI UART with serial code.

>  Also,
> if console setup failed, the console never enabled.  So the console
> can not be used anyway.

    I'm able to use it with ths fix in 2.6.10 with 1.04 driver version backported.

> I have an another fix.  Call register_console() again for PCI UART if
> the console was not enabled.

    I disagree. Look at what uart_add_one_port() does closely.

>  This fixes spin_lock_init issue and
> makes PCI UART really usable as console.

> Also, I have some other pending changes for this driver.
> 
>  * More strict check in verify_port.  Cleanup.
>  * Do not insert a char caused previous overrun.
>  * Fix some spin_locks.

    Yeah, I was about to send the patch that deasl with the nested spinlocks 
as well... :-)

>  * Call register_console again for PCI ports.

    This change doesn't look correct to me...

> This is a patch against linux-mips GIT.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> 
> diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
> index f10c86d..c24e0c3 100644
> --- a/drivers/serial/serial_txx9.c
> +++ b/drivers/serial/serial_txx9.c
> @@ -937,11 +942,6 @@ static int serial_txx9_console_setup(str
>  		return -ENODEV;
>  
>  	/*
> -	 * Temporary fix.
> -	 */
> -	spin_lock_init(&port->lock);
> -
> -	/*
>  	 *	Disable UART interrupts, set DTR and RTS high
>  	 *	and set speed.
>  	 */

    Can you tell me, how this is supposed to work with TX49xx SOC UARTs? When 
that spinlock will be init'ed for the console port? uart_add_one_port() won't 
do it, and your added code below won't do it either, so I disagree with this 
change (though with "empty" spinlock it will no doubt work) since there's 
nothing to init.

> @@ -1065,6 +1065,14 @@ static int __devinit serial_txx9_registe
>  		uart->port.mapbase  = port->mapbase;
>  		if (port->dev)
>  			uart->port.dev = port->dev;
> +#ifdef CONFIG_SERIAL_TXX9_CONSOLE
> +		/*
> +		 * The 'early' register_console fails for PCI ports.
> +		 * Do it again.
> +		 */
> +		if (!(serial_txx9_console.flags & CON_ENABLED))
> +			register_console(&serial_txx9_console);
> +#endif
>  		ret = uart_add_one_port(&serial_txx9_reg, &uart->port);
>  		if (ret == 0)
>  			ret = uart->port.line;

WBR, Sergei
