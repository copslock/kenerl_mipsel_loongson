Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 16:50:11 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:8920 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20048768AbXAXQuG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 16:50:06 +0000
Received: (qmail 10783 invoked by uid 101); 24 Jan 2007 16:48:59 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 24 Jan 2007 16:48:59 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l0OGmw8e004643;
	Wed, 24 Jan 2007 08:48:59 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <DCB6CRAS>; Wed, 24 Jan 2007 08:48:58 -0800
Message-ID: <45B78DF5.9000203@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	 er
Date:	Wed, 24 Jan 2007 08:48:53 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 24 Jan 2007 16:48:54.0136 (UTC) FILETIME=[88585F80:01C73FD7]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> 
>  >>This I would hope you can hide in the platform specific
>  >>serial_in/serial_out functions. If you write the UART_LCR save it in
>  >>serial_out(), if you read IER etc.
> 
>  > I couldn't find hooks for platform specific serial_in/out functions.
> 
>     It's because there are none. :-)
> 
>  > Do you mean using the up->port.iotype's in serial_in/out from 8250.c?
> 
>     Not sure what Alan meant, but this seems the only option for now.

That's the conclusion I came to. I've rewritten the patch to use port.type
instead of iotype since one of the fix is SoC and not UART specific. I guess
I could use both iotype and type with a test on each for the appropriate
bug, what do you recommend?


>   >>And we might want to add a void * for board specific insanity to the 
> 8250
>  >>structures if we really have to so you can hang your brain damage
>  >>privately off that ?
> 
>  > Sounds good to me, it would give us a location to store the address 
> of the
>  > UART_STATUS_REG required by this UART variant.
> 
>     I doubt we really need to *store* it somewhere. Isn't it an fixed 
> offset
> from UART's base (I haven't seen the header)?

Unfortunately it's not a constant offset from the UART in the SoC register
space. I've used Alan suggestion and added a classic, on some other OSes %-|,
void "user" pointer.

I'll repost as soon I complete testing and try the new timer patch.

Marc
