Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 19:40:35 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:21189 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038813AbXBITk3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 19:40:29 +0000
Received: (qmail 28237 invoked by uid 101); 9 Feb 2007 19:39:11 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 9 Feb 2007 19:39:11 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l19Jd9lK017743;
	Fri, 9 Feb 2007 11:39:09 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <1CC74MMJ>; Fri, 9 Feb 2007 11:39:09 -0800
Message-ID: <45CCCDD4.7030104@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	er
Date:	Fri, 9 Feb 2007 11:39:00 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 09 Feb 2007 19:39:07.0411 (UTC) FILETIME=[F68A7630:01C74C81]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Marc St-Jean wrote:
>  > Fourth attempt at the serial driver patch for the PMC-Sierra MSP71xx 
> device.
>  >
>  > There are three different fixes:
>  > 1. Fix for DesignWare THRE errata
>  > - Dropped our fix since the "8250-uart-backup-timer.patch" in the "mm"
>  > tree also fixes it. This patch needs to be applied on top of "mm" patch.
>  >
>  > 2. Fix for Busy Detect on LCR write
>  > - Changed the ordering of test in serial8250_interrupt().
>  > - Combined test for UPIO_DWAPB with UPIO_MEM in 
> serial8250_start_console().
>  > - Renamed new uart_8250_port member to private_data.
>  >
>  > 3. Workaround for interrupt/data concurrency issue
>  > - No changes since last patch.
> 
>  > @@ -1383,6 +1399,19 @@ static irqreturn_t serial8250_interrupt(
>  >                       handled = 1;
>  >
>  >                       end = NULL;
>  > +             } else if (up->port.iotype == UPIO_DWAPB &&
>  > +                             (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
> 
>      Worth aligning this line with the opening paren of if... but's that's
> nitpicking. :-)

No problem I'll change it. I just usually align to the closest tab stop to
the opening parenthesis.


>  > +                     /* The DesignWare APB UART has an Busy Detect 
> (0x07)
>  > +                      * interrupt meaning an LCR write attempt 
> occured while the
>  > +                      * UART was busy. The interrupt must be cleared 
> by reading
>  > +                      * the UART status register (USR) and the LCR 
> re-written. */
>  > +                     unsigned int status;
>  > +                     status = *(volatile u32 *)up->port.private_data;
>  > +                     serial_out(up, UART_LCR, up->lcr);
>  > +
>  > +                     handled = 1;
>  > +
>  > +                     end = NULL;
>  >               } else if (end == NULL)
>  >                       end = l;
>  >
>  >       return 0;
> 
>     Still, shouldn't you be doing this in serial8250_timeout()

No, the serial8250_timeout is for issue 1 at the top, this is for
issue 2.


> also?
> What IRQ numbers this UART is using, BTW?

For the ports on the device they are 27 and 42. Is there any significance
that I'm not aware of?


>  > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>  > index cf23813..bd9711a 100644
>  > --- a/include/linux/serial_core.h
>  > +++ b/include/linux/serial_core.h
>  > @@ -276,6 +277,7 @@ #define UPF_USR_MASK              ((__force upf_t) (
>  >       struct device           *dev;                   /* parent 
> device */
>  >       unsigned char           hub6;                   /* this should 
> be in the 8250 driver */
>  >       unsigned char           unused[3];
>  > +     void                            *private_data;          /* 
> generic platform data pointer */
> 
>     One tab to many before *private_data...

In my editor using 4 columns per tab it lines up with everything. Is there
some convention that patches should be made assuming 8 columns?


>  > diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
>  > index 3c8a6aa..1c5ed7d 100644
>  > --- a/include/linux/serial_reg.h
>  > +++ b/include/linux/serial_reg.h
>  > @@ -38,6 +38,8 @@ #define UART_IIR_THRI               0x02 /* Transmitt
>  >   #define UART_IIR_RDI                0x04 /* Receiver data interrupt */
>  >   #define UART_IIR_RLSI               0x06 /* Receiver line status 
> interrupt */
>  >
>  > +#define UART_IIR_BUSY                0x07 /* DesignWare APB Busy 
> Detect */
>  > +
>  >   #define UART_FCR    2       /* Out: FIFO Control Register */
>  >   #define UART_FCR_ENABLE_FIFO        0x01 /* Enable the FIFO */
>  >   #define UART_FCR_CLEAR_RCVR 0x02 /* Clear the RCVR FIFO */
> 
>     Oops, your mailer went and did it again. :-)

I'm completely giving up on Thunderbird,unless someone can point out
the specific internal configuration items which needs a kick!

Thanks,
Marc
