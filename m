Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NLn0F14041
	for linux-mips-outgoing; Mon, 23 Apr 2001 14:49:00 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3NLmsM14034
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 14:48:55 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3NLmZE06408;
	Mon, 23 Apr 2001 18:48:35 -0300
Date: Mon, 23 Apr 2001 18:48:35 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Scott A McConnell <samcconn@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: IRQ questions
Message-ID: <20010423184835.B6109@bacchus.dhis.org>
References: <3AE081E3.434E9126@cotw.com> <20010420190017.B7282@bacchus.dhis.org> <3AE4B902.C81AB2B9@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE4B902.C81AB2B9@cotw.com>; from samcconn@cotw.com on Mon, Apr 23, 2001 at 04:21:38PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 23, 2001 at 04:21:38PM -0700, Scott A McConnell wrote:

> > > I have a 2.4.3 kernel booting. I copied the old  arch/mips/kernel/irq.c
> > > to my target directory and changed
> >
> > One valid solution ...  Still.  We want to eleminate all this code
> > duplication for no good reason.
> 
> Would Rotten_IRQ have done the same thing?

Absolutely not.  The rotten IRQ thing gives you the old irq.c which assumes
more or less x86 centric interrupt handling, that is a 2 PICs and doesn't
get SMP right and leaves us a ton of structural problems.  Don't use, it's
destilled evil ;-)

> Could you name an arch in the cvs distribution that uses the new style IRQ's

Interrupt handling is an per architecture thing; currently i386 is coming
closest to the new design of our future interrupts.

  Ralf
