Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2006 19:14:40 +0200 (CEST)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:24060 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133773AbWEVROc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 May 2006 19:14:32 +0200
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k4MHENLW016340
	for <linux-mips@linux-mips.org>; Mon, 22 May 2006 17:14:24 GMT
Received: from [43.134.85.135] ([43.134.85.135])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k4MHEN7e029359
	for <linux-mips@linux-mips.org>; Mon, 22 May 2006 17:14:23 GMT
Message-ID: <4471F16F.8080408@am.sony.com>
Date:	Mon, 22 May 2006 10:14:23 -0700
From:	Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: RFC - fix for sched_clock/printk_clock bad resolution
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tim.bird@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tim.bird@am.sony.com
Precedence: bulk
X-list: linux-mips

Hi all,

I've been using CONFIG_PRINTK_TIME, and I noticed that I get
pretty bad resolution.  I'm only getting resolution to the
millisecond, since the default printk_clock() uses
sched_clock(), which just emits jiffy-based values.

I noticed that timerhi and timerlo are constantly updated
inside timer_interrupt() (in arch/mips/kernel/time.c). These
are used in a few places to get sub-jiffy clock resolution.

Are these (timerhi and timerlo) available on all MIPS platforms,
and would they make a good candidate for a better
high-resolution timestamp source for sched_clock() or printk_clock()?

I wrote the following, but I wanted to get feedback on it before
submitting a patch:

unsigned long long printk_clock(void)
{
        unsigned long long clock64;
        unsigned int count;

        if (!mips_hpt_read) {
		count = read_c0_count();
        } else {
		count = mips_hpt_read();
	}

        write_seqlock(&xtime_lock);

        /* Update timerhi/timerlo for intra-jiffy calibration. */
        timerhi += count < timerlo;                     /* Wrap around */
        timerlo = count;

        clock64 = (((unsigned long long)timerhi)<<32) + timerlo;

        write_sequnlock(&xtime_lock);

       return clock64*(1000000000ULL/mips_hpt_frequency);
}

EXPORT_SYMBOL(printk_clock);

I'm worried about the use of write_seqlock() in this routine.
It seems like printks called while inside the timer_interrupt
would deadlock.  What I'd really like is a write_tryseqlock(), or
a lock just around the timerhi/timerlo update itself (in both
the timer_interrupt routine and here).  But I don't
want to introduce a new lock just for this.  Especially since the
apparent locus of vulnerability to race condition is so small,
and it's not the end of the world for printk_clock()
to get bogus value on rare occasions.

I could remove the lock in printk_clock(), but if timerhi gets off, I'm
not sure what could get messed up.  I have alternate code which
copies timerhi and timerlo, and updates those independently,
turning printk_clock() into a reader-only of the variables.
Would that be better?

Also, will clock64*(1000000000ULL/mips_hpt_frequency)
blow up on 32-bit platforms?

Any comments would be appreciated.  Thanks.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
