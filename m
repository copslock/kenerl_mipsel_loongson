Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 13:44:31 +0100 (BST)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62472 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133487AbWC0MoO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Mar 2006 13:44:14 +0100
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1FNrEn-00038c-Qh; Mon, 27 Mar 2006 13:54:26 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1FNrEl-0006V9-MD; Mon, 27 Mar 2006 13:54:23 +0100
Date:	Mon, 27 Mar 2006 13:54:23 +0100
From:	Russell King <rmk@arm.linux.org.uk>
To:	Jon Anders Haugum <jonah@omegav.ntnu.no>
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] serial8250: set divisor register correctly for AMD Alchemy SoC uart. Re-posted.
Message-ID: <20060327125423.GA24311@flint.arm.linux.org.uk>
References: <20060327131437.P55909@invalid.ed.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327131437.P55909@invalid.ed.ntnu.no>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Mon, Mar 27, 2006 at 01:27:34PM +0200, Jon Anders Haugum wrote:
> Alchemy SoC uart have got a non-standard divisor register that needs some 
> special handling.
> 
> This patch adds divisor read/write functions with test and special 
> handling for Alchemy internal uart.
>
> @@ -533,22 +565,20 @@ static int size_fifo(struct uart_8250_po
>   */
>  static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
>  {
> -	unsigned char old_dll, old_dlm, old_lcr;
> +	unsigned char old_lcr;
>  	unsigned int id;
> +	unsigned short old_dl;
>  
>  	old_lcr = serial_inp(p, UART_LCR);
>  	serial_outp(p, UART_LCR, UART_LCR_DLAB);
>  
> -	old_dll = serial_inp(p, UART_DLL);
> -	old_dlm = serial_inp(p, UART_DLM);
> +	old_dl = serial_dl_read(p);
>  
> -	serial_outp(p, UART_DLL, 0);
> -	serial_outp(p, UART_DLM, 0);
> +	serial_dl_write(p, 0);
>  
> -	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
> +	id = serial_dl_read(p);
>  
> -	serial_outp(p, UART_DLL, old_dll);
> -	serial_outp(p, UART_DLM, old_dlm);
> +	serial_dl_write(p, old_dl);
>  	serial_outp(p, UART_LCR, old_lcr);
>  
>  	return id;

I'm not sure whether this is a good idea - this is used to detect
an 16C850 UART, so probably should be kept as is.

In other words, we should use serial_dl_read() / serial_dl_write()
when we're actually wanting to read or set the actual divisor, but
not for the autoconfiguration stuff.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
