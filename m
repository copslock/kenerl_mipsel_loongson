Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2006 15:50:16 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:23948 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039219AbWH1OuO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Aug 2006 15:50:14 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 530363ECC; Mon, 28 Aug 2006 07:49:54 -0700 (PDT)
Message-ID: <44F302D5.8050809@ru.mvista.com>
Date:	Mon, 28 Aug 2006 18:51:01 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] 8250_early console support for au1x00 (again)
References: <20060504134509.GE19913@gundam.enneenne.com> <445A114B.4040404@ru.mvista.com> <20060504152048.GG19913@gundam.enneenne.com> <445A225F.7090300@ru.mvista.com> <20060504163301.GH19913@gundam.enneenne.com> <20060522205036.GB16223@enneenne.com>
In-Reply-To: <20060522205036.GB16223@enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

> Here, attached and published on my site, my two new proposal for
> serial line and early console for au1x00.

> The first patch:

>    http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-au1x00-early-console

> adds early console support for au1x00. In this version I decided to
> add the "AU" serial type in all kernel messages.

> The second patch:

>    http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-au1x00-serial-phys-addr

> fixes serial address space by using only physical addresses. Please,
> note that this change allow to simply file "drivers/serial/8250.c"
> since functions __raw_readl()/__raw_writel() can be replaced by
> functions readl()/writel().

    Sorry for follwing up 2 month ago, I just happen to stumble on some issues 
addresses by these patches as well. I assume you haven't tried sending them to 
Russel King?
    Below are my comments:

