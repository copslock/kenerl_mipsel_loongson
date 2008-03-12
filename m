Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2008 09:32:51 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:49831 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28577364AbYCLJct (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Mar 2008 09:32:49 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JZNKG-0002Ia-00; Wed, 12 Mar 2008 10:32:44 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 16260C2AE5; Wed, 12 Mar 2008 10:31:46 +0100 (CET)
Date:	Wed, 12 Mar 2008 10:31:46 +0100
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Message-ID: <20080312093145.GA6270@alpha.franken.de>
References: <200803120221.25044.technoboy85@gmail.com> <200803120230.06420.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803120230.06420.technoboy85@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Mar 12, 2008 at 02:30:06AM +0100, Matteo Croce wrote:
> Ugly but we need it

why ? I'm running AR7 uarts just like all other 16550.

>  #if defined (CONFIG_SERIAL_8250_AU1X00)
> @@ -2455,7 +2462,11 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
>  {
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
>  
> +#ifdef CONFIG_AR7
> +	wait_for_xmitr(up, BOTH_EMPTY);
> +#else
>  	wait_for_xmitr(up, UART_LSR_THRE);
> +#endif
>  	serial_out(up, UART_TX, ch);
>  }

this doesn't make sense. Why don't you check for the port type and
decide, if you need to use the AR7 way or the normal way. This will
for example break 16550 uarts connected via PCI on UR8 devices.

> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 289942f..869b6df 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -40,6 +40,7 @@
>  #define PORT_NS16550A	14
>  #define PORT_XSCALE	15
>  #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> +#define PORT_AR7	16

this doesn't look correct.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
