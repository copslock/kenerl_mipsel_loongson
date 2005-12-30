Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2005 20:35:15 +0000 (GMT)
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:47715 "HELO
	smtp101.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133373AbVL3Ue5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Dec 2005 20:34:57 +0000
Received: (qmail 77741 invoked from network); 30 Dec 2005 20:36:54 -0000
Received: from unknown (HELO ?192.168.1.110?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 30 Dec 2005 20:36:53 -0000
Subject: Re: [PATCH] AMD Au1xx0 serial: claim the memory resource
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc:	rmk+serial@arm.linux.org.uk,
	Manish Lachwani <mlachwani@mvista.com>,
	Linux MIPS <linux-mips@linux-mips.org>,
	Jordan Crouse <jordan.crouse@amd.com>
In-Reply-To: <43B58548.4050208@ru.mvista.com>
References: <43B58548.4050208@ru.mvista.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 30 Dec 2005 12:36:36 -0800
Message-Id: <1135974996.7848.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


I think the new 8250 based driver is already upstream so this one should
be nuked anyway at some point.

Pete

On Fri, 2005-12-30 at 22:06 +0300, Sergei Shtylylov wrote:
> Hello.
> 
>      We've noticed that Au1x00 UART driver (drivers/serial/au1x00_uart.c)
> wasn't claiming its memory resources (in fact, as the heading comment had it,
> it wasn't doing this almost intentionally :-), so decided to add that
> cabability, cleaning the driver from a lot of unneeded code brought in during
> presumably very quick cut-and-pasting the driver from 8250.c: like handling of
> I/O port, ioremap() and PCMCIA cases which don't at all apply to Au1xx0 UARTs
> -- the KSEG1-mapped UART addresses are always taken from <asm-mips/serial.h>,
> so it was easy to get physical addresses back from them.
> 
> WBR, Sergei
> 
> Sighed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> 
> plain text document attachment (au1x00_uart-claim-memory.patch)
> diff --git a/drivers/serial/au1x00_uart.c b/drivers/serial/au1x00_uart.c
> index 878e0f3..6f4acc9 100644
> --- a/drivers/serial/au1x00_uart.c
> +++ b/drivers/serial/au1x00_uart.c
> @@ -12,12 +12,8 @@
>   *
>   * A note about mapbase / membase
>   *
> - *  mapbase is the physical address of the IO port.  Currently, we don't
> - *  support this very well, and it may well be dropped from this driver
> - *  in future.  As such, mapbase should be NULL.
> - *
> - *  membase is an 'ioremapped' cookie.  This is compatible with the old
> - *  serial.c driver, and is currently the preferred form.
> + *  mapbase is the physical address of the IO port.
> + *  membase is an 'ioremapped' cookie.
>   */
>  #include <linux/config.h>
>  #include <linux/module.h>
> @@ -157,9 +153,6 @@ static void autoconfig(struct uart_8250_
>  
>  	up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
>  
> -	if (up->port.type == PORT_UNKNOWN)
> -		goto out;
> -
>  	/*
>  	 * Reset the UART.
>  	 */
> @@ -171,7 +164,6 @@ static void autoconfig(struct uart_8250_
>  	(void)serial_in(up, UART_RX);
>  	serial_outp(up, UART_IER, 0);
>  
> - out:
>  	spin_unlock_irqrestore(&up->port.lock, flags);
>  //	restore_flags(flags);
>  	DEBUG_AUTOCONF("type=%s\n", uart_config[up->port.type].name);
> @@ -870,122 +862,35 @@ serial8250_pm(struct uart_port *port, un
>  	}
>  }
>  
> -/*
> - * Resource handling.  This is complicated by the fact that resources
> - * depend on the port type.  Maybe we should be claiming the standard
> - * 8250 ports, and then trying to get other resources as necessary?
> - */
> -static int
> -serial8250_request_std_resource(struct uart_8250_port *up, struct resource **res)
> -{
> -	unsigned int size = 8 << up->port.regshift;
> -	int ret = 0;
> -
> -	switch (up->port.iotype) {
> -	case SERIAL_IO_MEM:
> -		if (up->port.mapbase) {
> -			*res = request_mem_region(up->port.mapbase, size, "serial");
> -			if (!*res)
> -				ret = -EBUSY;
> -		}
> -		break;
> -
> -	case SERIAL_IO_HUB6:
> -	case SERIAL_IO_PORT:
> -		*res = request_region(up->port.iobase, size, "serial");
> -		if (!*res)
> -			ret = -EBUSY;
> -		break;
> -	}
> -	return ret;
> -}
> -
> -
>  static void serial8250_release_port(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
> -	unsigned long start, offset = 0, size = 0;
> -
> -	size <<= up->port.regshift;
> -
> -	switch (up->port.iotype) {
> -	case SERIAL_IO_MEM:
> -		if (up->port.mapbase) {
> -			/*
> -			 * Unmap the area.
> -			 */
> -			iounmap(up->port.membase);
> -			up->port.membase = NULL;
> -
> -			start = up->port.mapbase;
>  
> -			if (size)
> -				release_mem_region(start + offset, size);
> -			release_mem_region(start, 8 << up->port.regshift);
> -		}
> -		break;
> -
> -	case SERIAL_IO_HUB6:
> -	case SERIAL_IO_PORT:
> -		start = up->port.iobase;
> -
> -		if (size)
> -			release_region(start + offset, size);
> -		release_region(start + offset, 8 << up->port.regshift);
> -		break;
> -
> -	default:
> -		break;
> -	}
> +	if (up->port.mapbase)
> +		release_mem_region(up->port.mapbase, 0x100000);
>  }
>  
>  static int serial8250_request_port(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
> -	struct resource *res = NULL, *res_rsa = NULL;
> -	int ret = 0;
>  
> -	ret = serial8250_request_std_resource(up, &res);
> -
> -	/*
> -	 * If we have a mapbase, then request that as well.
> -	 */
> -	if (ret == 0 && up->port.flags & UPF_IOREMAP) {
> -		int size = res->end - res->start + 1;
> -
> -		up->port.membase = ioremap(up->port.mapbase, size);
> -		if (!up->port.membase)
> -			ret = -ENOMEM;
> -	}
> +	if (up->port.mapbase &&
> +	    request_mem_region(up->port.mapbase, 0x100000, "Au1x00 UART") == NULL)
> +		return -EBUSY;
>  
> -	if (ret < 0) {
> -		if (res_rsa)
> -			release_resource(res_rsa);
> -		if (res)
> -			release_resource(res);
> -	}
> -	return ret;
> +	return 0;
>  }
>  
>  static void serial8250_config_port(struct uart_port *port, int flags)
>  {
>  	struct uart_8250_port *up = (struct uart_8250_port *)port;
> -	struct resource *res_std = NULL, *res_rsa = NULL;
> -	int probeflags = PROBE_ANY;
>  
> -	probeflags &= ~PROBE_RSA;
> +	if (up->port.mapbase &&
> +	    request_mem_region(up->port.mapbase, 0x100000, "Au1x00 UART") == NULL)
> +		return;
>  
>  	if (flags & UART_CONFIG_TYPE)
> -		autoconfig(up, probeflags);
> -
> -	/*
> -	 * If the port wasn't an RSA port, release the resource.
> -	 */
> -	if (up->port.type != PORT_RSA && res_rsa)
> -		release_resource(res_rsa);
> -
> -	if (up->port.type == PORT_UNKNOWN && res_std)
> -		release_resource(res_std);
> +		autoconfig(up, PROBE_ANY);
>  }
>  
>  static int
> @@ -1049,6 +954,7 @@ static void __init serial8250_isa_init_p
>  		up->port.flags    = old_serial_port[i].flags;
>  		up->port.hub6     = old_serial_port[i].hub6;
>  		up->port.membase  = old_serial_port[i].iomem_base;
> +		up->port.mapbase  = CPHYSADDR(up->port.membase);
>  		up->port.iotype   = old_serial_port[i].io_type;
>  		up->port.regshift = old_serial_port[i].iomem_reg_shift;
>  		up->port.ops      = &serial8250_pops;
> @@ -1226,30 +1132,6 @@ int __init early_serial_setup(struct uar
>  	return 0;
>  }
>  
> -/**
> - *	serial8250_suspend_port - suspend one serial port
> - *	@line:  serial line number
> - *      @level: the level of port suspension, as per uart_suspend_port
> - *
> - *	Suspend one serial port.
> - */
> -void serial8250_suspend_port(int line)
> -{
> -	uart_suspend_port(&serial8250_reg, &serial8250_ports[line].port);
> -}
> -
> -/**
> - *	serial8250_resume_port - resume one serial port
> - *	@line:  serial line number
> - *      @level: the level of port resumption, as per uart_resume_port
> - *
> - *	Resume one serial port.
> - */
> -void serial8250_resume_port(int line)
> -{
> -	uart_resume_port(&serial8250_reg, &serial8250_ports[line].port);
> -}
> -
>  static int __init serial8250_init(void)
>  {
>  	int ret, i;
> @@ -1279,8 +1161,5 @@ static void __exit serial8250_exit(void)
>  module_init(serial8250_init);
>  module_exit(serial8250_exit);
>  
> -EXPORT_SYMBOL(serial8250_suspend_port);
> -EXPORT_SYMBOL(serial8250_resume_port);
> -
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Au1x00 serial driver\n");
> 
> 
> 
