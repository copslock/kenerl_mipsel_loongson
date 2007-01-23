Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 23:32:40 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40936 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S28583256AbXAWXcg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 23:32:36 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.8/8.13.4) with ESMTP id l0NNfsMc016425;
	Tue, 23 Jan 2007 23:41:56 GMT
Date:	Tue, 23 Jan 2007 23:41:53 +0000
From:	Alan <alan@lxorguk.ukuu.org.uk>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
 er
Message-ID: <20070123234153.66fbeac6@localhost.localdomain>
In-Reply-To: <45B68E23.7080800@pmc-sierra.com>
References: <45B68E23.7080800@pmc-sierra.com>
X-Mailer: Claws Mail 2.7.1 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, 23 Jan 2007 14:37:23 -0800
Marc St-Jean <Marc_St-Jean@pmc-sierra.com> wrote:
> > This I would hope you can hide in the platform specific
> > serial_in/serial_out functions. If you write the UART_LCR save it in
> > serial_out(), if you read IER etc.
> 
> I couldn't find hooks for platform specific serial_in/out functions.
> Do you mean using the up->port.iotype's in serial_in/out from 8250.c?

If you can have other uarts as well then yes. Basically I want all the
ugliness to belong to you not to the 8250 driver (and ditto for any other
half baked uart or demented piece of broken glue logic). If we don't do
that then 8250.c will end up unmanagable. So long as you crap in your own
pond everyone else is fine ;)

> A serial_in(up, UART_IIR) calls occur in more places that just the interrupt
> handler (i.e. autoconfig*, serial8250_start_tx, etc). We will need to check
> if we are in an interrupt on each IIR read, hopefully that won't be too much
> overhead!

Or if need be we make that hint generally available as we can do that bit
cleanly.

> > 
> > And we might want to add a void * for board specific insanity to the 8250
> > structures if we really have to so you can hang your brain damage
> > privately off that ?
> 
> Sounds good to me, it would give us a location to store the address of the
> UART_STATUS_REG required by this UART variant.

and for anything harder people can hang a struct off it.

Alan