> ------------------------------------------------------------------------
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index bcf1b10..78dcded 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -32,6 +32,7 @@
>  #include <linux/kdev_t.h>
>  #include <linux/root_dev.h>
>  #include <linux/highmem.h>
> +#include <linux/serial.h>
>  #include <linux/console.h>
>  #include <linux/mmzone.h>
>  #include <linux/pfn.h>
> @@ -517,6 +518,10 @@ void __init setup_arch(char **cmdline_p)
>  
>  	*cmdline_p = command_line;
>  
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +	early_serial_console_init(*cmdline_p);
> +#endif
> +
>  	parse_cmdline_early();
>  	bootmem_init();
>  	sparse_init();
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index bbf78aa..784d9d3 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -2336,8 +2336,11 @@ int __init serial8250_start_console(stru
>  
>  	add_preferred_console("ttyS", line, options);
>  	printk("Adding console on ttyS%d at %s 0x%lx (options '%s')\n",
> -		line, port->iotype == UPIO_MEM ? "MMIO" : "I/O port",
> -		port->iotype == UPIO_MEM ? (unsigned long) port->mapbase :
> +		line,
> +	       	(port->iotype == UPIO_MEM) ? "MMIO" : \
> +		(port->iotype == UPIO_AU)  ? "AU"   : "I/O port",
> +		(port->iotype == UPIO_MEM) || \
> +		(port->iotype == UPIO_AU) ? (unsigned long) port->mapbase :
>  		    (unsigned long) port->iobase, options);
>  	if (!(serial8250_console.flags & CON_ENABLED)) {
>  		serial8250_console.flags &= ~CON_PRINTBUFFER;
> diff --git a/drivers/serial/8250_early.c b/drivers/serial/8250_early.c
> index 7e51119..319baa9 100644
> --- a/drivers/serial/8250_early.c
> +++ b/drivers/serial/8250_early.c
[...]
> @@ -44,22 +52,133 @@ struct early_uart_device {
[...]
> +static unsigned int serial_in(struct uart_port *port, int offset)
>  {
> -	if (port->iotype == UPIO_MEM)
> +	offset = map_in_reg(port, offset) << port->regshift;
> +
> +	switch (port->iotype) {
> +	case UPIO_HUB6:
> +		outb(port->hub6 - 1 + offset, port->iobase);
> +		return inb(port->iobase + 1);

    This module can't handle HAB6 otherwise, so whay add it here?

> +	case UPIO_MEM:
>  		return readb(port->membase + offset);
> -	else
> +
> +	case UPIO_MEM32:
> +	case UPIO_AU:
> +		return readl(port->membase + offset);

    NAK. readl() can't be used to read from Alchemy SOC peripherals because 
it'll break in BE mode.  Alchemy automagically handles byteswap for the SOC 
peripherals.

> +
> +	default:
>  		return inb(port->iobase + offset);
> +	}
>  }
>  
> -static void __init serial_out(struct uart_port *port, int offset, int value)
> +static void
> +serial_out(struct uart_port *port, int offset, int value)
>  {
> -	if (port->iotype == UPIO_MEM)
> +	offset = map_out_reg(port, offset) << port->regshift;
> +
> +	switch (port->iotype) {
> +	case UPIO_HUB6:
> +		outb(port->hub6 - 1 + offset, port->iobase);
> +		outb(value, port->iobase + 1);
> +		break;
> +
> +	case UPIO_MEM:
>  		writeb(value, port->membase + offset);
> -	else
> +		break;
> +
> +	case UPIO_MEM32:
> +	case UPIO_AU:
> +		writel(value, port->membase + offset);
> +		break;
> +

    The same NAK with writel()...

> +	default:
>  		outb(value, port->iobase + offset);
> +	}
> +}
> +
> +/* Uart divisor latch read */
> +static inline int _serial_dl_read(struct uart_port *port)
> +{
> +	return serial_in(port, UART_DLL) | serial_in(port, UART_DLM) << 8;
> +}
> +
> +/* Uart divisor latch write */
> +static inline void _serial_dl_write(struct uart_port *port, int value)
> +{
> +	serial_out(port, UART_DLL, value & 0xff);
> +	serial_out(port, UART_DLM, value >> 8 & 0xff);
> +}
> +
> +#ifdef CONFIG_SERIAL_8250_AU1X00
> +/* Au1x00 haven't got a standard divisor latch */
> +static int serial_dl_read(struct uart_port *port)
> +{
> +	if (port->iotype == UPIO_AU)
> +		return readl(port->membase + 0x28);
> +	else
> +		return _serial_dl_read(port);
>  }
>  
> +static void serial_dl_write(struct uart_port *port, int value)
> +{
> +	if (port->iotype == UPIO_AU)
> +		writel(value, port->membase + 0x28);
> +	else
> +		_serial_dl_write(port, value);
> +}
> +#else
> +#define serial_dl_read(port) _serial_dl_read(port)
> +#define serial_dl_write(port, value) _serial_dl_write(port, value)
> +#endif
> +
>  #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
>  
>  static void __init wait_for_xmitr(struct uart_port *port)
> @@ -98,16 +217,17 @@ static void __init early_uart_write(stru
>  
>  static unsigned int __init probe_baud(struct uart_port *port)
>  {
> -	unsigned char lcr, dll, dlm;
> +	unsigned char lcr;
>  	unsigned int quot;
> +	int sd = ((int)(__raw_readl(SYS_POWERCTRL)&0x03)) + 2;   /* Au1x00 SD */
>  
>  	lcr = serial_in(port, UART_LCR);
>  	serial_out(port, UART_LCR, lcr | UART_LCR_DLAB);
> -	dll = serial_in(port, UART_DLL);
> -	dlm = serial_in(port, UART_DLM);
> +	quot = serial_dl_read(port);
>  	serial_out(port, UART_LCR, lcr);
>  
> -	quot = (dlm << 8) | dll;
> +	if (port->iotype == UPIO_AU)
> +		return CPU_SPEED / (sd * quot * 32);
>  	return (port->uartclk / 16) / quot;
>  }
>  
> @@ -142,6 +266,7 @@ static int __init parse_options(struct e
>  	port->uartclk = BASE_BAUD * 16;
>  	if (!strncmp(options, "mmio,", 5)) {
>  		port->iotype = UPIO_MEM;
> +		port->regshift = 0;

    Maybe regshift even deserves the separate (but optional) field in the boot 
option...

[...]
> @@ -169,8 +309,7 @@ static int __init parse_options(struct e
>  	}
>  
>  	printk(KERN_INFO "Early serial console at %s 0x%lx (options '%s')\n",
> -		mmio ? "MMIO" : "I/O port",
> -		mmio ? port->mapbase : (unsigned long) port->iobase,
> +		buf, mmio ? port->mapbase : (unsigned long) port->iobase,
>  		device->options);
>  	return 0;
>  }
> @@ -227,22 +366,23 @@ static int __init early_uart_console_swi
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

    I'd simply map UPIO_AU to "MMIO" in the message because it's memory mapped 
UART after all...

> diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
> index 17839e7..9e27aee 100644
> --- a/drivers/serial/serial_core.c
> +++ b/drivers/serial/serial_core.c
> @@ -2367,6 +2367,7 @@ int uart_match_port(struct uart_port *po
>  		return (port1->iobase == port2->iobase) &&
>  		       (port1->hub6   == port2->hub6);
>  	case UPIO_MEM:
> +	case UPIO_AU:

    Also needs cases for UPIO_MEM32 and UPIO_TSI.

>  		return (port1->mapbase == port2->mapbase);
>  	}
>  	return 0;


> ------------------------------------------------------------------------
> 
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 784d9d3..40c9097 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -311,12 +311,8 @@ static unsigned int serial_in(struct uar
>  		return readb(up->port.membase + offset);
>  
>  	case UPIO_MEM32:
> -		return readl(up->port.membase + offset);
> -
> -#ifdef CONFIG_SERIAL_8250_AU1X00
>  	case UPIO_AU:
> -		return __raw_readl(up->port.membase + offset);
> -#endif
> +		return readl(up->port.membase + offset);

    NAK for the reason already stated.

> @@ -339,14 +335,9 @@ serial_out(struct uart_8250_port *up, in
>  		break;
>  
>  	case UPIO_MEM32:
> -		writel(value, up->port.membase + offset);
> -		break;
> -
> -#ifdef CONFIG_SERIAL_8250_AU1X00
>  	case UPIO_AU:
> -		__raw_writel(value, up->port.membase + offset);
> +		writel(value, up->port.membase + offset);
>  		break;
> -#endif

    Ditto writel().

> @@ -380,7 +371,7 @@ static inline void _serial_dl_write(stru
>  static int serial_dl_read(struct uart_8250_port *up)
>  {
>  	if (up->port.iotype == UPIO_AU)
> -		return __raw_readl(up->port.membase + 0x28);
> +		return readl(up->port.membase + 0x28);
>  	else
>  		return _serial_dl_read(up);
>  }
> @@ -388,7 +379,7 @@ static int serial_dl_read(struct uart_82
>  static void serial_dl_write(struct uart_8250_port *up, int value)
>  {
>  	if (up->port.iotype == UPIO_AU)
> -		__raw_writel(value, up->port.membase + 0x28);
> +		writel(value, up->port.membase + 0x28);
>  	else
>  		_serial_dl_write(up, value);
>  }

    Ditto here.

> diff --git a/drivers/serial/8250_au1x00.c b/drivers/serial/8250_au1x00.c
> index 58015fd..9d0f1be 100644
> --- a/drivers/serial/8250_au1x00.c
> +++ b/drivers/serial/8250_au1x00.c

    The reason this file came into being at all is doubtful to me, BTW...
The platform devices should be registered in the platform setup code.

WBR, Sergei
