Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 12:35:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:34763 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024111AbXJ3Mfa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 12:35:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9UCZN7u024971;
	Tue, 30 Oct 2007 12:35:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9UCZMHw024970;
	Tue, 30 Oct 2007 12:35:22 GMT
Date:	Tue, 30 Oct 2007 12:35:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <KevinK@mips.com>
Cc:	tnishioka <tnishioka@mvista.com>, linux-mips@linux-mips.org
Subject: Re: About the changes in co_timer_ack() function of time.c.
Message-ID: <20071030123522.GB24392@linux-mips.org>
References: <20071027221105.2329b0e6.tnishioka@mvista.com> <003801c818c4$1cbe0150$8603a8c0@Ulysses>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003801c818c4$1cbe0150$8603a8c0@Ulysses>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 27, 2007 at 11:06:34AM -0700, Kevin D. Kissell wrote:

> The difference is that, in the case where we are *way* behind in interrupt
> processing, such that the Count value has gone beyond the to the next tick 
> interrupt value, the 2.6.10 code will only try to catch up by a single inteval,
> which may result in having to wait 4 billion cycles for the Count to wrap.
> The 2.6.23.1 version (a) repeats until the programmed Compare value is
> ahead of Count, and (b)  resamples the count register value each time 
> through the loop, which is important if other interrupts may be enabled
> while c0_timer_ack() is running, [...]

The code upto 2.6.23 uses IRQF_DISABLED (which used to be named SA_INTERRUPT
until July 2006) for the timer interrupt in timer_irqaction which is defined
in the generic time.c.

> [...] I could imagine that making a material difference in the presnece
> of "interrupt storms" from I/O devices.

I don't recall any reports of this sort of behaviour before tnishioka's.
This includes no hang reports about the R4000 read from c0_count ever -
because Linux will happen to just nicely tiptoe around the issue for all
real world configurations.

> If I wanted to be pendantic, I would argue that the 2.6.23 is still vulnerable
> to the Count register passing the Compare target between the "if" and the
> write_c0_compare(), and that it would be more airtight to code it more
> like:
>             expirelo = read_c0_count();
>             do {
>                 expirelo += cycles_per_jiffy;
>                 write_c0_compare(expirelo);
>             } while (((read_c0_count()) - expirelo < 0x7fffffff);
> 
> 
> It may well be that the initial value of expirelo should be derived
> from read_c0_compare() and not read_c0_count().  That would
> preserve synchronization of clock ticks against external wall-clock time,
> though the removal of the "slop" would mean that there would be
> slighly more interrupt service events per unit of real time.

I think it should be based on the last compare value.  This is the only
way to ensure interrupts will use a precise timing.

> But I gave up tilting at these windmills a long, long time ago... ;o)

Your windmill has been fixed for 2.6.24.

Now available at your nearest LMO (TM) GIT Store!

The big change is that the new timer code now has a proper concept of
oneshot interrupt timers.  Which is what the compare interrupt really is
despite the continuously running counter.  So this is how the new event
programming code looks like:

static int mips_next_event(unsigned long delta,
                           struct clock_event_device *evt)
{
	unsigned int cnt;
	int res;

	cnt = read_c0_count();
	cnt += delta;
	write_c0_compare(cnt);

	return ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
}

The called will check for the error return and if so invoke the active
clockevent device's ->set_next_event method again with a new suitable
delta.

Qemu btw. can trigger the -ETIME case fairly easily.

But anyway, I don't object a patch to improve theoretical correctness.

  Ralf
