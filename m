Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 12:00:45 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:47285 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20037623AbWH3LAn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Aug 2006 12:00:43 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1GINh2-00084E-00; Wed, 30 Aug 2006 12:53:12 +0200
Date:	Wed, 30 Aug 2006 12:53:12 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 8250_early console support for au1x00 (again)
Message-ID: <20060830105312.GF27010@gundam.enneenne.com>
References: <20060504134509.GE19913@gundam.enneenne.com> <445A114B.4040404@ru.mvista.com> <20060504152048.GG19913@gundam.enneenne.com> <445A225F.7090300@ru.mvista.com> <20060504163301.GH19913@gundam.enneenne.com> <20060522205036.GB16223@enneenne.com> <44F302D5.8050809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F302D5.8050809@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

>    Sorry for follwing up 2 month ago, I just happen to stumble on some 
>    issues addresses by these patches as well. I assume you haven't tried 
> sending them to Russel King?

Not yet, I just waiting for some comments. :)

> >+	switch (port->iotype) {
> >+	case UPIO_HUB6:
> >+		outb(port->hub6 - 1 + offset, port->iobase);
> >+		return inb(port->iobase + 1);
> 
>    This module can't handle HAB6 otherwise, so whay add it here?

Ok. I'm going to remove it.

> >+	case UPIO_MEM32:
> >+	case UPIO_AU:
> >+		return readl(port->membase + offset);
> 
>    NAK. readl() can't be used to read from Alchemy SOC peripherals because 
> it'll break in BE mode.  Alchemy automagically handles byteswap for the SOC 
> peripherals.

Ok. I'm going to fix it by using au_readl() but in this case I have to
add an ifdef with au1xxx include file. Can it be acceptable?

> >@@ -142,6 +266,7 @@ static int __init parse_options(struct e
> > 	port->uartclk = BASE_BAUD * 16;
> > 	if (!strncmp(options, "mmio,", 5)) {
> > 		port->iotype = UPIO_MEM;
> >+		port->regshift = 0;
> 
>    Maybe regshift even deserves the separate (but optional) field in the 
>    boot option...

Mmm... I don't know. However I have to set a default value.

> >+			(port->iotype == UPIO_MEM) ? "MMIO" : \
> >+			(port->iotype == UPIO_AU)  ? "AU"   : "I/O port",
> >+			(port->iotype == UPIO_MEM) || \
> >+			(port->iotype == UPIO_AU) ? port->mapbase :
> > 			    (unsigned long) port->iobase);
> 
>    I'd simply map UPIO_AU to "MMIO" in the message because it's memory 
>    mapped UART after all...

Yes, but in the kernel command line we must supply "au"... That's why
I used different string, so the user can verify whatever he/she passed
to the kernel.

> >index 17839e7..9e27aee 100644
> >--- a/drivers/serial/serial_core.c
> >+++ b/drivers/serial/serial_core.c
> >@@ -2367,6 +2367,7 @@ int uart_match_port(struct uart_port *po
> > 		return (port1->iobase == port2->iobase) &&
> > 		       (port1->hub6   == port2->hub6);
> > 	case UPIO_MEM:
> >+	case UPIO_AU:
> 
>    Also needs cases for UPIO_MEM32 and UPIO_TSI.

I just added the code for au1xxx. Why should I consider those cases
also?

> >-#ifdef CONFIG_SERIAL_8250_AU1X00
> > 	case UPIO_AU:
> >-		__raw_writel(value, up->port.membase + offset);
> >+		writel(value, up->port.membase + offset);
> > 		break;
> >-#endif
> 
>    Ditto writel().

Is __raw_writel() correct?

> WBR, Sergei

Thanks for your suggestions.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
