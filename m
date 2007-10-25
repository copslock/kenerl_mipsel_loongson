Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 19:18:09 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:33038 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20024014AbXJYSSB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 19:18:01 +0100
Received: (qmail 30169 invoked by uid 1000); 25 Oct 2007 20:18:00 +0200
Date:	Thu, 25 Oct 2007 20:18:00 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.24-rc1: au1xxx and clocksource
Message-ID: <20071025181800.GA30134@roarinelk.homelinux.net>
References: <20071024183135.GA23096@roarinelk.homelinux.net> <20071025175914.GB27616@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071025175914.GB27616@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

> > > So time to check how your favorite platform is doing and fix what broke!
> > 
> > I let it loose on my Au1200, but unfortunately the new time code is b0rked
> > ina way I don't understand.
> > 
> > Following call chain:
> > 
> > start_kernel()
> >  time_init()
> >   init_mips_clocksource()
> >   mips_clockevent_init()
> >    clockevents_register_device()
> >     clockevents_do_notify()
> >      notifier_call_chain():
> > 
> >       It dies here, line 69, in kernel/notifier.c:
> >       ret = nb->notifier_call(nb, val, v);
> 
> What sort of death?  Please describe all sympthoms of the patient.

Well it does nothing. Unfortunately the only JTAG probe we have 
is always in use by the WinCE people so can't be more specific than that.
 
> > Maybe my debug method is faulty (homebrew putstring() with au1200 uart
> >  banging) but the last debug output is before this line.
> 
> It is consistent with another bug report on IP27.
> 
> The function tick_notify has been installed as notifier, so that is what
> I think nb->notifier_call() should be pointing at.  So it should be
> called like this:
> 
>   tick_notify(&tick_notifier, CLOCK_EVT_NOTIFY_ADD, dev)

That's a great hint, I'll debug it some more.

Thank you!

	Manuel Lauss
