Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2004 21:57:16 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:57604 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225073AbUI1U5L>; Tue, 28 Sep 2004 21:57:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id CD410F5A69; Tue, 28 Sep 2004 22:57:01 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07233-04; Tue, 28 Sep 2004 22:57:01 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7DA6BE1C7D; Tue, 28 Sep 2004 22:57:01 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.12.11) with ESMTP id i8SKvGLX032064;
	Tue, 28 Sep 2004 22:57:18 +0200
Date: Tue, 28 Sep 2004 21:57:04 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: linux-mips@linux-mips.org, mentre@tcl.ite.mee.com
Subject: Re: Questions regarding MIPS platforms boot process
In-Reply-To: <20040915072337.GX6242@enix.org>
Message-ID: <Pine.LNX.4.58L.0409281640200.32231@blysk.ds.pg.gda.pl>
References: <20040915072337.GX6242@enix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 15 Sep 2004, Thomas Petazzoni wrote:

> 2) Mips_hpt_frequency
> 
> I'm not sure whether my board_time_init() function should set
> mips_hpt_frequency or not. In arch/mips/kernel/time.c, it is said that :
> 
>  *      b) (optional) calibrate and set the mips_hpt_frequency
>  *	    (only needed if you intended to use fixed_rate_gettimeoffset
>  *	     or use cpu counter as timer interrupt source)
> 
> So it doesn't seem to be mandatory, but actually I do not understand
> clearly the two cases for which setting mips_hpt_frequency is mandatory.
> I don't think I want to use fixed_rate_gettimeoffset, but I'm not sure
> with the second usage.

 If you want to use a HPT at all, then you do want to use
fixed_rate_gettimeoffset().  The calibrate_div32_gettimeoffset() and
calibrate_div64_gettimeoffset() backends are considered obsolete and will
be removed.  That's the first case.

 The other is when you use the CP0's internal timer as a source of timer 
interrupts.

> When I read the code of arch/mips/kernel/time.c, function time_init()
> around line 701, I can see that if no value has been set to
> mips_hpt_frequency, then it is computed by the calibrate_hpt(). So, when
> is it needed to set it ?

 You only need to set mips_hpt_frequency manually if there's no way do
determine the timer's frequency automatically.  This is usually the case,
when there is no reference timer in the system, e.g. you only have the
CP0's internal timer, but you know the timer's frequency.  But you are
free do that even if you have a reference timer, but using the generic 
calibration code would be too complicated to set up.

 Otherwise, you need to set the mips_timer_state function pointer to make
the code set up mips_hpt_frequency automagically.  The function has to
report a the state of the timer in such a way, that there are HZ 0 to 1
transitions per second with equal intervals.  Typically it would just read 
the state of an interrupt output from the device providing timer 
interrupts, but actually it's up to you how you implement it.

> FYI, the platform I'm working on doesn't have any external timer source.

 You need to set mips_hpt_frequency somehow, then.  If your CPU's clock is
fixed for all devices, then you can simply hardcode the frequency.  If the
clock varies and there's absolutely no way to determine it, you may ask
the user to enter the value valid for his system during kernel
configuration.

> What's the exact use of the mips_hpt_frequency ? Should I set it or not
> ?

 If you use the CP0's internal timer, then mips_hpt_frequency is used to
setup the timer's interval.  The resulting interval is expected to be 1/HZ
and it is the base of the system time, both for scheduling and for
timekeeping.

 If you don't use the CP0's internal timer, and you have an external timer
device (such as an RTC chip), then mips_hpt_frequency is optional,
although still recommended.  It's used to provide a finer granularity for 
timekeeping (gettimeofday() and friends).

  Maciej
