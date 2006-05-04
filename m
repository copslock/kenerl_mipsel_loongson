Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 15:37:12 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:37762 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133530AbWEDOhB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 15:37:01 +0100
Received: (qmail 26866 invoked from network); 4 May 2006 18:42:01 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 4 May 2006 18:42:01 -0000
Message-ID: <445A114B.4040404@ru.mvista.com>
Date:	Thu, 04 May 2006 18:35:55 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 8250_early console support for au1x00
References: <20060504134509.GE19913@gundam.enneenne.com>
In-Reply-To: <20060504134509.GE19913@gundam.enneenne.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:
> Done! :)
> 
> Here the patch (against «linux-2.6.16-stable» and tested with au1100
> based board):
> 
>    http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-patch-au1x00-early-console

    The following 2 fragments are kind of contradictory:

 > --- a/drivers/serial/8250.c
 > +++ b/drivers/serial/8250.c
 > @@ -2322,16 +2322,18 @@ static int __init find_port(struct uart_
 >
 >  int __init serial8250_start_console(struct uart_port *port, char *options)
 >  {
 > -	int line;
 > +	int line, mmio;
 >
 >  	line = find_port(port);
 >  	if (line < 0)
 >  		return -ENODEV;
 >
 >  	add_preferred_console("ttyS", line, options);
 > +	mmio = (port->iotype == UPIO_MEM) || (port->iotype == UPIO_AU);
 >  	printk("Adding console on ttyS%d at %s 0x%lx (options '%s')\n",
 > -		line, port->iotype == UPIO_MEM ? "MMIO" : "I/O port",
 > -		port->iotype == UPIO_MEM ? (unsigned long) port->mapbase :
 > +		line,
 > +	       	mmio ? "MMIO" : "I/O port",
 > +		mmio ? (unsigned long) port->mapbase :
 >  		    (unsigned long) port->iobase, options);
 >  	if (!(serial8250_console.flags & CON_ENABLED)) {

 > --- a/drivers/serial/8250_early.c
 > +++ b/drivers/serial/8250_early.c
 > @@ -232,22 +380,23 @@ static int __init early_uart_console_swi
 >  {
 >  	struct early_uart_device *device = &early_device;
 >  	struct uart_port *port = &device->port;
 > -	int mmio, line;
 > +	int line;
 >
 >  	if (!(early_uart_console.flags & CON_ENABLED))
 >  		return 0;
 >
 >  	/* Try to start the normal driver on a matching line.  */
 > -	mmio = (port->iotype == UPIO_MEM);
 >  	line = serial8250_start_console(port, device->options);
 >  	if (line < 0)
 >  		printk("No ttyS device at %s 0x%lx for console\n",
 > -			mmio ? "MMIO" : "I/O port",
 > -			mmio ? port->mapbase :
 > +			(port->iotype == UPIO_MEM) ? "MMIO" : \
 > +			(port->iotype == UPIO_AU)  ? "AU"   : "I/O port",
 > +			(port->iotype == UPIO_MEM) || \
 > +			(port->iotype == UPIO_AU) ? port->mapbase :
 >  			    (unsigned long) port->iobase);
 >
 >  	unregister_console(&early_uart_console);
 > -	if (mmio)
 > +	if ((port->iotype == UPIO_MEM) || (port->iotype == UPIO_AU))
 >  		iounmap(port->membase);

    Why the different code here? I suggest sticking to the 8250.c variant...
And, as I said. there's not much sense in calling iomap() on Alchemy UART, 
UPIO_IOREMAP flag wasn't really needed...

> Please, note also the «know bugs» section.

    You propably meant "known bugs"? :-)

> Ciao,
> 
> Rodolfo

WBR, Sergei
