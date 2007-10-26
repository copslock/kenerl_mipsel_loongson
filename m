Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2007 12:25:06 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:13838 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20027097AbXJZLY4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 Oct 2007 12:24:56 +0100
Received: (qmail 2823 invoked by uid 1000); 26 Oct 2007 13:24:55 +0200
Date:	Fri, 26 Oct 2007 13:24:55 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.24-rc1: au1xxx and clocksource
Message-ID: <20071026112455.GA2792@roarinelk.homelinux.net>
References: <20071024183135.GA23096@roarinelk.homelinux.net> <20071025175914.GB27616@linux-mips.org> <20071026061835.GA1267@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071026061835.GA1267@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Fri, Oct 26, 2007 at 08:18:35AM +0200, Manuel Lauss wrote:
> Hi Ralf,
> 
> On Thu, Oct 25, 2007 at 06:59:14PM +0100, Ralf Baechle wrote:
> > On Wed, Oct 24, 2007 at 08:31:35PM +0200, Manuel Lauss wrote:
> > > start_kernel()
> > >  time_init()
> > >   init_mips_clocksource()
> > >   mips_clockevent_init()
> > >    clockevents_register_device()
> > >     clockevents_do_notify()
> > >      notifier_call_chain():
> > > 
> > >       It dies here, line 69, in kernel/notifier.c:
> > >       ret = nb->notifier_call(nb, val, v);
> 
> >   tick_notify(&tick_notifier, CLOCK_EVT_NOTIFY_ADD, dev)
> > 
> > So things are likely going wrong somewhere in there.
> 
> starting in nb->notifier_call:
> tick_notify()
>  tick_check_new_device()
>   tick_setup_device()
>    tick_setup_periodic():
> 
>    it seems to enternally loop in here:
> 
> 123                 for (;;) {
> 124                         if (!clockevents_program_event(dev, next, ktime_get()))
> 125                                 return;
> 126                         next = ktime_add(next, tick_period);
> 127                 }
> 
> I think it's waiting for a timer irq which never happens.  The code in
> cevt-r4k.c assigns IRQ 7 as the timer irq which is a GPIO according to
> the manual. Actually, there is no real requestable() timer irq mentioned
> in the manual (RTC and TOY aside).

That's wrong of course :(

The real reason is that mips_hpt_frequency is zero, the whole min/max delta
is therefore 2^31-1 and the loop above never exits because mips_next_event()
is called with zero for the 'delta' parameter.

Setting mips_hpt_frequency to processor speed gives me a booting kernel.

Sorry for the noise!

Thanks,
	Manuel Lauss
