Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 02:00:25 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:18971 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038612AbWHVBAV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Aug 2006 02:00:21 +0100
Received: by mo.po.2iij.net (mo32) id k7M0xlZ4009802; Tue, 22 Aug 2006 09:59:47 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id k7M0xgeo095971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Aug 2006 09:59:42 +0900 (JST)
Date:	Tue, 22 Aug 2006 09:59:42 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, sshtylyov@ru.mvista.com,
	rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	thomas@koeller.dyndns.org
Subject: Re: [PATCH] RM9000 serial driver
Message-Id: <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <200608220057.52213.thomas.koeller@baslerweb.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com>
	<44DCDCED.7000404@ru.mvista.com>
	<200608220057.52213.thomas.koeller@baslerweb.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, 22 Aug 2006 00:57:51 +0200
Thomas Koeller <thomas.koeller@baslerweb.com> wrote:

<snip>

> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 0ae9ced..c6c28ed 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -251,9 +251,16 @@ static const struct serial8250_config ua
>  		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>  		.flags		= UART_CAP_FIFO | UART_CAP_UUE,
>  	},
> +	[PORT_RM9000] = {
> +		.name		= "RM9000",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> +		.flags		= UART_CAP_FIFO,
> +	},
>  };
>  
> -#ifdef CONFIG_SERIAL_8250_AU1X00
> +#if defined (CONFIG_SERIAL_8250_AU1X00)
>  
>  /* Au1x00 UART hardware has a weird register layout */
>  static const u8 au_io_in_map[] = {
> @@ -289,6 +296,34 @@ static inline int map_8250_out_reg(struc
>  	return au_io_out_map[offset];
>  }
>  
> +#elif defined (CONFIG_SERIAL_RM9000)

CONFIG_SERIAL_8250_RM9000.
Morover, you should update drivers/serial/Kconfig

> +
> +static const u8
> +	regmap_in[8] = {
> +		[UART_RX]	= 0x00,
> +		[UART_IER]	= 0x0c,
> +		[UART_IIR]	= 0x14,
> +		[UART_LCR]	= 0x1c,
> +		[UART_MCR]	= 0x20,
> +		[UART_LSR]	= 0x24,
> +		[UART_MSR]	= 0x28,
> +		[UART_SCR]	= 0x2c
> +	},
> +	regmap_out[8] = {
> +		[UART_TX] 	= 0x04,
> +		[UART_IER]	= 0x0c,
> +		[UART_FCR]	= 0x18,
> +		[UART_LCR]	= 0x1c,
> +		[UART_MCR]	= 0x20,
> +		[UART_LSR]	= 0x24,
> +		[UART_MSR]	= 0x28,
> +		[UART_SCR]	= 0x2c
> +	};
> +
> +#define map_8250_in_reg(up, offset) (regmap_in[offset])
> +#define map_8250_out_reg(up, offset) (regmap_out[offset])
> +
> +
>  #else
>  
>  /* sane hardware needs no mapping */
> @@ -374,21 +409,21 @@ #define serial_inp(up, offset)		serial_i
>  #define serial_outp(up, offset, value)	serial_out(up, offset, value)
>  
>  /* Uart divisor latch read */
> -static inline int _serial_dl_read(struct uart_8250_port *up)
> +static inline unsigned int _serial_dl_read(struct uart_8250_port *up)
>  {
>  	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
>  }
>  
>  /* Uart divisor latch write */
> -static inline void _serial_dl_write(struct uart_8250_port *up, int value)
> +static inline void _serial_dl_write(struct uart_8250_port *up, unsigned int value)
>  {
>  	serial_outp(up, UART_DLL, value & 0xff);
>  	serial_outp(up, UART_DLM, value >> 8 & 0xff);
>  }
>  
> -#ifdef CONFIG_SERIAL_8250_AU1X00
> +#if defined (CONFIG_SERIAL_8250_AU1X00)
>  /* Au1x00 haven't got a standard divisor latch */
> -static int serial_dl_read(struct uart_8250_port *up)
> +static unsigned int serial_dl_read(struct uart_8250_port *up)
>  {
>  	if (up->port.iotype == UPIO_AU)
>  		return __raw_readl(up->port.membase + 0x28);
> @@ -396,13 +431,26 @@ static int serial_dl_read(struct uart_82
>  		return _serial_dl_read(up);
>  }
>  
> -static void serial_dl_write(struct uart_8250_port *up, int value)
> +static void serial_dl_write(struct uart_8250_port *up, unsigned int value)
>  {
>  	if (up->port.iotype == UPIO_AU)
>  		__raw_writel(value, up->port.membase + 0x28);
>  	else
>  		_serial_dl_write(up, value);
>  }
> +#elif defined (CONFIG_SERIAL_RM9000)
> +static inline unsigned int serial_dl_read(struct uart_8250_port *up)
> +{
> +	return
> +		((readl(up->port.membase + 0x10) << 8) |
> +		(readl(up->port.membase + 0x08) & 0xff)) & 0xffff;
> +}
> +
> +static inline void serial_dl_write(struct uart_8250_port *up, unsigned int value)
> +{
> +	writel(value, up->port.membase + 0x08);
> +	writel(value >> 8, up->port.membase + 0x10);
> +}
>  #else

If you have an another standard 8250 port. this driver cannot support it
You should do as well as AU1X00.

Yoichi
