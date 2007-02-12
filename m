Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 17:47:32 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:33969 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039003AbXBLRr0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Feb 2007 17:47:26 +0000
Received: (qmail 9835 invoked by uid 101); 12 Feb 2007 17:46:18 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by mother.pmc-sierra.com with SMTP; 12 Feb 2007 17:46:18 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1CHkCic022124;
	Mon, 12 Feb 2007 09:46:17 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <1CC7WMZV>; Mon, 12 Feb 2007 09:46:12 -0800
Message-ID: <45D0A7DA.1040305@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	 er
Date:	Mon, 12 Feb 2007 09:46:02 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 12 Feb 2007 17:46:07.0677 (UTC) FILETIME=[ACBE66D0:01C74ECD]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Sergei Shtylyov wrote:
> Hello.
> 
> Marc St-Jean wrote:
> 
>  >> > Fourth attempt at the serial driver patch for the PMC-Sierra MSP71xx
>  >>device.
> 
>     I think you need to submit your patch to Andrew Morton since it 
> requires a patch from his tree.

OK, will do.


>  >> > @@ -1383,6 +1399,19 @@ static irqreturn_t serial8250_interrupt(
>  >> >                       handled = 1;
>  >> >
>  >> >                       end = NULL;
>  >> > +             } else if (up->port.iotype == UPIO_DWAPB &&
>  >> > +                             (iir & UART_IIR_BUSY) == 
> UART_IIR_BUSY) {
> 
>  >>     Worth aligning this line with the opening paren of if... but's 
> that's
>  >>nitpicking. :-)
> 
>  > No problem I'll change it. I just usually align to the closest tab 
> stop to
>  > the opening parenthesis.
> 
>     It haven't really changed in the last patch. :-)

I will respin with 8 char tabs.


>  >> > +                     /* The DesignWare APB UART has an Busy Detect
>  >>(0x07)
>  >> > +                      * interrupt meaning an LCR write attempt
>  >>occured while the
>  >> > +                      * UART was busy. The interrupt must be cleared
>  >>by reading
>  >> > +                      * the UART status register (USR) and the LCR
>  >>re-written. */
>  >> > +                     unsigned int status;
>  >> > +                     status = *(volatile u32 
> *)up->port.private_data;
>  >> > +                     serial_out(up, UART_LCR, up->lcr);
>  >> > +
>  >> > +                     handled = 1;
>  >> > +
>  >> > +                     end = NULL;
>  >> >               } else if (end == NULL)
>  >> >                       end = l;
>  >> >
>  >> >       return 0;
> 
>  >>    Still, shouldn't you be doing this in serial8250_timeout()
> 
>  > No, the serial8250_timeout is for issue 1 at the top, this is for
>  > issue 2.
> 
>     It's for lost interrupts, IIUC. They use anothe timeout handler for the
> workaround...

This issue (2) is a completely new type of interrupt generated but the
DesignWare APB uart, it has nothing to do with lost interrupts.


>  >>also?
>  >>What IRQ numbers this UART is using, BTW?
> 
>  > For the ports on the device they are 27 and 42. Is there any 
> significance
>  > that I'm not aware of?
> 
>     Yeah, IRQ0 is treated as no IRQ by 8250, and in this case it falls 
> back to
> using serial8250_timeout() to handle "interrupts".

Good to know. It won't be affecting us then.


> 
>  >>    Oops, your mailer went and did it again. :-)
> 
>  > I'm completely giving up on Thunderbird,unless someone can point out
> 
>     Ypu should have long ago. :-)
> 
>  > the specific internal configuration items which needs a kick!
> 
>     Only the attachments will work in the Mozilla kind mailer, AFAIK.
> The last patch looked OK at last. :-)

The attachemnents appear to be MIME which is a no-no according the
linux FAQ at kernel.org. I guess I'll stick with /bin/mail.

Thanks,
Marc
