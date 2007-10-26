Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2007 12:55:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:28087 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027270AbXJZLzL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 Oct 2007 12:55:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9QBt9aD032196;
	Fri, 26 Oct 2007 12:55:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9QBt8Ng032195;
	Fri, 26 Oct 2007 12:55:08 +0100
Date:	Fri, 26 Oct 2007 12:55:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.24-rc1: au1xxx and clocksource
Message-ID: <20071026115508.GA9075@linux-mips.org>
References: <20071024183135.GA23096@roarinelk.homelinux.net> <20071025175914.GB27616@linux-mips.org> <20071026061835.GA1267@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071026061835.GA1267@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 26, 2007 at 08:18:35AM +0200, Manuel Lauss wrote:

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

As I said before, I've renumbered interrupts on Alchemy.  0 ... 7 are now
the processor's built-in interrupt controller (see the IE bits in the
CPU status and cause register).  The Alchemy SOC's interrupt controller
has moved to interrupts 8 ... 71.

So what must be happening is that clockevents_program_event is returning
a non-zero value, that's the only thing that can make above loop going
forever.  Now looking at clockevents_program_event:

int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
                              ktime_t now)
{
        unsigned long long clc;
        int64_t delta;

        delta = ktime_to_ns(ktime_sub(expires, now));

        if (delta <= 0)
                return -ETIME;

        dev->next_event = expires;

        if (dev->mode == CLOCK_EVT_MODE_SHUTDOWN)
                return 0;

        if (delta > dev->max_delta_ns)
                delta = dev->max_delta_ns;
        if (delta < dev->min_delta_ns)
                delta = dev->min_delta_ns;

        clc = delta * dev->mult;
        clc >>= dev->shift;

        return dev->set_next_event((unsigned long) clc, dev);
}

So you either must be hitting the "delta <= 0" check.  Or ->set_next_event
is returning an error.  So as your earlier calltrace of the hang shows
you are using cevt-r4k.c for the clockevent device so the function getting
called would be arch/mips/kernel/cevt-r4k.c:mips_next_event().  With the
#ifdefery removed this function looks like this:

static int mips_next_event(unsigned long delta,
                           struct clock_event_device *evt)
{
        unsigned int cnt;
        int res;

        cnt = read_c0_count();
        cnt += delta;
        write_c0_compare(cnt);
        res = ((long)(read_c0_count() - cnt ) > 0) ? -ETIME : 0;

        return res;
}

So this would return an error if by the time the compare register has
been programmed the timer has already expired which would happen for
exmaple if it was programmed for an extremly short time into the future.

The timer clock initialization code in cevt-r4k.c:

        /* Calculate the min / max delta */
        cd->mult        = div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
        cd->shift               = 32;
        cd->max_delta_ns        = clockevent_delta2ns(0x7fffffff, cd);
        cd->min_delta_ns        = clockevent_delta2ns(0x300, cd);

Looks a little oldfashioned but okay otherwise - if mips_freq is sane.
So let's see.  mips_freq is initialized from mips_hpt_frequency which the
platform code should have initialized in plat_time_init() which happens
in arch/mips/au1000/common/time.c: cal_r4koff() which is getting called
from plat_timer_setup which is called from ...  nowhere anymore whoops.

I could restore the call easily but that function is on the way out and
any user of plat_timer_setup has likely other bugs in the new time code.

Can you try below patch?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/au1000/common/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index 0673fc0..f113b51 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -228,7 +228,7 @@ unsigned long cal_r4koff(void)
 	return (cpu_speed / HZ);
 }
 
-void __init plat_timer_setup(struct irqaction *irq)
+void __init plat_time_init(void)
 {
 	unsigned int est_freq;
 
