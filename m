Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 18:10:28 +0100 (BST)
Received: from amdext4.amd.com ([163.181.251.6]:55003 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133421AbWD1RKQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2006 18:10:16 +0100
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k3SHANYC018586;
	Fri, 28 Apr 2006 12:10:29 -0500
Received: from 163.181.22.101 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 28 Apr 2006 12:09:59 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Fri, 28 Apr 2006 12:09:59 -0500
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 4A0C42028; Fri, 28 Apr 2006
 11:09:59 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k3SHJNVh018312; Fri, 28 Apr 2006 11:19:23
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k3SHJNCL018311; Fri, 28 Apr 2006 11:19:23
 -0600
Date:	Fri, 28 Apr 2006 11:19:23 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
cc:	"Rodolfo Giometti" <giometti@linux.it>, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org
Subject: Re: trouble on serial console for au1100
Message-ID: <20060428171923.GG3314@cosmic.amd.com>
References: <20060427154948.GI32278@enneenne.com>
 <20060428111933.GY11097@dusktilldawn.nl>
MIME-Version: 1.0
In-Reply-To: <20060428111933.GY11097@dusktilldawn.nl>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 28 Apr 2006 17:10:00.0034 (UTC)
 FILETIME=[94EED420:01C66AE6]
X-WSS-ID: 684C93ED4IS3817596-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

> Can it be that you face the same problem I was facing not so long
> ago? After I applied the patch in the email I attach to this one
> all my serial troubles on the au1100 disappeared.

CCing the serial list too.  It could use more testing, but this seems
like it might be the answer to the myriad of serial issues that have 
been reported in the last month or so. 

I'm ashamed to admit I have no idea if this patch is even in the system or
not.  If not, I'm sure somebody
can clean it up and send it in the proper style.

Jordan

> From: Jon Anders Haugum <jonah@omegav.ntnu.no>
> Date: 	Thu, 20 Apr 2006 14:55:59 +0200 (CEST)
> To: rmk+serial@arm.linux.org.uk
> Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org
> Subject: [PATCH] serial8250: set divisor register correctly for AMD Alchemy
>  SoC uart. 3rd edition.
> 
> Alchemy SoC uart have got a non-standard divisor register that needs some
> special handling.
> 
> This patch adds divisor read/write functions with test and special
> handling for Alchemy internal uart.
> 
> Signed-off-by: Jon Anders Haugum <jonah@omegav.ntnu.no>
> 
> ---
> 
> 3rd edition:
> - Removed section covering 16C850 autoconfig.
> 
> 
> --- linux-2.6.16-rc5/drivers/serial/8250.c.orig	2006-03-03 02:12:10.000000000 +0100
> +++ linux-2.6.16-rc5/drivers/serial/8250.c	2006-03-03 02:16:19.000000000 +0100
> @@ -362,6 +362,40 @@ serial_out(struct uart_8250_port *up, in
>  #define serial_inp(up, offset)		serial_in(up, offset)
>  #define serial_outp(up, offset, value)	serial_out(up, offset, value)
>  
> +/* Uart divisor latch read */
> +static inline int _serial_dl_read(struct uart_8250_port *up)
> +{
> +	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
> +}
> +
> +/* Uart divisor latch write */
> +static inline void _serial_dl_write(struct uart_8250_port *up, int value)
> +{
> +	serial_outp(up, UART_DLL, value & 0xff);
> +	serial_outp(up, UART_DLM, value >> 8 & 0xff);
> +}
> +
> +#ifdef CONFIG_SERIAL_8250_AU1X00
> +/* Au1x00 haven't got a standard divisor latch */
> +static int serial_dl_read(struct uart_8250_port *up)
> +{
> +	if (up->port.iotype == UPIO_AU)
> +		return __raw_readl(up->port.membase + 0x28);
> +	else
> +		return _serial_dl_read(up);
> +}
> +
> +static void serial_dl_write(struct uart_8250_port *up, int value)
> +{
> +	if (up->port.iotype == UPIO_AU)
> +		__raw_writel(value, up->port.membase + 0x28);
> +	else
> +		_serial_dl_write(up, value);
> +}
> +#else
> +#define serial_dl_read(up) _serial_dl_read(up)
> +#define serial_dl_write(up, value) _serial_dl_write(up, value)
> +#endif
>  
>  /*
>   * For the 16C950
> @@ -494,7 +528,8 @@ static void disable_rsa(struct uart_8250
>   */
>  static int size_fifo(struct uart_8250_port *up)
>  {
> -	unsigned char old_fcr, old_mcr, old_dll, old_dlm, old_lcr;
> +	unsigned char old_fcr, old_mcr, old_lcr;
> +	unsigned short old_dl;
>  	int count;
>  
>  	old_lcr = serial_inp(up, UART_LCR);
> @@ -505,10 +540,8 @@ static int size_fifo(struct uart_8250_po
>  		    UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
>  	serial_outp(up, UART_MCR, UART_MCR_LOOP);
>  	serial_outp(up, UART_LCR, UART_LCR_DLAB);
> -	old_dll = serial_inp(up, UART_DLL);
> -	old_dlm = serial_inp(up, UART_DLM);
> -	serial_outp(up, UART_DLL, 0x01);
> -	serial_outp(up, UART_DLM, 0x00);
> +	old_dl = serial_dl_read(up);
> +	serial_dl_write(up, 0x0001);
>  	serial_outp(up, UART_LCR, 0x03);
>  	for (count = 0; count < 256; count++)
>  		serial_outp(up, UART_TX, count);
> @@ -519,8 +552,7 @@ static int size_fifo(struct uart_8250_po
>  	serial_outp(up, UART_FCR, old_fcr);
>  	serial_outp(up, UART_MCR, old_mcr);
>  	serial_outp(up, UART_LCR, UART_LCR_DLAB);
> -	serial_outp(up, UART_DLL, old_dll);
> -	serial_outp(up, UART_DLM, old_dlm);
> +	serial_dl_write(up, old_dl);
>  	serial_outp(up, UART_LCR, old_lcr);
>  
>  	return count;
> @@ -750,8 +780,7 @@ static void autoconfig_16550a(struct uar
>  
>  			serial_outp(up, UART_LCR, 0xE0);
>  
> -			quot = serial_inp(up, UART_DLM) << 8;
> -			quot += serial_inp(up, UART_DLL);
> +			quot = serial_dl_read(up);
>  			quot <<= 3;
>  
>  			status1 = serial_in(up, 0x04); /* EXCR1 */
> @@ -759,8 +788,7 @@ static void autoconfig_16550a(struct uar
>  			status1 |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
>  			serial_outp(up, 0x04, status1);
>  			
> -			serial_outp(up, UART_DLL, quot & 0xff);
> -			serial_outp(up, UART_DLM, quot >> 8);
> +			serial_dl_write(up, quot);
>  
>  			serial_outp(up, UART_LCR, 0);
>  
> @@ -1862,8 +1890,7 @@ serial8250_set_termios(struct uart_port 
>  		serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
>  	}
>  
> -	serial_outp(up, UART_DLL, quot & 0xff);		/* LS of divisor */
> -	serial_outp(up, UART_DLM, quot >> 8);		/* MS of divisor */
> +	serial_dl_write(up, quot);
>  
>  	/*
>  	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
