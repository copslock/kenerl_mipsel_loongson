Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 22:00:46 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4111 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133618AbWBSWAf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 22:00:35 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1FAwiD-0000ge-Hj; Sun, 19 Feb 2006 22:07:26 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1FAwiB-0004Do-6W; Sun, 19 Feb 2006 22:07:23 +0000
Date:	Sun, 19 Feb 2006 22:07:22 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Stanislaw Skowronek <skylark@linux-mips.org>
Subject: Re: Merging Skylark's IOC3 patch
Message-ID: <20060219220722.GB968@flint.arm.linux.org.uk>
References: <20060219211527.GA12848@deprecation.cyrius.com> <20060219215740.GQ10266@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219215740.GQ10266@deprecation.cyrius.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Sun, Feb 19, 2006 at 09:57:40PM +0000, Martin Michlmayr wrote:
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -310,6 +310,9 @@ static unsigned int serial_in(struct uar
>  	case UPIO_MEM:
>  		return readb(up->port.membase + offset);
>  
> +	case UPIO_IOC3:
> +		return readb(up->port.membase + (offset^3));
> +
>  	case UPIO_MEM32:
>  		return readl(up->port.membase + offset);
>  
> @@ -338,6 +341,10 @@ serial_out(struct uart_8250_port *up, in
>  		writeb(value, up->port.membase + offset);
>  		break;
>  
> +	case UPIO_IOC3:
> +		writeb(value, up->port.membase + (offset^3));
> +		break;
> +
>  	case UPIO_MEM32:
>  		writel(value, up->port.membase + offset);
>  		break;

Hmm, this starts to open up the question of whether having an array
of register pointers becomes cheaper.

> @@ -2300,8 +2311,10 @@ int __init serial8250_start_console(stru
>  
>  	add_preferred_console("ttyS", line, options);
>  	printk("Adding console on ttyS%d at %s 0x%lx (options '%s')\n",
> -		line, port->iotype == UPIO_MEM ? "MMIO" : "I/O port",
> -		port->iotype == UPIO_MEM ? (unsigned long) port->mapbase :
> +		line, port->iotype == UPIO_MEM ? "MMIO" : 
> +		port->iotype == UPIO_IOC3 ? "IOC3" : "I/O port",
> +		(port->iotype == UPIO_MEM || port->iotype == UPIO_IOC3) ?
> +		    (unsigned long) port->mapbase :
>  		    (unsigned long) port->iobase, options);

Maybe the "iotype" should index an array?

> diff --git a/include/linux/serial.h b/include/linux/serial.h
> index c69c6b9..a3ee515 100644
> --- a/include/linux/serial.h
> +++ b/include/linux/serial.h
> @@ -82,6 +82,7 @@ struct serial_struct {
>  #define SERIAL_IO_PORT	0
>  #define SERIAL_IO_HUB6	1
>  #define SERIAL_IO_MEM	2
> +#define SERIAL_IO_IOC3	3
>  
>  struct serial_uart_config {
>  	char	*name;
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 4041122..9441c90 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -221,6 +221,7 @@ struct uart_port {
>  #define UPIO_MEM		(2)
>  #define UPIO_MEM32		(3)
>  #define UPIO_AU			(4)			/* Au1x00 type IO */
> +#define UPIO_IOC3		(5)

Comparing SERIAL_IO_* and UPIO_*, I have to say no here.  Always ensure
that they end up with the same number.  SERIAL_IO_* is the current
userland version of UPIO_*.  At some point in the future (once the
pipedream of having _all_ serial drivers updated becomes reality) this
can be sorted out sanely.

> +	port.membase = (unsigned char *) &idd->vma->sregs.uarta;
> +	port.mapbase = ((unsigned long) port.membase) & 0xFFFFFFFFFF;
> +	d->line_a = serial8250_register_port(&port);

mapbase is supposed to be the physical address, whereas membase is what is
used to access the register, and should be something compatible with MMIO
accessors.  Is the cast really required here?

Are you tagging MMIO stuff with __iomem ?

Apart from that, I don't have any further comments at present.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
