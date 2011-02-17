Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 19:47:45 +0100 (CET)
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:46948
        "EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491109Ab1BQSrm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 19:47:42 +0100
Received: from omta24.westchester.pa.mail.comcast.net ([76.96.62.76])
        by qmta13.westchester.pa.mail.comcast.net with comcast
        id 96281g0041ei1Bg5D6nbeB; Thu, 17 Feb 2011 18:47:35 +0000
Received: from [192.168.1.13] ([69.251.104.163])
        by omta24.westchester.pa.mail.comcast.net with comcast
        id 96nY1g01Z3XYSBH3k6nZ29; Thu, 17 Feb 2011 18:47:34 +0000
Message-ID: <4D5D6D2D.2080309@gentoo.org>
Date:   Thu, 17 Feb 2011 13:47:09 -0500
From:   Kumba <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Linux MIPS List <linux-mips@linux-mips.org>,
        rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/2]: Add support for Dallas/Maxim DS1685/1687 RTC
References: <4D5A65E3.1050707@gentoo.org> <4D5C5C66.6060205@metafoo.de> <4D5CF0EE.7000308@gentoo.org> <4D5D09FF.6010005@metafoo.de>
In-Reply-To: <4D5D09FF.6010005@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

On 02/17/2011 06:43, Lars-Peter Clausen wrote:
> That is what I meant. Pass the return value of rtc_valid_tm on, instead of
> setting the time to 0 and pretend everything went fine.
> You can still keep the dev_err though, no problem with that.

Well, that particular return is in the while loop to check for an access 
lockout.  I'll be honest, I got that little bit out of a driver originally 
written for SGI Octane systems running Linux (an unofficial patch that has since 
suffered severe bitrot).

I know what bit to check to avoid an access lockout, but the DS1685 manual 
offers several options, and not being a hardware person, I'm not real sure how 
to represent them in code.

Here's what it says:

> There are three methods that can handle access of the RTC that avoid any
> possibility of accessing inconsistent time and calendar data. The first method
> uses the update-ended interrupt. If enabled, an interrupt occurs after every
> update cycle that indicates that over 999ms is available to read valid time and
> date information. If this interrupt is used, the IRQF bit in Register C should
> be cleared before leaving the interrupt routine.
>
> A second method uses the UIP bit in Register A to determine if the update cycle
> is in progress. The UIP bit pulses once per second. After the UIP bit goes
> high, the update transfer occurs 244μs later. If a low is read on the UIP bit,
> the user has at least 244μs before the time/calendar data is changed.
> Therefore, the user should avoid interrupt service routines that would cause
> the time needed to read valid time/calendar data to exceed 244μs.
>
> The third method uses a periodic interrupt to determine if an update cycle is
> in progress. The UIP bit in Register A is set high between the setting of the
> PF bit in Register C (Figure 4). Periodic interrupts that occur at a rate of
> greater than tBUC allow valid time and date information to be reached at each
> occurrence of the periodic interrupt. The reads should be complete within
> (tPI / 2 + tBUC) to ensure that data is not read during the update cycle.

I believe the driver is currently using #2.  Other drivers (rtc-sh.c) appear to 
use a do/while loop and check a bit that I assume is functionally equivalent to 
UIP here, but I'm not sure if that is accurate or not (and I have not dug up the 
manual for whatever chip rtc-sh.c touches).

What's the best approach to use here to avoid an access lockout? Should I run 
into an access lockout, what's the best way to handle that?


> What do you mean by 'quickly turning around and writing the values back'?
> The rtc_time struct passed to the set_time callback is supposed to contain only
> valid values.

The way I wrote ds1685_rtc_set_time copies the values from rtc_time out to local 
variables, runs the checks you say I need to remove, then if those pass, writes 
those values to the RTC registers.  I guess what your saying is that the checks 
are unnecessary because rtc_time has already been checked, so I'm just 
duplicating work and can write the values straight to the RTC registers?


> Well, if it is going to be shared it should probably remain somewhere in
> include/, but everything thats not shared should be moved to rtc-ds1685.c like
> for example ds1685_priv.

I think for now, moving everything into drivers/rtc works best.  I'll work from 
the linux-mips end on how IP32 needs to access this header file when I get that far.


> I don't know what you are trying to do, but the current code is extremely
> unreadable.
> You have all those variables declared in your functions which are on first
> sight not used, because they are only referenced from the macros. Furthermore
> the invocation of the macro has not the syntax of a function call, although
> semantically that is what it is.
> And especially ds1685_rtc_begin_data_access is dangerous, because of the
> 'return 1', there is no indication when you read the code that a function could
> magically exit upon invoking that macro.

Well, I thought I was being fancy and cute, but that's what code review is all 
about.  I'm working on breaking these up into inlinable functions and leave that 
bit of work up to the compiler.


> Why? The compiled code will probably be exactly the same as now.

Per above, if I can re-work the RTC access loop, I can eliminate this one bit 
and then this concern becomes moot.


Thanks!,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
