Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 20:04:47 +0100 (BST)
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:23825 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20039497AbWH2TEq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 20:04:46 +0100
Received: from flint.arm.linux.org.uk ([2002:d993:5cf9:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1GI8sv-0002V1-2d; Tue, 29 Aug 2006 20:04:29 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1GI8st-0005aJ-CF; Tue, 29 Aug 2006 20:04:27 +0100
Date:	Tue, 29 Aug 2006 20:04:27 +0100
From:	Russell King <rmk@arm.linux.org.uk>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Thomas Koeller <thomas.koeller@baslerweb.com>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-serial@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] RM9000 serial driver
Message-ID: <20060829190426.GA20606@flint.arm.linux.org.uk>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F441F3.8050301@ru.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, Aug 29, 2006 at 05:32:35PM +0400, Sergei Shtylyov wrote:
> >@@ -576,22 +626,17 @@ static int size_fifo(struct uart_8250_po
> >  */
> > static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
> > {
> >-	unsigned char old_dll, old_dlm, old_lcr;
> >-	unsigned int id;
> >+	unsigned char old_lcr;
> >+	unsigned int id, old_dl;
> > 
> > 	old_lcr = serial_inp(p, UART_LCR);
> > 	serial_outp(p, UART_LCR, UART_LCR_DLAB);
> >+	old_dl = _serial_dl_read(p);
> > 
> >-	old_dll = serial_inp(p, UART_DLL);
> >-	old_dlm = serial_inp(p, UART_DLM);
> >-
> >-	serial_outp(p, UART_DLL, 0);
> >-	serial_outp(p, UART_DLM, 0);
> >-
> >-	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
> >+	serial_dl_write(p, 0);
> >+	id = serial_dl_read(p);
> > 
> >-	serial_outp(p, UART_DLL, old_dll);
> >-	serial_outp(p, UART_DLM, old_dlm);
> >+	serial_dl_write(p, old_dl);
> > 	serial_outp(p, UART_LCR, old_lcr);
> > 
> > 	return id;
> 
>    Not sure the autoconfig code was intended for half-compatible UARTs. 
>    Note that it sets up->port.type as its result. However, your change seems 
> correct, it just have nothing to do with RM9000.

It's worse than that - this code is there to read the ID from the divisor
registers implemented in some UARTs.  If it isn't one of those UARTs, it's
expected to return zero.

So we don't actually want to be prodding some other random registers on
differing UARTs.

>    As a side note, I think that the code that sets DLAB before and resets it
> after the divisor latch read/write should be part of serial_dl_read() and
> serial_dl_write() actually. In the Alchemy UARTs this bit is reserved.

Not really, for two reasons.

1. We end up with additional pointless writes to undo what serial_dl_*
   did.
2. setting DLAB might work for a subset of ports, but others require
   different magic numbers written to LCR to access the divisor.
3. other ports have additional properties when DLAB is set, to the
   extent that you must not write other registers when it's reset to
   avoid clearing some features you want to enable.

So, really, Moving that stuff into serial_dl_* ends up adding additional
code and complexity where it isn't needed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
