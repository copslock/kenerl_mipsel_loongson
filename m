Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 21:11:40 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:16818 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20049692AbXAXVLf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 21:11:35 +0000
Received: (qmail 4536 invoked by uid 101); 24 Jan 2007 21:10:22 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by mother.pmc-sierra.com with SMTP; 24 Jan 2007 21:10:22 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l0OLAKqp016099;
	Wed, 24 Jan 2007 13:10:20 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <DCB6C7YR>; Wed, 24 Jan 2007 13:10:19 -0800
Message-ID: <45B7CB34.60209@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	 er
Date:	Wed, 24 Jan 2007 13:10:12 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 24 Jan 2007 21:10:13.0206 (UTC) FILETIME=[09CC9760:01C73FFC]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13809
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
>  >> >>This I would hope you can hide in the platform specific
>  >> >>serial_in/serial_out functions. If you write the UART_LCR save it in
>  >> >>serial_out(), if you read IER etc.
> 
>  >> > I couldn't find hooks for platform specific serial_in/out functions.
> 
>  >>    It's because there are none. :-)
> 
>  >> > Do you mean using the up->port.iotype's in serial_in/out from 8250.c?
> 
>  >>    Not sure what Alan meant, but this seems the only option for now.
> 
>  > That's the conclusion I came to. I've rewritten the patch to use 
> port.type
>  > instead of iotype since one of the fix is SoC and not UART specific. 
> I guess
> 
>     I failed to folkow your logic. :-)

No longer matters as I can't use port.type. See next comment.

>  > I could use both iotype and type with a test on each for the appropriate
>  > bug, what do you recommend?
> 
>     I think iotype would be enough. You can't pass type for platform 
> devices
> anyway, IIRC (the thing I don't quite like).

I just found that out the hard way, it get's overwritten during autoconfig* and
ends up back at PORT_16550A.

I'm now trying to use my own iotype = UPIO_DWAPB and I've added it to all cases
that check for UPIO_MEM. However at boot time I'm getting:
	"serial8250: ttyS0 at *unknown* (irq = 27) is a 16550A".
It looks like something outside of 8250.c must be checking for UPIO_MEM, I'm
looking into it.

> 
>  >>  >>And we might want to add a void * for board specific insanity to 
> the 8250
>  >> >>structures if we really have to so you can hang your brain damage
>  >> >>privately off that ?
> 
>  >> > Sounds good to me, it would give us a location to store the 
> address of the
>  >> > UART_STATUS_REG required by this UART variant.
> 
>  >>    I doubt we really need to *store* it somewhere. Isn't it an fixed 
> offset
>  >>from UART's base (I haven't seen the header)?
> 
>  > Unfortunately it's not a constant offset from the UART in the SoC 
> register
> 
>     Hm...
> 
>  > space. I've used Alan suggestion and added a classic, on some other 
> OSes %-|,
>  > void "user" pointer.
> 
>     Only do not do it under #ifdef.

Understood, getting rid of them is why I started this thread.

Marc
